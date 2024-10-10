vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " " 
vim.cmd("set number")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/flke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup("plugins")

vim.opt.clipboard = 'unnamedplus'
vim.opt.relativenumber = true

-- Map Ctrl+Backspace in Insert mode to delete the previous word
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', { noremap = true, silent = true })
--Word Wrap
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = '~'
vim.o.wrapmargin = 2

-- Import the necessary module

