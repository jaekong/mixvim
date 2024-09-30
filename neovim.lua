require("smart-splits").setup({
  at_edge = 'stop';
})

---@return boolean
local function at_top_edge()
  return vim.fn.winnr() == vim.fn.winnr('k')
end

---@return boolean
local function at_bottom_edge()
  return vim.fn.winnr() == vim.fn.winnr('j')
end

---@return boolean
local function at_left_edge()
  return vim.fn.winnr() == vim.fn.winnr('h')
end

---@return boolean
local function at_right_edge()
  return vim.fn.winnr() == vim.fn.winnr('l')
end

vim.api.nvim_create_user_command(
  "AtLeftEdge",
  function()
    print(at_left_edge())
  end,
  {}
)
vim.api.nvim_create_user_command(
  "AtRightEdge",
  function()
    print(at_right_edge())
  end,
  {}
)
vim.api.nvim_create_user_command(
  "AtTopEdge",
  function()
    print(at_top_edge())
  end,
  {}
)
vim.api.nvim_create_user_command(
  "AtBottomEdge",
  function()
    print(at_bottom_edge())
  end,
  {}
)

require('hover').setup {
  init = function ()
    require('hover.providers.lsp')
  end,
  preview_opts = {
    border = 'single'
  },
  mouse_providers = { 'LSP' },
  mouse_delay = 1000
}

vim.g.is_at_start = function()
  local col = vim.fn.col('.') - 1
  local line = vim.fn.getline('.')
  local char_under_cursor = string.sub(line, 0, col)

  if col == 0 or string.match(char_under_cursor, '^%s+$') then
    return true
  else
    return false
  end
end

vim.g.if_is_at_start = function (cmd_true, cmd_false)
  if vim.g.is_at_start() then
    vim.cmd(cmd_true)
  else
    vim.cmd(cmd_false)
  end
end

vim.g.select_line = function()
  if vim.api.nvim_get_mode()["mode"] == "v" then
    vim.api.nvim_feedkeys("+", "v", false);
  else
    local currentLine = vim.fn.line(".")
    local currentLineEndColumn = vim.fn.line("$") - 1
    vim.fn.setpos("\'<", {0, currentLine, 0, 0})
    vim.fn.setpos("\'>", {0, currentLine, currentLineEndColumn, 0})
    vim.api.nvim_feedkeys("v", "n", false);
  end
end
