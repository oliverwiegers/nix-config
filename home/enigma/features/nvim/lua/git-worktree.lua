require("git-worktree").setup()

local Worktree = require("git-worktree")
local Job = require("plenary.job")

local function	is_nrdp()
  return not not (string.find(vim.loop.cwd(), vim.env.NRDP, 1, true))
end

Worktree.on_tree_change(function(op)
  if op == "create" and is_nrdp() then
    Job:new({
      "git", "submodle", "update", "--init", "--recursive", "--remote"
    }):start()
  end
end)
