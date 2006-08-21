From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2006 19:22:30 +0000
Subject: Re: compile error in 2.6.18-rc4
Message-Id: <20060821.122230.48523302.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 21 Aug 2006 13:06:52 +0300 (EEST)

> This is the function in question (whitespace-mangled):
> 
> static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
> {
>         unsigned long paddr = pfn << PAGE_SHIFT;
>         unsigned long sz_bits;
> 
>         sz_bits = 0UL;
>         if (_PAGE_SZBITS_4U != 0UL || _PAGE_SZBITS_4V != 0UL) {
>                 __asm__ __volatile__(
>                 "\n661: sethi           %uhi(%1), %0\n"
>                 "       sllx            %0, 32, %0\n"
>                 "       .section        .sun4v_2insn_patch, \"ax\"\n"
>                 "       .word           661b\n"
>                 "       mov             %2, %0\n"
>                 "       nop\n"
>                 "       .previous\n"
>                 : "=r" (sz_bits)
>                 : "i" (_PAGE_SZBITS_4U), "i" (_PAGE_SZBITS_4V));
>         }
>         return __pte(paddr | sz_bits | pgprot_val(prot));
> }
> 
> The message 'operand number missing after %-letter' is strange, I see no
> stray % marks.
> 
> The error seems to come from gcc, even make V=1 mm/fremap.s fails. Gcc
> bug?

It's the "%uhi", it should be "%%uhi" since we want a real "%" there
and not an argument expansion.

I wonder why my gcc eats this just fine and has done so all year...

Oh I see, I think your gcc is one that supports named % arguments
which allows alpha numeric assembler argument names.

Since the character after the % isn't a number, older gcc's just
assume one means a real "%" character and not an argument expansion.

Anyways I'll fix this up.
