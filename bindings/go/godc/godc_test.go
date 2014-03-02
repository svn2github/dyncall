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
	"unsafe"
)

func TestGoDC(t *testing.T) {
	lm := new(ExtLib)
	if err := lm.Load("/usr/lib/libm.so"); err != nil {
		t.FailNow()
	}
	defer lm.Free()

	if err := lm.SymsInit("/usr/lib/libm.so"); err != nil {
		t.FailNow()
	}
	defer lm.SymsCleanup()

	fmt.Printf("Testing dl:\n")
	fmt.Printf("-----------\n")
	fmt.Printf("Loaded library at address: %p\n", lm.lib)
	fmt.Printf("C sqrt function at address: %p\n", lm.FindSymbol("sqrt"))
	fmt.Printf("C pow function at address: %p\n\n", lm.FindSymbol("pow"))

	fmt.Printf("Testing dlSyms:\n")
	fmt.Printf("---------------\n")
	fmt.Printf("Symbols in libm: %d\n", lm.SymsCount())
	fmt.Printf("Symbol name for address %p: %s\n", lm.FindSymbol("pow"), lm.SymsNameFromValue(lm.FindSymbol("pow")))
	fmt.Printf("All symbol names in libm:\n")
	for i, n := 0, lm.SymsCount(); i<n; i++ {
		fmt.Printf("  %s\n", lm.SymsName(i))
	}
	fmt.Printf("\n")



	// Another lib
	lc := new(ExtLib)
	if err := lc.Load("/usr/lib/libc.so"); err != nil {
		t.FailNow()
	}
	defer lc.Free()

	if err := lc.SymsInit("/usr/lib/libc.so"); err != nil {
		t.FailNow()
	}
	defer lc.SymsCleanup()

	fmt.Printf("Symbols in libc: %d (not listing them here, too many)\n\n", lc.SymsCount())



	// Call some functions
	fmt.Printf("Testing dc:\n")
	fmt.Printf("-----------\n")
	vm := new(CallVM)
	if err := vm.InitCallVM(); err != nil {
		t.FailNow()
	}
	defer vm.Free()

	vm.Mode(DC_CALL_C_DEFAULT)

	// Float
	vm.Reset()
	vm.ArgFloat(36)
	fmt.Printf("sqrtf(36) = %f\n", vm.CallFloat(lm.FindSymbol("sqrtf")))
	vm.Reset() // Test reset, reusing VM
	vm.ArgDouble(3.6)
	fmt.Printf("floor(3.6) = %f\n", vm.CallDouble(lm.FindSymbol("floor")))

	// Double
	vm.Reset()
	vm.ArgDouble(4.2373)
	fmt.Printf("sqrt(4.2373) = %f\n", vm.CallDouble(lm.FindSymbol("sqrt")))
	vm.Reset()
	vm.ArgDouble(2.373)
	vm.ArgDouble(-1000) // 2 args
	fmt.Printf("copysign(2.373, -1000) = %f\n", vm.CallDouble(lm.FindSymbol("copysign")))

	// Strings
	vm.Reset()
	cs1 := vm.AllocCString("/return/only/this_here")
	defer vm.FreeCString(cs1)

	vm.ArgPointer(cs1)
	fmt.Printf("basename(\"/return/only/this_here\") = %s\n", vm.CallPointerToStr(lc.FindSymbol("basename")))
	// Reuse path
	fmt.Printf("dirname(\"/return/only/this_here\") = %s\n", vm.CallPointerToStr(lc.FindSymbol("dirname")))

	// Integer
	vm.Reset()
	vm.ArgInt('a')
	fmt.Printf("toupper('a') = %c\n", vm.CallInt(lc.FindSymbol("toupper")))
	vm.Reset()
	vm.ArgInt('a')
	fmt.Printf("tolower('a') = %c\n", vm.CallInt(lc.FindSymbol("tolower")))
	vm.Reset()
	vm.ArgInt('R')
	fmt.Printf("toupper('R') = %c\n", vm.CallInt(lc.FindSymbol("toupper")))
	vm.Reset()
	vm.ArgInt('R')
	fmt.Printf("tolower('R') = %c\n", vm.CallInt(lc.FindSymbol("tolower")))

	// Integer return
	vm.Reset()
	cs2 := vm.AllocCString("Tassilo")
	defer vm.FreeCString(cs2)

	fmt.Printf("rand() = %d\n", vm.CallInt(lc.FindSymbol("rand")))
	fmt.Printf("rand() = %d\n", vm.CallInt(lc.FindSymbol("rand")))
	fmt.Printf("rand() = %d\n", vm.CallInt(lc.FindSymbol("rand")))
	fmt.Printf("rand() = %d\n", vm.CallInt(lc.FindSymbol("rand")))
	fmt.Printf("rand() = %d\n", vm.CallInt(lc.FindSymbol("rand")))
	vm.ArgPointer(cs2)
	fmt.Printf("strlen(\"Tassilo\") = %d\n", vm.CallInt(lc.FindSymbol("strlen")))

	// Ellipse
	vm.Mode(DC_CALL_C_ELLIPSIS)
	vm.Reset()
	buf := make([]byte, 1000)
	bufPtr := unsafe.Pointer(&buf[0])
	cs3 := vm.AllocCString("Four:%d | \"Hello\":%s | Pi:%f")
	cs4 := vm.AllocCString("Hello")
	defer vm.FreeCString(cs4)
	defer vm.FreeCString(cs3)

	vm.ArgPointer(bufPtr)
	vm.ArgPointer(cs3)
	vm.Mode(DC_CALL_C_ELLIPSIS_VARARGS)
	vm.ArgInt(4)
	vm.ArgPointer(cs4)
	vm.ArgDouble(3.14) // Double, b/c of ... promotion rules
	n := vm.CallInt(lc.FindSymbol("sprintf"))
	fmt.Printf("sprintf(bufPtr, \"Four:%%d | \\\"Hello\\\":%%s | Pi:%%f\", 4, \"Hello\", 3.14) = %d:\n", n)
	fmt.Printf("  bufPtr: %s\n", string(buf[:n]))
}

