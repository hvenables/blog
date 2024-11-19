// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

import { highlightPreCodeBlocks } from 'modules/code_blocks';
import { addTrixInlineStyle } from 'modules/trix_inline_blocks';

document.addEventListener('turbo:load', highlightPreCodeBlocks);
document.addEventListener("trix-before-initialize", addTrixInlineStyle);

import 'modules/init_choices'
