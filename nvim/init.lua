local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- run :GoBuild or :GoTestCompile based on the go file
local function build_go_files()
  if vim.endswith(vim.api.nvim_buf_get_name(0), "_test.go") then
    vim.cmd("GoTestCompile")
  else
    vim.cmd("GoBuild")
  end
end

----------------
--- plugins ---
----------------
require("lazy").setup({

  -- colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard"
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- automatic dark mode
  -- requires: brew install cormacrelf/tap/dark-notify
  {
    "cormacrelf/dark-notify",
    config = function()
      require("dark_notify").run()
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup({
        options = { theme = 'gruvbox' },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 2 -- absolute path
            }
          }
        }
      })
    end,
  },

  -- vim-go
  {
    "fatih/vim-go",
    config = function()
      -- disable most features in favor of treesitter and native LSP
      vim.g['go_gopls_enabled'] = 0
      vim.g['go_code_completion_enabled'] = 0
      vim.g['go_fmt_autosave'] = 0
      vim.g['go_imports_autosave'] = 0
      vim.g['go_mod_fmt_autosave'] = 0
      vim.g['go_doc_keywordprg_enabled'] = 0
      vim.g['go_def_mapping_enabled'] = 0
      vim.g['go_textobj_enabled'] = 0
      vim.g['go_list_type'] = 'quickfix'
    end,
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'go',
          'gomod',
          'proto',
          'lua',
          'vimdoc',
          'vim',
          'bash',
          'fish',
          'json',
          'yaml',
          'toml',
          'ruby',
          'rust',
          'python',
          'swift',
          'markdown',
          'markdown_inline',
          'mermaid',
          'dockerfile',
          'hcl',
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<space>",
            node_incremental = "<space>",
            node_decremental = "<bs>",
            scope_incremental = "<tab>",
          },
        },
        autopairs = {
          enable = true,
        },
        highlight = {
          enable = true,

          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ["iB"] = "@block.inner",
              ["aB"] = "@block.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']]'] = '@function.outer',
            },
            goto_next_end = {
              [']['] = '@function.outer',
            },
            goto_previous_start = {
              ['[['] = '@function.outer',
            },
            goto_previous_end = {
              ['[]'] = '@function.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>sn'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>sp'] = '@parameter.inner',
            },
          },
        },
      })
    end,
  },

  -- search selection via *
  { 'bronson/vim-visual-star-search' },

  {
    'dinhhuy258/git.nvim',
    config = function()
      require("git").setup()
    end,
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        filters = {
          dotfiles = true,
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function opts(desc)
            return {
              desc = 'nvim-tree: ' .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
          vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
          vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
        end
      })
    end,
  },

  -- save my last cursor position
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true
      })
    end,
  },

  {
    "AndrewRadev/splitjoin.vim"
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup {
        check_ts = true,
      }

      -- Remove backtick pairing
      local Rule = require('nvim-autopairs.rule')
      npairs.remove_rule('`')
    end
  },

  {
    "coder/claudecode.nvim",
    lazy = false,
    opts = {
      terminal = {
        provider = "none",
      },
    },
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
    },
    keys = {
      { "<leader>c", nil, desc = "AI/Claude Code" },
      { "<C-t>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ca", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>cs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      { "<leader>da", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>dd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    }
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "elanmed/fzf-lua-frecency.nvim",
    },
    opts = {},
    config = function()
      require("fzf-lua").register_ui_select()
      require('fzf-lua').setup {
        oldfiles = {
           include_current_session = true,
        },
        winopts = {
          backdrop = 100,
          border = "single",
          preview = {
            hidden = true,
            default = "bat",
            border = "rounded",
            title = false,
            layout = "vertical",
            horizontal = "right:50%",
          },
        },
        git = {
           files = {
             cwd_header = false,
             prompt        = '> ',
             cmd           = 'git ls-files --exclude-standard',
             multiprocess  = true,
             git_icons     = false,
             file_icons    = false,
             color_icons   = false,
           },
        },
        files = {
          git_files = false,
          cwd_header = false,
          cwd_prompt = true,
          file_icons = false,
        }
      }

      -- Setup frecency for fzf-lua (tracks frequently + recently used files)
      require('fzf-lua-frecency').setup()

     vim.keymap.set("n", "<C-p>", function()
       local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
       if vim.v.shell_error ~= 0 then
         git_root = vim.fn.getcwd()
       end
       require('fzf-lua-frecency').frecency({
         file_icons = false,
         git_icons = false,
         cwd_only = true,
         cwd = git_root,
       })
     end, {})
     vim.keymap.set("n", "<C-b>", require("fzf-lua").files, {})
     vim.keymap.set("n", "<C-g>", require("fzf-lua").lsp_document_symbols, {})
    end
  },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  -- Useful status updates for LSP
  { 'j-hui/fidget.nvim', opts = {} },

  -- Extra capabilities for nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp' },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "lukas-reineke/cmp-under-comparator",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local types = require("cmp.types")
      local compare = require("cmp.config.compare")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      luasnip.config.setup {}

      local modified_priority = {
          [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
          [types.lsp.CompletionItemKind.Snippet] = 0, -- top
          [types.lsp.CompletionItemKind.Keyword] = 0, -- top
          [types.lsp.CompletionItemKind.Text] = 100, -- bottom
      }

      local function modified_kind(kind)
          return modified_priority[kind] or kind
      end

      require('cmp').setup({
        preselect = false,
        completion = {
            completeopt = "menu,menuone,preview,noselect",
        },
        snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
        },
        formatting = {
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
            },
          },
        },

        sorting = {
            priority_weight = 1.0,
            comparators = {
                compare.offset,
                compare.exact,
                compare.score,
                compare.locality,
                function(entry1, entry2) -- sort by length ignoring "=~"
                    local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
                    local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
                    if len1 ~= len2 then
                        return len1 - len2 < 0
                    end
                end,
                compare.recently_used,
                function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
                    local kind1 = modified_kind(entry1:get_kind())
                    local kind2 = modified_kind(entry2:get_kind())
                    if kind1 ~= kind2 then
                        return kind1 - kind2 < 0
                    end
                end,
                require("cmp-under-comparator").under,
                compare.kind,
            },
        },

        matching = {
           disallow_fuzzy_matching = true,
           disallow_fullfuzzy_matching = true,
           disallow_partial_fuzzy_matching = true,
           disallow_partial_matching = false,
           disallow_prefix_unmatching = true,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
          end, { 'i', 's' }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then
                 cmp.select_prev_item()
             elseif luasnip.jumpable(-1) then
                 luasnip.jump(-1)
             else
                 fallback()
             end
          end, { "i", "s" }),

        },
        window = { documentation = cmp.config.window.bordered(), completion = cmp.config.window.bordered() },
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
          },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Insert,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = "luasnip", keyword_length = 2},
          { name = "buffer", keyword_length = 5},
        },
        performance = {
          max_view_entries = 20,
        },
      })
    end,
  },

})

