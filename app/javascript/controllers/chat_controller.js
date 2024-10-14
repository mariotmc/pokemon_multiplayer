import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  connect() {
    this.loadExistingMessages();
    this.channel = consumer.subscriptions.create("ChatChannel", {
      received: this.received.bind(this),
    });
  }

  async loadExistingMessages() {
    const response = await fetch("/messages");
    const messages = await response.json();
    messages.forEach((message) => this.addMessage(message));
  }

  received(data) {
    this.addMessage(data);
  }

  addMessage(data) {
    const messageElement = document.createElement("p");
    messageElement.textContent = `${data.player} ${data.message}`;
    messageElement.classList.add("mb-2", "text-sm");
    this.element.querySelector("#chat-messages").appendChild(messageElement);
    this.scrollToBottom();
  }

  scrollToBottom() {
    const chatMessages = this.element.querySelector("#chat-messages");
    chatMessages.scrollTop = chatMessages.scrollHeight;
  }
}
