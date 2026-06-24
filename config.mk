# abook - config.mk
# Edit to match your system, then run: make && sudo make install

PREFIX    = /usr/local
MANPREFIX = $(PREFIX)/share/man

CC        = cc
CFLAGS    = -O2 -Wall
LDFLAGS   =

# ncurses: prefer wide-character variant (ncursesw), fall back to ncurses
# Arch/Debian: -lncursesw   macOS (Homebrew): -lncurses
LIBS      = -lncursesw -lreadline
