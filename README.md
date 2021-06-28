Idris 2 CLibs
=============

A collection of Idris 2 bindings to C libraries. Installing:

* `make build` builds the libraries
* `make install` installs the packages into the Idris 2 prefix
* `make clean` cleans everything

Only the libraries for which the C dependencies are available will be built.
Currently, we have bindings for:

* `NCurses` (status: just a few basic functions)
* `Readline` (status: minimally useful)
* `SDL` (status: just a few basic functions)

Please don't expect any of these to be complete, well documented, or even
particularly usable yet! Contributions are welcome :).

(Please also don't expect a high level of support or maintenance, at the
moment. Volunteers to help maintain the collection will be gratefully
welcomed!)

Structure
---------

`MakeLibs.idr` lists the packages which will be installed, as a list of
subdirectories each of which includes a C package. These subdirectories
contain:

* A file `<package>.ipkg`, where `<package>` is the subdirectory name
* Optionally, a file `DEPS`, which lists the C libraries, one per line,
  required to use the library

They might also include C glue code, built and installed via the `ipkg`
file, and a `Test` directory. See `Readline` for a small example.

Conventions
-----------

Packages should export Idris bindings to the C interface as part of the
`System` hierarchy. Ideally, functions should use the `HasIO` interface rather
than using `IO` directly.

It is fine to include higher level APIs (e.g. using monad transformers, or
some kind of effect system) as long as the plain C bindings are also exposed.
