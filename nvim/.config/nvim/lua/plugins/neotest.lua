return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            --   command = "~/path/to/jest",
            --   args = {
            --     "--config=jest.config.js",
            --   },
            --   working_directory = "~/path/to/project",
          }),
          require("neotest-python")({
            -- python = "/path/to/python",
            -- runner = "pytest",
            -- args = {
            --   "--pytest-arg-1",
            --   "--pytest-arg-2",
            --   "--pytest-arg-3",
            -- },
          }),
        },
        quickfix = {
          enabled = false,
        },
        output = {
          enabled = true,
          open_on_run = true,
        },
        output_panel = {
          enabled = true,
          open = "botright split | resize 15",
        },
      })
    end,
  },
}
