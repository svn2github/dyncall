/*
 Package: dyncall
 File: dyncall/dyncall_call_mips_n64_gas.s
 Description: mips "n64" abi call kernel implementation in GNU Assembler
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
	.section .mdebug.abi64
	.previous
	.abicalls
	.text
	.align	2
	.globl	dcCall_mips_n64
	.ent	dcCall_mips_n64
dcCall_mips_n64:

	/* Stack-frame prolog */

	.frame	$fp,64,$31		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	dsubu	$sp,$sp,64
	sd	$31,48($sp)	/* save return address register (ra) */
	sd	$30,40($sp)	/* save frame pointer register (fp) */
	sd	$28,32($sp)	/* save global pointer register (gp) */
	move	$fp,$sp


	/* arguments: */
		
	/* $4 target function */
 	/* $5 register data */
	/* $6 stack size */
	/* $7 stack data */
	

	/* allocate argument stack space */

	dsubu	$sp, $sp, $6
	
	/* copy stack data */

	/* n64 abi call assumptions:
           - stack data is 16-byte aligned.
           - no extra-storage for arguments passed via registers.
        */

	/* $12  source pointer (parameter stack data) */
	/* $14  destination (stack pointer) */
	/* $6   byte count */

	move	$12, $7
	move	$14, $sp

.next:
	beq	$6, $0, .skip
	nop
	daddiu	$6, $6, -8
	ld	$2, 0($12)
	sd	$2, 0($14)
	daddiu	$12,$12, 8
	daddiu	$14,$14, 8
	b	.next
.skip:
	move	$25, $4

	/* load registers */

	/* locals: */
	/* $13 = register data */
	move	$13, $5
	
	/* load integer parameter registers */

	ld	$4 , 0($13)
	ld	$5 , 8($13)
	ld	$6 ,16($13)
	ld	$7 ,24($13)
	ld	$8 ,32($13)
	ld	$9 ,40($13)
	ld	$10,48($13)
	ld	$11,56($13)

	/* load single-precise floating pointer parameter registers */

	l.d	$f12, 64($13)
	l.d	$f13, 72($13)
	l.d	$f14, 80($13)
	l.d	$f15, 88($13)
	l.d	$f16, 96($13)
	l.d	$f17,104($13)
	l.d	$f18,112($13)
	l.d	$f19,120($13)	

	jal	$31, $25

	/* no nop according to gcc assembly output */	

	/* Stack-frame epilog */	
	move	$sp,$fp 
	ld	$31,48($sp)	/* restore ra register */
	ld	$fp,40($sp)	/* restore fp register */
	ld	$28,32($sp)	/* restore gp register */
	daddu	$sp,$sp,64
	j	$31
	.end	dcCall_mips_n64
	.size	dcCall_mips_n64, .-dcCall_mips_n64

