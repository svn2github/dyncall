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

// #cgo LDFLAGS: -L../../../dyncall/ -ldyncall_s
// #cgo LDFLAGS: -L../../../dynload/ -ldynload_s
// #cgo LDFLAGS: -L../../../dyncallback/ -ldyncallback_s
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
}

type CallVM struct {
	cvm  *C.DCCallVM
}


// dynload
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


// dynload Syms
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


// dyncall
func (p *CallVM) InitCallVM() error {
	return p.InitCallVMWithStackSize(4096)
}

func (p *CallVM) InitCallVMWithStackSize(stackSize int) error {
	p.cvm = C.dcNewCallVM(C.DCsize(stackSize))
	if p.cvm != nil { return nil }
	return fmt.Errorf("Can't create CallVM")
}

func (p *CallVM) Free() {
	C.dcFree(p.cvm)
}

func (p *CallVM) Reset() {
	C.dcReset(p.cvm)
}

func (p *CallVM) Mode(mode int) {
	C.dcMode(p.cvm, C.DCint(mode))
}


/*
DC_API void       dcMode          (DCCallVM* vm, DCint mode);

DC_API void       dcArgBool       (DCCallVM* vm, DCbool     value);
DC_API void       dcArgChar       (DCCallVM* vm, DCchar     value);
DC_API void       dcArgShort      (DCCallVM* vm, DCshort    value);
DC_API void       dcArgInt        (DCCallVM* vm, DCint      value);
DC_API void       dcArgLong       (DCCallVM* vm, DClong     value);
DC_API void       dcArgLongLong   (DCCallVM* vm, DClonglong value);
DC_API void       dcArgFloat      (DCCallVM* vm, DCfloat    value);
DC_API void       dcArgDouble     (DCCallVM* vm, DCdouble   value);
DC_API void       dcArgPointer    (DCCallVM* vm, DCpointer  value);
DC_API void       dcArgStruct     (DCCallVM* vm, DCstruct* s, DCpointer value);

DC_API void       dcCallVoid      (DCCallVM* vm, DCpointer funcptr);
DC_API DCbool     dcCallBool      (DCCallVM* vm, DCpointer funcptr);
DC_API DCchar     dcCallChar      (DCCallVM* vm, DCpointer funcptr);
DC_API DCshort    dcCallShort     (DCCallVM* vm, DCpointer funcptr);
DC_API DCint      dcCallInt       (DCCallVM* vm, DCpointer funcptr);
DC_API DClong     dcCallLong      (DCCallVM* vm, DCpointer funcptr);
DC_API DClonglong dcCallLongLong  (DCCallVM* vm, DCpointer funcptr);
DC_API DCfloat    dcCallFloat     (DCCallVM* vm, DCpointer funcptr);
DC_API DCdouble   dcCallDouble    (DCCallVM* vm, DCpointer funcptr);
DC_API DCpointer  dcCallPointer   (DCCallVM* vm, DCpointer funcptr);
DC_API void       dcCallStruct    (DCCallVM* vm, DCpointer funcptr, DCstruct* s, DCpointer returnValue);

DC_API DCint      dcGetError      (DCCallVM* vm);

DC_API DCstruct*  dcNewStruct      (DCsize fieldCount, DCint alignment);
DC_API void       dcStructField    (DCstruct* s, DCint type, DCint alignment, DCsize arrayLength);
DC_API void       dcSubStruct      (DCstruct* s, DCsize fieldCount, DCint alignment, DCsize arrayLength);  	
DC_API void       dcCloseStruct    (DCstruct* s);  	
DC_API DCsize     dcStructSize     (DCstruct* s);  	
DC_API DCsize     dcStructAlignment(DCstruct* s);  	
DC_API void       dcFreeStruct     (DCstruct* s);

DC_API DCstruct*  dcDefineStruct  (const char* signature);
*/
