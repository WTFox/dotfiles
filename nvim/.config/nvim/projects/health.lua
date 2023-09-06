-- require("neotest").setup({
--   quickfix = {
--     enabled = false,
--   },
--   output = {
--     enabled = true,
--     open_on_run = true,
--   },
--   output_panel = {
--     enabled = true,
--     open = "botright split | resize 15",
--   },
--   adapters = {
--     require("neotest-python")({
--       args = {
--         "--create-db",
--         "--nomigrations",
--         "--ignore=node_modules",
--       },
--     }),
--     require("neotest-jest")({
--       command = "~/dev/health/node_modules/.bin/jest",
--       args = {
--         "--config=jest.config.js",
--       },
--       working_directory = "~/dev/health",
--     }),
--   },
-- })

return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "nvim-neotest/neotest-python",
  },
  opts = {
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
    adapters = {
      ["neotest-python"] = {
        -- Here you can specify the settings for the adapter, i.e.
        -- runner = "pytest",
        python = "venv/bin/python",
        args = {
          "--create-db",
          "--nomigrations",
          "--ignore=node_modules",
        },
      },
      ["neotest-jest"] = {
        command = "~/dev/health/node_modules/.bin/jest",
        args = {
          "--config=jest.config.js",
        },
        working_directory = "~/dev/health",
      },
    },
  },
}
