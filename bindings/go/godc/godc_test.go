/*

 godc_test.go
 Copyright (c) 2014 Tassilo Philipp <tphilipp@potion-studios.com>

 Permission to use, copy, modify, and distribute this software for any
 purpose with or without fee is hereby granted, provided that the above
 copyright notice and this permission notice appear in all copies.

 THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

*/


package godc

import (
	"testing"
	"fmt"
)

func TestGoDC(t *testing.T) {
	l := new(ExtLib)
	if err := l.Load("/usr/lib/libm.so"); err != nil {
		t.FailNow()
	}
	defer l.Free()

	if err := l.SymsInit("/usr/lib/libm.so"); err != nil {
		t.FailNow()
	}
	defer l.SymsCleanup()

	fmt.Printf("Testing dl:\n")
	fmt.Printf("-----------\n")
	fmt.Printf("Loaded library at address: %p\n", l.lib)
	fmt.Printf("C sqrt function at address: %p\n", l.FindSymbol("sqrt"))
	fmt.Printf("C pow function at address: %p\n\n", l.FindSymbol("pow"))

	fmt.Printf("Testing dlSyms:\n")
	fmt.Printf("---------------\n")
	fmt.Printf("Symbols in lib: %d\n", l.SymsCount())
	fmt.Printf("Symbol name for address %p: %s\n", l.FindSymbol("pow"), l.SymsNameFromValue(l.FindSymbol("pow")))
	fmt.Printf("All symbol names in lib:\n")
	for i, n := 0, l.SymsCount(); i<n; i++ {
		fmt.Printf("  %s\n", l.SymsName(i))
	}
	fmt.Printf("\n")

	fmt.Printf("Testing dc:\n")
	fmt.Printf("-----------\n")
}

