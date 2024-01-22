local M = {}

function M.is_wsl()
  return vim.fn.executable("wsl.exe") == 1
end

return M
