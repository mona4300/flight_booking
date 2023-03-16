import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  run(event) {
    let confirmModalElement = document.getElementById('confirmModal')
    confirmModalElement.dataset.confirmed = event.params.confirmed

    const turboConfirmationClosed = new Event("turbo.confirmation.closed");
    confirmModalElement.dispatchEvent(turboConfirmationClosed)
  }
}










































``