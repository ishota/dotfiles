" 自動生成ファイルの出力先を変更
set directory=~/dotfiles/.vim/tmp
set backupdir=~/dotfiles/.vim/tmp
set viminfo+=n~/dotfiles/.vim/tmp/viminfo.txt


" 文字設定
set fileencodings=utf-8,cp932,euc-jp,sjis " ファイルを読み込む時の、文字コード自動判別の順番
set fileformats=unix,dos,mac " ファイル形式を試す順番
set ambiwidth=double " Unicode文字の不明瞭な文字幅を決定する

" カラースキーム

" 基本設定
set nobackup " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない
set hidden " バッファが編集中でもその他のファイルを開けるように
set ttyfast " ターミナル接続を高速化
set smartindent " 改行時自動インデント
set number " 行番号を表示
set incsearch " インクリメントサーチを有効にする
set ignorecase " 検索時大文字小文字を区別しない
set smartcase " 検索時大文字を入力した時はignorecaseを無効化
set completeopt=menuone " 候補が一つしかない時もポップアップする
set showmatch " 括弧入力時の対応する括弧を表示
set laststatus=2 "ステータス行の設定0:表示無し, 1:2以上の時だけ, 2:常に表示
set title " タイトルを表示
set timeout timeoutlen=1000 ttimeoutlen=50 " キー待ち時間の変数
set history=500 " 保存するコマンド履歴の数
set nostartofline " 移動コマンドを使った時、行頭に移動しない
set scrolloff=5 " カーソルの上下に表示する行数
set backspace=indent,eol,start " backspaceでの削除に左の文字を含める
set gdefault " 置換する時にgオプションをデフォルトで有効
set nowrap " テキストを折り返す
set showtabline=2 "常にタブラインを表示
set ruler " カーソルが何行目の何列目に置かれているかを表示する
set list " 不可視もじを表示する
set listchars=tab:>\ ,extends:<
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 " 自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースでカーソルが動く幅
set showcmd " ノーマルモードで入力したコマンドが右下に表示
set whichwrap=h,l " カーソルの左右移動で行末から次の行の先頭への移動が可能
set matchpairs& matchpairs+=<:> " 対応括弧に<>を追加
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:” " 全角括弧の対を追加
set textwidth=0 " 入力されているテキストの最大幅を無効化
set virtualedit=all " ファイル編集中でも、保存しないで他のファイルを表示
set wildmenu wildmode=list:full
set t_Co=256
set vb t_vb= " ビープ音を消す
set novisualbell
set foldmethod=indent

" ハイライト設定
" autocmd ColorScheme * highlight


" 自動処理
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " インサートモードに入る時に自動でコメントアウトされない
autocmd BufWritePre * :%s/\s\+$//ge " 行末のスペースを保存時に除去

" シンタックス
syntax enable

" マクロ
source $VIMRUNTIME/macros/matchit.vim

" キーバインド
" エスケープの配置換え
inoremap <silent> jk <ESC>
" インサートモードでもCtr押しながら移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
" 行末・行頭移動
nnoremap <Space>h ^
nnoremap <Space>l $
" 上下移動
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j
" 自動括弧閉じ
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
" インサートモードに入らずに空行を追加
nnoremap <Space>o :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
" 置換コマンドのマッピング
nnoremap gs :<C-u>%s//g<Left><Left>
vnoremap gs :s//g<Left><Left>


" 関数
" カーソルラインの位置を保存する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

" マウスでカーソル移動とスクロール
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" インサートモードでクリップボードからペーストする時に自動でインデントさせない
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esr>[200~ XTermPasteBegin("")
endif

" スペルチェック機能
set spelllang=en,cjk

fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  set spell

  if syntax =~? '/<comment\>'
    syntax spell dejault
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END

" タブ番号：ファイル名表示にする
set tabline=%!MyTabLine()
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " ラベルはMyTabLabel()で作成する
    let my_tab_label = '%{MyTabLabel(' . (i+1) . ')}'
    " 強調表示グループの選択
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
      " タブ番号 : [ファイル名] のフォーマットになるように設定
    let s .= (i + 1) . ':[' . my_tab_label . ']'
  endfor
  " 最後のタブページの後はTabLineFillで埋め、タブページ番号をリセットする
  let s .= '%#TabLineFill#%T'
  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return fnamemodify(bufname(buflist[winnr - 1]), ":t")
endfunction

" 全角スペースの表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif

" インサートモード時、ステータスラインの色を変更
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" マッチ数を表示する
nnoremap <expr> / _(":%s/<Cursor>/&/gn")

function! s:move_cursor_pos_mapping(str, ...)
  let left = get(a:, 1, "<Left>")
  let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
  return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction

function! _(str)
  return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction

" ?検索時の送り方向を/と統一
nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'Nzv'
nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'Nzv'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction

