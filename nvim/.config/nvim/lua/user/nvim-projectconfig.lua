local status_ok, projectconfig = pcall(require, "nvim-projectconfig")
if not status_ok then
  return
end

projectconfig.setup()
