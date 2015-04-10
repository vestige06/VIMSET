"??部份是爲了校驗中文在ssh 里正常顯示中文的vim內部碼設置
"Part of Setting chinese display and input in ssh normally inside vim...
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set fileformats=unix,dos
"Highlight settings . 
colorscheme busybee
colorscheme summerfruit256
syntax on 
"indent line
set list
set lcs=tab:\|\ 
"set lines num & status
set nu
"set cursorline
set ruler
"set indent & tab
set autoindent
set smartindent
set history=600
set shiftwidth=4
set tabstop=4

"=============================================
"簡繁互轉 OPENCC 版：用 opencc 轉換緩衝區內容
"   作者：Civa Lin 林雪凡 - Version: 1.0
"
"   注意：
"       - 請在系統中安裝 opencc >= 3.0 才能使用
"       - 轉換不影響檔案，需要儲存者請手動儲存。
"       - 在 linux 中測試過 OK，在 windows 環境下應該需要小修改，歡迎提交 patch
"
"   用法：
"       :O[PENCC] 設定檔
"
"   設定檔：
"       - 請善用 tab 自動補全
"       - 註：以下說明中所稱之「繁體」，為一「能分則不合」的中介繁體「用字」，
"         這套用字在 opencc 中被當作中間格式，其他轉換執行時也都會經過此一模式
"         。技術細節請參考 opencc 官網。
"       - 註：下方說明部份摘抄自 https://www.byvoid.com/blog/tag/OpenCC 此處僅
"         為使用方便而節錄。
"
"       - zhs2zht.ini     簡體到繁體
"       - zht2zhs.ini     繁體到簡體
"       - zhs2zhtw_p.ini  簡體到臺灣標準（只轉換詞彙）
"       - zhs2zhtw_v.ini  簡體到臺灣標準（只轉換異體字）
"       - zhs2zhtw_vp.ini 簡體到臺灣標準（轉換異體字和詞彙）
"       - zht2zhtw_p.ini  繁體到臺灣標準（只轉換詞彙）
"       - zht2zhtw_v.ini  繁體到臺灣標準（只轉換異體字）
"       - zht2zhtw_vp.ini 繁體到臺灣標準（轉換異體字和詞彙）
"       - zhtw2zhs.ini    臺灣標準到簡體（不轉換詞彙）
"       - zhtw2zht.ini    臺灣標準到繁體（不轉換詞彙）
"       - zhtw2zhcn_s.ini 臺灣標準到中國大陸標準（轉換詞彙，並轉換爲簡體）
"       - zhtw2zhcn_t.ini 臺灣標準到中國大陸標準（轉換詞彙，保持繁體）
"
"       - 辭彙轉換，例：　光碟（台灣標準）<->  光盤（大陸標準）
"       - 異體字轉換，例：裏（內部繁體）  <->  裡（台灣標準）
"           - 注意此處的異體字只包括涵意完全沒有歧義的，因此數量不多
"             （但有些字可能很常見）
"
"       - 基本上用 zht2zhs.ini 與 zhs2zht.ini 就足夠了，
"         如果要求轉換結果使用台灣／大陸慣用字詞，則再使用其他選項。
"
"   相關銘謝：
"       - Opencc 由 Byvoid 製作。膜拜地點： http://opencc.byvoid.com/
command! -complete=custom,OPENCCINI -nargs=1 OPENCC call OPENCC(<q-args>)

	fun! OPENCC(modefile)
if (index(g:openccinifiles, a:modefile) == -1)
	echo "Cancel, Args not support!"
	return
	endif
	let opencc = "opencc"
	let infile = tempname()
	let outfile = tempname()
let winview = winsaveview()
	silent exe "write " . infile
	let command_line = opencc . " -c " . a:modefile . " -i " . infile . " -o " . outfile
	silent call system(command_line)
if (v:shell_error != 0)
	echo "Opencc not found! Please install it first!"
	return
	endif
	normal ggVGd
	silent exe "read " . outfile
	normal ggdd
call winrestview(winview)
	endfun

fun! OPENCCINI(A,L,P)
	return join(g:openccinifiles, "\n")
	endfun

	"可用的 opencc 設定檔
	let g:openccinifiles = ["zhs2zht.ini", "zht2zhs.ini" ,"zhs2zhtw_p.ini", "zhs2zhtw_v.ini", "zhs2zhtw_vp.ini", "zht2zhtw_p.ini", "zht2zhtw_v.ini", "zht2zhtw_vp.ini", "zhtw2zhs.ini", "zhtw2zht.ini", "zhtw2zhcn_s.ini", "zhtw2zhcn_t.ini"]




" Binging Buffers Command with <F8>

:map <F12> GoDate: <Esc>:read !date<CR>kJ
:map <F2> :buffers<CR>
:map <Left> :bp<CR>
:map <Right> :bn<CR>

"ajax Abbr php include_once
iabbrev ajax_t var x = window.XMLHttpRequest? new XMLHttpRequest(): new ActiveXObject();<Enter> x.onreadystatechange = function(){<Enter> if(x.readyState == 4){<Enter> if(x.status == 200){<Enter> }<Enter> else{<Enter> }<Enter> }<Enter> }<Enter> x.open('GET','',false);<Enter> x.send();

iabbrev php_t <?php ?>
iabbrev in_on include_once "";
iabbrev if_el if(){<Enter>}<Enter>else{<Enter>}
iabbrev se_s session_start();
iabbrev e_c echo "";

"F3 F4 is for format html indent
:map <F3> :filetype indent on<CR> :set ft=html<CR> :set smartindent<CR>
:map <F4> :filetype indent on<CR> :set ft=php<CR> :set smartindent<CR>
"F5 is Tlist taglist switch and something
:map <F5> :Tlist<CR>
let Tlist_Show_One_File=1
:map <F11> <ESC> /func <CR>


"F6 is for split one line html
:xmap <F6> : s/<[^>]*>/\r&\r/g<CR>
:map <F7> i'<ESC>lea'<ESC>
:map <F12> :qa!<CR>
"configure the tagbar-phpctags.vim
let g:tagbar_phpctags_memory_limit='512M'

"Load auto-complete with dictionary 
set dictionary+=~/.vim/Dict/php_func
set dictionary+=~/.vim/Dict/php_var
"Is or not a keyWord, better not ,effect something
"set iskeyword+='
"set iskeyword+=[
"set iskeyword+=]
"set iskeyword+=(
"set iskeyword+=)

"Up Right Left Down
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

"split {} F8 KEY
:map <F8> <ESC> : s/}/\r}/g<CR> kvj=

"EXCTAGE ...
set tags=tags;/
