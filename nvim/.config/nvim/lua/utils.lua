local M = {}

function M.is_wsl()
  return vim.fn.executable("wsl.exe") == 1
end

function M.is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

return M
