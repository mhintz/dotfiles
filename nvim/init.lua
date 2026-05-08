-- ****** RUNTIMEPATH ******
-- Keep ~/.vim and ~/.vim/after on the runtimepath so existing plugins,
-- autoload scripts, and the vim-plug bundle directory keep working.
vim.opt.runtimepath:prepend(vim.fn.expand('~/.vim'))
vim.opt.runtimepath:append(vim.fn.expand('~/.vim/after'))
vim.o.packpath = vim.o.runtimepath

-- ****** PLUGINS (vim-plug) ******
-- Kept as vimscript so the lambda-style `do` hook keeps working unchanged.
vim.cmd([[
  call plug#begin('~/.vim/bundle')
  " tmux integration
  Plug 'vim-airline/vim-airline'
  Plug 'christoomey/vim-tmux-navigator'
  " highlighting / themes
  Plug 'sheerun/vim-polyglot'
  Plug 'alunny/pegjs-vim', {'for': ['pegjs']}
  Plug 'junegunn/seoul256.vim'
  Plug 'vim-airline/vim-airline-themes'
  " ergonomics
  Plug 'chaoren/vim-wordmotion'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'Raimondi/delimitMate'
  Plug 'editorconfig/editorconfig-vim'
  " utilities
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'wincent/ferret', {'on': 'Acks'}
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  " neovim lsp
  " Plug 'neovim/nvim-lspconfig'
  " coc-nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " install these JS/TS plugins manually:
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install'}
  Plug 'neoclide/coc-eslint', {'do': 'yarn install'}
  Plug 'neoclide/coc-prettier', {'do': 'yarn install'}
  " rust / python
  " Plug 'neoclide/coc-rls', {'do': 'yarn install'}
  Plug 'fannheyward/coc-rust-analyzer', { 'do': 'yarn install' }
  Plug 'pappasam/coc-jedi', { 'do': 'yarn install && yarn build', 'branch': 'main' }
  " Plug 'neoclide/coc-python', {'do': 'yarn install'}
  " Golang
  " Plug 'josa42/coc-go', { 'do': 'yarn install' }
  " Plug 'neoclide/coc-json', {'do': 'yarn install'}
  " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " AI Stuff
  " Plug 'github/copilot.vim'

  " Avante deps
  " Plug 'nvim-lua/plenary.nvim'
  " Plug 'MunifTanjim/nui.nvim'
  " Plug 'MeanderingProgrammer/render-markdown.nvim'
  " Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make BUILD_FROM_SOURCE=true' }

  " Windsurf extension
  " Plug 'hrsh7th/nvim-cmp'
  " Plug 'Exafunction/windsurf.nvim'

  " maybe?
  " Plug 'rakr/vim-one'
  " Plug 'edkolev/tmuxline.vim'
  " Plug 'ervandew/supertab'
  " Plug 'craigemery/vim-autotag'
  " Plug 'jason0x43/vim-js-indent'
  " Plug 'tpope/vim-unimpaired'
  call plug#end()
]])

-- ****** BASIC OPTIONS ******
vim.opt.encoding = 'utf-8'
vim.cmd('filetype plugin indent on')

-- ****** THEME AND HIGHLIGHTING ******

-- nvim file rendering options
vim.opt.lazyredraw = true
vim.opt.termguicolors = true

-- seoul256 colors for the built-in terminal (also used by fzf preview).
vim.g.terminal_color_0  = '#606060'
vim.g.terminal_color_1  = '#df9a98'
vim.g.terminal_color_2  = '#719672'
vim.g.terminal_color_3  = '#e0bb71'
vim.g.terminal_color_4  = '#96bbdc'
vim.g.terminal_color_5  = '#dfbdbc'
vim.g.terminal_color_6  = '#97bcbc'
vim.g.terminal_color_7  = '#d8d8d8'
vim.g.terminal_color_8  = '#757575'
vim.g.terminal_color_9  = '#e07798'
vim.g.terminal_color_10 = '#97bb98'
vim.g.terminal_color_11 = '#ffdd98'
vim.g.terminal_color_12 = '#badcfb'
vim.g.terminal_color_13 = '#ffbebc'
vim.g.terminal_color_14 = '#96ddde'
vim.g.terminal_color_15 = '#e9e9e9'

-- seoul256 background to match terminal
vim.g.seoul256_background = 237
vim.opt.background = 'dark'
vim.cmd.colorscheme('seoul256')

-- vim-airline theme
vim.g.airline_theme = 'seoul256'

