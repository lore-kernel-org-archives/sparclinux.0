From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 05 Dec 2004 04:12:11 +0000
Subject: [PATCH]: Fix for sparc64 SMP boot failures
Message-Id: <20041204201211.33b4b0f9.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Sat__4_Dec_2004_20_12_11_-0800_hK8XTa1nTIZAYPpb"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__4_Dec_2004_20_12_11_-0800_hK8XTa1nTIZAYPpb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


This bug has been around for quite some time, is present
in both 2.4.x and 2.6.x, and only triggers sporadically.

It depends upon the size of the kernel image and how the
BSS section is layed out.  Specifically both of the following
conditions must hold to hit the bug:

1) The kernel must be > 4MB in size.  You can check this via
   looking at System.map for the kernel image and checking
   if the final symbol "_end" is at an address >= 0x800000

2) The object "p1275buf" must cross a PAGE_SIZE (8K) boundary.

If this is true, secondary cpus will not boot up and instead
will hang in the kernel TLB miss handler.

The attached patches for 2.4.x and 2.6.x fix the problem and I'll
be pushing these upstream right after this email goes out.


--Multipart=_Sat__4_Dec_2004_20_12_11_-0800_hK8XTa1nTIZAYPpb
Content-Type: text/plain;
 name="sparc64_smp_24.diff"
Content-Disposition: attachment;
 filename="sparc64_smp_24.diff"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/03 20:43:03-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix SMP cpu bringup bug when bigkernel.
#   
#   We have to load the bigkernel second TLB entry on
#   secondary processors before we move over the use
#   the kernel trap table.  Otherwise we can take a
#   TLB miss somewhere in the post-4MB area and the
#   TLB handler is not prepared to service that.
#   
#   The case that usually occurs is the prom_set_trap_table
#   call made by trampoline.S, since p1275buf usually sits
#   very near the end of the kernel image.  It worked by
#   luck most of the time as long as p1275buf sits within
#   a single page since earlier code running in trampoline.S
#   forced that TLB entry to be loaded by the OBP TLB miss
#   handler.
#   
#   This was not fun to figure out.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# arch/sparc64/kernel/trampoline.S
#   2004/12/03 20:39:23-08:00 davem@nuts.davemloft.net +84 -1
#   [SPARC64]: Fix SMP cpu bringup bug when bigkernel.
# 
# arch/sparc64/kernel/smp.c
#   2004/12/03 20:39:23-08:00 davem@nuts.davemloft.net +0 -9
#   [SPARC64]: Fix SMP cpu bringup bug when bigkernel.
# 
diff -Nru a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
--- a/arch/sparc64/kernel/smp.c	2004-12-03 20:45:30 -08:00
+++ b/arch/sparc64/kernel/smp.c	2004-12-03 20:45:30 -08:00
@@ -137,15 +137,6 @@
 void __init smp_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
-	extern int bigkernel;
-	extern unsigned long kern_locked_tte_data;
-
-	if (bigkernel) {
-		prom_dtlb_load(sparc64_highest_locked_tlbent()-1, 
-			kern_locked_tte_data + 0x400000, KERNBASE + 0x400000);
-		prom_itlb_load(sparc64_highest_locked_tlbent()-1, 
-			kern_locked_tte_data + 0x400000, KERNBASE + 0x400000);
-	}
 
 	inherit_locked_prom_mappings(0);
 
diff -Nru a/arch/sparc64/kernel/trampoline.S b/arch/sparc64/kernel/trampoline.S
--- a/arch/sparc64/kernel/trampoline.S	2004-12-03 20:45:30 -08:00
+++ b/arch/sparc64/kernel/trampoline.S	2004-12-03 20:45:30 -08:00
@@ -90,7 +90,9 @@
 	sllx		%g2, 32, %g2
 	wr		%g2, 0, %tick_cmpr
 
-	/* Call OBP by hand to lock KERNBASE into i/d tlbs. */
+	/* Call OBP by hand to lock KERNBASE into i/d tlbs.
+	 * We lock 2 consequetive entries if we are 'bigkernel'.
+	 */
 	mov		%o0, %l0
 
 	sethi		%hi(prom_entry_lock), %g2
@@ -136,6 +138,46 @@
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
 
