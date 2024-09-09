;; extends

(string
  (string_start) @_start (#eq? @_start "\"\"\"")
  (string_content) @block_string.inner
  (string_end) @_end (#eq? @_end "\"\"\"")) @block_string.outer