----------------
--- LSP Setup (Neovim 0.11 native) ---
----------------

-- Get capabilities from cmp-nvim-lsp for better completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- gopls (install: brew install gopls)
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  capabilities = capabilities,
})

-- lua-language-server (install: brew install lua-language-server)
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
})

-- rust-analyzer (install: brew install rust-analyzer)
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  capabilities = capabilities,
})

-- Enable the LSP servers
vim.lsp.enable({ 'gopls', 'lua_ls', 'rust_analyzer' })

----------------
--- SETTINGS ---
----------------

-- disable netrw at the very start of our init.lua, because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autowrite = true
vim.opt.autochdir = true

vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = 'menuone,noinsert,noselect'

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.wrap = true

-- This comes first, because we have mappings that depend on leader
vim.g.mapleader = ','

-- Fast saving
vim.keymap.set('n', '<Leader>w', ':write!<CR>')
vim.keymap.set('n', '<Leader>q', ':q!<CR>', { silent = true })

-- Some useful quickfix shortcuts
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-m>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>a', '<cmd>cclose<CR>')

-- Exit on jj and jk
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')

-- Copy current filepath to system clipboard (relative to git root)
vim.keymap.set('n', '<Leader>e', function()
  local git_prefix = vim.fn.system('git rev-parse --show-prefix'):gsub('\n', '')
  local path
  if vim.v.shell_error == 0 then
    path = git_prefix .. vim.fn.expand('%')
  else
    path = vim.fn.expand('%:p')
  end
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { silent = true })

