return {
  -- 1. 先安装主题插件
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- 2. 告诉 LazyVim 使用它
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
