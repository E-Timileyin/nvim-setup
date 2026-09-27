# Motions — one-page drill card

For **recall**, not reading. Everything here was verified against this nvim
(0.12.5) with `:normal` on a live buffer, not copied from a cheat sheet.

Deep explanation → [LEARN-NVIM.md](LEARN-NVIM.md). Drill plan → its §23.

> Leader = `Space` · `jk` = Escape · `;` = `:` · `<C-s>` = save

---

## 1. The only sentence that matters

```
[count] operator [count] motion / text-object
   2        d             w
   —        c            i"
```

**Verb** says what. **Motion** says where. **Count** says how many.

Eight verbs × twenty motions ≈ 160 commands, zero new keys.

**If you pressed the same key three times, a motion exists that does it once.**
That single rule is the whole skill. Stop and look it up.

---

## 2. Verbs

| key | action |
|---|---|
| `d` | delete |
| `c` | change — delete, then insert |
| `y` | yank |
| `>` `<` | indent / dedent |
| `=` | auto-indent |
| `gc` | comment (Comment.nvim) |
| `gu` `gU` `g~` | lower / UPPER / toggle case |
| `ys` `cs` `ds` | add / change / delete surround (nvim-surround) |
| `!` | filter through a shell command |

Doubled = whole line → `dd` `cc` `yy` `>>` `==` `gcc`
Capital = to end of line → `D`=`d$` · `C`=`c$` · `Y`=`y$`

---

## 3. Motions, ranked by how much you'll actually use them

### Tier 1 — get these automatic first

| key | lands on |
|---|---|
| `w` `b` | next / previous word start |
| `e` | end of word |
| `0` `$` | line start / line end |
| `^` | first non-blank |
| `gg` `G` | file top / bottom |
| `{n}G` · `:{n}` | line n |
| `f{c}` then `;` `,` | to next `c` · repeat · reverse |
| `i{a}` `a{a}` | text objects — §4 |

### Tier 2 — once Tier 1 is muscle memory

| key | lands on |
|---|---|
| `ge` | previous word end |
| `g_` | last non-blank |
| `t{c}` `T{c}` `F{c}` | *till* char · backwards |
| `%` | matching bracket |
| `{` `}` | paragraph (blank-line block) |
| `(` `)` | sentence |
| `C-d` `C-u` | half page down / up |
| `zt` `zz` `zb` | scroll line to top / centre / bottom |
| `H` `M` `L` | screen top / middle / bottom |
| `gj` `gk` | down / up a *display* line — for wrapped text |
| `''` | back to the last jump |

### Capital = WORD (whitespace-delimited)

The difference is only punctuation — `_` counts as a word character in both:

| text | `iw` | `iW` |
|---|---|---|
| `foo.bar` | `foo` | `foo.bar` |
| `kebab-case` | `kebab` | `kebab-case` |
| `a::b::c` | `::` | `a::b::c` |
| `foo_barBaz` | `foo_barBaz` | `foo_barBaz` |

---

## 4. Text objects — the nouns

`i` = **inner**, `a` = **around** (includes delimiters / whitespace).
Used after a verb: `d` `c` `y` `v` `>` `gc` `ys` …

