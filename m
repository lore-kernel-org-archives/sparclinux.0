From: David Miller <davem@davemloft.net>
Date: Thu, 09 Oct 2014 23:42:27 +0000
Subject: Re: locking warning from p1275_cmd_direct
Message-Id: <20141009.194227.995504858336265268.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410062206320.32206@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410062206320.32206@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 9 Oct 2014 14:06:02 +0300 (EEST)

> Now that My Ultra 5 is stable again, I noticed this new warning during 
> reboot:

Can you give this patch a try?

diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index e58b817..b2340f0 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -9,6 +9,7 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
+#include <linux/irqflags.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -36,8 +37,8 @@ void p1275_cmd_direct(unsigned long *args)
 {
 	unsigned long flags;
 
-	raw_local_save_flags(flags);
-	raw_local_irq_restore((unsigned long)PIL_NMI);
+	local_save_flags(flags);
+	local_irq_restore((unsigned long)PIL_NMI);
 	raw_spin_lock(&prom_entry_lock);
 
 	prom_world(1);
@@ -45,7 +46,7 @@ void p1275_cmd_direct(unsigned long *args)
 	prom_world(0);
 
 	raw_spin_unlock(&prom_entry_lock);
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 void prom_cif_init(void *cif_handler, void *cif_stack)
