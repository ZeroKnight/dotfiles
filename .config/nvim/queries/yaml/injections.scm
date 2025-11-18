;; extends

(flow_node
  [(double_quote_scalar) (single_quote_scalar)] @injection.content
  (#set! injection.language "jinja")
  (#offset! @injection.content 0 1 0 -1)
  (#lua-match? @injection.content "{{.+}}"))

(flow_node
  (plain_scalar
    (string_scalar) @injection.content
    (#set! injection.language "jinja")
    (#lua-match? @injection.content "{{.+}}")))

(block_node
  (block_scalar) @injection.content
  (#set! injection.language "jinja")
  (#lua-match? @injection.content "{{.+}}"))

; FIXME: Correct capture, but no highlighting due to a lack of brace pairs
; We can cheat a bit by setting the injected language to Python; it's not
; totally accurate, but it's close enough.
(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_stmt)
      (#any-of? @_stmt "when" "failed_when" "changed_when"))
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content
      (#set! injection.language "python")))) ; HACK: *Should* be "jinja"
