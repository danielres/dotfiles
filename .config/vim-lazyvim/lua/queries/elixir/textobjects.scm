
;; ========== argument swap ==================================================
(call
  (arguments (_) @parameter.inner)
)

;; ========== function movement (@function.outer) ============================
(call
  target: (identifier) @_kw
  (#any-of? @_kw "def" "defp" "defmacro" "defmacrop" "defn" "defnp" "defmemo" "test" "describe" "setup")
) @function.outer

;; ========== module / protocol as class (@class.outer) ======================
(call
  target: (identifier) @_kw
  (arguments (alias)        @class.name)
  (do_block)                @class.inner
  (#any-of? @_kw "defmodule" "defprotocol")
) @class.outer

