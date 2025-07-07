---@alias Kmap.opt
---| 'remap' # make the mapping recursive
---| 'nowait' # not wait for more characters to be typed, for multimatch
---| 'silent' # not be echoed on the command line
---| 'script' #
---| 'expr' # the {lhs} is an expression
---| 'unique' # fail if the mapping or abbreviation already exists

---@alias Kmap.opts Kmap.opt[]

---@alias MapFn fun(lhs: Key, rhs: any, opts: Kmap.opts|nil, buf: integer|boolean|nil)

---@return table<string, MapFn>
local function gen_keymap()
  local function gen_opts(opts, buf)
    local _opts = {
      remap  = false,
      nowait = false,
      silent = false,
      script = false,
      expr   = false,
      unique = false,
    }
    if not opts then opts = {} end
    for _, k in pairs(opts) do _opts[k] = true end
    if buf then _opts['buffer'] = buf end
    return _opts
  end

  local function gen_setkey_func(mode, map_rhs)
    ---@type MapFn
    return function(lhs, rhs, opts, buf)
      if not lhs then return end
      if not vim.islist(lhs) then lhs = { lhs } end
      for _, l in ipairs(lhs) do
        vim.keymap.set(mode, l, map_rhs(rhs), gen_opts(opts, buf))
      end
    end
  end

  local to_cmd = function(s) return ':' .. s .. '<cr>' end
  local to_lua = function(s) return ':lua ' .. s .. '<cr>' end
  local to_raw = function(c) return c end

  local function get_mode_map(mode)
    return vim.tbl_map(
      function(v)
        local _mode = {}
        mode:gsub('.', function(c)
          table.insert(_mode, c)
        end)
        return gen_setkey_func(_mode, v)
      end,
      {
        [mode .. 'cmd'] = to_cmd,
        [mode .. 'lua'] = to_lua,
        [mode .. 'raw'] = to_raw,
      })
  end

  return vim.tbl_extend('keep',
    get_mode_map('n'),
    get_mode_map('i'),
    get_mode_map('v'),
    get_mode_map('c'),
    get_mode_map('nv')
  )
end

local M = {}
local utils = require('lib.utils')

local keymap_path = vim.fn.stdpath('cache') .. '/keymap/'

M.domap = gen_keymap()

---@param name string
---@param maps table<string, Array<string>>
function M.dump_cfg(name, maps)
  utils.mpack_dump(keymap_path .. name, maps)
end

---@param name string
---@return table<string, Array<string>> | nil
function M.load_cfg(name)
  return utils.mpack_load(keymap_path .. name)
end

return M
