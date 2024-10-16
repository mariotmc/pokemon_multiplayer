import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  async sendButtonPress(event) {
    const button = event.currentTarget.dataset.button;
    const response = await fetch(`/buttons/${button}`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        Accept: "application/json",
      },
    });
  }
}
