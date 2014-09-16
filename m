From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 16:50:39 +0000
Subject: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

For physical address larger than 47 bits the computed physical address
was insufficient within KERN_TSB_LOOKUP_TL1. This resulted in a vmlinux
loaded above 47 bits of physical address unable to boot in spectacular
ways.

For now we've expanded the physical address range to 52 bits at the cost of
two instructions. Older sparc64 incur two nop-s.

The two new instructions from this patch and the former KTSB_PHYS_SHIFT can
potentially be eliminated using memblock aligning large and constraining
the physical limit. Essentially use the "sethi" for a physical manipulated
address and replacing the "or" at patch time with a "sllx". This would leave
the tsb within head_64.S unused and possibly not a good solution for Cheetah+.
We'll comtemplate this more in another round.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/tsb.h    |   33 ++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/vmlinux.lds.S |   10 ++++++++++
 arch/sparc/mm/init_64.c         |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 90916f9..d4e09c5 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -246,7 +246,24 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	(KERNEL_TSB_SIZE_BYTES / 16)
 #define KERNEL_TSB4M_NENTRIES	4096
 
-#define KTSB_PHYS_SHIFT		15
+	/* This is required for more than 47 bits of physical address.
+	 * It is a memory versus instruction count choice. I chose two
+	 * more instructions which is two nops for not participating sparc64.
+	 * Should we increase the swapper_tsb size and/or swapper_4m_tsb size
+	 * then this choice should be reconsidered.
+	 */
+#define KTSB_PHYS_SHIFT		20
+#define	KTSB_PHYS_MASK_LOW_1MB	(~((1UL << KTSB_PHYS_SHIFT) - 1))
+#ifndef	__ASSEMBLY__
+struct tsb_phys_patch_low_1mb_entry {
+	unsigned int	addr;
+	unsigned int	inst[2];
+};
+extern struct tsb_phys_patch_low_1mb_entry
+	__swapper_phys_low_1mb_patch, __swapper_phys_low_1mb_patch_end,
+	__swapper_4m_phys_low_1mb_patch, __swapper_4m_phys_low_1mb_patch_end;
+#endif
+
 
 	/* Do a kernel TSB lookup at tl>0 on VADDR+TAG, branch to OK_LABEL
 	 * on TSB hit.  REG1, REG2, REG3, and REG4 are used as temporaries
@@ -267,6 +284,13 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
 	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
 	.previous; \
+661:	nop; \
+	nop; \
+	.section	.swapper_phys_low_1mb_patch, "ax"; \
+	.word		661b; \
+	sethi		0, REG2; \
+	or		REG2, REG1, REG1; \
+	.previous; \
 	srlx		VADDR, PAGE_SHIFT, REG2; \
 	and		REG2, (KERNEL_TSB_NENTRIES - 1), REG2; \
 	sllx		REG2, 4, REG2; \
@@ -292,6 +316,13 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
 	sllx		REG1, KTSB_PHYS_SHIFT, REG1; \
 	.previous; \
+661:	nop; \
+	nop; \
+	.section	.swapper_4m_phys_low_1mb_patch, "ax"; \
+	.word		661b; \
+	sethi		0, REG2; \
+	or		REG2, REG1, REG1; \
+	.previous; \
 	and		TAG, (KERNEL_TSB4M_NENTRIES - 1), REG2; \
 	sllx		REG2, 4, REG2; \
 	add		REG1, REG2, REG2; \
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 932ff90..2da4f39 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -127,6 +127,16 @@ SECTIONS
 		*(.page_offset_shift_patch)
 		__page_offset_shift_patch_end = .;
 	}
+	.swapper_phys_low_1mb_patch : {
+		__swapper_phys_low_1mb_patch = .;
+		*(.swapper_phys_low_1mb_patch)
+		__swapper_phys_low_1mb_patch_end = .;
+	}
+	.swapper_4m_phys_low_1mb_patch : {
+		__swapper_4m_phys_low_1mb_patch = .;
+		*(.swapper_4m_phys_low_1mb_patch)
+		__swapper_4m_phys_low_1mb_patch_end = .;
+	}
 	.popc_3insn_patch : {
 		__popc_3insn_patch = .;
 		*(.popc_3insn_patch)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 87047fb..1bf4643 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1722,6 +1722,36 @@ static void patch_one_ktsb_phys(unsigned int *start, unsigned int *end, unsigned
 	}
 }
 
+/* We know this patch correctly functions for swapper_tsb and swapper_4m_tsb
+ * because of their respective data alignment. That is bits [31:10] are within
+ * the alignment. The physical address is shifted right 20 which clips the
+ * low bits within thirty two bits.
+ */
+static void
+patch_one_ktsb_phys_low_1mb(struct tsb_phys_patch_low_1mb_entry *entry,
+			    struct tsb_phys_patch_low_1mb_entry *end,
+			    unsigned long phys)
+{
+	unsigned long phys_low_1mb = phys & ~KTSB_PHYS_MASK_LOW_1MB;
+
+	while (entry < end) {
+		unsigned long addr = entry->addr;
+		unsigned int *inst = (unsigned int *)(unsigned long) addr;
+
+		inst[0] = entry->inst[0] | (phys_low_1mb >> 10);
+		__asm__ __volatile__("flush %0\n\t"
+			: /* no outputs */
+			: "r" (inst));
+
+		inst[1] = entry->inst[1];
+		__asm__ __volatile__("flush %0\n\t"
+			: /* no outputs */
+			: "r" (inst + 1));
+
+		entry++;
+	}
+}
+
 static void ktsb_phys_patch(void)
 {
 	extern unsigned int __swapper_tsb_phys_patch;
@@ -1731,6 +1761,8 @@ static void ktsb_phys_patch(void)
 	ktsb_pa = kern_base + ((unsigned long)&swapper_tsb[0] - KERNBASE);
 	patch_one_ktsb_phys(&__swapper_tsb_phys_patch,
 			    &__swapper_tsb_phys_patch_end, ktsb_pa);
+	patch_one_ktsb_phys_low_1mb(&__swapper_phys_low_1mb_patch,
+				    &__swapper_phys_low_1mb_patch_end, ktsb_pa);
 #ifndef CONFIG_DEBUG_PAGEALLOC
 	{
 	extern unsigned int __swapper_4m_tsb_phys_patch;
@@ -1739,6 +1771,9 @@ static void ktsb_phys_patch(void)
 		   ((unsigned long)&swapper_4m_tsb[0] - KERNBASE));
 	patch_one_ktsb_phys(&__swapper_4m_tsb_phys_patch,
 			    &__swapper_4m_tsb_phys_patch_end, ktsb_pa);
+	patch_one_ktsb_phys_low_1mb(&__swapper_4m_phys_low_1mb_patch,
+				    &__swapper_4m_phys_low_1mb_patch_end,
+				    ktsb_pa);
 	}
 #endif
 }
-- 
1.7.1