-- vim-airline (disable tmuxline integration; it doesn't render correctly)
vim.g.airline_extensions = { 'tabline' }

-- ****** SETTINGS ******
vim.opt.mouse = 'a'
vim.opt.autoread = true

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.opt.history = 50

vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3

-- CoC.nvim recommendations
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 500
vim.opt.signcolumn = 'yes'

-- Undo / swap directories. The trailing `//` is meaningful — it tells vim to
-- encode the full path into the filename so files with the same basename in
-- different directories don't collide.
local home = vim.env.HOME
vim.opt.undodir = home .. '/.vim/.undo//'
vim.opt.directory:prepend(home .. '/.vim/.swp//')

vim.opt.scrolloff = 3
vim.opt.hidden = true

-- line wrap
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'sbr'
vim.opt.showbreak = '↪↪'

-- default indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- completion menu
vim.opt.completeopt = { 'menu', 'menuone', 'preview' }
vim.opt.shortmess:append('c')

-- config to make splits open below the current split rather than above it
-- vim.opt.splitbelow = true

-- ****** LEADER ******
vim.g.mapleader = ' '

local map = vim.keymap.set

-- ****** PLUGIN SETTINGS ******

-- delimitMate
vim.g.delimitMate_expand_cr = 1

-- NERDTree
map('n', '<leader>o', ':NERDTreeToggle<CR>')
vim.g.NERDTreeWinSize = 30
vim.g.NERDTreeShowHidden = 1

-- pesky netrw buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  command = 'setl bufhidden=wipe',
})

-- FZF + ripgrep
vim.opt.runtimepath:append('/usr/local/opt/fzf')
vim.opt.runtimepath:append('/usr/local/bin/rg')

-- The Rg/Files commands stay in vimscript — they use vim-plug helper funcs
-- and `<bang>` / `<q-args>` syntax that's awkward to express in Lua.
vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \   <bang>0 ? fzf#vim#with_preview('up:50%')
  \           : fzf#vim#with_preview('right:40%'),
  \   <bang>0)
]])

-- FZF window styling: hide statusline/mode/ruler in fzf, restore on leave.
local fzf_group = vim.api.nvim_create_augroup('FZF', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = fzf_group,
  pattern = 'fzf',
  callback = function()
    vim.opt_local.laststatus = 0
    vim.opt_local.showmode = false
    vim.opt_local.ruler = false
    vim.api.nvim_create_autocmd('BufLeave', {
      buffer = 0,
      once = true,
      callback = function()
        vim.opt.laststatus = 3
        vim.opt.showmode = true
        vim.opt.ruler = true
      end,
    })
  end,
})

-- fzf completions (recursive maps — they expand <plug>)
map('i', '<c-x><c-l>', '<plug>(fzf-complete-line)', { remap = true })
map('i', '<c-x><c-f>', '<plug>(fzf-complete-path)', { remap = true })
map('i', '<c-x><c-p>', '<plug>(fzf-complete-path)', { remap = true })

-- copilot: use ctrl-l for accepting completions (kept as vimscript for the
-- <silent><script><expr> trio)
vim.cmd([[imap <silent><script><expr> <c-l> copilot#Accept("")]])
vim.g.copilot_no_tab_map = true

-- Ferret
vim.g.FerretMap = 0
vim.g.FerretExecutable = 'rg'
vim.g.FerretExecutableArguments = {
  rg = '--hidden --vimgrep --no-heading --no-config --max-columns 4096',
}

-- ****** CoC.nvim ******
-- The CoC tab-completion expression and the script-local helper functions
-- are kept as vimscript: they reference each other and use `<SID>`/`coc#*`
-- expression-style return values that are clean in vim and clunky in Lua.
vim.cmd([[
" tab completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'vert bo help '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" format function (probably needs work / configuration)
command! -nargs=0 Format :call CocAction('format')

let s:CoC_File_Types = ["typescript", "typescript.tsx", "typescriptreact", "python", "rust", "vim", "help"]
let s:CoC_Prettier_Types = ["typescript", "typescript.tsx", "typescriptreact", "javascript", "javascript.jsx", "javascriptreact"]
function! CoC_key_maps()
  if (index(s:CoC_File_Types, &filetype) >= 0)
    " keymaps for diagnostic info
    nmap <buffer> <silent> <leader>D <Plug>(coc-diagnostic-info)
    nmap <buffer> <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <buffer> <silent> ]c <Plug>(coc-diagnostic-next)
    " keymaps for calling ShowDocumentation
    nnoremap <buffer> <leader>K :call ShowDocumentation()<CR>
    nnoremap <buffer> gh :call ShowDocumentation()<CR>
    " keymaps for jumping around the code
    nmap <buffer> <silent> <C-]> <Plug>(coc-definition)
    nmap <buffer> <silent> gt <Plug>(coc-type-definition)
    nmap <buffer> <silent> gi <Plug>(coc-implementation)
    nmap <buffer> <silent> gr <Plug>(coc-references)
    nmap <buffer> <leader>R <Plug>(coc-rename)
    nmap <buffer> <leader>rf <Plug>(coc-refactor)
  endif
  if (index(s:CoC_Prettier_Types, &filetype) >= 0)
    nmap <buffer> <leader>F :CocCommand eslint.executeAutofix<CR>
  endif
  if (index(s:CoC_Prettier_Types, &filetype) >= 0)
    nmap <buffer> <leader>L :CocCommand eslint.executeAutofix<CR>
  endif
endfunction

function! CoC_notify_init()
  echohl MoreMsg | echom 'coc.nvim initialized!' | echohl None
endfunction

augroup CoC
  autocmd!
  autocmd FileType * call CoC_key_maps()
  autocmd User CocNvimInit call CoC_notify_init()
augroup END
]])

-- CoC convenience maps
map('n', '<leader>rsc', ':CocRestart<CR>')
map('n', '<leader>cl', ':CocList<CR>')

-- ****** Random utilities ******
map('n', '<leader>wf', function()
  vim.api.nvim_echo({ { vim.fn.expand('%:p'), 'MoreMsg' } }, false, {})
end)

-- ****** Special-case syntax ******
local hmm_group = vim.api.nvim_create_augroup('HmmLangSyntax', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = hmm_group,
  pattern = '*.hmm',
  command = 'set syntax=scheme',
})

