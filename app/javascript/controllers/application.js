import { Application } from "@hotwired/stimulus"
import CharacterCounter from '@stimulus-components/character-counter'

const application = Application.start()
application.register('character-counter', CharacterCounter)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
