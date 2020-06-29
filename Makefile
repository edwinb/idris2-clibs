.PHONY: build install clean

build:
	idris2 MakeLibs.idr -x build

install:
	idris2 MakeLibs.idr -x install

clean:
	idris2 MakeLibs.idr -x clean