local mdx_group = vim.api.nvim_create_augroup('MDXSyntax', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = mdx_group,
  pattern = '*.mdx',
  command = 'set filetype=markdown',
})

-- ****** KEYBINDINGS ******

-- one-key access to the command line
map('n', ';', ':')

-- reload the loaded init file (works regardless of where it's symlinked)
map('n', '<leader>rv', ':source $MYVIMRC<CR>')

-- open help in a vertical split
map('n', '<leader>H', ':vert bo help<CR>')

-- ****** BUFFERS, WINDOWS, AND TABS ******
map('n', '<leader>wq', ':wq<CR>')
map('n', 's', ':w<CR>')
map('n', '<leader>qq', ':bp|bd #<CR>')
-- (Ctrl-w q quits completely)
map('n', '<leader>qw', ':q<CR>')
map('n', '<leader>qa', ':qa<CR>')
map('n', '<leader>qc', ':%bdelete<CR>')
map('n', '<leader>qb', ':%bdelete!<CR>')
map('n', '<leader>qn', ':enew<CR>')

-- fzf-vim mappings
map('n', '<C-p>', ':Files!<CR>')
map('n', '<leader>a', ':Rg!<Space>')
map('n', '<leader>A', 'yiW:Rg! <C-R>"')
map('n', '<leader>p', ':Buffers<CR>')
map('n', '<leader>f', ':BLines<CR>')
map('n', '<leader>n', 'yiW/<C-R>"<CR>')
map('n', '<leader>N', 'yiW:BLines <C-R>"<CR>')
map('n', '<leader>h', ':Helptags<CR>')
map('n', '<leader>P', ':History<CR>')
map('n', '<leader>C', ':Commands<CR>')

-- ferret
map('n', '<leader>S', 'yiW:Ack <C-R>"')
map('n', '<leader>SR', 'yiW:Acks /<C-R>"')

-- quickfix and location list
map('n', '<leader>co', ':copen<CR>')
map('n', '<leader>cc', ':cclose<CR>')
map('n', '<leader>lo', ':lopen<CR>')
map('n', '<leader>lc', ':lclose<CR>')

-- last-edited file
map('n', '<leader><leader>', ':e#<CR>')
map('n', '<leader>bb', '<C-^>')

-- move between buffers
map('', '<leader><Left>', ':bprev<CR>')
map('', '<leader><Right>', ':bnext<CR>')

-- <leader># opens the Nth listed buffer
local function open_buf_by_idx(index)
  local listed = {}
  for _, b in ipairs(vim.fn.getbufinfo()) do
    if b.listed == 1 then
      table.insert(listed, b.bufnr)
    end
  end
  if listed[index + 1] then
    vim.cmd('b ' .. listed[index + 1])
  end
end

for i = 1, 9 do
  map('n', '<leader>' .. i, function() open_buf_by_idx(i - 1) end)
end

-- ****** EDITING COMMANDS ******

-- turn off Ctrl-Z since it's annoying
map('', '<C-z>', '<Nop>')

-- macro stuff: free up `q`, move record-macro to `Q`, then bind `q`->`b`
map('', 'q', '<Nop>')
map('n', 'Q', 'q')
map('n', 'q', 'b', { remap = true })
map('v', 'q', 'b', { remap = true })

-- clear search highlights
map('', '<leader>dh', ':nohlsearch<CR>')

-- start a substitution for the identifier under the cursor
map('n', '<leader>s', 'yiW:%s/<C-R>"/')

-- remove trailing whitespace
map('n', '<leader>ds', [[:%s/\s\+$//e<CR>]])

-- Opposite of join. Replace a space with a newline; otherwise insert one.
vim.cmd([[nnoremap <expr> K getline('.')[col('.') - 1] == ' ' ? "r<CR>" : "i<CR><ESC>l"]])

-- duplicate line
map('n', '<leader>ld', 'yyp')

-- insert a blank line above without leaving normal mode
map('n', '<leader>ll', 'mzO<ESC>`z')

-- ****** CURSOR & SCROLLING ******
map('', '<M-n>', '6<C-e>6j')
map('', '<M-m>', '6<C-y>6k')

map('', '<M-j>', '6j')
map('', '<M-k>', '6k')

map('', '<C-M-n>', '6<C-e>')
map('', '<C-M-m>', '6<C-y>')

-- half-pages
map('', '<M-d>', '<C-d>')
map('', '<M-u>', '<C-u>')

-- pages
map('', '<M-f>', '<C-f>')
map('', '<M-b>', '<C-b>')

-- emacs-style start/end of line
map('', '<C-a>', '^')
map('', '<C-e>', '$')

-- these override vim-rsi's defaults
map('i', '<C-a>', '<C-o>^')
map('i', '<C-e>', '<C-o>$')

map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')

-- paste from system clipboard
map('n', '<leader>v', ':set paste<CR>"*gp:set nopaste<CR>')

-- delete to end of line in insert mode
map('i', '<C-k>', '<C-o>d$')

-- move lines vertically
map('n', '<C-M-j>', 'mz:m+<cr>`z')
map('n', '<C-M-k>', 'mz:m-2<cr>`z')
map('v', '<C-M-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]])
map('v', '<C-M-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]])

-- ****** Avante setup (disabled) ******
-- vim.api.nvim_create_autocmd('User', { pattern = 'avante.nvim', callback = function() end })
-- require('avante').setup({})

-- ****** Windsurf setup (disabled) ******
-- local cmp = require('cmp')
-- cmp.setup({
--   completion = { autocomplete = false },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-l>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     ['<Tab>'] = function(fallback)
--       if cmp.visible() then cmp.select_next_item() else fallback() end
--     end,
--     ['<S-Tab>'] = function(fallback)
--       if cmp.visible() then cmp.select_prev_item() else fallback() end
--     end,
--   }),
--   sources = { { name = 'codeium' } },
-- })
-- require('codeium').setup({})

-- dd-gopls neovim LSP setup
vim.lsp.config('gopls', {
  cmd = { 'dd-gopls' },
  cmd_env = {
    GOPLS_DISABLE_MODULE_LOADS = 1,
  },
  filetypes = { 'go', 'gomod', 'gowork' },
  root_markers = { 'go.mod', 'go.work' },
})
vim.lsp.enable('gopls')

-- determines if the previous character is whitespace
local function lsp_check_backspace()
  local col = vim.fn.col('.') - 1
  if col == 0 then return true end
  return vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- LSP keymaps and tab-driven completion, applied per-buffer when a server attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('mh.lsp', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    local bopts = { buffer = ev.buf }

    -- Hover (LSP doesn't auto-bind K because of the global K mapping).
    map('n', '<leader>K', vim.lsp.buf.hover, bopts)
    -- Replacements for the old vim-go keymaps.
    map('n', '<leader>R', vim.lsp.buf.rename, bopts)
    map('n', '<leader>F', vim.lsp.buf.format, bopts)
    map('n', '<leader>I', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.organizeImports' } },
        apply = true,
      })
    end, bopts)

    -- Built-in completion machinery (snippet expansion, item resolution),
    -- without autotrigger — Tab drives it instead.
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf)

      -- Tab: cycle through items if popup visible, literal Tab at start/whitespace,
      -- otherwise trigger completion via omnifunc.
      map('i', '<Tab>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-n>'
        end
        if lsp_check_backspace() then
          return '<Tab>'
        end
        return '<C-x><C-o>'
      end, { buffer = ev.buf, expr = true, replace_keycodes = true, silent = true })

      -- CR: accept selected item when popup visible, otherwise normal newline.
      map('i', '<CR>', function()
        return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
      end, { buffer = ev.buf, expr = true, replace_keycodes = true, silent = true })

      -- Close the preview/documentation split as soon as a completion is accepted.
      vim.api.nvim_create_autocmd('CompleteDone', {
        buffer = ev.buf,
        callback = function() vim.cmd('pclose') end,
      })
    end
  end,
})
