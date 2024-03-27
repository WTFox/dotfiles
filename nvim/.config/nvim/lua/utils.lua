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

function M.read_jsonfile(file)
  local f = io.open(file, "r")
  if f == nil then
    return nil
  end
  local content = f:read("*all")
  f:close()
  return vim.fn.json_decode(content)
end

return M
