From: Mathieu Chouquet-Stringer <mchouque@online.fr>
Date: Wed, 12 May 2004 19:59:13 +0000
Subject: Re: Another gcc 3.4 fix
Message-Id: <20040512195913.GA15908@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512052744.GA31207@localhost>
In-Reply-To: <20040512052744.GA31207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 12, 2004 at 12:50:11PM -0700, David S. Miller wrote:
> Please send the full output gcc-3.4 gives for kernel_unaligned_trap().
> There is no way it can delete that whole asm statement that has
> the kernel_unaligned_trap_fault definition, the asm is marked
> volatile afterall.

I hope I cut at the right places:

	.section	".text"
	.align 4
	.align 32
	.global kernel_unaligned_trap
	.type	kernel_unaligned_trap, #function
	.proc	020
kernel_unaligned_trap:
	.register	%g7, #scratch
	!#PROLOGUE# 0
	save	%sp, -208, %sp
	!#PROLOGUE# 1
	srl	%i1, 21, %g1
	mov	0, %l2
	and	%g1, 1, %g1
	brz,pt	%g1, .LL69
	srl	%i1, 19, %g5
	and	%g5, 15, %g1
	mov	2, %l2
	cmp	%g1, 15
	movne	%icc, 1, %l2
.LL69:
	and	%g5, 15, %g2
	xor	%g2, 11, %g1
	xor	%g2, 14, %g2
	subcc	%g0, %g1, %g0
	subx	%g0, -1, %g3
	subcc	%g0, %g2, %g0
	subx	%g0, -1, %g1
	orcc	%g3, %g1, %g0
	bne,pt	%icc, .LL75
	mov	8, %l4
	andcc	%g5, 3, %g2
	bne,pt	%icc, .LL113
	mov	4, %l4
.LL75:
	srl	%i1, 24, %g1
	andcc	%g1, 1, %g0
	bne,pn	%xcc, .LL83
	mov	%l4, %l0
	cmp	%l2, 2
	bne,pn	%icc, .LL82
	srl	%i1, 25, %g1
.LL83:
	ldx	[%i0+136], %o1
	sethi	%hi(.LLC8), %o0
	call	printk, 0
	or	%o0, %lo(.LLC8), %o0
	sethi	%hi(.LLC9), %o0
	mov	%i0, %o1
	call	die_if_kernel, 0
	or	%o0, %lo(.LLC9), %o0
.LL113:
	cmp	%g2, 3
	be,pn	%icc, .LL75
	mov	16, %l4
	cmp	%g2, 2
	be,pt	%icc, .LL75
	mov	2, %l4
	srl	%i1, 0, %o1
	sethi	%hi(.LLC6), %o0
	call	printk, 0
	or	%o0, %lo(.LLC6), %o0
	sethi	%hi(.LLC7), %o0
	ldx	[%g6+40], %o1
	call	die_if_kernel, 0
	or	%o0, %lo(.LLC7), %o0
.LL82:
	mov	%i0, %o0
	srl	%i1, 0, %o1
	and	%g1, 31, %l1
	srl	%l1, 0, %l3
	call	compute_effective_address, 0
	mov	%l3, %o2
	cmp	%l2, 0
	be,pn	%icc, .LL89
	mov	%o0, %l5
	cmp	%l2, 1
	bne,pn	%icc, .LL114
	cmp	%l0, 16
	stx	%g0, [%fp+2023]
	be,pn	%icc, .LL115
	add	%fp, 2023, %l4
	cmp	%l1, 0
	bne,a,pn %icc, .LL116
	mov	%l3, %o0
.LL100:
	srl	%i1, 23, %g1
	andcc	%g1, 1, %g0
	be,pt	%xcc, .LL104
	mov	128, %g3
	srl	%i1, 5, %g1
	srl	%i1, 13, %g2
	andcc	%g2, 1, %g0
	be,pt	%xcc, .LL104
	and	%g1, 0xff, %g3
	ldub	[%i0+132], %g3
