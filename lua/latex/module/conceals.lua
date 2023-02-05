local query = require("vim.treesitter.query")

local M = {}

local function read_query_files(filenames)
  local contents = ""

  for _, filename in ipairs(filenames) do
    local file, err = io.open(filename, 'r')
    local payload = ''
    if file then
      payload = file:read('*a')
      io.close(file)
    else
      error(err)
    end
    contents = contents .. '\n' .. payload
  end
  return contents
end

local function hasgrandparent(match, _, _, predicate)
  local node = match[predicate[2]]
  for _ = 1, 2 do
    if not node then return false end
    node = node:parent()
  end
  if not node then return false end
  local ancestor_types = { unpack(predicate, 3) }
  if vim.tbl_contains(ancestor_types, node:type()) then
    return true
  end
  return false
end

local function setpairs(match, _, source, predicate, metadata)
  -- (#set-pairs! @aa key list)
  local capture_id = predicate[2]
  local node = match[capture_id]
  local key = predicate[3]
  if not node then return end
  local node_text = query.get_node_text(node, source)
  -- if metadata[capture_id] and metadata[capture_id].range then
  --   local sr, sc, er, ec = unpack(metadata[capture_id].range)
  --   node_text = vim.api.nvim_buf_get_text(source, sr, sc, er, ec, {})[1]
  -- end
  for i = 4, #predicate, 2 do
    if node_text == predicate[i] then
      metadata[key] = predicate[i+1]
      break
    end
  end
end

local function load_queries(args)
  local filenames = query.get_query_files('latex', 'highlights')
  query.add_predicate('has-grandparent?', hasgrandparent, true)
  query.add_directive('set-pairs!', setpairs, true)
  for _, name in ipairs(args.enabled) do
    local files = vim.api.nvim_get_runtime_file("queries/latex/conceal_" .. name .. ".scm", true)
    for _, file in ipairs(files) do
      table.insert(filenames, file)
    end
  end
  local strings = read_query_files(filenames) or ''
  local added_query_start =
  [[(generic_command
    command: ((command_name) @text.math
    (#any-of? @text.math
  ]]
  local added_query_middle =
  [[
  ))
  (#set-pairs! @text.math conceal
  ]]
  local added_query_end = "))"
  for command, conceal in pairs(args.add) do
    added_query_start = added_query_start .. '"\\\\' .. command .. '" '
    added_query_middle = added_query_middle .. '"\\\\' .. command .. '" "' .. conceal .. '" '
  end
  if next(args.add) then
    strings = strings .. added_query_start ..added_query_middle .. added_query_end
  end
  query.set_query('latex', 'highlights', strings)
end

function M.init(args)
  if args.enabled == false then return end
  load_queries(args)
end

return M
