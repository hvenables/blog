import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message"];

  connect() {
    this.hideAfterTimeout();
  }

  hide() {
    this.messageTarget.remove();
  }

  hideAfterTimeout() {
    // Auto-hide the flash message after 5 seconds
    setTimeout(() => {
      this.hide();
    }, 5000); // Adjust the time (5000ms = 5 seconds) as needed
  }
}