+	sethi		%hi(bigkernel), %g2
+	lduw		[%g2 + %lo(bigkernel)], %g2
+	cmp		%g2, 0
+	be,pt		%icc, do_dtlb
+	 nop
+
+	sethi		%hi(call_method), %g2
+	or		%g2, %lo(call_method), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x00]
+	mov		5, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x08]
+	mov		1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x10]
+	sethi		%hi(itlb_load), %g2
+	or		%g2, %lo(itlb_load), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x18]
+	sethi		%hi(mmu_ihandle_cache), %g2
+	lduw		[%g2 + %lo(mmu_ihandle_cache)], %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x20]
+	sethi		%hi(KERNBASE + 0x400000), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x28]
+	sethi		%hi(kern_locked_tte_data), %g2
+	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
+	sethi		%hi(0x400000), %g1
+	add		%g2, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x30]
+
+	mov		14, %g2
+	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
+
+	mov		62, %g2
+1:
+	stx		%g2, [%sp + 2047 + 128 + 0x38]
+	sethi		%hi(p1275buf), %g2
+	or		%g2, %lo(p1275buf), %g2
+	ldx		[%g2 + 0x08], %o1
+	call		%o1
+	 add		%sp, (2047 + 128), %o0
+
+do_dtlb:
 	sethi		%hi(call_method), %g2
 	or		%g2, %lo(call_method), %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x00]
@@ -168,6 +210,47 @@
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
 
+	sethi		%hi(bigkernel), %g2
+	lduw		[%g2 + %lo(bigkernel)], %g2
+	cmp		%g2, 0
+	be,pt		%icc, do_unlock
+	 nop
+
+	sethi		%hi(call_method), %g2
+	or		%g2, %lo(call_method), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x00]
+	mov		5, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x08]
+	mov		1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x10]
+	sethi		%hi(dtlb_load), %g2
+	or		%g2, %lo(dtlb_load), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x18]
+	sethi		%hi(mmu_ihandle_cache), %g2
+	lduw		[%g2 + %lo(mmu_ihandle_cache)], %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x20]
+	sethi		%hi(KERNBASE + 0x400000), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x28]
+	sethi		%hi(kern_locked_tte_data), %g2
+	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
+	sethi		%hi(0x400000), %g1
+	add		%g2, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x30]
+
+	mov		14, %g2
+	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
+
+	mov		62, %g2
+1:
+
+	stx		%g2, [%sp + 2047 + 128 + 0x38]
+	sethi		%hi(p1275buf), %g2
+	or		%g2, %lo(p1275buf), %g2
+	ldx		[%g2 + 0x08], %o1
+	call		%o1
+	 add		%sp, (2047 + 128), %o0
+
+do_unlock:
 	sethi		%hi(prom_entry_lock), %g2
 	stb		%g0, [%g2 + %lo(prom_entry_lock)]
 	membar		#StoreStore | #StoreLoad

--Multipart=_Sat__4_Dec_2004_20_12_11_-0800_hK8XTa1nTIZAYPpb
Content-Type: text/plain;
 name="sparc64_smp_26.diff"
Content-Disposition: attachment;
 filename="sparc64_smp_26.diff"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/04 19:34:20-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix SMP cpu bringup bug when bigkernel.
#   
#   We have to load the bigkernel second TLB entry on
#   secondary processors before we move over the use
#   the kernel trap table.  Otherwise we can take a
#   TLB miss somewhere in the post-4MB area and the
#   TLB handler is not prepared to service that.
#   
#   The case that usually occurs is the prom_set_trap_table
#   call made by trampoline.S, since p1275buf usually sits
#   very near the end of the kernel image.  It worked by
#   luck most of the time as long as p1275buf sits within
#   a single page since earlier code running in trampoline.S
#   forced that TLB entry to be loaded by the OBP TLB miss
#   handler.
#   
#   This was not fun to figure out.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# arch/sparc64/kernel/trampoline.S
#   2004/12/04 19:33:42-08:00 davem@nuts.davemloft.net +84 -1
#   [SPARC64]: Fix SMP cpu bringup bug when bigkernel.
# 
# arch/sparc64/kernel/smp.c
#   2004/12/04 19:33:42-08:00 davem@nuts.davemloft.net +0 -9
#   [SPARC64]: Fix SMP cpu bringup bug when bigkernel.
# 
diff -Nru a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
--- a/arch/sparc64/kernel/smp.c	2004-12-04 19:41:44 -08:00
+++ b/arch/sparc64/kernel/smp.c	2004-12-04 19:41:44 -08:00
@@ -103,15 +103,6 @@
 void __init smp_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