-- Copy absolute filepath to system clipboard
vim.keymap.set('n', '<Leader>r', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { silent = true })

-- Remove search highlight
vim.keymap.set('n', '<Leader><space>', ':nohlsearch<CR>')

-- Search mappings: center on the line
vim.keymap.set('n', 'n', 'nzzzv', {noremap = true})
vim.keymap.set('n', 'N', 'Nzzzv', {noremap = true})

-- Don't jump forward if I highlight and search for a word
local function stay_star()
  local sview = vim.fn.winsaveview()
  local args = string.format("keepjumps keeppatterns execute %q", "sil normal! *")
  vim.api.nvim_command(args)
  vim.fn.winrestview(sview)
end
vim.keymap.set('n', '*', stay_star, {noremap = true, silent = true})

-- Ctrl-c as ESC (fixes visual block mode paste)
vim.keymap.set('i', '<C-c>', '<ESC>')

-- Keep clipboard when pasting over selection
vim.keymap.set("x", "p", "\"_dP")

-- Better split switching
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Terminal mode window switching
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- Visual linewise up and down by default
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', '<Down>', 'gj')

-- Yanking a line should act like D and C
vim.keymap.set('n', 'Y', 'y$')

if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true

  local function update_title()
    local root = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')
    if vim.v.shell_error == 0 and #root > 0 and root[1] ~= '' then
      vim.opt.titlestring = vim.fn.fnamemodify(root[1], ':t')
    else
      vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end
  end

  update_title()

  vim.api.nvim_create_autocmd({'DirChanged', 'VimEnter'}, {
    callback = update_title,
  })
end

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

-- git.nvim
vim.keymap.set('n', '<leader>gb', '<CMD>lua require("git.blame").blame()<CR>')
vim.keymap.set('n', '<leader>go', "<CMD>lua require('git.browse').open(false)<CR>")
vim.keymap.set('x', '<leader>go', ":<C-u> lua require('git.browse').open(true)<CR>")

vim.api.nvim_create_user_command("GBrowse", 'lua require("git.browse").open(true)<CR>', {
  range = true,
  bang = true,
  nargs = "*",
})

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle!<CR>', { noremap = true })

-- vim-go
vim.keymap.set('n', '<leader>b', build_go_files)
vim.api.nvim_create_user_command("A", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'edit'})<CR>", {})
vim.api.nvim_create_user_command("AV", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'vsplit'})<CR>", {})
vim.api.nvim_create_user_command("AS", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'split'})<CR>", {})

-- Go uses tabs for indentation
vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('setIndent', { clear = true }),
  pattern = { 'go' },
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4'
})

-- automatically resize all vim buffers if I resize the terminal window
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- OSC 7: Report working directory to terminal (for Ghostty split inheritance)
local function osc7_notify()
  local cwd = vim.fn.getcwd()
  if cwd:match('/.git$') or cwd:match('/.git/') then
    cwd = cwd:gsub('/.git.*$', '')
  end
  local osc7 = string.format("\027]7;file://%s\007", cwd)
  vim.fn.chansend(vim.v.stderr, osc7)
end

local osc7_group = vim.api.nvim_create_augroup('osc7', { clear = true })

vim.api.nvim_create_autocmd('DirChanged', {
  group = osc7_group,
  pattern = { '*' },
  callback = osc7_notify,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = osc7_group,
  pattern = { '*' },
  callback = osc7_notify,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = osc7_group,
  pattern = { '*' },
  callback = osc7_notify,
})

-- put quickfix window always to the bottom
local qfgroup = vim.api.nvim_create_augroup('changeQuickfix', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'wincmd J',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'setlocal wrap',
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- disable diagnostics virtual text
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
  update_in_insert = false,
})

-- Run gofmt/gofumpt, import packages automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('setGoFormatting', { clear = true }),
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end

    vim.lsp.buf.format()
  end
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>s', "<cmd>belowright split | lua vim.lsp.buf.definition()<CR>", opts)

    vim.keymap.set('n', 'gr', function()
      vim.lsp.buf.references(nil, {
        on_list = function(options)
          vim.fn.setqflist({}, ' ', options)
          if #options.items > 0 then
            vim.cmd('copen')
            vim.cmd('cfirst')
            vim.cmd('normal! zz')
          end
        end
      })
    end, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})
