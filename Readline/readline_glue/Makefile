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

LIBTARGET = libidrisreadline.$(SHLIB_SUFFIX)
# TODO: Work out how to get the right install directory without hard coding
# the version number!
INSTALLDIR = `${IDRIS} --libdir`/readline-0.1/lib

HDRS = idris_readline.h
OBJS = idris_readline.o

READLINE_LIBS := -lreadline
READLINE_FLAGS := -fPIC

CFLAGS = $(READLINE_FLAGS)

$(LIBTARGET): $(OBJS)
	$(CC) -o $(LIBTARGET) -shared $(OBJS) $(READLINE_LIBS) $(READLINE_FLAGS)
	
clean:
	rm -f $(OBJS) $(LIBTARGET)

install:
	@if ! [ -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	install $(LIBTARGET) $(HDRS) $(INSTALLDIR)

.PHONY: install clean
