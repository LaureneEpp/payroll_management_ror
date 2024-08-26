// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { showPopup } from "./components/popup";
import { showFlashMessage } from "./components/flash_message";
window.showPopup = showPopup;
