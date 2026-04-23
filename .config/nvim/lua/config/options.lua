-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 20260330
vim.opt.relativenumber = true -- 相对行号
vim.opt.cursorline = true -- 高亮当前行
-- 4 空格缩进配置
vim.opt.shiftwidth = 4 -- 设定缩进宽度为 4
vim.opt.tabstop = 4 -- 设定 Tab 显示宽度为 4
vim.opt.softtabstop = 4 -- 设定按退格键时一次删除 4 个空格
vim.opt.expandtab = true -- 将 Tab 键自动转换为空格
