local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  }
}

dap.adapters["dart"] = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
  args = {"flutter"}
}

for _, language in ipairs {"typescript", "javascript"} do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
  }
end
