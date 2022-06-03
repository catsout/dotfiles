local noremap='noremap'
local silent='silent'
local expr='expr'
local nowait='nowait'

local function gen_keymap()
  local function gen_opts(opts)
    local _opts = {}
    for _,k in pairs(opts) do _opts[k] = true end
    return _opts
  end

  local function gen_mapkey(mode, map_rhs)
    return function(lhs, rhs, opts)
      vim.api.nvim_set_keymap(mode, lhs, map_rhs(rhs), gen_opts(opts))
    end
  end
  local function gen_mapbufkey(mode, map_rhs)
    return function(lhs, rhs, buf, opts)
      vim.api.nvim_buf_set_keymap(buf, mode, lhs, map_rhs(rhs), gen_opts(opts))
    end
  end

  local to_cmd = function(s) return ':'..s..'<cr>' end
  local to_lua = function(s) return ':lua '..s..'<cr>' end
  local function get_mode_map(mode)
    return {
      [mode..'cmd'] = gen_mapkey(mode, to_cmd),
      [mode..'lua'] = gen_mapkey(mode, to_lua),
      [mode..'cmdbuf'] = gen_mapbufkey(mode, to_cmd),
      [mode..'luabuf'] = gen_mapbufkey(mode, to_lua)
    }
  end

  return vim.tbl_extend('keep',
    get_mode_map('n'),
    get_mode_map('i'),
    get_mode_map('v')
  )
end

local kmap = gen_keymap()
local opts = {noremap, silent}

return  {
  setup = function ()
    -- lsp
    kmap.nlua('<space>e', 'vim.diagnostic.open_float()', opts)
    kmap.nlua('[d', 'vim.diagnostic.goto_prev()', opts)
    kmap.nlua(']d', 'vim.diagnostic.goto_next()', opts)
    kmap.nlua('<space>q', 'vim.diagnostic.setloclist()', opts)

    -- nvim-tree
    kmap.ncmd('<C-n>', ':NvimTreeToggle', opts)
    kmap.ncmd('<leader>', ':NvimTreeRefresh', opts)
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
    kmap.nluabuf('<space>f', 'vim.lsp.buf.format()', buf, opts)
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
