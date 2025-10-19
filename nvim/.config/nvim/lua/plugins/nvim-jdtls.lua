return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	opts = function()
		return {
			-- Use the jdtls wrapper from Mason with Java 21
			cmd = {
				vim.fn.stdpath("data") .. "/mason/bin/jdtls",
				"--java-executable",
				"/opt/homebrew/opt/openjdk@21/bin/java",
			},

			-- Root directory detection
			root_dir = function(fname)
				local markers = { "gradlew", ".git", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts" }
				return vim.fs.root(fname, markers)
			end,

			-- Project name from root directory
			project_name = function(root_dir)
				return root_dir and vim.fs.basename(root_dir)
			end,

			-- Config and workspace directories
			jdtls_config_dir = function(project_name)
				return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
			end,
			jdtls_workspace_dir = function(project_name)
				return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
			end,

			-- Build the full command
			full_cmd = function(opts)
				local fname = vim.api.nvim_buf_get_name(0)
				local root_dir = opts.root_dir(fname)
				local project_name = opts.project_name(root_dir)
				local cmd = vim.deepcopy(opts.cmd)
				if project_name then
					vim.list_extend(cmd, {
						"-configuration",
						opts.jdtls_config_dir(project_name),
						"-data",
						opts.jdtls_workspace_dir(project_name),
					})
				end
				return cmd
			end,

			-- Java settings
			settings = {
				java = {
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },
					completion = {
						favoriteStaticMembers = {
							"org.junit.Assert.*",
							"org.junit.Assume.*",
							"org.junit.jupiter.api.Assertions.*",
							"org.junit.jupiter.api.Assumptions.*",
							"org.mockito.Mockito.*",
							"org.mockito.ArgumentMatchers.*",
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
				},
			},
		}
	end,
	config = function(_, opts)
		local function attach_jdtls()
			local fname = vim.api.nvim_buf_get_name(0)

			local config = {
				cmd = opts.full_cmd(opts),
				root_dir = opts.root_dir(fname),
				settings = opts.settings,
				init_options = {
					bundles = {},
				},
			}

			require("jdtls").start_or_attach(config)
		end

		-- Attach for each java buffer
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = attach_jdtls,
		})

		-- Attach immediately for the first file
		attach_jdtls()
	end,
}
