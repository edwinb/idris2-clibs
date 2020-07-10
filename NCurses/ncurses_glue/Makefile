IDRIS           := idris2
MACHINE         := $(shell $(CC) -dumpmachine)

ifneq (, $(findstring darwin, $(MACHINE)))
	OS      :=darwin
else ifneq (, $(findstring cygwin, $(MACHINE)))
	OS      :=windows
else ifneq (, $(findstring mingw, $(MACHINE)))
	OS      :=windows
else ifneq (, $(findstring windows, $(MACHINE)))
	OS      :=windows
else
	OS      :=unix
endif

ifeq ($(OS), darwin)
        SHLIB_SUFFIX    :=dylib
else ifeq ($(OS), windows)
        SHLIB_SUFFIX    :=dll
else
        SHLIB_SUFFIX    :=so
endif

LIBTARGET = libidrisncurses.$(SHLIB_SUFFIX)
INSTALLDIR = `${IDRIS} --libdir`/ncurses/lib

HDRS = idris_ncurses.h
OBJS = idris_ncurses.o

NCURSES_LIBS := -lncurses
NCURSES_FLAGS := -fPIC

CFLAGS = $(NCURSES_FLAGS)

$(LIBTARGET): $(OBJS)
	$(CC) -o $(LIBTARGET) -shared $(OBJS) $(NCURSES_LIBS) $(NCURSES_FLAGS)
	
clean:
	rm -f $(OBJS) $(LIBTARGET)

install:
	@if ! [ -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	install $(LIBTARGET) $(HDRS) $(INSTALLDIR)

.PHONY: install clean
