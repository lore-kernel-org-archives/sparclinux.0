From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 04 May 2014 07:04:37 +0000
Subject: Re: [PATCH] sparc64: Normalize NMI watchdog logging and behavior.
Message-Id: <20140504070437.GA28025@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140504.012710.2211195166500423039.davem@davemloft.net>
In-Reply-To: <20140504.012710.2211195166500423039.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 04, 2014 at 01:27:10AM -0400, David Miller wrote:
> 
> Bring this code in line with the perf based generic NMI watchdog
> in kernel/watchdog.c (which we should convert over to at some
> point).
> 
> In particular, don't do anything super fancy when the watchdog
> triggers, and specifically don't do a do_exit() which only makes
> things worse.

It is always good when we can use more of the generic functionality.
Should we do something remotely similar for sparc32?

It looks like the sun4m_nmi() function is also used for sun4d + leon,
but I need to look again to make sure.

	Sam

Something like this:

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 8bb3b3f..7c8ad6f 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -308,28 +308,28 @@ static void sun4m_clear_clock_irq(void)
 void sun4m_nmi(struct pt_regs *regs)
 {
 	unsigned long afsr, afar, si;
+	char *reason = "unknown";
 
-	printk(KERN_ERR "Aieee: sun4m NMI received!\n");
 	/* XXX HyperSparc hack XXX */
 	__asm__ __volatile__("mov 0x500, %%g1\n\t"
 			     "lda [%%g1] 0x4, %0\n\t"
 			     "mov 0x600, %%g1\n\t"
 			     "lda [%%g1] 0x4, %1\n\t" :
 			     "=r" (afsr), "=r" (afar));
-	printk(KERN_ERR "afsr=%08lx afar=%08lx\n", afsr, afar);
+
 	si = sbus_readl(&sun4m_irq_global->pending);
 	printk(KERN_ERR "si=%08lx\n", si);
 	if (si & SUN4M_INT_MODULE_ERR)
-		printk(KERN_ERR "Module async error\n");
+		reason = "Module async error";
 	if (si & SUN4M_INT_M2S_WRITE_ERR)
-		printk(KERN_ERR "MBus/SBus async error\n");
+		reason = "MBus/SBus async error";
 	if (si & SUN4M_INT_ECC_ERR)
-		printk(KERN_ERR "ECC memory error\n");
+		reason = "ECC memory error";
 	if (si & SUN4M_INT_VME_ERR)
-		printk(KERN_ERR "VME async error\n");
-	printk(KERN_ERR "you lose buddy boy...\n");
-	show_regs(regs);
-	prom_halt();
+		reason = "VME async error";
+
+	panic("sun4m NMI received (%s), afsr=%08lx afar=%08lx\n",
+	      reason, afsr, afar);
 }
 
 void sun4m_unmask_profile_irq(void)
