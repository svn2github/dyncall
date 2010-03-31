#//////////////////////////////////////////////////////////////////////////////
#
# Copyright (c) 2010 Daniel Adler <dadler@uni-goettingen.de>, 
#                    Tassilo Philipp <tphilipp@potion-studios.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#//////////////////////////////////////////////////////////////////////////////


# Set default unix *fixes if unspecified.
OBJ_SUFFIX	= .o
LIB_PREFIX	= lib
LIB_SUFFIX	= _s.a
APP_PREFIX	=
APP_SUFFIX	=
DLL_PREFIX	= lib
DLL_SUFFIX	= .so

LINK_LIB_CMD	= $AR $ARFLAGS $target $prereq
LINK_DLL_CMD	= $CXX -o $target -shared $LDFLAGS $prereq $LIBS
LINK_APP_CMD	= $CXX -o $target $LDFLAGS $prereq $LIBS
#LINK_DLL_CMD	= $LD -o $target -shared $LDFLAGS $prereq $LIBS
#LINK_APP_CMD	= $LD -o $target $LDFLAGS $prereq $LIBS

