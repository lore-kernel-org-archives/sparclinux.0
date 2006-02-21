From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 21 Feb 2006 07:15:15 +0000
Subject: [PATCH]: SILO Niagara/SUN4V support
Message-Id: <20060220.231515.26597106.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This patch against silo-1.4.10 makes SILO work on Niagara/SUN4V:

1) Don't try to access %ver register on Niagara, this will
   trap because it's a hyperprivileged operation on SUN4V.

   We detect SUN4V with an ugly trick, we try to write to
   the PSTATE_AG bit of %pstate.  If it reads back zero, it
   is SUN4V.

   A better way to do this would be to fetch the "compatible"
   property of the OBP root node and check if it is "sun4v"
   but that might not be so easy to do this early.

   To be honest, the necessity of this I-cache flushing code
   itself is suspect.  I bet we can delete the whole thing
   or replace it with a portable loop that does "flush %reg"
   over the area we want the be I-cache synced.

2) Kill all of this code flushing the fixed SUN4U TLB entries.
   We don't load the TLB entries by hand any more so this code
   is just noise and would be wrong on SUN4V in any event.

3) Kill all of the %tick{_cmpr} register poking.

   All this timer code cares about is that it records %tick when
   it starts, and then later make relative measurements using
   that saved value.

   The rest of the code touching %tick{_cmpr} is superfluous.

   Besides you can't write to %tick on SUN4V as that is a
   hyperprivileged operation.

4) Return 'sun4u' from silo_get_architecture() when we detect
   'sun4v', we want to run the same code paths.

   We could add a "sun4v" architecture type but I see no gain
   from that as it would just bloat up all the sun4u tests
   with a new "||" branch.

If someone could at least do some light testing of this on
SUN4U I'd really appreciate this.  Ben, please don't apply this
until you or someone else does at least one SUN4U smoke test.

I've successfully tested this on a T-200 with 16GB of ram.

Thanks.

--- ./first-isofs/crt0.S.~1~	2006-02-20 16:24:38.000000000 -0800
+++ ./first-isofs/crt0.S	2006-02-20 16:28:07.000000000 -0800
@@ -112,6 +112,25 @@ flush_icache:
 	tst	%i4			/* quit unless it's Sun4u */
 	be	0f
 	 nop
+
+	/* Careful, we cannot read the %ver register on sun4v because
+	 * there that register is hyperprivileged and we are executing
+	 * in privileged mode.
+	 *
+	 * This early on it's difficult to portably detect sun4v as
+	 * that requires OBP calls.  So do this super-ugly trick of
+	 * trying to set the PSTATE_AG bit in %pstate which will read
+	 * back as zero on sun4u.
+	 */
+	rdpr	%pstate, %l0
+	or	%l0, 0x1, %l1
+	wrpr	%l1, %pstate
+	rdpr	%pstate, %l1
+	wrpr	%l0, %pstate
+	andcc	%l1, 0x1, %g0
+	be,pn	%xcc, 0f
+	 nop
+
 	rdpr	%ver, %l0
 	srlx	%l0, (32 + 16), %l1
 	cmp	%l1, 0x3e
--- ./second/memory.c.~1~	2006-02-20 16:24:46.000000000 -0800
+++ ./second/memory.c	2006-02-20 19:53:01.000000000 -0800
@@ -21,9 +21,6 @@
 
 #include <silo.h>
 
-#define IMAGE_TLB_ENTRY		61
-#define INITRD_TLB_ENTRY	60
-
 #define INITRD_VIRT_ADDR	0x40c00000
 #define IMAGE_VIRT_ADDR		0x40000000
 
@@ -198,20 +195,6 @@ inline void sun4m_set_direct (unsigned l
 	"sta %0, [%1] 32\n\t" : : "r" (set), "r" (l));
 }
 
-#ifndef TLB_TAG_ACCESS
-#define TLB_TAG_ACCESS 		0x30
-#endif
-
-#ifndef ASI_DMMU
-#define ASI_DMMU 		0x58
-#define ASI_DTLB_DATA_ACCESS	0x5d
-#endif
-
-#ifndef ASI_IMMU
-#define ASI_IMMU		0x50
-#define ASI_ITLB_DATA_ACCESS	0x55
-#endif
-
 unsigned long long initrd_phys;
 
 unsigned long sun4m_initrd_pa;
@@ -300,7 +283,6 @@ static char *sun4u_memory_find (unsigned
 		unsigned long long size;
 	} *p = (struct p1275_mem *)0;
 	unsigned int virt = (is_kernel ? IMAGE_VIRT_ADDR : INITRD_VIRT_ADDR);
-	unsigned int tlb_entry = (is_kernel ? IMAGE_TLB_ENTRY : INITRD_TLB_ENTRY);
 	unsigned long long phys = 0, phys_base;
 
 	p = (struct p1275_mem *)malloc(2048);
