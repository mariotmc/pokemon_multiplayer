import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  async sendButtonPress(event) {
    try {
      await fetch(`/buttons/${event.currentTarget.dataset.button}`, {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          Accept: "application/json",
        },
      });
    } catch (error) {
      console.error("Error:", error);
    }
  }
}
