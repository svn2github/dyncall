/*
 Package: dyncall
 File: dyncall/dyncall_call_mips_eabi.h
 Description: mips "eabi" abi call kernel C interface
 License:
 
 Copyright (c) 2007-2010 Daniel Adler <dadler@uni-goettingen.de>, 
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

#ifndef DYNCALL_CALL_MIPS_EABI_H
#define DYNCALL_CALL_MIPS_EABI_H

#ifdef __cplusplus
extern "C" {
#endif


struct DCRegData_mips_eabi
{
  DCint   mIntData[8];
  DCfloat mSingleData[8];
};


/* 
** mips32 calling convention calls 
**
** - hybrid return-type call (bool ... pointer)
**
*/

void dcCall_mips_eabi  (DCpointer target, struct DCRegData_mips_eabi*   regdata, DCsize stksize, DCpointer stkdata);

#ifdef __cplusplus
}
#endif


#endif /* DYNCALL_CALL_MIPS_EABI_H */

