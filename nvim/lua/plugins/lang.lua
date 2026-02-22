-- =============================================================================
-- lua/plugins/lang.lua — Language-specific plugins
-- =============================================================================

local not_vscode = function() return not vim.g.vscode end

return {

  -- --------------------------------------------------------------------------
  -- Dart / Flutter — syntax, formatting, and filetype support
  -- LSP is handled by coc-flutter (coc.nvim extension)
  -- --------------------------------------------------------------------------
  {
    "dart-lang/dart-vim-plugin",
    cond = not_vscode,
    ft   = { "dart" },
  },
}
