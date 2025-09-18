return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>ghp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
        { "<leader>ghb", function() require("gitsigns").blame_line() end, desc = "Blame line" },
        { "<leader>ghr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
        { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next git hunk" },
        { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Previous git hunk" },
    },
    opts = {
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
    },
}
