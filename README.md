AURCHPACK
========

This Makefile uses a list of
[AUR](https://wiki.archlinux.org/index.php/Arch_User_Repository) packages to
automatically batch install those packages. You need to have `make` installed,
of course.

[**NOTE: It is best to first `make download` and then check the `PKGBUILD`s
for security reasons!**](https://wiki.archlinux.org/index.php/Arch_User_Repository#Build_and_install_the_package)

Features
--------

- Install `base-devel` via `pacman`
- Downloading all `PKGBUILD`s from AUR listed in the specific file
- Build and install all those packages via `makepkg`
- Download only once!

Usage
-----

- Create file `pkgfile` with AUR packages. Only valid names and no blank lines
  allowed!

	package_name1
	package_name2

- `make` checks for `base-devel` package, downloads and extracts `PKGBUILD`s,
  installs packages
- `make download` checks for `base-devel` package, downloads and extracts
  `PKGBUILD`s, but does not install them
- `make deps` only installs `base-devel` package
- `make clean` cleans all files

Environment Variables
---------------------

You can pass environment variables to `make` like `make VARIABLE=value
[target]`, e. g. `make DOWNLOAD=false install`.

- `PKGFILE=pkgfile`: File with list
- `DLDIR=/tmp/aurchpack`: Download and build there
- `INSTALL=true`: Install packages
- `DOWNLOAD=true`: Download packages
- `DEPS=true`: install `base-devel` package
- `MAKEPKG=-si`: `makepkg` parameters

License
-------

Do with it what you want.

Trivia
------

- The file `downloaded` tells `aurchpack` that it does not need to download
  the files again. This way you can call `make download` and `make install`
  separately without downloading all packages again.
- `inferno` is actually the [Inferno Operating
  System](https://en.wikipedia.org/wiki/Inferno_(operating_system))
- [`sc-im`](https://github.com/andmarti1424/sc-im) is a terminal spreadsheet
  calculator

Why?
====

This may be the simplest way to install AUR packages. I want to use it as a
tool to sync my arch setup to another pc.
