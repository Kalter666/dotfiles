return function()
  require("sniprun").setup {
    display = { "NvimNotify" },
    display_options = {
      notification_timeout = 60,
    },
    live_mode_toggle = "enable",
    live_display = { "NvimNotify", "TerminalOk" },
    interpreter_options = {
      Rust_original = {
        compiler = "rustc",
      },
    },
  }
end
