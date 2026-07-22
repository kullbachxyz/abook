# abook

A terminal address book, built on [abook](http://abook.sourceforge.net/) by JH.

This is a fork of [hhirsch/abook](https://github.com/hhirsch/abook) with the following additions:

- **Edit fields in place** — the existing value is pre-loaded when editing, so you can fix typos without retyping.
- **Configurable date format** — display birthday, anniversary, and other date fields in any format via `abookrc`.
- **Mudita export** — a `mudita` export filter producing vCard 3.0 that Mudita Center / Mudita phones (Kompakt etc.) will actually import.

---

## Installation

### Dependencies

| Package | Notes |
|---|---|
| `ncurses` | `libncursesw5-dev` / `ncurses-devel` |
| `readline` | GNU readline with history support (`libreadline-dev` / `readline-devel`) |

**Debian / Ubuntu:**
```sh
sudo apt install build-essential libncursesw5-dev libreadline-dev
```

**Arch Linux:**
```sh
sudo pacman -S base-devel ncurses readline
```

**Fedora / RHEL:**
```sh
sudo dnf install gcc make ncurses-devel readline-devel
```

**macOS (Homebrew):**
```sh
brew install ncurses readline
```

### Build from source

```sh
git clone https://github.com/kullbachxyz/abook
cd abook
make
sudo make install
```

To install to a custom prefix (e.g. `~/.local`), edit `config.mk` before building:

```
PREFIX = $(HOME)/.local
```

Then `make && make install` (no `sudo` needed for a user prefix).

---

## Configuration

Abook reads `~/.abook/abookrc` on startup. A sample config is installed to
`/usr/local/etc/abook/abookrc` (or see `sample.abookrc` in this repo).

### Date format

Date fields (birthday, anniversary, etc.) can be displayed in any format:

```
set date_format = "%D.%M.%Y"   # 30.06.1994  (German)
set date_format = "%D-%M-%Y"   # 30-06-1994
set date_format = "%Y-%M-%D"   # 1994-06-30  (ISO 8601, default)
```

| Sequence | Meaning | Example |
|---|---|---|
| `%Y` | Year, 4 digits | `1994` |
| `%y` | Year, no padding | `1994` |
| `%M` | Month, 2 digits | `06` |
| `%m` | Month, no padding | `6` |
| `%D` | Day, 2 digits | `30` |
| `%d` | Day, no padding | `30` |
| `%I` | ISO 8601 | `1994-06-30` |

The format applies in both the list view and the detail/edit view.

---

## Mudita export

Mudita phones import contacts through Mudita Center, but abook's default `vcard`
export is silently rejected ("no contacts to import"): Mudita's parser requires
a `VERSION:` line (which abook's vCard 2 output omits) and only reads the name
from the structured `N` property using `TYPE=` parameters. The `mudita` filter
emits vCard 3.0 shaped to that parser.

From the export menu (`e`) choose **vCard 3 file (Mudita phones)**, or from the
command line:

```sh
abook --convert --infile ~/.abook/addressbook --outformat mudita --outfile contacts.vcf
```

Then in Mudita Center: *Your Kompakt → Contacts → Import contacts → Import from file*
and select `contacts.vcf`.

---

## Mutt integration

Add to `~/.muttrc` (or the system-wide `/etc/Muttrc`):

```
set query_command = "abook --mutt-query '%s'"
macro pager A |'abook --add-email'\n
```

- Press `Q` in mutt to query the address book.
- Press `A` in the pager to add a sender's address directly.

It is also recommended to set `pipe_decode` in your mutt config — see the mutt manual for details.

Abook supports importing and exporting mutt alias files and a number of other formats. Mutt groups are fully supported.

---

## Notes

- **Locale / non-ASCII characters** — if special characters appear broken, make sure your locale is configured correctly. On Linux, `LC_CTYPE` must be set to a UTF-8 locale.
- **Debug mode** — build with `./configure --enable-debug` and redirect stderr: `abook 2>debug.log`.
- **LDIF import into Netscape** — files exported by abook must use the `.4ld` extension.

---

## Links

- Original upstream: http://abook.sourceforge.net/
- Original mailing list: https://lists.sourceforge.net/lists/listinfo/abook-devel

## License

Released under the GNU General Public License. See [COPYING](COPYING) for details.
