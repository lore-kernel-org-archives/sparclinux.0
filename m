From: Meelis Roos <mroos@linux.ee>
Date: Mon, 21 Aug 2006 10:06:52 +0000
Subject: Re: compile error in 2.6.18-rc4
Message-Id: <20060821100652.915BE149B5@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>    CC      mm/fremap.o
> mm/fremap.c: In function 'install_page':
> include/asm/pgtable.h:236: error: invalid 'asm': operand number missing after %-letter
> {standard input}: Assembler messages:
> {standard input}:424: Error: Illegal operands

gcc 4.1.2 20060814 (prerelease) (Debian 4.1.1-11)
binutils 2.17 (Debian 2.6.17-2)

This is the function in question (whitespace-mangled):

static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
{
        unsigned long paddr = pfn << PAGE_SHIFT;
        unsigned long sz_bits;

        sz_bits = 0UL;
        if (_PAGE_SZBITS_4U != 0UL || _PAGE_SZBITS_4V != 0UL) {
                __asm__ __volatile__(
                "\n661: sethi           %uhi(%1), %0\n"
                "       sllx            %0, 32, %0\n"
                "       .section        .sun4v_2insn_patch, \"ax\"\n"
                "       .word           661b\n"
                "       mov             %2, %0\n"
                "       nop\n"
                "       .previous\n"
                : "=r" (sz_bits)
                : "i" (_PAGE_SZBITS_4U), "i" (_PAGE_SZBITS_4V));
        }
        return __pte(paddr | sz_bits | pgprot_val(prot));
}

The message 'operand number missing after %-letter' is strange, I see no
stray % marks.

The error seems to come from gcc, even make V=1 mm/fremap.s fails. Gcc
bug?

-- 
Meelis Roos