.LL104:
	wr	%g3, 0, %asi
	ldx	[%l4], %l1
cmp	%l0, 2
	be,pn	%icc, 2f
	 cmp	%l0, 4
	be,pt	%icc, 1f
	 srlx	%l1, 24, %l2
	srlx	%l1, 56, %g1
	srlx	%l1, 48, %g7
4:	stba	%g1, [%l5] %asi
	srlx	%l1, 40, %g1
5:	stba	%g7, [%l5 + 1] %asi
	srlx	%l1, 32, %g7
6:	stba	%g1, [%l5 + 2] %asi
7:	stba	%g7, [%l5 + 3] %asi
	srlx	%l1, 16, %g1
8:	stba	%l2, [%l5 + 4] %asi
	srlx	%l1, 8, %g7
9:	stba	%g1, [%l5 + 5] %asi
10:	stba	%g7, [%l5 + 6] %asi
	ba,pt	%xcc, 0f
11:	 stba	%l1, [%l5 + 7] %asi
1:	srl	%l1, 16, %g7
12:	stba	%l2, [%l5] %asi
	srl	%l1, 8, %l2
13:	stba	%g7, [%l5 + 1] %asi
14:	stba	%l2, [%l5 + 2] %asi
	ba,pt	%xcc, 0f
15:	 stba	%l1, [%l5 + 3] %asi
2:	srl	%l1, 8, %l2
16:	stba	%l2, [%l5] %asi
17:	stba	%l1, [%l5 + 1] %asi
0:
	wr	%g0, 17, %asi

	.section __ex_table
	.word	4b, kernel_unaligned_trap_fault
	.word	5b, kernel_unaligned_trap_fault
	.word	6b, kernel_unaligned_trap_fault
	.word	7b, kernel_unaligned_trap_fault
	.word	8b, kernel_unaligned_trap_fault
	.word	9b, kernel_unaligned_trap_fault
	.word	10b, kernel_unaligned_trap_fault
	.word	11b, kernel_unaligned_trap_fault
	.word	12b, kernel_unaligned_trap_fault
	.word	13b, kernel_unaligned_trap_fault
	.word	14b, kernel_unaligned_trap_fault
	.word	15b, kernel_unaligned_trap_fault
	.word	16b, kernel_unaligned_trap_fault
	.word	17b, kernel_unaligned_trap_fault

	.previous
	
	ldx	[%i0+144], %g3
.LL118:
	stx	%g3, [%i0+136]
	add	%g3, 4, %g2
	stx	%g2, [%i0+144]
	ldx	[%g6+8], %g1
	andcc	%g1, 128, %g0
	be,pt	%xcc, .LL67
	mov	-1, %g1
	srlx	%g1, 32, %g1
	and	%g2, %g1, %g2
	and	%g3, %g1, %g1
	stx	%g2, [%i0+144]
	ba,pt	%xcc, .LL67
	stx	%g1, [%i0+136]
.LL89:
	mov	%l3, %o0
	call	fetch_reg_addr, 0
	mov	%i0, %o1
	srl	%i1, 23, %g2
	sethi	%hi(4194304), %g1
	and	%i1, %g1, %g5
	andcc	%g2, 1, %g0
	be,pt	%xcc, .LL93
	mov	128, %g3
	srl	%i1, 5, %g1
	srl	%i1, 13, %g2
	andcc	%g2, 1, %g0
	be,pt	%xcc, .LL93
	and	%g1, 0xff, %g3
	ldub	[%i0+132], %g3
.LL93:
	wr	%g3, 0, %asi
	cmp	%l4, 8
	bge,pn	%icc, 9f
	 cmp	%l4, 4
	be,pt	%icc, 6f
4:	 lduba	[%l5] %asi, %l1
5:	lduba	[%l5 + 1] %asi, %l2
	sll	%l1, 8, %l1
	brz,pt	%g5, 3f
	 add	%l1, %l2, %l1
	sllx	%l1, 48, %l1
	srax	%l1, 48, %l1