| object | selects |
|---|---|
| `iw` / `aw` | word / word + trailing space |
| `iW` / `aW` | WORD |
| `i"` `i'` `` i` `` | inside quotes |
| `i(` — also `ib` | inside parens |
| `i{` — also `iB` | inside braces = a function body |
| `i[` | inside brackets |
| `i<` | inside angle brackets — `Vec<u8>` → `u8` |
| `it` | inside an HTML/XML tag |
| `ip` / `ap` | paragraph |
| `is` / `as` | sentence |

**You do not need to be at the start.** Anywhere inside is enough — that is the
entire point of text objects, and the reason `ciw` beats `b c e`.

**Not available in your setup:** `ii`/`ai` (indent block), `if`/`af` (function),
`ic`/`ac` (class). I tested — `dii` is a no-op, and they are absent from nvim's
`motion.txt`. They need `nvim-treesitter-textobjects`, which you don't have. See §7.

---

## 5. Ten combos that cover most editing

Verified against a live buffer:

| combo | input → output |
|---|---|
| `ciw` | `hello world` → ` world` |
| `ci"` | `say "hi there" now` → `say "" now` |
| `di(` | `call(foo, bar)` → `call()` |
| `caw` | `hello world` → `world` |
| `dap` | deletes the whole paragraph |
| `vi{` then `>` | indents a function body |
| `gcip` | comments a whole function |
| `gc}` | comments to end of paragraph |
| `da(` | `call(foo, bar) x` → `call x` |
| `ysiw"` | `hello world` → `"hello" world` |

Two more worth knowing:

- `ds(` **removes the delimiters but keeps the contents** — `call(foo) x` → `callfoo x`. It does not delete the text inside. Use `di(` for that.
- `cs"'` changes the surrounding quotes — `say "hi" now` → `say 'hi' now`.

---

## 6. Insert, save, quit

| key | action |
|---|---|
| `i` `a` | insert before / after cursor |
| `I` `A` | insert at first non-blank / end of line |
| `o` `O` | open a line below / above |
| `gi` | jump back to where you last inserted |
| `jk` | Escape |
| `<C-s>` | save (from normal, insert, or visual) |
| `;` | `:` — command line |
| `:w` `:wq` `:q!` | write · write+quit · discard |

### `C-a` / `C-x` — increment / decrement

Underused. It understands the number's format:

| input | `C-a` | `10 C-a` | `C-x` |
|---|---|---|---|
| `port = 3000` | `port = 3001` | `port = 3010` | `port = 2999` |
| `hex = 0xFF` | `hex = 0x100` | | |
| `v1.9` | `v1.10` | | |

Note `v1.9` → `v1.10`, not `v2.9`. It increments the number under the cursor.

---

## 7. The gap worth closing

Your motion set is missing the tree-sitter text objects. Today `ci(` guesses by
bracket matching; `cif` would mean *this function's body*, at whatever nesting
depth, without you finding the braces.

Installing `nvim-treesitter-textobjects` gives you:

`if` / `af` function · `ic` / `ac` class · `ia` / `aa` argument · `ii` / `ai` indent block

That is the single biggest available upgrade to your motions. Say the word.

---

## 8. Retrieval drills

**Cover the answers. Write the keystrokes on paper. Then check.**
Re-reading this table is not practice — failing to recall is.

1. Change the word under the cursor, stay in insert mode.
2. Delete from the cursor to the end of the paragraph.
3. Wrap the current word in double quotes.
4. Jump to the matching closing brace of the function you're inside.
5. Change everything inside the current string literal.
6. Move the current line to the middle of the screen.
7. Jump to the top of the file, then back to where you were.
8. Delete the next three words.
9. Comment out the whole function you're in.
10. Add 1 to the number under the cursor.

<details>
<summary>Answers</summary>

1. `ciw`
2. `d}`
3. `ysiw"`
4. `%`
5. `ci"`
6. `zz`
7. `gg`, then `''`
8. `d3w`
9. `gcip` — cursor inside the body. (`gcaf` once §7 is installed.)
10. `<C-a>`

</details>

---

## 9. How this actually becomes automatic

Reading this card will not do it. Three things will:

1. **`<leader>th`** — turns on hardtime. It blocks your second consecutive
   `h`/`j`/`k`/`l` and tells you the motion you should have used. This is the
   drill. Expect it to be irritating for about a week; that irritation *is* the
   learning.
2. **`<leader>tp`** — precognition renders ghost hints for `w b e $ ^ { }` in the
   buffer, so the target is visible before you commit. Good for Tier 1.
3. **`<leader>` and wait** — which-key lists what's actually bound. You never need
   to memorise *config* keys, because which-key will tell you. Note this card is
   therefore about **motions**, which which-key cannot show you — press `d` and
   wait, and you get nothing.

One rule to carry out of this file: **the moment you feel yourself pressing a key
three times, stop and find the motion.** That is the entire skill, and it is the
only part of this that scales.
