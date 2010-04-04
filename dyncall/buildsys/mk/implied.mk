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


%.o: %.c
	$CC $CFLAGS -I$TOP/dyncall -I$TOP/dyncallback -c $prereq -o $stem.o

%.o: %.cpp
	$CXX $CXXFLAGS -I$TOP/dyncall -I$TOP/dyncallback -c $prereq -o $stem.o

%.o: %.s
	$AS $ASFLAGS -o $stem.o $prereq
	
%.o: %.S
	cpp $CPPFLAGS $prereq | $AS $ASFLAGS -o $stem.o $prereq

%.pdf: %.tex
	pdflatex $prereq

