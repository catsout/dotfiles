local M = {};

function M.ver_runtime()
  local vserion_str = function()
    return vim.version().major .. '.' .. vim.version().minor .. '.x'
  end

  return vim.fn.stdpath('config') .. '/ver/' .. vserion_str()
end

function M.dirname(str)
	if str:match(".-/.-") then
		local name = string.gsub(str, "(.*/)(.*)", "%1")
		return name
	else
		return ''
	end
end

function M.mpack_dump(path, obj)
  vim.fn.mkdir(M.dirname(path), 'p')
  local file = io.open(path, 'w')
  if file then
    file:write(vim.mpack.encode(obj))
    file:close()
  end
end

function M.mpack_load(path)
  local file = io.open(path, 'r')
  if file then
    return vim.mpack.decode(file:read("*a"))
  end
  return nil
end


function M.join_paths(...)
  return vim.fs.normalize(table.concat({ ... }, '/'))
end


return M;
