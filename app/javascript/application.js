// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
import hljs from "highlight.js"

hljs.configure({
  languages: ['ruby', 'javascript', 'css'],
  es: {
    next: true,
  },
});

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('pre code').forEach((block) => {
    hljs.highlightElement(block);
  });
});

document.addEventListener('turbo:frame-load', () => {
  document.querySelectorAll('pre code').forEach((block) => {
    hljs.highlightElement(block);
  });
});
