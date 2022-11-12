local mock = require('luassert.mock')
local stub = require('luassert.stub')
local imaps = require('module.imaps')

describe("test markdown math mode", function()
  it("correctly responds true", function()
    local ts_utils = mock(require('nvim-treesitter.ts_utils'), true)
    local api = mock(vim.api, true)

    ts_utils.get_node_at_cursor.returns({
      type = function(_) return "inline" end,
      parent = function(_) return nil end
    })
    ts_utils.get_root_for_node.returns(true)
    ts_utils.get_node_range.returns(20, 0, 30, 0)
    api.nvim_buf_get_lines.returns({
      "",
      "More formally,",
      "suppose that $$X$$ is a geodesic metric space,",
      "so the distance between any two points is realized",
      "by the length of some shortest path between them.",
      "(In fact this can be weakened somewhat)",
      "Let's assume further that",
      "the metric on $$X$$ is *proper,*",
      "so that closed balls are compact.",
      "(It follows that $$X$$ is locally compact ",
      "and that the metric is complete.)"
    })
    api.nvim_win_get_cursor.returns(22, 15)
    local inside = imaps.markdown_math_mode()
    assert.equals(true, inside)
    mock.revert(api)
    mock.revert(ts_utils)
  end)
end)

