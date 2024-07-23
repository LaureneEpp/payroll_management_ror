// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "userMenu", "mobileMenu"]

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
  }

  toggleUserMenu() {
    this.userMenuTarget.classList.toggle("hidden")
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle("hidden")
  }
}
