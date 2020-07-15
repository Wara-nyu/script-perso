set nocp " =nocompatible
set number " n° de ligne

filetype plugin indent on " couleur et indentation
syntax on " a priori pour reconnaitre les languages et colorier selon
set expandtab " pour inserer des espaces quand tab est pressé
set tabstop=2 " pour que tab fasse 2 espaces
set autoindent " 
set shiftwidth=2 " pour que l'autoindent fasse 2 espaces

set hlsearch " mise en evidence de la recherche
set incsearch " recherche mis en avant lettre par lettre (find as you type)
"^L pour enlever la selection de recherche
if maparg('<C-L>','n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"complet° avec <Tab> en mode commande
set wildmenu
"set wildmode=longest,full ???

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
call plug#end()

set linebreak
