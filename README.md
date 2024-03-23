# Portable Bit Manipulation for Modula-2
An API for bit manipulation that is portable between different Modula-2 dialects.

This library consists of a common API definition, a set of compiler-specific and system-specific implementation modules, a portable implementation for use by unsupported compilers/systems, and a common test suite.

## Supported Implementations
The portable implementation has been tested on
* GNU Modula-2 for Linux x86_64
* GNU Modula-2 for Solaris sparc64 (ISO) (tested by John O. Goyo)
* XDS Modula-2 (32-bit) (ISO) (tested by Michael Reidl)

Specific implementations at this time include
* GNU Modula-2 for Linux x86_64 (ISO)

## Directory Structure
Definition and implementation files are each stored to separate directories, `defs/` and `impls/` respectively. Each compiler-specific implementation is saved in a separate directory under `impls/`, with system-specific implementations in sub-directories of these where appropriate. The included Makefile will save object (`.o` or `.obj`) files to sub-directories under `objs/`, while the executable files are saved to appropriate sub-directories of `bin/`. Finally, the test suite is located in the `test/` directory.

The current directory structure is:
```
(library root)
|_ defs/
|
|_ impls/
|  |_ portable/
|  |_ gnu/
|     |_ x86_64/
|
|_ objs/
|  |_ portable/
|  |_ gnu/
|     |_ x86_64/
|
|_ bin/
|  |_ portable/
|  |_ gnu/
|     |_ x86_64/
|
|_ tests/
```


## Test Suite
A simple ad-hoc test suite has been provided which is intended to exercise each of the procedures of a given implementation of the API.

### Makefile
A Makefile is provided for user convenience. At this time the Makefile has only been tested on Linux for x86_64.

To compile a test for a given implementation, use the appropriate `make` entry for the implementation to be tested. At this time, there are two testing options:

* `make tests_portable`
* `make tests_gnu_x86_64`

To compile a given implementation without also compiling the test suite, the following options are currently supported:

* `make portable`
* `make gnu_x86_64`


## Credits
This library is licensed under the GNU General Public License v.3, as described in the LICENSE file. Copyright (C) 2024 Alice Osako.

Portions of this code are derived from the [Modula-2 Bootstrap Kernel project](https://github.com/m2sf/m2bsk), Copyright (c) 2020 Modula-2 Software Foundation under the GNU Limited General Public License v.3.

Thanks to Benjamin Kowarsch for providing the M2BSK code that was the basis for this project, as well as general advice on implementation practices.

Thanks to Gaius Mulley for assistance in using the GNU Modula-2 compiler and libraries, and for the patience shown in assisting the primary developer.

Thanks to Michael Reidl for testing the portable library under XDS Modula-2, and provided bugfixes.

Thanks to John O. Goyo for testing the portable library under GNU Modula-2 (Solaris, sparc64).

Thanks to Eric Streit, John O. Goyo, Rudolph Schubert, and Christopher Schlegel for general advice and assistance.