@@ -390,7 +372,6 @@ static char *sun4u_memory_find (unsigned
 static void sun4u_memory_release(int is_kernel)
 {
 	unsigned long long virt, len;
-	unsigned int tlb_entry = (is_kernel ? IMAGE_TLB_ENTRY : INITRD_TLB_ENTRY);
 
 	if (is_kernel) {
 		virt = sun4u_image_virt;
@@ -406,32 +387,6 @@ static void sun4u_memory_release(int is_
 
 	prom_unmap(len, virt);
 
-        __asm __volatile("\n\
-            rdpr %%pil, %%g1\n\
-            wrpr 15, %%pil\n\
-            stxa %%g0, [%0] %1\n\
-            membar #Sync\n\
-            stxa %%g0, [%2] %3\n\
-            membar #Sync\n\
-            wrpr %%g1, %%pil\n\
-        " : : "r" (TLB_TAG_ACCESS), "i" (ASI_DMMU),
-              "r" (tlb_entry << 3),
-              "i" (ASI_DTLB_DATA_ACCESS) : "g1");
-
-	if (is_kernel) {
-	        __asm __volatile("\n\
-        	    rdpr %%pil, %%g1\n\
-	            wrpr 15, %%pil\n\
-        	    stxa %%g0, [%0] %1\n\
-		    membar #Sync\n\
-        	    stxa %%g0, [%2] %3\n\
-	            membar #Sync\n\
-        	    wrpr %%g1, %%pil\n\
-	        " : : "r" (TLB_TAG_ACCESS), "i" (ASI_IMMU),
-        	      "r" (tlb_entry << 3),
-	              "i" (ASI_ITLB_DATA_ACCESS) : "g1");
-	}
-
 	if (is_kernel)
 		sun4u_image_len = 0;
 	else
--- ./second/crt0.S.~1~	2006-02-20 16:24:51.000000000 -0800
+++ ./second/crt0.S	2006-02-20 16:28:12.000000000 -0800
@@ -183,6 +183,25 @@ flush_icache:
 	tst	%i4			/* quit unless it's Sun4u */
 	be	0f
 	 nop
+
+	/* Careful, we cannot read the %ver register on sun4v because
+	 * there that register is hyperprivileged and we are executing
+	 * in privileged mode.
+	 *
+	 * This early on it's difficult to portably detect sun4v as
+	 * that requires OBP calls.  So do this super-ugly trick of
+	 * trying to set the PSTATE_AG bit in %pstate which will read
+	 * back as zero on sun4u.
+	 */
+	rdpr	%pstate, %l0
+	or	%l0, 0x1, %l1
+	wrpr	%l1, %pstate
+	rdpr	%pstate, %l1
+	wrpr	%l0, %pstate
+	andcc	%l1, 0x1, %g0
+	be,pn	%xcc, 0f
+	 nop
+
 	rdpr	%ver, %l0
 	srlx	%l0, (32 + 16), %l1
 	cmp	%l1, 0x3e
--- ./second/timer.c.~1~	2001-08-09 20:50:27.000000000 -0700
+++ ./second/timer.c	2006-02-20 19:58:54.000000000 -0800
@@ -40,8 +40,6 @@ static volatile struct sun4m_timer_regs 
 static volatile struct sun4c_timer_info *sun4c_timer;
 static unsigned char *addr_to_free = 0;
 static int len_to_free;
-static unsigned long long sun4u_tickcmpr;
-static int sun4u_notimer = 0;
 static struct mostek48t02 *mregs;
 static long clock_frequency;
 
@@ -156,16 +154,6 @@ static inline int sun4u_init_timer ()
     }
     if (!foundcpu || !clock_frequency)
         clock_frequency = prom_getint(prom_root_node, "clock-frequency") / 100;
-    if (notimer) {
-        sun4u_notimer = 1;
-        __asm__ __volatile__ ("\t"
-        	"rd	%%tick_cmpr, %%g1\n\t"
-        	"stx	%%g1, [%0]\n\t"
-        	"mov	1, %%g1\n\t"
-        	"sllx    %%g1, 63, %%g1\n\t"
-        	"wr      %%g1, 0, %%tick_cmpr"
-        	: : "r" (&sun4u_tickcmpr) : "g1");
-    }
     return 0;
 }
 
@@ -206,13 +194,6 @@ int init_timer ()
 
 void close_timer ()
 {
-    if (sun4u_notimer) {
-        __asm__ __volatile__("\t"
-        	"ldx	[%0], %%g1\n\t"
-        	"wrpr	%%g0, 0, %%tick\n\t"
-        	"wr	%%g1, 0, %%tick_cmpr"
-        	: : "r" (&sun4u_tickcmpr) : "g1");
-    }
     if (addr_to_free) {
         if (addr_to_free = (unsigned char *)0xffffffff)
             sun4c_unmapio (TICKER_VIRTUAL);
--- ./second/misc.c.~1~	2006-01-01 18:08:13.000000000 -0800
+++ ./second/misc.c	2006-02-20 20:13:45.000000000 -0800
@@ -518,6 +518,7 @@ enum arch silo_get_architecture(void)
     case 'e':
 	return sun4e;
     case 'u':
+    case 'v':
 	return sun4u;
     default:
     	for(i = 0; i < NUM_SUN_MACHINES; i++)
