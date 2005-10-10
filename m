From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 18:32:15 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <20051010.113215.70490812.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Oct 2005 18:19:29 +0300 (EEST)

> >> Remapping the kernel... done.
> >
> > If you add "-v" to the kernel parameters, does it say anything more?
> 
> Yep, -p gave the oops input, should have tried it myself.

We're not mapping the firmware page tables correctly, or we're
somehow jumping into the firmware when we shouldn't be.

I bet the timer interrupt in the OBP is still firing and that's
why we crash.  We must not, in any way, call into the firmware
between the setup_tba() call and the completion of
inherit_prom_mappings_post() because the firmware page tables
are not active and we'll fault on any access to the firmware's
address space.

Does this fix it?

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 0d2e967..8f21767 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1480,7 +1480,7 @@ pgd_t swapper_pg_dir[2048];
 void __init paging_init(void)
 {
 	unsigned long end_pfn, pages_avail, shift;
-	unsigned long real_end, i;
+	unsigned long real_end, i, flags;
 
 	/* Find available physical memory... */
 	read_obp_memory("available", &pavail[0], &pavail_ents);
@@ -1521,6 +1521,8 @@ void __init paging_init(void)
 	
 	inherit_prom_mappings_pre();
 	
+	local_irq_save(flags);
+
 	/* Ok, we can use our TLB miss and window trap handlers safely.
 	 * We need to do a quick peek here to see if we are on StarFire
 	 * or not, so setup_tba can setup the IRQ globals correctly (it
@@ -1545,6 +1547,8 @@ void __init paging_init(void)
 
 	inherit_prom_mappings_post();
 
+	local_irq_restore(flags);
+
 	inherit_locked_prom_mappings(1);
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
