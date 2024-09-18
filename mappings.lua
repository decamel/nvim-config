local M = {}

M.clangd = {
  plugin = true,
  n = {
    ["<leader>o"] = {
      "<cmd> ClangdSwitchSourceHeader <CR>",
      "Switch source header file"
    }
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Debugger: Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Debugger: Run or resume",
    },
    ["<leader>di"] = {
      "<cmd> DapStepInto <CR>",
      "Debugger: Step into"
    },
    ["<leader>do"] = {
      "<cmd> DapStepOver <CR>",
      "Debugger: Step over"
    },
    ["<leader>dus"] = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.toggle();
      end,
      "Open debugging sidebar"
    }
  },
}


M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end,
      "Debug python"
    },
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

M.bookmarks = {
  -- plugin = true,
  n = {
    ['<leader>mm'] = {
      "<cmd> BookmarksMark <CR>",
      "Markcurrent line into active Bookmarks list"
    },
    ['<leader>mg'] = {
      "<cmd> BookmarksGoto <CR>",
      "Go to bookmark at current active Bookmarks list"
    },
    ['<leader>ma'] = {
      "<cmd> BookmarksCommands <CR>",
      "Find and trigger a bookmark command."
    },
    ['<leader>mr'] = {
      "<cmd> BookmarksGotoRecent <CR>",
      "Go to latest visited/create Bookmark"
    },
  }

}

M.comment = {
  plugin = true,
  n = {
    ['<leader>cl'] = {
      "<cmd> CBccline15 <CR>",
      "Create line comment for this line"
    },
    ['<leader>cb'] = {
      "<cmd> CBccbox10 <CR>",
      "Create block comment for this line"
    },
    ['<leader>ct'] = {
      "<cmd> CBccline <CR>",
      "Create line header comment for this line",
    }
  }
}

return M