-	extern int bigkernel;
-	extern unsigned long kern_locked_tte_data;
-
-	if (bigkernel) {
-		prom_dtlb_load(sparc64_highest_locked_tlbent()-1, 
-			kern_locked_tte_data + 0x400000, KERNBASE + 0x400000);
-		prom_itlb_load(sparc64_highest_locked_tlbent()-1, 
-			kern_locked_tte_data + 0x400000, KERNBASE + 0x400000);
-	}
 
 	inherit_locked_prom_mappings(0);
 
diff -Nru a/arch/sparc64/kernel/trampoline.S b/arch/sparc64/kernel/trampoline.S
--- a/arch/sparc64/kernel/trampoline.S	2004-12-04 19:41:44 -08:00
+++ b/arch/sparc64/kernel/trampoline.S	2004-12-04 19:41:44 -08:00
@@ -90,7 +90,9 @@
 	sllx		%g2, 32, %g2
 	wr		%g2, 0, %tick_cmpr
 
-	/* Call OBP by hand to lock KERNBASE into i/d tlbs. */
+	/* Call OBP by hand to lock KERNBASE into i/d tlbs.
+	 * We lock 2 consequetive entries if we are 'bigkernel'.
+	 */
 	mov		%o0, %l0
 
 	sethi		%hi(prom_entry_lock), %g2
@@ -136,6 +138,46 @@
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
 
+	sethi		%hi(bigkernel), %g2
+	lduw		[%g2 + %lo(bigkernel)], %g2
+	cmp		%g2, 0
+	be,pt		%icc, do_dtlb
+	 nop
+
+	sethi		%hi(call_method), %g2
+	or		%g2, %lo(call_method), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x00]
+	mov		5, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x08]
+	mov		1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x10]
+	sethi		%hi(itlb_load), %g2
+	or		%g2, %lo(itlb_load), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x18]
+	sethi		%hi(mmu_ihandle_cache), %g2
+	lduw		[%g2 + %lo(mmu_ihandle_cache)], %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x20]
+	sethi		%hi(KERNBASE + 0x400000), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x28]
+	sethi		%hi(kern_locked_tte_data), %g2
+	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
+	sethi		%hi(0x400000), %g1
+	add		%g2, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x30]
+
+	mov		14, %g2
+	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
+
+	mov		62, %g2
+1:
+	stx		%g2, [%sp + 2047 + 128 + 0x38]
+	sethi		%hi(p1275buf), %g2
+	or		%g2, %lo(p1275buf), %g2
+	ldx		[%g2 + 0x08], %o1
+	call		%o1
+	 add		%sp, (2047 + 128), %o0
+
+do_dtlb:
 	sethi		%hi(call_method), %g2
 	or		%g2, %lo(call_method), %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x00]
@@ -168,6 +210,47 @@
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
 
+	sethi		%hi(bigkernel), %g2
+	lduw		[%g2 + %lo(bigkernel)], %g2
+	cmp		%g2, 0
+	be,pt		%icc, do_unlock
+	 nop
+
+	sethi		%hi(call_method), %g2
+	or		%g2, %lo(call_method), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x00]
+	mov		5, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x08]
+	mov		1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x10]
+	sethi		%hi(dtlb_load), %g2
+	or		%g2, %lo(dtlb_load), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x18]
+	sethi		%hi(mmu_ihandle_cache), %g2
+	lduw		[%g2 + %lo(mmu_ihandle_cache)], %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x20]
+	sethi		%hi(KERNBASE + 0x400000), %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x28]
+	sethi		%hi(kern_locked_tte_data), %g2
+	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
+	sethi		%hi(0x400000), %g1
+	add		%g2, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x30]
+
+	mov		14, %g2
+	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
+
+	mov		62, %g2
+1:
+
+	stx		%g2, [%sp + 2047 + 128 + 0x38]
+	sethi		%hi(p1275buf), %g2
+	or		%g2, %lo(p1275buf), %g2
+	ldx		[%g2 + 0x08], %o1
+	call		%o1
+	 add		%sp, (2047 + 128), %o0
+
+do_unlock:
 	sethi		%hi(prom_entry_lock), %g2
 	stb		%g0, [%g2 + %lo(prom_entry_lock)]
 	membar		#StoreStore | #StoreLoad

--Multipart=_Sat__4_Dec_2004_20_12_11_-0800_hK8XTa1nTIZAYPpb--
