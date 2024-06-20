local gutils = require("neotest-gtest.utils")
local neotest_ns = vim.api.nvim_create_namespace("neotest")
local lib = require("neotest.lib")

local _cpp_test_extensions = {
  ["cpp"] = true,
  ["cppm"] = true,
  ["cc"] = true,
  ["cxx"] = true,
  ["c++"] = true,
}

-- vim.diagnostic.config({
--   virtual_text = {
--     format = function(diagnostic)
--       local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
--       return message
--     end,
--   }
-- }, neotest_ns)

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      root = lib.files.match_root_pattern(
        ".git",
        ".gitignore",
        "requirements.txt"
      ),
      args = {
        "--verbose",
        "--buffer"
      },
      runner = "unittest",
    }),
    require("neotest-go")({
      recursive_run = true,
      experimental = {
        test_table = true,
      },
    }),
    require("neotest-gtest").setup({
      root = lib.files.match_root_pattern(
        "WORKSPACE",
        ".clangd",
        "vcpkg.json",
        ".git",
        "build"
      ),
      is_test_file = function(file)
        local elems = vim.split(file, lib.files.sep, { plain = true })
        local filename = elems[#elems]
        if filename == "" then
          return false
        end

        local extsplit = vim.split(filename, ".", { plain = true })
        local extension = extsplit[#extsplit]
        local fname_last_part = extsplit[#extsplit - 1]
        local result = _cpp_test_extensions[extension] and
            (vim.startswith(fname_last_part, "test_")
              or vim.endswith(fname_last_part, "_test")
              or vim.endswith(fname_last_part, "_tests"))
            or false
        return result
      end,
      mappings = {
        configure = "G"
      }
    }),
    require("neotest-plenary"),
  },
})
