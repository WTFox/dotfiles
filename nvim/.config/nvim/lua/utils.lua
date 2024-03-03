local M = {}

function M.wants_transparent_background()
  return os.getenv("NVIM_TRANSPARENT_BACKGROUND") == "1"
end

function M.is_wsl()
  return vim.fn.executable("wsl.exe") == 1
end

function M.is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

return M
