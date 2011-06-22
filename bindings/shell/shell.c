/*
 Package: dyncall
 File: bindings/shell.c
 Description: printf(1) style function call mechanism
 License:
 Copyright (c) 2007-2011 Daniel Adler <dadler@uni-goettingen.de>, 
                         Tassilo Philipp <tphilipp@potion-studios.com>

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

#include "../../dyncall/dyncall/dyncall.h"
#include "../../dyncall/dynload/dynload.h"
#include "../../dyncall/dyncall/dyncall_signature.h"
#include <stdio.h>


void usage(const char* s)
{
	printf(
		"Usage: %s SO SYM SIG [ARGS]\n"
		"  where SO is the name of the shared object, SYM is the symbol name, SIG the\n"
		"  symbol's type signature, and ARGS the arguments.\n",
		s
	);
}


int main(int argc, char* argv[])
{
	const char* libPath;
	const char* symName;
	const DCsigchar* sig;
	const DCsigchar* i;
	void* sym;
	DCCallVM* vm;
	DLLib* dlLib;

	/* Parse arguments and check validity. */
	if(argc < 4) { /* Need at least shared object name, symbol name and signature string. */
		usage(argv[0]);
		return 1;
	}

	/* Check if number of arguments matches sigstring spec. */
	/*if(n != argc-4)@@@*/	/* 0 is prog, 1 is lib, 2 is symbol name, 3 is sig */

	libPath = argv[1];
	symName = argv[2];
	sig = i = argv[3];

	/* Load library and get a pointer to the symbol to call. */
	dlLib = dlLoadLibrary(libPath);
	if(!dlLib) {
		printf("Can't load \"%s\".\n", libPath);
		usage(argv[0]);
		return 1;
	}

	sym = dlFindSymbol(dlLib, symName);
	if(!sym) {
		printf("Can't find symbol \"%s\".\n", symName);
		dlFreeLibrary(dlLib);
		usage(argv[0]);
		return 1;
	}


	vm = dcNewCallVM(4096/*@@@*/);/*@@@ error checking */
	dcReset(vm);

	while(*i != '\0' && *i != DC_SIGCHAR_ENDARG) {
		switch(*i) {
			case DC_SIGCHAR_CC_PREFIX:
				switch(*++i) {
					case DC_SIGCHAR_CC_STDCALL:      dcMode(vm, DC_CALL_C_X86_WIN32_STD);      break;
					case DC_SIGCHAR_CC_FASTCALL_GNU: dcMode(vm, DC_CALL_C_X86_WIN32_FAST_GNU); break;
					case DC_SIGCHAR_CC_FASTCALL_MS:  dcMode(vm, DC_CALL_C_X86_WIN32_FAST_MS);  break;
					case DC_SIGCHAR_CC_THISCALL_MS:  dcMode(vm, DC_CALL_C_X86_WIN32_THIS_MS);  break;
					/* @@@ extend with other modes when they become available */
				} break;

			case DC_SIGCHAR_BOOL:      dcArgBool    (vm, (DCbool)           atoi    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_CHAR:      dcArgChar    (vm, (DCchar)           atoi    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_UCHAR:     dcArgChar    (vm, (DCchar)(DCuchar)  atoi    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_SHORT:     dcArgShort   (vm, (DCshort)          atoi    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_USHORT:    dcArgShort   (vm, (DCshort)(DCushort)atoi    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_INT:       dcArgInt     (vm, (DCint)            strtol  (argv[4+i-sig],NULL,10)); break;
			case DC_SIGCHAR_UINT:      dcArgInt     (vm, (DCint)(DCuint)    strtoul (argv[4+i-sig],NULL,10)); break;
			case DC_SIGCHAR_LONG:      dcArgLong    (vm, (DClong)           strtol  (argv[4+i-sig],NULL,10)); break;
			case DC_SIGCHAR_ULONG:     dcArgLong    (vm, (DCulong)          strtoul (argv[4+i-sig],NULL,10)); break;
			case DC_SIGCHAR_LONGLONG:  dcArgLongLong(vm, (DClonglong)       strtoll (argv[4+i-sig],NULL,10)); break;
			case DC_SIGCHAR_ULONGLONG: dcArgLongLong(vm, (DCulonglong)      strtoull(argv[4+i-sig],NULL,10)); break;
			case DC_SIGCHAR_FLOAT:     dcArgFloat   (vm, (DCfloat)          atof    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_DOUBLE:    dcArgDouble  (vm, (DCdouble)         atof    (argv[4+i-sig]        )); break;
			case DC_SIGCHAR_POINTER:   dcArgPointer (vm, (DCpointer)                 argv[4+i-sig]         ); break;
			case DC_SIGCHAR_STRING:    dcArgPointer (vm, (DCpointer)                 argv[4+i-sig]         ); break;
		}
		++i;
	}

	if(*i == DC_SIGCHAR_ENDARG)
		++i;

	switch(*i) {
		case '\0':
		case DC_SIGCHAR_VOID:                       dcCallVoid    (vm,sym) ; break;
		case DC_SIGCHAR_BOOL:      printf("%d\n",   dcCallBool    (vm,sym)); break;
		case DC_SIGCHAR_CHAR:      printf("%d\n",   dcCallChar    (vm,sym)); break;
		case DC_SIGCHAR_UCHAR:     printf("%d\n",   dcCallChar    (vm,sym)); break;
		case DC_SIGCHAR_SHORT:     printf("%d\n",   dcCallShort   (vm,sym)); break;
		case DC_SIGCHAR_USHORT:    printf("%d\n",   dcCallShort   (vm,sym)); break;
		case DC_SIGCHAR_INT:       printf("%d\n",   dcCallInt     (vm,sym)); break;
		case DC_SIGCHAR_UINT:      printf("%d\n",   dcCallInt     (vm,sym)); break;
		case DC_SIGCHAR_LONG:      printf("%d\n",   dcCallLong    (vm,sym)); break;
		case DC_SIGCHAR_ULONG:     printf("%d\n",   dcCallLong    (vm,sym)); break;
		case DC_SIGCHAR_LONGLONG:  printf("%lld\n", dcCallLongLong(vm,sym)); break;
		case DC_SIGCHAR_ULONGLONG: printf("%lld\n", dcCallLongLong(vm,sym)); break;
		case DC_SIGCHAR_FLOAT:     printf("%g\n",   dcCallFloat   (vm,sym)); break;
		case DC_SIGCHAR_DOUBLE:    printf("%g\n",   dcCallDouble  (vm,sym)); break;
		case DC_SIGCHAR_POINTER:   printf("%x\n",   dcCallPointer (vm,sym)); break;
		case DC_SIGCHAR_STRING:    printf(          dcCallPointer (vm,sym)); break;
	}

	dlFreeLibrary(dlLib);
	dcFree(vm);
}

