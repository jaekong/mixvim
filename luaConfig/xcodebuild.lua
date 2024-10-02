local xcodebuild = require('xcodebuild')
xcodebuild.setup({
    restore_on_start = true,
    auto_save = true,
    show_build_progress_bar = true,
    prepare_snapshot_test_previews = true,
    test_search = {
      file_matching = "filename_lsp",
      target_matching = true,
      lsp_client = "sourcekit",
      lsp_timeout = 200,
    },
    commands = {
      cache_devices = true,
      extra_build_args = "-parallelizeTargets",
      extra_test_args = "-parallelizeTargets",
      project_search_max_depth = 3,
      remote_debugger = nil,
      remote_debugger_port = 65123,
    },
    logs = {
      auto_open_on_success_tests = false,
      auto_open_on_failed_tests = false,
      auto_open_on_success_build = false,
      auto_open_on_failed_build = true,
      auto_close_on_app_launch = false,
      auto_close_on_success_build = false,
      auto_focus = true,
      filetype = "objc",
      open_command = "silent botright 20split {path}",
      logs_formatter = "xcbeautify --disable-colored-output",
      only_summary = false,
      live_logs = true,
      show_warnings = true,
      notify = function(message, severity)
        vim.notify(message, severity)
      end,
      notify_progress = function(message)
        vim.cmd("echo '" .. message .. "'")
      end,
    },
    console_logs = {
      enabled = true,
      format_line = function(line)
        return line
      end,
      filter_line = function(line)
        return true
      end,
    },
    marks = {
      show_signs = true,
      success_sign = "✔",
      failure_sign = "✖",
      show_test_duration = true,
      show_diagnostics = true,
    },
    quickfix = {
      show_errors_on_quickfixlist = true,
      show_warnings_on_quickfixlist = true,
    },
    test_explorer = {
      enabled = true,
      auto_open = true,
      auto_focus = true,
      open_command = "botright 42vsplit Test Explorer",
      open_expanded = true,
      success_sign = "✔",
      failure_sign = "✖",
      progress_sign = "…",
      disabled_sign = "⏸",
      partial_execution_sign = "‐",
      not_executed_sign = " ",
      show_disabled_tests = false,
      animate_status = true,
      cursor_follows_tests = true,
    },
    code_coverage = {
      enabled = false,
      file_pattern = "*.swift",

      covered_sign = "",
      partially_covered_sign = "┃",
      not_covered_sign = "┃",
      not_executable_sign = "",
    },
    code_coverage_report = {
      warning_coverage_level = 60,
      error_coverage_level = 30,
      open_expanded = false,
    },
    integrations = {
      xcode_build_server = {
        enabled = true,
      },
      nvim_tree = {
        enabled = true,
        guess_target = true,
        should_update_project = function(path)
          local hasProjectFile = vim.fn.filereadable("./Project.swift") == 1
          local hasTuistDir = vim.fn.finddir("Tuist") ~= ""
          if hasProjectFile and hasTuistDir then
            local handle
            local generated = function (status)
              if status == 0 then
                vim.notify("Tuist Project regenerated.", vim.log.levels.INFO)
              else
                vim.notify("Tuist project generation failed.", vim.log.levels.ERROR)
              end
            end
            handle = vim.uv.spawn("tuist", { args = { "generate" } }, generated)

            return false
          end

          return true
        end,
      },
      neo_tree = {
        enabled = true,
        guess_target = true,
        should_update_project = function(path)
          local hasProjectFile = vim.fn.filereadable("./Project.swift") == 1
          local hasTuistDir = vim.fn.finddir("Tuist") ~= ""
          if hasProjectFile and hasTuistDir then
            local handle
            local generated = function (status)
              if status == 0 then
                vim.notify("Tuist Project regenerated.", vim.log.levels.INFO)
              else
                vim.notify("Tuist project generation failed.", vim.log.levels.ERROR)
              end
            end
            handle = vim.uv.spawn("tuist", { args = { "generate" } }, generated)

            return false
          end

          return true
        end,
      },
      oil_nvim = {
        enabled = true,
        guess_target = true,
        should_update_project = function(path)
          local hasProjectFile = vim.fn.filereadable("./Project.swift") == 1
          local hasTuistDir = vim.fn.finddir("Tuist") ~= ""
          if hasProjectFile and hasTuistDir then
            local handle
            local generated = function (status)
              if status == 0 then
                vim.notify("Tuist Project regenerated.", vim.log.levels.INFO)
              else
                vim.notify("Tuist project generation failed.", vim.log.levels.ERROR)
              end
            end
            handle = vim.uv.spawn("tuist", { args = { "generate" } }, generated)

            return false
          end

          return true
        end,
      },
      quick = {
        enabled = true,
      },
    },
    highlights = {},
  })

vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
-- vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
-- vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Show Code Coverage Report" })
vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })

xcodebuildDap = require('xcodebuild.integrations.dap')
xcodebuildDap.setup("codelldb")


vim.keymap.set("n", "<leader>dd", xcodebuildDap.build_and_debug, { desc = "Build & Debug" })
vim.keymap.set("n", "<leader>dr", xcodebuildDap.debug_without_build, { desc = "Debug Without Building" })
vim.keymap.set("n", "<leader>dt", xcodebuildDap.debug_tests, { desc = "Debug Tests" })
vim.keymap.set("n", "<leader>dT", xcodebuildDap.debug_class_tests, { desc = "Debug Class Tests" })
vim.keymap.set("n", "<leader>b", xcodebuildDap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", xcodebuildDap.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
vim.keymap.set("n", "<leader>dx", xcodebuildDap.terminate_session, { desc = "Terminate Debugger" })

local dapui = require("dapui")
local dap = require("dap")

local adapter = xcodebuildDap.get_codelldb_adapter("codelldb")
-- table.insert(adapter.executable.args, "--settings")
-- table.insert(adapter.executable.args, "'{\"showDisassembly\" : \"never\"}'")

dap.configurations.swift[1].postRunCommands = {
      "breakpoint delete cpp_exception",
}

dapui.setup({
  controls = {
    element = "repl",
    enabled = true,
  },
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  icons = { collapsed = "", expanded = "", current_frame = "" },
  layouts = {
    {
      elements = {
        { id = "repl", size = 0.34 },
        { id = "breakpoints", size = 0.33},
        { id = "console", size = 0.33 },
      },
      position = "bottom",
      size = 10,
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


