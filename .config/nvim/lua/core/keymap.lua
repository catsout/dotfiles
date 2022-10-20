local M = {}

--[[
Ctrl  modifier --> <C-key>
Shift modifier --> <S-key>
Alt   modifier --> <A-key> / <M-key>
Super modifier --> <D-key>

<leader>       User defined, default: '\'

<BS>           Backspace
<Tab>          Tab
<CR>           Enter
<Enter>        Enter
<Return>       Enter
<Esc>          Escape
<Space>        Space
<Up>           Up arrow
<Down>         Down arrow
<Left>         Left arrow
<Right>        Right arrow
<F1> - <F12>   Function keys 1 to 12
#1, #2..#9,#0  Function keys F1 to F9, F10
<Insert>       Insert
<Del>          Delete
<Home>         Home
<End>          End
<PageUp>       Page-Up
<PageDown>     Page-Down
<bar>          the '|' character, which otherwise needs to be escaped '\|'
--]]

function M.load()
  local pinfo = require('core.plugin-info').infos
  local kmap = require('lib.kmap').domap
  kmap.nraw('<space>e', vim.diagnostic.open_float)
  kmap.nraw('[d', vim.diagnostic.goto_prev)
  kmap.nraw(']d', vim.diagnostic.goto_next)
  kmap.nraw('<space>q', vim.diagnostic.setloclist)
  kmap.ncmd('<leader>c', 'PackerCompile')
  kmap.ncmd('<leader>s', 'w')

  pinfo.toggleterm.keymap = {
    toggle = '<C-t>',
  }
  pinfo.nvim_tree.keymap = {
    toggle = '<C-n>',

    refresh = '<leader>r',
  }

  pinfo.sym.keymap = {
    toggle = '<C-s>',

    close          = { '<Esc>', 'q' },
    goto_location  = '<Cr>',
    focus_location = 'o',
    hover_symbol   = '<C-space>',
    toggle_preview = 'K',
    rename_symbol  = 'r',
    code_actions   = 'a',
    fold           = 'h',
    unfold         = 'l',
    fold_all       = 'W',
    unfold_all     = 'E',
    fold_reset     = 'R',
  }

  pinfo.cmp.keymap = {
    abort          = '<C-e>',
    scroll_back    = '<C-b>',
    scroll_forward = '<C-f>',
    confirm        = '<CR>',
    complete       = '<C-Space>',
    next_item      = '<Tab>',
    prev_item      = '<S-Tab>',
  }

  pinfo.lsp.keymap = {
    formatting     = '<space>f',
    definition     = 'gd',
    declaration    = 'gD',
    implementation = 'gi',
    references     = 'gr',
    hover          = 'K',
    help           = '<C-k>',
    rename         = '<space>rn',
  }

  pinfo.gitsigns.keymap = {
    diff_file       = '<leader>hd',
    preview_hunk    = '<leader>hp',
    stage_hunk_undo = '<leader>hu',
    stage_hunk      = '<leader>hs',
    reset_hunk      = '<leader>hr',
    next_diff       = ']df',
    prev_diff       = '[df'
  }

end

return M
