#### Shrinkelf



Strip elf binaries aggressively.

Might work only for statically linked binaries,
but not severely tested.

I (misc) ported the code to work with 64bit binaries,
and to compile with [minilib](https://github.com/michael105/minilib) (or the standard c lib)
without external dependencies. 
The original source can be found at https://github.com/berney/superstrip.


##### Compile


Just type `make`.

To download and link with minilib,
type `make -f minilib.make`.


##### Doc

Usage: shrinkelf [file]

(copied from the original source)


[file] must be a seekable ELF file, and this is only useful for an
executable, possibly only for a statically linked executable.  It
will be copied to a temporary file, but only those parts which are
mapped in memory upon loading will be kept: all other data, such as
symbol names, section names, section tables, debugging information,
etc, are discarded.  Thus, this is like the "strip" operation, but
even more radical.  The primary author advises you to use
this program only in situations where disk space is extremely
scarce (e.g. on a floppy).  Note that this will not gain you any
space in memory, by definition. 

Some important caveats:
Do not use on object files, nor on dynamic libraries with which you
intend to link (I mean ld-link, not run-time link), this would make
them useless.  Use on dynamic libraries only intended for run-time
link, or on dynamically linked executable, appears to work in some
situations, but this is by no means guaranteed (of course, nothing
about this program is guaranteed anyway, see above) and strongly
discouraged. 
Only 32-bit ELF is supported at the moment.  Support for 64-bit ELF
is intended in a future version. 
Only native endianness is supported.  That is, the program will
only treat ELF files made for a machine with the same endianness as
that on which it runs. 
This has not been extensively tested yet and many bugs are probably
still lurking. 