3:	ba,pt	%xcc, 0f
	 stx	%l1, [%o0]
6:	lduba	[%l5 + 1] %asi, %l2
	sll	%l1, 24, %l1
7:	lduba	[%l5 + 2] %asi, %g7
	sll	%l2, 16, %l2
8:	lduba	[%l5 + 3] %asi, %g1
	sll	%g7, 8, %g7
	or	%l1, %l2, %l1
	or	%g7, %g1, %g7
	or	%l1, %g7, %l1
	brnz,a,pt %g5, 3f
	 sra	%l1, 0, %l1
3:	ba,pt	%xcc, 0f
	 stx	%l1, [%o0]
9:	lduba	[%l5] %asi, %l1
10:	lduba	[%l5 + 1] %asi, %l2
	sllx	%l1, 56, %l1
11:	lduba	[%l5 + 2] %asi, %g7
	sllx	%l2, 48, %l2
12:	lduba	[%l5 + 3] %asi, %g1
	sllx	%g7, 40, %g7
	sllx	%g1, 32, %g1
	or	%l1, %l2, %l1
	or	%g7, %g1, %g7
13:	lduba	[%l5 + 4] %asi, %l2
	or	%l1, %g7, %g7
14:	lduba	[%l5 + 5] %asi, %g1
	sllx	%l2, 24, %l2
15:	lduba	[%l5 + 6] %asi, %l1
	sllx	%g1, 16, %g1
	or	%g7, %l2, %g7
16:	lduba	[%l5 + 7] %asi, %l2
	sllx	%l1, 8, %l1
	or	%g7, %g1, %g7
	or	%l1, %l2, %l1
	or	%g7, %l1, %g7
	cmp	%l4, 8
	be,a,pt %icc, 0f
	 stx	%g7, [%o0]
	srlx	%g7, 32, %l1
	sra	%g7, 0, %g7
	stx	%l1, [%o0]
	stx	%g7, [%o0 + 8]
0:
	wr	%g0, 17, %asi

	.section __ex_table
	.word	4b, kernel_unaligned_trap_fault
	.word	5b, kernel_unaligned_trap_fault
	.word	6b, kernel_unaligned_trap_fault
	.word	7b, kernel_unaligned_trap_fault
	.word	8b, kernel_unaligned_trap_fault
	.word	9b, kernel_unaligned_trap_fault
	.word	10b, kernel_unaligned_trap_fault
	.word	11b, kernel_unaligned_trap_fault
	.word	12b, kernel_unaligned_trap_fault
	.word	13b, kernel_unaligned_trap_fault
	.word	14b, kernel_unaligned_trap_fault
	.word	15b, kernel_unaligned_trap_fault
	.word	16b, kernel_unaligned_trap_fault

	.previous
	
	ba,pt	%xcc, .LL118
	ldx	[%i0+144], %g3
.LL116:
	call	fetch_reg_addr, 0
	mov	%i0, %o1
	ba,pt	%xcc, .LL100
	mov	%o0, %l4
.LL115:
	add	%l1, 1, %o0
	mov	%i0, %o1
	and	%o0, 63, %o0
	call	fetch_reg, 0
	mov	8, %l0
	srl	%o0, 0, %l2
	cmp	%l1, 0
	bne,pn	%icc, .LL117
	mov	%l2, %o0
	ba,pt	%xcc, .LL100
	stx	%o0, [%fp+2023]
.LL117:
	mov	%l3, %o0
	call	fetch_reg, 0
	mov	%i0, %o1
	sllx	%o0, 32, %o0
	or	%o0, %l2, %o0
	ba,pt	%xcc, .LL100
	stx	%o0, [%fp+2023]
.LL114:
	sethi	%hi(.LLC10), %o0
	call	panic, 0
	or	%o0, %lo(.LLC10), %o0
.LL67:
	nop
	return	%i7+8
	nop
	.size	kernel_unaligned_trap, .-kernel_unaligned_trap

-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
