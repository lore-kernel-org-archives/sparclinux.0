From: David Miller <davem@davemloft.net>
Date: Fri, 18 Feb 2011 22:08:15 +0000
Subject: [PATCH] sparc64: Sharpen address space randomization calculations.
Message-Id: <20110218.140815.260099344.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


A recent patch to the x86 randomization code caused me to take
a quick look at what we do on sparc64, and in doing so I noticed
that we sometimes calculate a non-page-aligned randomization value
and stick it into mmap_base.

I also noticed that since I copied the logic over from PowerPC,
the powerpc code has tweaked the randomization ranges in ways that
would benefit us as well.

For one thing, we should allow up to at least 8MB of randomization
otherwise huge-page regions when HPAGE_SIZE is 4MB never randomize
at all.

And on the 64-bit side we were using up to 4GB.  Tone it down to
1GB as 4GB can result in a lot of address space wastage.

Finally, make sure all computations are unsigned.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sys_sparc_64.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index f836f4e..96082d3 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -360,20 +360,25 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 }
 EXPORT_SYMBOL(get_fb_unmapped_area);
 
-/* Essentially the same as PowerPC... */
-void arch_pick_mmap_layout(struct mm_struct *mm)
+/* Essentially the same as PowerPC.  */
+static unsigned long mmap_rnd(void)
 {
-	unsigned long random_factor = 0UL;
-	unsigned long gap;
+	unsigned long rnd = 0UL;
 
 	if (current->flags & PF_RANDOMIZE) {
-		random_factor = get_random_int();
+		unsigned long val = get_random_int();
 		if (test_thread_flag(TIF_32BIT))
-			random_factor &= ((1 * 1024 * 1024) - 1);
+			rnd = (val % (1UL << (22UL-PAGE_SHIFT)));
 		else
-			random_factor = ((random_factor << PAGE_SHIFT) &
-					 0xffffffffUL);
+			rnd = (val % (1UL << (29UL-PAGE_SHIFT)));
 	}
+	return (rnd << PAGE_SHIFT) * 2;
+}
+
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	unsigned long random_factor = mmap_rnd();
+	unsigned long gap;
 
 	/*
 	 * Fall back to the standard layout if the personality
-- 
1.7.4.1

