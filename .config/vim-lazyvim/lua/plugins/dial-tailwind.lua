return {
  "monaqa/dial.nvim",
  opts = function(_, opts)
    -- fix increments in tailwind -- see https://github.com/monaqa/dial.nvim/issues/101
    table.remove(opts.groups.default, 2)
  end,
}
