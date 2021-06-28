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

LIBTARGET = libidrissdl.$(SHLIB_SUFFIX)
# TODO: Work out how to get the right install directory without hard coding
# the version number!
INSTALLDIR = `${IDRIS} --libdir`/sdl-0.1/lib

HDRS = idris_sdl.h
OBJS = idris_sdl.o

SDL_LIBS := `sdl2-config --libs`
SDL_FLAGS := `sdl2-config --cflags`

CFLAGS = $(SDL_FLAGS)

$(LIBTARGET): $(OBJS)
	echo $(SDL_LIBS)
	$(CC) -o $(LIBTARGET) -shared $(OBJS) $(SDL_LIBS) $(SDL_FLAGS)
	
clean:
	rm -f $(OBJS) $(LIBTARGET)

install:
	@if ! [ -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	install $(LIBTARGET) $(HDRS) $(INSTALLDIR)

.PHONY: install clean
