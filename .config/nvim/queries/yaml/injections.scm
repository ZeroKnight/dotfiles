;; extends

(block_mapping_pair
  value: (flow_node
    (double_quote_scalar) @injection.content
    (#set! injection.language "jinja")
    (#offset! @injection.content 0 1 0 -1)))
    (#lua-match? @injection.content "^{{.+}}$")

(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_stmt)
      (#any-of? @_stmt "when" "failed_when" "changed_when"))
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content
      (#set! injection.language "jinja"))))
