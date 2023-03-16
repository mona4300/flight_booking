import { Application } from "@hotwired/stimulus"
import ConfirmationModalController from "./confirmation_modal_controller" 

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
application.register("confirmation-modal", ConfirmationModalController)

window.Stimulus   = application
export { application }
