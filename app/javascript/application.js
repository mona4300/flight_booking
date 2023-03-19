// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

Turbo.setConfirmMethod((message, element) => {
  let confirmModalElement = document.getElementById('confirmModal')
  let confirmModal = new bootstrap.Modal(confirmModalElement)

  confirmModalElement.querySelector("div.modal-body").textContent = message
  confirmModal.show()

  return new Promise((resolve, reject) => {
    confirmModalElement.addEventListener('turbo.confirmation.closed', event => {
      confirmModal.hide()
      resolve(event.target.dataset.confirmed == '1')
    }, { once: true })
  })
})

document.cookie = 'timezone='+ Intl.DateTimeFormat().resolvedOptions().timeZone