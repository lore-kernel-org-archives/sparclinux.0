From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 13 Mar 2017 16:44:37 +0000
Subject: [PATCH v2 2/4] sparc64: allow platforms to say when to unload boot console
Message-Id: <1489423479-654395-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add a weak function that can be overwritten by platforms that tells whether
it is time to unregister boot console.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 kernel/printk/printk.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2984fb0..88a6d18 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2385,6 +2385,16 @@ static int __init keep_bootcon_setup(char *str)
 early_param("keep_bootcon", keep_bootcon_setup);
 
 /*
+ * Returns true if boot console should be kept, can be overwritten by platforms
+ */
+bool __weak plat_unregister_bootcon(struct console *newcon,
+				    struct console *bcon)
+{
+	return bcon &&
+		(newcon->flags & (CON_CONSDEV | CON_BOOT)) = CON_CONSDEV;
+}
+
+/*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
  * print any messages that were printed by the kernel before the
@@ -2409,6 +2419,7 @@ void register_console(struct console *newcon)
 	unsigned long flags;
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
+	bool unreg_bootcon;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2503,6 +2514,8 @@ void register_console(struct console *newcon)
 	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) = CON_CONSDEV))
 		newcon->flags &= ~CON_PRINTBUFFER;
 
+	unreg_bootcon = plat_unregister_bootcon(newcon, bcon);
+
 	/*
 	 *	Put this console in the list - keep the
 	 *	preferred driver at the head of the list.
@@ -2551,9 +2564,7 @@ void register_console(struct console *newcon)
 	pr_info("%sconsole [%s%d] enabled\n",
 		(newcon->flags & CON_BOOT) ? "boot" : "" ,
 		newcon->name, newcon->index);
-	if (bcon &&
-	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) = CON_CONSDEV) &&
-	    !keep_bootcon) {
+	if (unreg_bootcon && !keep_bootcon) {
 		/* We need to iterate through all boot consoles, to make
 		 * sure we print everything out, before we unregister them.
 		 */
-- 
1.7.1

