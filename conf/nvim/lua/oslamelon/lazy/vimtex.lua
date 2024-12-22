return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    
    -- Make zathura default latex viewer method
    vim.g.vimtex_view_method = "zathura"

    -- Make latexmk default compiler
    vim.g.vimtex_compiler_method = "latexmk"
    
  end
}
