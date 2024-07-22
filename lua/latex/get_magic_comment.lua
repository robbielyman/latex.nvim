local get_magic_comment = function(key, ific)
  if ific == nil then
    ific = true
  end
  if ific then
    key = string.lower(key)
  end
  local i = 0
  local value = nil
  while true do
    local line = vim.api.nvim_buf_get_lines(0, i, i + 1, false)[1]
    if string.match(line, "^%%!") then
      if ific then
        line = string.lower(line)
      end
      if string.find(line, key, 1, true) then
        value = string.match(line, "[^ =]*$")
        break
      end
      i = i + 1
    else
      break
    end
  end
  return value
end
return get_magic_comment
