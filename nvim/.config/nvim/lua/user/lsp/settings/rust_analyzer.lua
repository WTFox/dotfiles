return { {
  assist = {
    importEnforceGranularity = true,
    importPrefix = "crate"
  },
  cargo = {
    allFeatures = true
  },
  checkOnSave = {
    -- default: `cargo check`
    command = "clippy"
  },
},
  inlayHints = {
    lifetimeElisionHints = {
      enable = true,
      useParameterNames = true
    },
  },
}
