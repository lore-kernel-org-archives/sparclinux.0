From: David Miller <davem@davemloft.net>
Date: Fri, 09 May 2014 02:37:55 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140508.223755.1620535696727124186.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok, let's try the following patch as a test, it will kind of let me
know if I'm barking up the wrong tree or not.

This basically turns off the TSB path entirely in the TLB miss handler
for THP mappings.

Let me know if this changes the behavior on your Ultra-I/II machines.

Thanks!

diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index 14158d4..cc3d688 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -45,7 +45,7 @@ tsb_miss_itlb:
 	 */
 tsb_miss_page_table_walk:
 	TRAP_LOAD_TRAP_BLOCK(%g7, %g5)
-
+#if 0
 	/* Before committing to a full page table walk,
 	 * check the huge page TSB.
 	 */
@@ -94,7 +94,7 @@ tsb_miss_page_table_walk:
 80:	stx		%g5, [%g7 + TRAP_PER_CPU_TSB_HUGE_TEMP]
 
 #endif
-
+#endif
 	ldx		[%g7 + TRAP_PER_CPU_PGD_PADDR], %g7
 
 	/* At this point we have:
@@ -135,6 +135,11 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	bne,pt		%xcc, 60f
 	 nop
 
+#if 1
+	ba,pt		%xcc, tsb_tlb_reload
+	 nop
+#endif
+#if 0
 	/* It is a huge page, use huge page TSB entry address we
 	 * calculated above.  If the huge page TSB has not been
 	 * allocated, setup a trap stack and call hugetlb_setup()
@@ -172,6 +177,7 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	 add	%sp, PTREGS_OFF, %o0
 	ba,pt	%xcc, rtrap
 	 nop
+#endif
 
 60:
 #endif
