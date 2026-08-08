return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {},
                config = function(_, opts)
                    local dap, dapui = require("dap"), require("dapui")
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close()
                    end
                end,
            },
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "mason-org/mason.nvim" },
                -- installation is owned by mason-tool-installer.nvim (lua/plugins/mason.lua);
                -- this just bridges already-installed adapters into nvim-dap
                opts = {
                    automatic_installation = true,
                    handlers = {},
                },
            },
            {
                "mfussenegger/nvim-dap-python",
                keys = {
                    {
                        "<leader>dm",
                        function()
                            require("dap-python").test_method()
                        end,
                        desc = "Debug nearest method",
                    },
                },
                config = function()
                    local mason_registry = require("mason-registry")
                    local debugpy_path = mason_registry.get_package("debugpy"):get_install_path()
                    require("dap-python").setup(debugpy_path .. "/venv/bin/python")
                end,
            },
            { "leoluz/nvim-dap-go", opts = {} },
        },
        config = function()
            -- codelldb adapter for Rust/C/C++, installed via mason
            local mason_registry = require("mason-registry")
            local codelldb_path = mason_registry.get_package("codelldb"):get_install_path()
                .. "/extension/adapter/codelldb"

            local dap = require("dap")
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = codelldb_path,
                    args = { "--port", "${port}" },
                },
            }

            for _, lang in ipairs({ "rust", "c", "cpp" }) do
                dap.configurations[lang] = {
                    {
                        name = "Launch",
                        type = "codelldb",
                        request = "launch",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                    },
                }
            end
        end,
        keys = {
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Continue",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle breakpoint",
            },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Conditional breakpoint",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_over()
                end,
                desc = "Step over",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step into",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "Step out",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "Toggle REPL",
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "Run last",
            },
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                desc = "Toggle dap-ui",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
            {
                "<leader>de",
                function()
                    require("dapui").eval()
                end,
                mode = { "n", "v" },
                desc = "Eval expression",
            },
        },
    },
}
