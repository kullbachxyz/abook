include config.mk

SRCS = abook.c abook_rl.c database.c edit.c filter.c getname.c \
       getopt.c getopt1.c gettext.c ldif.c list.c mbswidth.c \
       misc.c options.c ui.c views.c xmalloc.c

OBJS = $(SRCS:.c=.o)

CPPFLAGS = -DHAVE_CONFIG_H -I. -D_GNU_SOURCE

all: abook

abook: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

install: abook
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f abook $(DESTDIR)$(PREFIX)/bin/abook
	chmod 755 $(DESTDIR)$(PREFIX)/bin/abook
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f abook.1 $(DESTDIR)$(MANPREFIX)/man1/abook.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/abook.1
	mkdir -p $(DESTDIR)$(MANPREFIX)/man5
	cp -f abookrc.5 $(DESTDIR)$(MANPREFIX)/man5/abookrc.5
	chmod 644 $(DESTDIR)$(MANPREFIX)/man5/abookrc.5

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/abook
	rm -f $(DESTDIR)$(MANPREFIX)/man1/abook.1
	rm -f $(DESTDIR)$(MANPREFIX)/man5/abookrc.5

clean:
	rm -f abook $(OBJS)

.PHONY: all install uninstall clean
