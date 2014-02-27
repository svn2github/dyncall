/*

 godc.go
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


// Go/dyncall extension implementation.
package godc

// #cgo LDFLAGS: -L../../../dynload/ -ldynload_s
// #include "../../../dyncall/dyncall/dyncall.h"
// #include "../../../dyncall/dynload/dynload.h"
// #include "../../../dyncall/dyncall/dyncall_signature.h"
import "C"
import (
	"unsafe"
	"fmt"
)

type ExtLib struct {
	lib  *C.DLLib
	syms *C.DLSyms
	cvm  *C.DCCallVM
}


/* Methods. */
func (p *ExtLib) Load(path string) error {
	p.lib = C.dlLoadLibrary(C.CString(path))
	if p.lib != nil { return nil }
	return fmt.Errorf("Can't load %s", path)
}

func (p *ExtLib) Free() {
	C.dlFreeLibrary(p.lib)
}

func (p *ExtLib) FindSymbol(name string) unsafe.Pointer {
	return unsafe.Pointer(C.dlFindSymbol(p.lib, C.CString(name)))
}


func (p *ExtLib) SymsInit(path string) error {
	p.syms = C.dlSymsInit(C.CString(path))
	if p.syms != nil { return nil }
	return fmt.Errorf("Can't load %s", path)
}

func (p *ExtLib) SymsCleanup() {
	C.dlSymsCleanup(p.syms)
}

func (p *ExtLib) SymsCount() int {
	return int(C.dlSymsCount(p.syms))
}

func (p *ExtLib) SymsName(i int) string {
	return C.GoString(C.dlSymsName(p.syms, C.int(i)))
}

func (p *ExtLib) SymsNameFromValue(v unsafe.Pointer) string {
	return C.GoString(C.dlSymsNameFromValue(p.syms, v))
}

/*func (p *ExtLib) SecCheck(rb_dcLibHandle* extLib)
{
	if(extLib->lib == NULL)
		rb_raise(rb_eRuntimeError, "no library loaded - use ExtLib#load");
}*/


/*func (p *ExtLib) Count() int {
	return C.dlSymsCount(p.lib);
}*/

/*
func (p *ExtLib) Each(int argc, VALUE* argv, VALUE self)//@@@ bug
{
	rb_dcLibHandle* extLib;
	size_t i, c;

	Data_Get_Struct(self, rb_dcLibHandle, extLib);

	if(!rb_block_given_p())
		rb_raise(rb_eRuntimeError, "no block given");

	ExtLib_SecCheck(extLib);

	c = dlSymsCount(extLib->lib);
	for(i=0; i<c; ++i)
		rb_yield(ID2SYM(rb_intern(dlSymsName(extLib->lib, i))));

	return self;
}


func (p *ExtLib) ExistsQ(VALUE self, VALUE sym)
{
	rb_dcLibHandle* extLib;

	Data_Get_Struct(self, rb_dcLibHandle, extLib);

	ExtLib_SecCheck(extLib);

	return dlFindSymbol(extLib->lib, rb_id2name(SYM2ID(sym))) ? Qtrue : Qfalse;
}
*/
