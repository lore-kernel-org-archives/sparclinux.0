From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 17:16:22 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140917.131622.547550635758465341.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 12:50:39 -0400

> From: bob picco <bpicco@meloft.net>
> 
> For physical address larger than 47 bits the computed physical address
> was insufficient within KERN_TSB_LOOKUP_TL1. This resulted in a vmlinux
> loaded above 47 bits of physical address unable to boot in spectacular
> ways.
> 
> For now we've expanded the physical address range to 52 bits at the cost of
> two instructions. Older sparc64 incur two nop-s.
> 
> The two new instructions from this patch and the former KTSB_PHYS_SHIFT can
> potentially be eliminated using memblock aligning large and constraining
> the physical limit. Essentially use the "sethi" for a physical manipulated
> address and replacing the "or" at patch time with a "sllx". This would leave
> the tsb within head_64.S unused and possibly not a good solution for Cheetah+.
> We'll comtemplate this more in another round.
> 
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

Bob, I think we can do this with a 4 instruction sequence, basically
"sethi, sethi, sllx, or".  The two sethi's give us 22 bits each, and
we again take advantage of the 32K+ alignment of both kernel TSBs.

Can you give this patch below a quick test on your machine that hits
this issue?

Thanks.

==========
[PATCH] sparc64: Adjust KTSB assembler to support larger physical addresses.

As currently coded the KTSB accesses in the kernel only support up to
47 bits of physical addressing.

Adjust the instruction and patching sequence in order to increase it
to 54 bits.

Validate that the KTSB physical address will work with this scheme,
at run time, so that we fail gracefully instead of crapping all
over memory randomly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/tsb.h | 26 ++++++++------------------
 arch/sparc/mm/init_64.c      | 44 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 90916f9..def62ed4 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -246,8 +246,6 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	(KERNEL_TSB_SIZE_BYTES / 16)
 #define KERNEL_TSB4M_NENTRIES	4096
 
-#define KTSB_PHYS_SHIFT		15
-
 	/* Do a kernel TSB lookup at tl>0 on VADDR+TAG, branch to OK_LABEL
 	 * on TSB hit.  REG1, REG2, REG3, and REG4 are used as temporaries
 	 * and the found TTE will be left in REG1.  REG3 and REG4 must
@@ -256,17 +254,13 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 * VADDR and TAG will be preserved and not clobbered by this macro.
 	 */
 #define KERN_TSB_LOOKUP_TL1(VADDR, TAG, REG1, REG2, REG3, REG4, OK_LABEL) \
-661:	sethi		%hi(swapper_tsb), REG1;			\
-	or		REG1, %lo(swapper_tsb), REG1; \
+661:	sethi		%hi(0), REG1; \
+	sethi		%hi(swapper_tsb), REG2; \
 	.section	.swapper_tsb_phys_patch, "ax"; \
 	.word		661b; \
 	.previous; \
-661:	nop; \
-	.section	.tsb_ldquad_phys_patch, "ax"; \
-	.word		661b; \
-	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
-	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
-	.previous; \
+	sllx		REG1, 32, REG1; \
+	or		REG1, REG2, REG1; \
 	srlx		VADDR, PAGE_SHIFT, REG2; \
 	and		REG2, (KERNEL_TSB_NENTRIES - 1), REG2; \
 	sllx		REG2, 4, REG2; \
@@ -281,17 +275,13 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 * we can make use of that for the index computation.
 	 */
 #define KERN_TSB4M_LOOKUP_TL1(TAG, REG1, REG2, REG3, REG4, OK_LABEL) \
-661:	sethi		%hi(swapper_4m_tsb), REG1;	     \
-	or		REG1, %lo(swapper_4m_tsb), REG1; \
+661:	sethi		%hi(0), REG1; \
+	sethi		%hi(swapper_4m_tsb), REG2; \
 	.section	.swapper_4m_tsb_phys_patch, "ax"; \
 	.word		661b; \
 	.previous; \
-661:	nop; \
-	.section	.tsb_ldquad_phys_patch, "ax"; \
-	.word		661b; \
-	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
-	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
-	.previous; \
+	sllx		REG1, 32, REG1; \
+	or		REG1, REG2, REG1; \
 	and		TAG, (KERNEL_TSB4M_NENTRIES - 1), REG2; \
 	sllx		REG2, 4, REG2; \
 	add		REG1, REG2, REG2; \
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c8bccaf..c30a796 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1705,17 +1705,55 @@ static void __init tsb_phys_patch(void)
 static struct hv_tsb_descr ktsb_descr[NUM_KTSB_DESCR];
 extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
 
+/* The swapper TSBs are loaded with a base sequence of:
+ *
+ *	sethi	%hi(0), REG1
+ *	sethi	%hi(SYMBOL), REG2
+ *	sllx	REG1, 32, REG1
+ *	or	REG1, REG2, REG1
+ *
+ * The two KTSBs are both at least 32K aligned, so a single
+ * sethi can load the virtual address.
+ *
+ * When we use physical addressing for the TSB accesses, we patch the
+ * first two instructions in the above sequence.  This scheme supports
+ * up to 54 bits of physical addressing.
+ */
+
 static void patch_one_ktsb_phys(unsigned int *start, unsigned int *end, unsigned long pa)
 {
-	pa >>= KTSB_PHYS_SHIFT;
+	const unsigned long check_mask = 0x003ffffffffffc00UL;
+	unsigned long high_bits, low_bits;
+
+	if (unlikely(pa & ~check_mask)) {
+		prom_printf("Kernel TSB pa[0x%016lx] is out of range.\n", pa);
+		prom_halt();
+	}
+
+	/* We are extracting:
+	 *
+	 * ------------------------------------
+	 * | --- | high bits | low bits | --- |
+	 * ------------------------------------
+	 *  63 54 53       32 31      10 9   0
+	 *
+	 * from the KTSB physical address.
+	 *
+	 * The sethi instruction's 22-bit immediate field starts at bit
+	 * zero, so we are shifting the fields down into that location
+	 * and masking things off.
+	 */
+
+	high_bits = (pa >> 32) & 0x3fffff;
+	low_bits = (pa >> 10) & 0x3fffff;
 
 	while (start < end) {
 		unsigned int *ia = (unsigned int *)(unsigned long)*start;
 
-		ia[0] = (ia[0] & ~0x3fffff) | (pa >> 10);
+		ia[0] = (ia[0] & ~0x3fffff) | high_bits;
 		__asm__ __volatile__("flush	%0" : : "r" (ia));
 
-		ia[1] = (ia[1] & ~0x3ff) | (pa & 0x3ff);
+		ia[1] = (ia[1] & ~0x3fffff) | low_bits;
 		__asm__ __volatile__("flush	%0" : : "r" (ia + 1));
 
 		start++;
-- 
1.8.1.2

