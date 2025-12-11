// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Choices from "choices.js"
import "choices.js/public/assets/styles/choices.min.css"

document.addEventListener("turbo:load", () => {
  document.querySelectorAll("select[multiple].multi-select").forEach((el) => {
    new Choices(el, {
      removeItemButton: true,
      searchEnabled: true
    })
  })
})
