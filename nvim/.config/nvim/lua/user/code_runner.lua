local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
  return
end

code_runner.setup {
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3 -u",
    typescript = "deno run",
    javascript = "deno run",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
  },
  mode = 'toggleterm',
}
