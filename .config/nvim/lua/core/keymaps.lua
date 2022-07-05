local noremap='noremap'
local silent='silent'
local expr='expr'
local nowait='nowait'

local kmap = require('lib.kmap')
local opts = {noremap}

return  {
  setup = function ()
    -- lsp
    kmap.nlua('<space>e', 'vim.diagnostic.open_float()', opts)
    kmap.nlua('[d', 'vim.diagnostic.goto_prev()', opts)
    kmap.nlua(']d', 'vim.diagnostic.goto_next()', opts)
    kmap.nlua('<space>q', 'vim.diagnostic.setloclist()', opts)

    -- nvim-tree
    kmap.ncmd('<C-n>', 'NvimTreeToggle', opts)
    kmap.ncmd('<leader>r', 'NvimTreeRefresh', opts)

    -- toggleterm
    kmap.ncmd('<C-t>', '<Cmd>exe v:count1 . "ToggleTerm"', opts)
    kmap.ncmd('<C-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"', opts)
  end,
  lsp_bufmap = function (buf)
    -- goto
    kmap.nluabuf('gD', 'vim.lsp.buf.declaration()', buf, opts)
    kmap.nluabuf('gD', 'vim.lsp.buf.definition()', buf, opts)
    kmap.nluabuf('gr', 'vim.lsp.buf.references()', buf, opts)

    kmap.nluabuf('<C-k>', 'vim.lsp.buf.signature_help()', buf, opts)

    -- action
    kmap.nluabuf('<space>rn', 'vim.lsp.buf.rename()', buf, opts)
    -- kmap.nluabuf('<space>ca', 'vim.lsp.buf.code_action()', opts)
    kmap.nluabuf('<space>f', 'vim.lsp.buf.formatting()', buf, opts)
  end
}

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
