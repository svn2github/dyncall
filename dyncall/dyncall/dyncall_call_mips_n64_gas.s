/*

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

.text
.globl dcCall_mips_n64

dcCall_mips_n64:
	/* $4 target function */
 	/* $5 register data */
	/* $6 stack size */
	/* $7 stack data */
	addiu	$sp,$sp,-32
	sw	$16,16($sp)
	sw	$31,8($sp)
	sw	$fp,0($sp)

	move	$fp,$sp
	
	move	$2, $0
	add	$2, 16
	neg	$2
	and	$sp, $2
	add	$6, 15
	and	$6, $2

	move	$12,$4		/* target function */
	move	$13,$5		/* register data   */
	move    $16,$6		/* stack size      */
	
	sub	$sp,$sp,$16	/* allocate stack frame */
	
	/* copy stack data */

.next:
	beq	$6,$0, .skip
	nop
	addiu	$6,$6, -8

	lw	$2, 0($7)
	sw	$2, 0($sp)
	addiu	$7,$7, 8
	addiu	$sp,$sp, 8
	j	.next
	nop
	
.skip:	

	sub	$sp,$sp,$16

	/* load integer parameter registers */

	lw	$4 , 0($13)
	lw	$5 , 8($13)
	lw	$6 , 16($13)
	lw	$7 ,24($13)
	lw	$8 ,32($13)
	lw	$9 ,40($13)
	lw	$10,48($13)
	lw	$11,56($13)

	/* load single-precise floating pointer parameter registers */

	lwc1	$f12, 64($13)
	lwc1	$f13, 72($13)
	lwc1	$f14, 80($13)
	lwc1	$f15, 88($13)
	lwc1	$f16, 96($13)
	lwc1	$f17,104($13)
	lwc1	$f18,112($13)
	lwc1	$f19,120($13)	

	jal	$12
	nop

	/* add	$sp,$sp,$16  */
	move	$sp,$fp 

	lw	$16,16($sp)
	lw	$31,8($sp)
	lw	$fp,0($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

