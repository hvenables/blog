import hljs from "highlight.js"

hljs.configure({
  languages: ['ruby', 'javascript', 'css'],
  es: {
    next: true,
  },
});

export function highlightPreCodeBlocks() {
  document.querySelectorAll('pre code').forEach((block) => {
    hljs.highlightElement(block);
  });
}