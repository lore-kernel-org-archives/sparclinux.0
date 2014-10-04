From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 20:00:06 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141004.160006.464574565866138892.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 15:12:37 -0400 (EDT)

> From: Bob Picco <bpicco@meloft.net>
> Date: Thu, 2 Oct 2014 10:24:35 -0400
> 
>> At this commit:
>> 59a35b1 sparc64: Use kernel page tables for vmemmap.
> 
> I think I figured out what the bug is.
> 
> It has to do with how KERN_PGTABLE_WALK masks in the sub-pagesize
> bits for huge pages.
> 
> That assembler works fine for PAGE_OFFSET mappings where the
> sub-pagesize bits always have a direct correspondance to the
> physical bits.  But for something like vmemmap that doesn't
> work.
> 
> I'll verify this and work on a fix.

Ok, this should do it, looking forward to see your test results:

diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 93a84ea..ecb49cf 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -134,8 +134,23 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	TSB_STORE(TSB, TAG);
 
 	/* Do a kernel page table walk.  Leaves valid PTE value in
-	 * REG1.  Jumps to FAIL_LABEL on early page table walk termination.
-	 * VADDR will not be clobbered, but REG2 will.
+	 * REG1.  Jumps to FAIL_LABEL on early page table walk
+	 * termination.  VADDR will not be clobbered, but REG2 will.
+	 *
+	 * There are two masks we must apply to propagate bits from
+	 * the virtual address into the PTE physical address field
+	 * when dealing with huge pages.  This is because the page
+	 * table boundaries do not match the huge page size(s) the
+	 * hardware supports.
+	 *
+	 * In these cases we propagate the bits that are below the
+	 * page table level where we saw the huge page mapping, but
+	 * are still within the relevant physical bits for the huge
+	 * page size in question.  So for PMD mappings (which fall on
+	 * bit 23, for 8MB per PMD) we must propagate bit 22 for a
+	 * 4MB huge page.  For huge PUDs (which fall on bit 33, for
+	 * 8GB per PUD), we have to accomodate 256MB and 2GB huge
+	 * pages.  So for those we propagate bits 32 to 28.
 	 */
 #define KERN_PGTABLE_WALK(VADDR, REG1, REG2, FAIL_LABEL)	\
 	sethi		%hi(swapper_pg_dir), REG1; \
@@ -154,8 +169,10 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		REG2, 32, REG2; \
 	andcc		REG1, REG2, %g0; \
+	sethi		%hi(0xf8000000), REG2; \
 	bne,pt		%xcc, 697f; \
-	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
+	 sllx		REG2, 1, REG2; \
+	sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
 	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
@@ -164,9 +181,8 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 sllx		REG2, 32, REG2; \
 	andcc		REG1, REG2, %g0; \
 	be,pn		%xcc, 698f; \
-697:	 sethi		%hi(0xffe00000), REG2; \
-	sllx		REG2, 1, REG2; \
-	brgez,pn	REG1, FAIL_LABEL; \
+	 sethi		%hi(0x400000), REG2; \
+697:	brgez,pn	REG1, FAIL_LABEL; \
 	 andn		REG1, REG2, REG1; \
 	and		VADDR, REG2, REG2; \
 	ba,pt		%xcc, 699f; \
