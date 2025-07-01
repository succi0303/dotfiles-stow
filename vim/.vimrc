" vim-plug
call plug#begin('~/.vim/autoload/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'easymotion/vim-easymotion'
Plug 'EdenEast/nightfox.nvim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'previm/previm'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'

call plug#end()

" Basic settings
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
set backspace=indent,eol,start
set hidden
set showcmd
set showmatch
set cursorline
set number
set wrap
set laststatus=2
set incsearch
set display+=lastline
set wildmenu
set ignorecase
set clipboard=unnamed
set wildmode=list,full
set nobackup
set noswapfile
set nowritebackup
nnoremap <ESC><ESC> :nohlsearch<CR>

" Indent settings
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set smarttab
set autoindent
set smartindent
augroup fileTypeIndent
  autocmd!
  autocmd!
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yml,*.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BUfNewFile,BufRead *.template,*.template.yml,*.cfn.yaml,*.cfn.yml setlocal ft=cloudformation.yaml
augroup END

" Window settings
nnoremap s <Nop>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sq :<C-u>q<CR>

" Tab settings
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap sQ :<C-u>tabclose<CR>

" Buffer settings
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

syntax on

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme nightfox

" lightline.vim
  let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status'
	\ },
	\ }
  " Use autocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" vim-easymotion
let g:EasyMotion_startofline=0
let g:EasyMotion_smartcase=1
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
map <Leader>s <Plug>(easymotion-bd-f2)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>n <Plug>(easymotion-linebackward)

" open-browser
let g:netw_nogx=1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" autocomplete
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>" " "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
let g:coc_global_extensions = [
      \ 'coc-cfn-lint',
      \ 'coc-css',
      \ 'coc-docker',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-fzf-preview',
      \ 'coc-git',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-lua',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-solargraph',
      \ 'coc-sql',
      \ 'coc-stylelint',
      \ 'coc-toml',
      \ 'coc-tslint',
      \ 'coc-tsserver',
      \ 'coc-yaml'
      \ ]
" coc-explorer
nmap <C-e> <Cmd>CocCommand explorer<CR>
" coc-fzf-preview
let g:fzf_preview_git_files_command   = 'git ls-files --exclude-standard | while read line; do if [[ ! -L $line ]] && [[ -f $line ]]; then echo $line; fi; done'
let g:fzf_preview_grep_cmd            = 'rg --line-number --no-heading --color=never --sort=path'
let g:fzf_preview_mru_limit           = 500
let g:fzf_preview_use_dev_icons       = 1
let g:fzf_preview_default_fzf_options = {
\ '--reverse': v:true,
\ '--preview-window': 'wrap',
\ '--exact': v:true,
\ '--no-sort': v:true,
\ }
let $FZF_PREVIEW_PREVIEW_BAT_THEME  = 'OneHalfDark'
noremap <fzf-p> <Nop>
map     <C-g>       <fzf-p>
noremap ;;      ;
noremap <dev>   <Nop>
map     m       <dev>
noremap <silent> <fzf-p>r     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> <fzf-p>w     :<C-u>CocCommand fzf-preview.ProjectMrwFiles<CR>
nnoremap <silent> <fzf-p>a     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> <fzf-p>g     :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> <fzf-p>s     :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> <fzf-p>b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> <fzf-p>B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> <fzf-p><C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> <fzf-p>/     :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort<CR>
nnoremap <silent> <fzf-p>*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=expand('<cword>')<CR>"<CR>
xnoremap <silent> <fzf-p>*     "sy:CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=substitute(@s, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
nnoremap <silent> <fzf-p>n     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=substitute(@/, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
nnoremap <silent> <fzf-p>?     :<C-u>CocCommand fzf-preview.BufferLines --resume --add-fzf-arg=--no-sort<CR>
nnoremap          <fzf-p>f     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          <fzf-p>f     "sy:CocCommand fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> <fzf-p>q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> <fzf-p>l     :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <silent> <fzf-p>:     :<C-u>CocCommand fzf-preview.CommandPalette<CR>
nnoremap <silent> <fzf-p>p     :<C-u>CocCommand fzf-preview.Yankround<CR>
nnoremap <silent> <fzf-p>m     :<C-u>CocCommand fzf-preview.Bookmarks --resume<CR>
nnoremap <silent> <fzf-p><C-]> :<C-u>CocCommand fzf-preview.VistaCtags --add-fzf-arg=--query="<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> <fzf-p>o     :<C-u>CocCommand fzf-preview.VistaBufferCtags<CR>

nnoremap <silent> <dev>q  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> <dev>Q  :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>
nnoremap <silent> <dev>rf :<C-u>CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> <dev>t  :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>

autocmd User fzf_preview#initialized call s:fzf_preview_settings()

function! s:buffers_delete_from_lines(lines) abort
  for line in a:lines
    let matches = matchlist(line, '\[\(\d\+\)\]')
    if len(matches) >= 1
      execute 'Bdelete! ' . matches[1]
    endif
  endfor
endfunction

function! s:fzf_preview_settings() abort
  let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
  let g:fzf_preview_command = 'COLORTERM=truecolor ' . g:fzf_preview_command

  let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file', 'coc')
  let g:fzf_preview_custom_processes['open-file']['ctrl-s'] = g:fzf_preview_custom_processes['open-file']['ctrl-x']
  call remove(g:fzf_preview_custom_processes['open-file'], 'ctrl-x')

  let g:fzf_preview_custom_processes['open-buffer'] = fzf_preview#remote#process#get_default_processes('open-buffer', 'coc')
  let g:fzf_preview_custom_processes['open-buffer']['ctrl-s'] = g:fzf_preview_custom_processes['open-buffer']['ctrl-x']
  call remove(g:fzf_preview_custom_processes['open-buffer'], 'ctrl-q')
  let g:fzf_preview_custom_processes['open-buffer']['ctrl-x'] = get(function('s:buffers_delete_from_lines'), 'name')

  let g:fzf_preview_custom_processes['open-bufnr'] = fzf_preview#remote#process#get_default_processes('open-bufnr', 'coc')
  let g:fzf_preview_custom_processes['open-bufnr']['ctrl-s'] = g:fzf_preview_custom_processes['open-bufnr']['ctrl-x']
  call remove(g:fzf_preview_custom_processes['open-bufnr'], 'ctrl-q')
  let g:fzf_preview_custom_processes['open-bufnr']['ctrl-x'] = get(function('s:buffers_delete_from_lines'), 'name')

  let g:fzf_preview_custom_processes['git-status'] = fzf_preview#remote#process#get_default_processes('git-status', 'coc')
  let g:fzf_preview_custom_processes['git-status']['ctrl-s'] = g:fzf_preview_custom_processes['git-status']['ctrl-x']
  call remove(g:fzf_preview_custom_processes['git-status'], 'ctrl-x')
endfunction
