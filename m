From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2006 22:27:38 +0000
Subject: Re: compile error in 2.6.18-rc4
Message-Id: <20060821.152738.102776521.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2006 12:22:30 -0700 (PDT)

> It's the "%uhi", it should be "%%uhi" since we want a real "%" there
> and not an argument expansion.

Meelis, give this patch a spin.

commit 45f3ec4f9d5415d99bd777776c431bce0e1ef383
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Aug 21 15:27:16 2006 -0700

    [SPARC64]: Fix pfn_pte() build failure.
    
    The "%uhi" needs to be "%%uhi" because we want a real
    "%" character in the assembler here, instead of an
    assembler variable expansion.
    
    Aparently older GCCs were more liberal and interpreted
    this %-letter as a literal "%" for whatever reason.
    
    Based upon a build failure report from Meelis Roos.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
index 1ba19eb..ebfe395 100644
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -234,7 +234,7 @@ static inline pte_t pfn_pte(unsigned lon
 	sz_bits = 0UL;
 	if (_PAGE_SZBITS_4U != 0UL || _PAGE_SZBITS_4V != 0UL) {
 		__asm__ __volatile__(
-		"\n661:	sethi		%uhi(%1), %0\n"
+		"\n661:	sethi		%%uhi(%1), %0\n"
 		"	sllx		%0, 32, %0\n"
 		"	.section	.sun4v_2insn_patch, \"ax\"\n"
 		"	.word		661b\n"
