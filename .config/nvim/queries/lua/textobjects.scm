;; extends

(string
  start: "[["
  content: (string_content) @block_string.inner
  end: "]]") @block_string.outer
