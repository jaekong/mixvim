local pid = vim.fn.getpid()

vim.opt.titlestring = [[nvim [%{luaeval('vim.fn.getpid()')}%{']'}]]
vim.cmd("set title")

os.execute("mkdir -p /tmp/nvim-server")

vim.fn.serverstart("/tmp/nvim-server/" .. tostring(pid) .. ".pipe")

