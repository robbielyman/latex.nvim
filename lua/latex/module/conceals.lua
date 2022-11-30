local query = require("vim.treesitter.query")

local M = {}

local function safe_read(filename, read_quantifier)
  local file, err = io.open(filename, 'r')
  if not file then
    error(err)
  end
  local content = file:read(read_quantifier)
  io.close(file)
  return content
end

local function read_query_files(filenames)
  local contents = {}

  for _, filename in ipairs(filenames) do
    table.insert(contents, safe_read(filename, '*a'))
  end

  return table.concat(contents, '')
end

local function hasgrandparent(match, _, _, predicate)
  local node = match[predicate[2]]
  for i = 1, 2 do
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

function M.init(args)
  if args.enabled == false then return end
  local filenames = vim.treesitter.query.get_query_files('latex', 'highlights')
  query.add_predicate('has-grandparent?', hasgrandparent, true)
  query.add_directive("set-pairs!", setpairs, true)
  for _, name in ipairs(args.enabled) do
    local files = vim.api.nvim_get_runtime_file("queries/latex/conceal_" .. name .. ".scm", true)
    for _, file in ipairs(files) do
      table.insert(filenames, file)
    end
  end
  local strings = read_query_files(filenames)
  vim.treesitter.query.set_query('latex', 'highlights', strings)
end

return M
