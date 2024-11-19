# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "highlight.js", to: "https://ga.jspm.io/npm:highlight.js@11.4.0/es/index.js"
pin "@stimulus-components/character-counter", to: "@stimulus-components--character-counter.js" # @5.0.0
pin "modules/code_blocks", to: "modules/code_blocks.js"
pin "modules/trix_inline_blocks", to: "modules/trix_inline_blocks.js"
pin "choices", to: "choices.js"
pin "modules/init_choices", to: "modules/init_choices.js"
