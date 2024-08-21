import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "frame"]
  
  close(event) {
    event.preventDefault();
    this.modalTarget.remove()
    this.frameTarget.remove()
  }
  
}