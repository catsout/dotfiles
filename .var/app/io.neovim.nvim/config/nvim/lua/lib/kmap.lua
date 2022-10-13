local function gen_keymap()
  local function gen_opts(opts, buf)
    local _opts = {}
    for _, k in pairs(opts) do _opts[k] = true end
    _opts['buffer'] = buf
    return _opts
  end

  local function gen_mapkey(mode, map_rhs)
    return function(lhs, rhs, opts, buf)
      vim.keymap.set(mode, lhs, map_rhs(rhs), gen_opts(opts, buf))
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
        return gen_mapkey(_mode, v)
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

return gen_keymap()
