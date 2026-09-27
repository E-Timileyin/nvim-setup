# Learn Neovim — from motions to muscle memory

A field guide written for **this** config (`~/.config/nvim`). Every key listed here
works in your setup. `<leader>` = **Space**. `C-x` = Ctrl+x, `A-x` = Alt+x, `S-x` = Shift+x.

> **How to use this file.** Don't read it all at once. Do one section per day and
> run the **Drill** at the end of each section. Keep this open in a tmux split while
> you code. Hardtime is running and will tell you when a better motion exists.
> Press `<leader>tp` any time to see where `w b e ^ $ { }` would land.

---

## Table of contents

0. [The mindset: vim is a language](#0-the-mindset-vim-is-a-language)
1. [Modes & survival](#1-modes--survival)
2. [Horizontal motions (inside a line)](#2-horizontal-motions-inside-a-line)
3. [Vertical motions (between lines)](#3-vertical-motions-between-lines)
4. [Screen & scroll motions](#4-screen--scroll-motions)
5. [Search as a motion](#5-search-as-a-motion)
6. [Jumps, marks & the jumplist](#6-jumps-marks--the-jumplist)
7. [Operators: verbs](#7-operators-verbs)
8. [Text objects: nouns](#8-text-objects-nouns)
9. [Entering insert mode the smart way](#9-entering-insert-mode-the-smart-way)
10. [Visual mode](#10-visual-mode)
11. [Registers, yank & paste](#11-registers-yank--paste)
12. [Repeat: dot, counts & macros](#12-repeat-dot-counts--macros)
13. [Search & replace](#13-search--replace)
14. [Undo, redo & undotree](#14-undo-redo--undotree)
15. [Windows, splits & tmux](#15-windows-splits--tmux)
16. [Buffers & Harpoon](#16-buffers--harpoon)
17. [Finding things: Telescope & file tree](#17-finding-things-telescope--file-tree)
18. [Coding: LSP, completion, formatting](#18-coding-lsp-completion-formatting)
19. [Git inside nvim](#19-git-inside-nvim)
20. [Learn mode, toggles & helpers](#20-learn-mode-toggles--helpers)
21. [Command-line power moves](#21-command-line-power-moves)
22. [tmux cheatsheet](#22-tmux-cheatsheet)
23. [4-week grind plan](#23-4-week-grind-plan)
24. [Full keybinding reference (this config)](#24-full-keybinding-reference-this-config)

---

## 0. The mindset: vim is a language

Every edit is a sentence:

```
[count] operator [count] motion/text-object
   2       d               w          → delete 2 words
           c               i"         → change inside quotes
           y               ap         → yank a paragraph
           >               }          → indent to end of paragraph
```

- **Operators** are verbs: `d` delete, `c` change, `y` yank, `>` indent…
- **Motions** say where: `w` word, `}` paragraph, `f(` next "(", `G` end of file…
- **Text objects** say what: `iw` inner word, `a(` around parens, `it` inside tag…
- **Counts** say how many.

Learn about 10 verbs and 20 motions and you get hundreds of commands for free.
Rule of thumb: **if you press the same key 3+ times, there's a better motion.**

---

## 1. Modes & survival

| Mode | Enter with | What it's for |
|---|---|---|
| Normal | `Esc` or `jk` (your mapping) | Moving + commanding. **Live here.** |
| Insert | `i a o …` | Typing text |
| Visual | `v` (chars) `V` (lines) `C-v` (block) | Selecting |
| Command | `:` or `;` (your mapping) | Ex commands |
| Terminal | `:terminal` then `i` | Shell in nvim; leave with `C-x` |

Survival keys:

| Key | Action |
|---|---|
| `jk` | Leave insert mode (faster than Esc) |
| `C-s` | Save (normal, insert, visual) |
| `:w` / `:q` / `:wq` / `:q!` | Write / quit / both / quit without saving |
| `:qa` | Quit all |
| `Esc` (normal) | Clear search highlight |
| `<leader>?` | Show keymaps for this buffer (which-key) |
| Press `<leader>` and wait | which-key shows every leader binding |
| `:help {thing}` / `<leader>fh` | Built-in docs, fuzzy-searchable |

> **Note on `;`.** This config maps `;` to `:`. In stock vim, `;` repeats the last
> `f/t/F/T` jump. You still have `,` (repeat in reverse). If you want the real `;`
> back, delete the `map("n", ";", ":")` line in `lua/mappings.lua`.

**Drill:** open any file, enter and leave insert mode 20 times using only `jk`. Save with `C-s`.

---

## 2. Horizontal motions (inside a line)

### Characters
| Key | Moves to |
|---|---|
| `h` / `l` | left / right one char (these wrap lines in your config) |
| `0` | column 0 (very start of line) |
| `^` | first non-blank char — **usually what you want** |
| `$` | end of line |
| `g_` | last non-blank char |

### Words
A **word** is letters/digits/underscore. A **WORD** is anything split by spaces.

```
user.profile_name = get(ctx, "id")
^    ^^           ^ ^  ^^   ^
w stops: user . profile_name = get ( ctx , "id" )
W stops: user.profile_name  =  get(ctx,  "id")
```

| Key | Moves to |
|---|---|
| `w` / `W` | start of next word / WORD |
| `b` / `B` | start of previous word / WORD |
| `e` / `E` | end of word / WORD |
| `ge` / `gE` | end of previous word / WORD |

### Find in line (the sniper keys)
| Key | Moves to |
|---|---|
| `f{c}` | **onto** next char `c` → `f(` jumps to next `(` |
| `F{c}` | onto previous char `c` |
| `t{c}` | **till** (just before) next `c` |
| `T{c}` | just after previous `c` |
| `,` | repeat last f/t/F/T backward (`;` forward is remapped, see §1) |

Why `t` matters: `dt)` deletes up to but not including `)`, so it's perfect for
clearing function arguments. `ct,` changes up to the next comma.

**Drill:** on `func handleRequest(w http.ResponseWriter, r *http.Request) error {`
- cursor at `f` → reach `(` with `f(`
- reach `r` of `r *http` with `f,` then `w`
- delete all args: `f(` then `ldt)` or better `ci(` (see §8)
- jump to `{` with `$`

---

## 3. Vertical motions (between lines)

Your config shows **relative line numbers**, so the number next to each line is exactly
how far away it is. Read the number, type it, press `j`/`k`.

| Key | Moves to |
|---|---|
| `j` / `k` | down / up one line |
| `5j` / `12k` | down 5 / up 12 (read from the relative number column) |
| `gg` | first line of file |
| `G` | last line |
| `42G` or `:42` | line 42 |
| `50%` | halfway through file |
| `}` / `{` | next / previous blank line (paragraph / code block) |
| `)` / `(` | next / previous sentence |
| `%` | matching `( ) [ ] { }`, jumps from the opening to the closing brace |
| `+` / `Enter` | first non-blank of next line |
| `-` | first non-blank of previous line |
| `gj` / `gk` | down/up by *screen* line (on wrapped text) |

### Code-aware jumps
| Key | Moves to |
|---|---|
| `[{` / `]}` | enclosing `{` / `}` (escape out of a block) |
| `[(` / `])` | enclosing `(` / `)` |
| `[m` / `]m` | previous / next method start (Java-style, works in many langs) |
| `gd` | definition of the symbol under the cursor (LSP) |
| `]d` / `[d` | next / previous diagnostic |
| `]h` / `[h` | next / previous git hunk |
| `]t` / `[t` | next / previous TODO comment |

**Hardtime alert:** `jjjjj` gets flagged. Use `5j`, `}`, or search instead.

**Drill:** in a 100+ line Go file:
1. `gg`, then `G`, then `:50` and `50%`
2. Use `}` to hop function by function; `{` back
3. Put cursor on a `{` and press `%` → lands on its `}`
4. From inside a function body press `[{` to jump to its opening brace

---

## 4. Screen & scroll motions

| Key | Action |
|---|---|
| `C-d` / `C-u` | half page down / up (cursor moves too) |
| `C-f` / `C-b` | full page down / up |
| `C-e` / `C-y` | scroll 1 line without moving the cursor |
| `H` / `M` / `L` | cursor to top / middle / bottom of screen |
| `zz` | center screen on the cursor, **use after every big jump** |
| `zt` / `zb` | cursor line to top / bottom of screen |

Combo: `C-d zz` keeps you reading in the middle of the screen.

---

## 5. Search as a motion

Search is the fastest way to move far. It's also a motion, so `d/foo` deletes up to "foo".

| Key | Action |
|---|---|
| `/text` Enter | search forward |
| `?text` Enter | search backward |
| `n` / `N` | next / previous match |
| `*` / `#` | search word under cursor forward / backward (very common) |
| `g*` / `g#` | same but partial matches |
| `Esc` | clear highlight (your mapping) |

Your config uses **smartcase**: `/user` matches `User` and `user`, while `/User` matches
only `User`.

Regex basics inside `/`: `\<word\>` whole word, `^` line start, `$` line end,
`.` any char, `.*` anything, `\d` digit, `\s` whitespace.

**Drill:** put the cursor on a variable name, press `*` and `n` to cycle through every
usage, then `N` back. Then do the same with `gr` (LSP references) and compare.

---

## 6. Jumps, marks & the jumplist

Every "big" move (`G`, `/`, `%`, `gd`, `*`, `{`) is recorded.

| Key | Action |
|---|---|
| `C-o` | jump **back** (older position), your "undo movement" |
| `C-i` | jump forward. **Note:** terminals send `Tab` and `C-i` as the same key, and this config maps `Tab` to "next buffer", so inside tmux `C-i` may switch buffers instead. `:jumps` lists the jumplist if you need it |
| `` `` `` (two backticks) | toggle between the last two jump positions |
| `` `. `` | where you last changed text |
| `` `^ `` | where you last left insert mode |
| `gi` | go back to last insert position **and** enter insert. (Careful: this config maps `gi` to LSP implementation, so use `` `^ `` then `a`) |

### Marks
| Key | Action |
|---|---|
| `ma` | set mark `a` (lowercase = this file) |
| `` `a `` | jump to exact mark position |
| `'a` | jump to mark's line |
| `mA` | uppercase = **global** mark, which jumps across files |
| `<leader>ma` | Telescope list of marks |
| `:delm a` / `:delm!` | delete mark a / all lowercase marks |

Classic flow: `gd` into a definition, read it, `C-o` back to where you were.

---

## 7. Operators: verbs

| Operator | Meaning | Example |
|---|---|---|
| `d` | delete (cut) | `dw` `d$` `dj` `dG` `dgg` |
| `c` | change (delete + insert) | `cw` `c$` `ci"` |
| `y` | yank (copy) | `yw` `y$` `yap` |
| `>` / `<` | indent / dedent | `>}` `>ip` |
| `=` | auto-indent | `=ip` `gg=G` (whole file) |
| `gu` / `gU` / `g~` | lower / UPPER / toggle case | `gUiw` → WORD |
| `gc` | comment toggle | `gcip` `gcj` `gc}` |
| `ys` | add surround (nvim-surround) | `ysiw"` → "word" |
| `!` | filter through shell | `!ip sort` |

Doubled operator = current line: `dd` `cc` `yy` `>>` `<<` `==` `gcc` `guu` `gUU`.
Capital = to end of line: `D` = `d$`, `C` = `c$`, `Y` = `y$`.

Single-key edits:

| Key | Action |
|---|---|
| `x` / `X` | delete char under / before cursor |
| `r{c}` | replace one char with `c` |
| `R` | replace mode (overtype) |
| `J` | join line below onto this one |
| `gJ` | join without adding space |
| `~` | toggle case of char |
| `C-a` / `C-x` | increment / decrement number under cursor (`10 C-a` adds 10) |

---

## 8. Text objects: nouns

Used after an operator (or in visual mode). `i` = **inner**, `a` = **around** (includes
the delimiters/whitespace). **You don't need to be at the start**, just anywhere inside.

| Object | Selects |
|---|---|
| `iw` / `aw` | word / word + trailing space |
| `iW` / `aW` | WORD |
| `is` / `as` | sentence |
| `ip` / `ap` | paragraph (block of code between blank lines) |
| `i"` `a"` `i'` `a'` `` i` `` | inside / around quotes |
| `i(` `a(` (also `ib`) | inside / around parentheses |
| `i{` `a{` (also `iB`) | inside / around braces, i.e. a function body |
| `i[` `a[` | brackets |
| `i<` `a<` | angle brackets (generics!) |
| `it` / `at` | inside / around an HTML/XML tag |

The most useful combos for backend work:

```
ci"     change a string literal               "old value" → "|"
ci(     rewrite all function args            call(a, b, c) → call(|)
di{     empty a function/struct body
yi{     copy a function body
da(     delete args including parens
vi{     select block, then > to indent it
ca[     replace a whole slice literal
dap     delete a paragraph / function block
gcap    comment out a block
=i{     re-indent a block
```

### Surround (nvim-surround)
| Keys | Before → After |
|---|---|
| `ysiw"` | `word` → `"word"` |
| `ysiw)` | `word` → `(word)`   (`(` adds spaces: `( word )`) |
| `yss"` | whole line wrapped |
| `cs"'` | `"x"` → `'x'` |
| `cs'<p>` | `'x'` → `<p>x</p>` |
| `ds"` | `"x"` → `x` |
| `dst` | remove surrounding tag |
| visual `S"` | wrap selection |

**Drill (do it 10× each):** on `err := db.Query(ctx, "SELECT * FROM users", id)`
- change the SQL string: `ci"`
- clear the args: `ci(`
- delete the whole call `db.Query(...)`: cursor on the `d` of `db`, then `df)`
- yank the SQL string with quotes: `ya"`

---

## 9. Entering insert mode the smart way

Choosing the right entry key saves a motion every time.

| Key | Inserts |
|---|---|
| `i` / `a` | before / after cursor |
| `I` / `A` | start (first non-blank) / end of line |
| `o` / `O` | new line below / above |
| `s` | delete char + insert (= `cl`) |
| `S` / `cc` | clear line (keeps indent) + insert |
| `C` | change to end of line |
| `gI` | insert at column 0 |

Inside insert mode:

| Key | Action |
|---|---|
| `C-w` | delete previous word |
| `C-u` | delete to start of line |
| `C-h` | backspace |
| `C-r {reg}` | paste register (`C-r "` last yank, `C-r +` clipboard) |
| `C-o {cmd}` | run ONE normal command, then back to insert (`C-o zz`) |
| `C-t` / `C-d` | indent / dedent current line |
| `C-Space` | open completion menu (always manual in learn mode) |

Autopairs is on: typing `(` inserts `()`. Typing `)` when already before one just
steps over it.

---

## 10. Visual mode

| Key | Action |
|---|---|
| `v` | char-wise |
| `V` | line-wise |
| `C-v` | block (column) |
| `gv` | reselect last selection |
| `o` | jump to the other end of the selection |
| `>` / `<` | indent (stays selected in your config, so press again) |
| `J` / `K` | **move selected lines** down / up (your mapping) |
| `S"` | surround selection |
| `gc` | comment selection |
| `u` / `U` | lower / upper case |
| `:` | run command on selected lines (`:'<,'>s/a/b/g`) |

### Block mode magic (multi-cursor without plugins)
1. `C-v`, then `3j` to select a column down 4 lines
2. `I` type text `Esc` → inserted on every line
3. or `$A` type `Esc` → appended to end of every line
4. or `c` to change the block on every line

Example: add `export ` before 5 lines: `C-v 4j I export Esc`.

> Prefer operators + text objects over visual mode. `ci(` beats `vi(c`, since it's shorter
> and repeatable with `.`.

---

## 11. Registers, yank & paste

This config sets `clipboard=unnamedplus`, so **every yank goes to the system clipboard**
and `p` pastes from it.

| Key | Action |
|---|---|
| `p` / `P` | paste after / before cursor |
| `yy` `p` | duplicate a line |
| `ddp` | swap line with the one below |
| `xp` | swap two chars |
| `"0p` | paste the last **yank** (not the last delete!) |
| `"_d` | delete into the black hole (doesn't overwrite your yank) |
| `"ayy` / `"ap` | yank into / paste from named register `a` |
| `"Ayy` | **append** to register `a` |
| `:reg` | view all registers |
| `<leader>ya` | yank the whole file (your mapping) |

The trap: you yank a word, delete another word to replace it, and `p` pastes the
**deleted** word. Fixes: use `"0p`, or select the target with `viw` then `p`.

---

## 12. Repeat: dot, counts & macros

### The dot command `.`
Repeats the last **change**. Design your edits so they are repeatable:
- `A;` Esc → `j.` `j.` adds `;` to several lines
- `ciwnewName` Esc → `n.` `n.` renames next matches after `*`
- `>>` then `.` `.` to indent more

### The `cgn` pattern (find-and-replace one by one, with control)
1. `*` on the word (or `/word`)
2. `cgn` newText `Esc`: changes the next match
3. `.` changes the next one; `n` skips one

### Macros
| Key | Action |
|---|---|
| `qa` | start recording into register `a` |
| `q` | stop recording |
| `@a` | play macro `a` |
| `@@` | replay last macro |
| `10@a` | play 10 times |
| `:'<,'>normal @a` | play on every selected line |

Macro rules: start with a motion to a predictable spot (`0` or `^`), end by moving to
where the next run should begin (`j`).

Example: turn `name string` lines into struct tags `Name string \`json:"name"\``:
record on one line, `j` at the end, replay with `@@`.

---

## 13. Search & replace

```
:s/old/new/           first match on current line
:s/old/new/g          all on current line
:%s/old/new/g         whole file
:%s/old/new/gc        whole file, confirm each (y/n/a/q)
:'<,'>s/old/new/g     only in visual selection
:%s/\<id\>/userID/g   whole-word only
:%s/foo\(\d\+\)/bar\1/g   capture group → \1
```

Use `:%s//new/g` with an empty pattern to reuse your last `/` or `*` search.

Other line-wide commands:
```
:g/TODO/d             delete every line containing TODO
:v/error/d            delete every line NOT containing "error" (log filtering!)
:g/^$/d               delete blank lines
:sort  /  :sort u     sort lines / sort unique
```

Project-wide: `<leader>fw` (live grep) → `C-q` sends results to the quickfix list →
`:cdo s/old/new/g | update` replaces across all files.

For renaming a **symbol** (variable/function/type), always prefer `<leader>rn` (LSP rename),
because it understands scope.

---

## 14. Undo, redo & undotree

| Key | Action |
|---|---|
| `u` | undo |
| `C-r` | redo |
| `U` | undo all changes on the last line |
| `:earlier 5m` / `:later 5m` | time travel |
| `<leader>u` | **Undotree**: visual history of every branch |

Undo is persistent in your config (`undofile`), so you can close a file, reopen it tomorrow,
and still undo.

Tip: break undo chunks by leaving insert mode often (`jk`). One long insert = one big undo.

---

## 15. Windows, splits & tmux

| Key | Action |
|---|---|
| `:vs` / `:sp` | vertical / horizontal split (`:vs file.go` opens file in it) |
| `C-w v` / `C-w s` | same |
| `C-h/j/k/l` or `A-h/j/k/l` | move between nvim splits **and** tmux panes seamlessly |
| `C-w q` or `:q` | close split |
| `C-w o` | close all other splits (only) |
| `C-w =` | equalize sizes |
| `C-w _` / `C-w \|` | maximize height / width |
| `C-w +` / `C-w -` / `C-w >` / `C-w <` | resize (prefix a count: `10 C-w >`) |
| `C-w x` | swap with next split |
| `C-w H/J/K/L` | move split to far left/bottom/top/right |
| `C-w T` | move split into its own tab |
| `<leader>z` | Zen mode: focus one buffer |

Terminal inside nvim: `:terminal` (or `:vs | terminal`), press `i` to type, `C-x` to get
back to normal mode.

---

## 16. Buffers & Harpoon

### Important: single-buffer mode
`lua/autocmds.lua` **auto-closes other unmodified buffers when you open a file**, like
a single-tab editor. So `:bnext` usually has nothing to cycle through. Harpoon is how you
bounce between files in this config.

| Key | Action |
|---|---|
| `Tab` / `S-Tab` | next / previous buffer |
| `]b` / `[b` | same |
| `<leader>x` | close buffer |
| `<leader>b` | new empty buffer |
| `<leader>fb` | Telescope buffer list |
| `C-^` | alternate file (last buffer), if it's still open |

### Harpoon (ThePrimeagen) — your file hotbar
Mark the 3–4 files you're working on for the current task (handler, service, repo, test),
then jump between them instantly.

| Key | Action |
|---|---|
| `<leader>ha` | add current file to harpoon |
| `<leader>hh` | open harpoon menu |
| `<leader>1` … `<leader>4` | jump to harpoon file 1–4 |

In the menu, it's a normal buffer, so use vim to edit it:
- `dd` removes a file, `p` pastes it elsewhere to **reorder** slots
- `Enter` opens the file; `:w` or `q`/`Esc` closes the menu
- Keep the order consistent: 1 = main code, 2 = test, 3 = interface/types, 4 = config

Workflow: `<leader>ff` finds a file → `<leader>ha` → repeat for the task's files →
work with `<leader>1-4` for the rest of the session. Harpoon lists are per project (cwd).

---

## 17. Finding things: Telescope & file tree

### Telescope (`<leader>f…` = find)
| Key | Finds |
|---|---|
| `<leader>ff` | files |
| `<leader>fw` | text in project (live grep with ripgrep) |
| `<leader>fb` | open buffers |
| `<leader>fo` | recent files |
| `<leader>fh` | help tags |
| `<leader>fs` | symbols in this file (functions, types) |
| `<leader>fS` | symbols in whole workspace |
| `<leader>fd` | diagnostics |
| `<leader>ft` | TODO/FIXME/HACK comments |
| `<leader>gt` | git status |
| `<leader>ma` | marks |

Inside Telescope:
| Key | Action |
|---|---|
| `C-n` / `C-p` (or arrows) | next / previous result |
| `Enter` | open |
| `C-v` / `C-x` | open in vertical / horizontal split |
| `C-q` | send all results to quickfix list |
| `C-u` / `C-d` | scroll preview |
| `Esc` Esc | close (first Esc = normal mode, where `j/k` work) |

Quickfix list (after `C-q`): `:copen`, `:cnext` / `:cprev`, `:cclose`.

### nvim-tree (file explorer)
| Key | Action |
|---|---|
| `C-n` | toggle tree |
| `<leader>e` | focus tree |
| `Enter` / `o` | open file / expand folder |
| `a` | create file (end with `/` for folder: `handlers/`) |
| `d` | delete |
| `r` | rename |
| `x` / `c` / `p` | cut / copy / paste |
| `y` / `Y` | copy name / relative path |
| `H` | toggle dotfiles |
| `R` | refresh |
| `-` | go up one directory |
| `g?` | show all tree keys |

---

## 18. Coding: LSP, completion, formatting

LSP servers installed: Go (gopls), Python (basedpyright + ruff), Rust, TypeScript, Java,
Bash, Docker, Terraform, YAML/JSON (with SchemaStore validation for k8s, GitHub
Actions, compose, CloudFormation…), Lua, HTML/CSS.

### Navigation & info
| Key | Action |
|---|---|
| `gd` | go to definition (`C-o` to come back) |
| `gD` | go to declaration |
| `gr` | references |
| `gi` | implementations (great for Go interfaces) |
| `K` | hover docs / type info |
| `<leader>sh` | signature help (function params) |
| `<leader>rn` | rename symbol everywhere |
| `<leader>ca` | code actions (fill struct, add import, quick fixes) |
| `<leader>fs` / `<leader>fS` | symbols in file / workspace |

### Diagnostics
| Key | Action |
|---|---|
| `]d` / `[d` | next / previous error or warning |
| `<leader>q` | put all diagnostics in the location list |
| `<leader>fd` | Telescope diagnostics |

### Completion (nvim-cmp)
In **learn mode** the menu never pops up on its own. Try to recall the API first,
then press `C-Space` if you're stuck.

| Key | Action |
|---|---|
| `C-Space` | open completion |
| `C-n` / `C-p` or `Tab` / `S-Tab` | next / previous item |
| `Enter` | accept |
| `C-e` | close menu |
| `C-f` / `C-d` | scroll docs |
| `Tab` / `S-Tab` (in snippet) | jump to next / previous placeholder |

### Copilot (work mode only, `<leader>tl`)
| Key | Action |
|---|---|
| `C-y` | accept suggestion |
| `C-t` | accept one word |
| `C-]` / `C-\` | next / previous suggestion |
| `C-e` | dismiss |

### Formatting
Auto-format on save (gofumpt+goimports-reviser+golines for Go, ruff for Python, prettier
for JS/TS/YAML/JSON, terraform fmt, rustfmt, stylua). Manual: `<leader>fm`.

### Commenting
`gcc` line, `gc{motion}` (e.g. `gcap`, `gc3j`), visual `gc`.

---

## 19. Git inside nvim

| Key | Action |
|---|---|
| `<leader>gg` | **lazygit** (full git UI: stage, commit, push, rebase) |
| `]h` / `[h` | next / previous changed hunk |
| `<leader>gp` | preview hunk diff |
| `<leader>gs` | stage hunk |
| `<leader>gr` | reset (discard) hunk |
| `<leader>gb` | blame this line |
| `<leader>gt` | git status in Telescope |

Lazygit essentials: `space` stage, `c` commit, `P` push, `p` pull, `?` help, `q` quit.

---

## 20. Learn mode, toggles & helpers

| Key | Action |
|---|---|
| `<leader>tl` | **learn ↔ work mode** (learn = Copilot off + manual completion). Starts in learn. Statusline shows which mode you're in. |
| `<leader>tp` | precognition: show where motions land on the current line |
| `<leader>th` | toggle hardtime (motion coach) |
| `<leader>ts` | muted ↔ full-color syntax |
| `<leader>z` | zen mode |
| `<leader>sn` | dismiss notifications |
| `<leader>u` | undotree |
| `<leader>?` | which-key for this buffer |

Hardtime commands: `:Hardtime report` shows the habits you repeat most. Fix the top one
each week. When hints feel easy, set `restriction_mode = "block"` in
`lua/plugins/init.lua`.

Built-in tutor (disabled in this config's startup for speed, but works like this):
```
nvim --clean +Tutor
```
Do it once fully. It takes about 30 minutes and is worth it.

---

## 21. Command-line power moves

```
:e path/to/file          open file (Tab completes)
:e!                      reload file, discard changes
:w !sudo tee %           save a root-owned file
:r !date                 insert command output below
:!go test ./...          run shell command
:%!jq .                  pretty-print JSON buffer through jq
:'<,'>!sort -u           sort selected lines via shell
:noh                     clear highlight (or Esc)
:Lazy                    plugin manager
:Mason                   install LSPs/formatters
:checkhealth             diagnose problems
:LspInfo / :checkhealth vim.lsp   see attached language servers
q:                       command history window (edit old commands with vim!)
q/                       search history window
```

In `:` mode: `C-r C-w` inserts the word under the cursor, and `Up`/`Down` walks history
filtered by what you've typed.

---

## 22. tmux cheatsheet

Prefix = **`C-a`**.

| Keys | Action |
|---|---|
| `C-a \|` / `C-a -` | split side-by-side / top-bottom |
| `C-h/j/k/l` | move between panes (and nvim splits) |
| `C-a H/J/K/L` | resize pane |
| `C-a m` | zoom pane (toggle) |
| `C-a x` | kill pane |
| `C-a c` | new window |
| `A-1`…`A-9` | jump to window |
| `C-a ,` | rename window |
| `C-a S` | pick session |
| `C-a N` | new session |
| `C-a $` | rename session |
| `C-a d` | detach |
| `C-a [` | copy mode (vim keys, `v` select, `y` yank) |
| `C-a r` | reload config |

### Save & load sessions (manual, your choice)
tmux **never** auto-restores. You decide what to load.

| Keys | Action |
|---|---|
| `C-a C-s` | save everything under a name (e.g. `grind`, `api-project`) |
| `C-a C-r` | menu → pick a named save (1–9) or `a` = latest autosave |
| `C-a C-x` | menu → delete a named save |

Autosave still runs every 15 min as a crash backup ("latest autosave" in the menu) but
never overwrites your named saves. Saves live in `~/.local/share/tmux/resurrect/named/`.

Best practice: open a fresh tmux (`tmux`), `C-a C-r`, pick your save. Restoring into a
session that already has the same names only fills in what's missing.

---

## 23. 4-week grind plan

Do 15 minutes of drills before coding each day. Then code **only** with what you've
learned so far, and check `:Hardtime report` on Fridays.

**Week 1: movement**
- Day 1: §1 + `nvim --clean +Tutor`
- Day 2: `w b e`, `0 ^ $`: no `h/l` spam
- Day 3: `f t F T ,`: reach any char on a line in ≤ 2 keystrokes
- Day 4: relative numbers + `5j`, `{ }`, `%`, `gg G`
- Day 5: `/ ? n N * #` and `C-o` / `C-i`
- Weekend: navigate a real repo using only `gd`, `gr`, `C-o`, `<leader>ff`, `<leader>fw`

**Week 2: editing grammar**
- `d c y` + motions: `dw`, `cw`, `d$`, `ct,`, `dt)`
- text objects: `ci" ci( di{ yap vi{`, one per day until it's automatic
- `.` repeat, and the `cgn` pattern
- surround: `ysiw" cs"' ds(`
- `o O A I` instead of moving then pressing `i`

**Week 3: files & flow**
- Harpoon as the default way to switch files (`<leader>ha`, `<leader>1-4`)
- Splits and tmux panes: code | tests | shell
- Telescope + quickfix: grep, `C-q`, `:cdo`
- LSP: `<leader>ca`, `<leader>rn`, `K`, `]d`
- Git: hunks with `]h`, `<leader>gp`, lazygit commits

**Week 4: power**
- registers (`"0p`, `"_d`, `"a`)
- macros: record one real refactor a day
- `:s` with ranges and `:g`/`:v`
- visual block inserts
- switch hardtime to `block` mode

### Self-check: can you do these without thinking?
- [ ] Change a function's arguments from anywhere inside the parens (`ci(`)
- [ ] Delete a whole function (`dap` or `V%d` from the `{`)
- [ ] Jump to a definition and back (`gd`, `C-o`)
- [ ] Rename a variable project-wide (`<leader>rn`)
- [ ] Add a line-ending char to 5 lines (`A,` Esc, `j.` ×4 / or block `$A`)
- [ ] Find every usage of a word (`*` / `gr`)
- [ ] Move 3 lines down 10 lines (`V2j` then `J` ×10 / or `:m +10`)
- [ ] Swap between 4 files in < 1 second each (Harpoon)
- [ ] Replace all `foo` with `bar` only inside a function (`vi{` then `:s/foo/bar/g`)
- [ ] Record and replay a macro across 20 lines

---

## 24. Full keybinding reference (this config)

Source of truth: `lua/mappings.lua`, `lua/plugins/init.lua`, `lua/configs/cmp.lua`.

### General
| Key | Mode | Action |
|---|---|---|
| `;` | n | command mode (`:`) |
| `jk` | i | escape |
| `C-s` | n,i,v | save |
| `Esc` | n | clear highlight |
| `C-x` | t | leave terminal mode |
| `<leader>b` | n | new buffer |
| `<leader>ya` | n | yank whole file |
| `<leader>?` | n | buffer keymaps (which-key) |

### Buffers & files
| Key | Action |
|---|---|
| `Tab` / `S-Tab`, `]b` / `[b` | next / prev buffer |
| `<leader>x` | close buffer |
| `C-n` | toggle file tree |
| `<leader>e` | focus file tree |

### Editing
| Key | Mode | Action |
|---|---|---|
| `<` / `>` | v | indent, keep selection |
| `J` / `K` | v | move selection down / up |
| `gcc` / `gc` | n / v,op | comment |
| `ys` `cs` `ds` / `S` | n / v | surround |

### Windows
| Key | Action |
|---|---|
| `C-h/j/k/l`, `A-h/j/k/l` | move across nvim splits + tmux panes |
| `<leader>z` | zen mode |

### LSP
| Key | Action |
|---|---|
| `gd` `gD` `gr` `gi` | definition / declaration / references / implementation |
| `K` | hover |
| `<leader>rn` | rename |
| `<leader>ca` | code action |
| `<leader>sh` | signature help |
| `[d` / `]d` | prev / next diagnostic |
| `<leader>q` | diagnostics → loclist |
| `<leader>fm` | format |

### Find (Telescope)
`<leader>ff` files · `fw` grep · `fb` buffers · `fh` help · `fo` recent · `fs` symbols ·
`fS` workspace symbols · `fd` diagnostics · `ft` TODOs · `ma` marks · `gt` git status

### Harpoon
`<leader>ha` add · `<leader>hh` menu · `<leader>1..4` jump

### Git
`<leader>gg` lazygit · `gp` preview hunk · `gs` stage hunk · `gr` reset hunk ·
`gb` blame · `gt` status · `]h` / `[h` hunks

### TODOs
`]t` / `[t` next / prev TODO · `<leader>ft` list

### Toggles
`<leader>tl` learn/work · `tp` motion hints · `th` hardtime · `ts` syntax color ·
`u` undotree · `sn` dismiss notifications

### Completion (insert)
`C-Space` open · `C-n`/`C-p`/`Tab`/`S-Tab` select · `Enter` accept · `C-e` abort ·
`C-f`/`C-d` scroll docs

### Copilot (insert, work mode)
`C-y` accept · `C-t` word · `C-]` / `C-\` cycle · `C-e` dismiss
