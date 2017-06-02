From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 02 Jun 2017 21:51:12 +0000
Subject: [PATCH] sparc64: mm: fix copy_tsb to correctly copy huge page TSBs
Message-Id: <1496440272-19057-1-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Bob Picco <bob.picco@oracle.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, David Miller <davem@davemloft.net>, Mike Kravetz <mike.kravetz@oracle.com>

When a TSB grows beyond its current capacity, a new TSB is allocated
and copy_tsb is called to copy entries from the old TSB to the new.
A hash shift based on page size is used to calculate the index of an
entry in the TSB.  copy_tsb has hard coded PAGE_SHIFT in these
calculations.  However, for huge page TSBs the value REAL_HPAGE_SHIFT
should be used.  As a result, when copy_tsb is called for a huge page
TSB the entries are placed at the incorrect index in the newly
allocated TSB.  When doing hardware table walk, the MMU does not
match these entries and we end up in the TSB miss handling code.
This code will then create and write an entry to the correct index
in the TSB.  We take a performance hit for the table walk miss and
recreation of these entries.

Pass a new parameter to copy_tsb that is the page size shift to be
used when copying the TSB.

Suggested-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/sparc/kernel/tsb.S | 11 +++++++----
 arch/sparc/mm/tsb.c     |  7 +++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index 10689cf..07c0df9 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -455,13 +455,16 @@ __tsb_context_switch:
 	.type	copy_tsb,#function
 copy_tsb:		/* %o0=old_tsb_base, %o1=old_tsb_size
 			 * %o2=new_tsb_base, %o3=new_tsb_size
+			 * %o4=page_size_shift
 			 */
 	sethi		%uhi(TSB_PASS_BITS), %g7
 	srlx		%o3, 4, %o3
-	add		%o0, %o1, %g1	/* end of old tsb */
+	add		%o0, %o1, %o1	/* end of old tsb */
 	sllx		%g7, 32, %g7
 	sub		%o3, 1, %o3	/* %o3 = new tsb hash mask */
 
+	mov		%o4, %g1	/* page_size_shift */
+
 661:	prefetcha	[%o0] ASI_N, #one_read
 	.section	.tsb_phys_patch, "ax"
 	.word		661b
@@ -486,9 +489,9 @@ copy_tsb:		/* %o0=old_tsb_base, %o1=old_tsb_size
 	/* This can definitely be computed faster... */
 	srlx		%o0, 4, %o5	/* Build index */
 	and		%o5, 511, %o5	/* Mask index */
-	sllx		%o5, PAGE_SHIFT, %o5 /* Put into vaddr position */
+	sllx		%o5, %g1, %o5	/* Put into vaddr position */
 	or		%o4, %o5, %o4	/* Full VADDR. */
-	srlx		%o4, PAGE_SHIFT, %o4 /* Shift down to create index */
+	srlx		%o4, %g1, %o4	/* Shift down to create index */
 	and		%o4, %o3, %o4	/* Mask with new_tsb_nents-1 */
 	sllx		%o4, 4, %o4	/* Shift back up into tsb ent offset */
 	TSB_STORE(%o2 + %o4, %g2)	/* Store TAG */
@@ -496,7 +499,7 @@ copy_tsb:		/* %o0=old_tsb_base, %o1=old_tsb_size
 	TSB_STORE(%o2 + %o4, %g3)	/* Store TTE */
 
 80:	add		%o0, 16, %o0
-	cmp		%o0, %g1
+	cmp		%o0, %o1
 	bne,pt		%xcc, 90b
 	 nop
 
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 0a04811..8d802a2 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -496,7 +496,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 		extern void copy_tsb(unsigned long old_tsb_base,
 				     unsigned long old_tsb_size,
 				     unsigned long new_tsb_base,
-				     unsigned long new_tsb_size);
+				     unsigned long new_tsb_size,
+				     unsigned long page_size_shift);
 		unsigned long old_tsb_base = (unsigned long) old_tsb;
 		unsigned long new_tsb_base = (unsigned long) new_tsb;
 
@@ -504,7 +505,9 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 			old_tsb_base = __pa(old_tsb_base);
 			new_tsb_base = __pa(new_tsb_base);
 		}
-		copy_tsb(old_tsb_base, old_size, new_tsb_base, new_size);
+		copy_tsb(old_tsb_base, old_size, new_tsb_base, new_size,
+			tsb_index = MM_TSB_BASE ?
+			PAGE_SHIFT : REAL_HPAGE_SHIFT);
 	}
 
 	mm->context.tsb_block[tsb_index].tsb = new_tsb;
-- 
2.7.4

