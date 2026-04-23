" 基础显示设置
set number              " 显示行号
set relativenumber      " 显示相对行号（方便 5j, 10k 这种快速跳转）
set cursorline          " 高亮当前行
set showmode            " 在底部显示当前模式（INSERT/VISUAL等）
set showcmd             " 显示当前输入的命令
" syntax on               " 开启语法高亮
" colorscheme desert      " 使用经典的 desert 配色（或者你的系统自带的其他颜色）

" 搜索设置
set hlsearch            " 高亮显示搜索结果
set incsearch           " 边输入边搜索
set ignorecase          " 搜索时忽略大小写
set smartcase           " 如果搜索词包含大写，则不忽略大小写

" 缩进与格式
set tabstop=4           " Tab 宽度为 4 个空格
set shiftwidth=4        " 自动缩进宽度为 4 个空格
set expandtab           " 将 Tab 自动转换为空格
set autoindent          " 继承前一行的缩进

" 系统交互
set clipboard=unnamedplus " 与系统剪贴板共享（需要安装 xclip 或 wl-clipboard）
set mouse=a             " 开启鼠标支持（可以点选、滚动）
set encoding=utf-8      " 强制使用 UTF-8 编码

"  (Leader 键设为空格)
let mapleader = " "

" 快速保存和退出
noremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>

" 按空格 + nh 取消搜索高亮
noremap <Leader>nh :nohl<CR>

" 自动命令：如果是脚本文件，自动加权限
" 当保存一个以 #! 开头的文件时，自动赋予执行权限
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x % | endif
