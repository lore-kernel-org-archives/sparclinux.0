From: David Miller <davem@davemloft.net>
Date: Thu, 04 Mar 2010 07:53:15 +0000
Subject: [PATCH] Fix NMI openfirmware bug.
Message-Id: <20100303.235315.211254866.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This fixes the bootup hangs Josip Rodin was seeing, I'll push it
to -stable too.

sparc64: Make prom entry spinlock NMI safe.

If we do something like try to print to the OF console from an NMI
while we're already in OpenFirmware, we'll deadlock on the spinlock.

Use a raw spinlock and disable NMIs when we take it.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/prom/p1275.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 4b7c937..2d8b70d 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -32,10 +32,9 @@ extern void prom_cif_interface(void);
 extern void prom_cif_callback(void);
 
 /*
- * This provides SMP safety on the p1275buf. prom_callback() drops this lock
- * to allow recursuve acquisition.
+ * This provides SMP safety on the p1275buf.
  */
-DEFINE_SPINLOCK(prom_entry_lock);
+DEFINE_RAW_SPINLOCK(prom_entry_lock);
 
 long p1275_cmd(const char *service, long fmt, ...)
 {
@@ -47,7 +46,9 @@ long p1275_cmd(const char *service, long fmt, ...)
 	
 	p = p1275buf.prom_buffer;
 
-	spin_lock_irqsave(&prom_entry_lock, flags);
+	raw_local_save_flags(flags);
+	raw_local_irq_restore(PIL_NMI);
+	raw_spin_lock(&prom_entry_lock);
 
 	p1275buf.prom_args[0] = (unsigned long)p;		/* service */
 	strcpy (p, service);
@@ -139,7 +140,8 @@ long p1275_cmd(const char *service, long fmt, ...)
 	va_end(list);
 	x = p1275buf.prom_args [nargs + 3];
 
-	spin_unlock_irqrestore(&prom_entry_lock, flags);
+	raw_spin_unlock(&prom_entry_lock);
+	raw_local_irq_restore(flags);
 
 	return x;
 }
-- 
1.6.6.1

