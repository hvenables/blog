// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

import { highlightPreCodeBlocks } from './modules/code_blocks';

function addMultipleEventListeners(element, events, listener) {
  events.forEach((event) => element.addEventListener(event, listener));
}

addMultipleEventListeners(document, ['turbo:load', 'turbo:frame-load', 'turbo:render'], highlightPreCodeBlocks);

Trix.config.textAttributes.inlineCode = {
  tagName: "code",
  inheritable: true
}

// addEventListener("trix-initialize", event => {
//   const element = event.target
//   const { toolbarElement, editor } = element
//
//   const blockCodeButton = toolbarElement.querySelector("[data-trix-attribute=code]")
//   const inlineCodeButton = blockCodeButton.cloneNode(true)
//
//   inlineCodeButton.hidden = true
//   inlineCodeButton.dataset.trixAttribute = "inlineCode"
//   blockCodeButton.insertAdjacentElement("afterend", inlineCodeButton)
//
//   element.addEventListener("trix-selection-change", _ => {
//     const type = getCodeFormattingType()
//     blockCodeButton.hidden = type == "inline"
//     inlineCodeButton.hidden = type == "block"
//   })
//
//   function getCodeFormattingType() {
//     if (editor.attributeIsActive("code")) return "block"
//     if (editor.attributeIsActive("inlineCode")) return "inline"
//
//     const range = editor.getSelectedRange()
//     if (range[0] == range[1]) return "block"
//
//     const text = editor.getSelectedDocument().toString().trim()
//     return /\n/.test(text) ? "block" : "inline"
//   }
// })
