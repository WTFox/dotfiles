return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "fredrikaverpil/neotest-golang",
        "rouge8/neotest-rust",
        "marilari88/neotest-vitest",
        "nvim-neotest/neotest-jest",
    },
    opts = function()
        return {
            adapters = {
                require("neotest-python")({
                    runner = "pytest",
                    dap = { justMyCode = false },
                }),
                require("neotest-golang"),
                require("neotest-rust"),
                require("neotest-vitest"),
                require("neotest-jest"),
            },
        }
    end,
    config = function(_, opts)
        require("neotest").setup(opts)
    end,
    keys = {
        {
            "<leader>tt",
            function()
                require("neotest").run.run()
            end,
            desc = "Run nearest test",
        },
        {
            "<leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Run file tests",
        },
        {
            "<leader>ta",
            function()
                require("neotest").run.run(vim.uv.cwd())
            end,
            desc = "Run all tests",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle summary",
        },
        {
            "<leader>to",
            function()
                require("neotest").output.open({ enter = true })
            end,
            desc = "Show output",
        },
        {
            "<leader>tp",
            function()
                require("neotest").output_panel.toggle()
            end,
            desc = "Toggle output panel",
        },
        {
            "<leader>tS",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop",
        },
        {
            "<leader>tl",
            function()
                require("neotest").run.run_last()
            end,
            desc = "Run last",
        },
        {
            "<leader>td",
            function()
                require("neotest").run.run({ strategy = "dap" })
            end,
            desc = "Debug nearest test",
        },
    },
}
