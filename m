From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2016 00:53:51 +0000
Subject: [PATCH] sparc: Don't leak context bits into thread->fault_address
Message-Id: <20160727.175351.219584019615190125.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On pre-Niagara systems, we fetch the fault address on data TLB
exceptions from the TLB_TAG_ACCESS register.  But this register also
contains the context ID assosciated with the fault in the low 13 bits
of the register value.

This propagates into current_thread_info()->fault_address and can
cause trouble later on.

So clear the low 13-bits out of the TLB_TAG_ACCESS value in the cases
where it matters.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/dtlb_prot.S |  4 ++--
 arch/sparc/kernel/ktlb.S      | 12 ++++++++++++
 arch/sparc/kernel/tsb.S       | 12 ++++++++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/dtlb_prot.S b/arch/sparc/kernel/dtlb_prot.S
index d668ca14..4087a62 100644
--- a/arch/sparc/kernel/dtlb_prot.S
+++ b/arch/sparc/kernel/dtlb_prot.S
@@ -25,13 +25,13 @@
 
 /* PROT ** ICACHE line 2: More real fault processing */
 	ldxa		[%g4] ASI_DMMU, %g5		! Put tagaccess in %g5
+	srlx		%g5, PAGE_SHIFT, %g5
+	sllx		%g5, PAGE_SHIFT, %g5		! Clear context ID bits
 	bgu,pn		%xcc, winfix_trampoline		! Yes, perform winfixup
 	 mov		FAULT_CODE_DTLB | FAULT_CODE_WRITE, %g4
 	ba,pt		%xcc, sparc64_realfault_common	! Nope, normal fault
 	 nop
 	nop
-	nop
-	nop
 
 /* PROT ** ICACHE line 3: Unused...	*/
 	nop
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index ef0d8e9..f22bec0 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -20,6 +20,10 @@ kvmap_itlb:
 	mov		TLB_TAG_ACCESS, %g4
 	ldxa		[%g4] ASI_IMMU, %g4
 
+	/* The kernel executes in context zero, therefore we do not
+	 * need to clear the context ID bits out of %g4 here.
+	 */
+
 	/* sun4v_itlb_miss branches here with the missing virtual
 	 * address already loaded into %g4
 	 */
@@ -128,6 +132,10 @@ kvmap_dtlb:
 	mov		TLB_TAG_ACCESS, %g4
 	ldxa		[%g4] ASI_DMMU, %g4
 
+	/* The kernel executes in context zero, therefore we do not
+	 * need to clear the context ID bits out of %g4 here.
+	 */
+
 	/* sun4v_dtlb_miss branches here with the missing virtual
 	 * address already loaded into %g4
 	 */
@@ -251,6 +259,10 @@ kvmap_dtlb_longpath:
 	nop
 	.previous
 
+	/* The kernel executes in context zero, therefore we do not
+	 * need to clear the context ID bits out of %g5 here.
+	 */
+
 	be,pt	%xcc, sparc64_realfault_common
 	 mov	FAULT_CODE_DTLB, %g4
 	ba,pt	%xcc, winfix_trampoline
diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index be98685..d568c82 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -29,13 +29,17 @@
 	 */
 tsb_miss_dtlb:
 	mov		TLB_TAG_ACCESS, %g4
+	ldxa		[%g4] ASI_DMMU, %g4
+	srlx		%g4, PAGE_SHIFT, %g4
 	ba,pt		%xcc, tsb_miss_page_table_walk
-	 ldxa		[%g4] ASI_DMMU, %g4
+	 sllx		%g4, PAGE_SHIFT, %g4
 
 tsb_miss_itlb:
 	mov		TLB_TAG_ACCESS, %g4
+	ldxa		[%g4] ASI_IMMU, %g4
+	srlx		%g4, PAGE_SHIFT, %g4
 	ba,pt		%xcc, tsb_miss_page_table_walk
-	 ldxa		[%g4] ASI_IMMU, %g4
+	 sllx		%g4, PAGE_SHIFT, %g4
 
 	/* At this point we have:
 	 * %g1 --	PAGE_SIZE TSB entry address
@@ -284,6 +288,10 @@ tsb_do_dtlb_fault:
 	nop
 	.previous
 
+	/* Clear context ID bits.  */
+	srlx		%g5, PAGE_SHIFT, %g5
+	sllx		%g5, PAGE_SHIFT, %g5
+
 	be,pt	%xcc, sparc64_realfault_common
 	 mov	FAULT_CODE_DTLB, %g4
 	ba,pt	%xcc, winfix_trampoline
-- 
2.1.2.532.g19b5d50

