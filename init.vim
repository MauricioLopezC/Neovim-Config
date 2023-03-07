call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
Plug 'jiangmiao/auto-pairs'
"file browser nerdtree
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake' "code check
Plug 'morhetz/gruvbox' "theme 
Plug 'sainnhe/sonokai'
Plug 'joshdick/onedark.vim' 
Plug 'overcache/NeoSolarized'
"Plug 'sheerun/vim-polyglot' "syntax highlight 
"Plug 'vim-python/python-syntax'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'EdenEast/nightfox.nvim' " Vim-Plug
Plug 'Tsuzat/NeoSolarized.nvim', { 'branch': 'master' }
Plug 'Mofiqul/vscode.nvim'
"coc for code autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"treesitter for syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"snippets
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

call plug#end()

"basic configs
set number
set termguicolors
colorscheme gruvbox
"let g:gruvbox_transparent_bg = 1
"hi normal guibg=000000
let g:python_highlight_all = 1
let g:javascript_plugin_jsdoc = 1
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"jedi
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_initialization = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

"neomake
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)

"NerdTree keymaps 
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"indentLine configs 
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

nnoremap <leader>tv :botright vnew <Bar> :terminal<cr>
nnoremap <leader>th :botright new <Bar> :terminal<cr>
nnoremap('n', '<C-l>', '<C-W>l')
"disable neomake pylint alterts (missing docstring)

let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0103, C0111',
  \ '-f', 'text',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '-r', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }

"let g:neomake_python_enabled_makers = ['flake8', 'pylint']
"coc config
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"ultisnips configurations
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"



"lua configurations
lua << END
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		}
	}
END
