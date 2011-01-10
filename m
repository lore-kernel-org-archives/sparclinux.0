From: "Fabio M. Di Nitto" <fabbione@fabbione.net>
Date: Mon, 10 Jan 2011 08:58:03 +0000
Subject: [PATCH] debug: allow to retain boot console via boot option keep_bootcon
Message-Id: <1294649883-31614-1-git-send-email-fabbione@fabbione.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On some architectures, the boot process involves de-registering the boot
console (early boot), initialize drivers and then re-register the console.

This mechanism introduces a window in which no printk can happen on the console
and messages are buffered and then printed once the new console is available.

If a kernel crashes during this window, all it's left on the boot console
is "console [foo] enabled, bootconsole disabled" making debug of the crash
rather 'interesting'.

By adding "keep_bootcon" option, do not unregister the boot console, that
will allow to printk everything that is happening up to the crash.

The option is clearly meant only for debugging purposes as it introduces lots
of duplicated info printed on console, but will make bug report from users
easier as it doesn't require a kernel build just to figure out where we crash.

Signed-off-by: Fabio M. Di Nitto <fabbione@fabbione.net>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 kernel/printk.c                     |   16 +++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index f3dc951..56e8fd6 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -865,6 +865,12 @@ and is between 256 and 4096 characters. It is defined in the file
 			       If specified, z/VM IUCV HVC accepts connections
 			       from listed z/VM user IDs only.
 
+	keep_bootcon	[KNL]
+			Do not unregister boot console at start. This is only
+			useful for debugging when something happens in the window
+			between unregistering the boot console and initializing
+			the real console.
+
 	i2c_bus=	[HW] Override the default board specific I2C bus speed
 			     or register an additional I2C bus that is not
 			     registered from board initialization code.
diff --git a/kernel/printk.c b/kernel/printk.c
index 4642a5c..9be7ece 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -1215,6 +1215,18 @@ void console_start(struct console *console)
 }
 EXPORT_SYMBOL(console_start);
 
+static int __read_mostly keep_bootcon = 0;
+
+static int __init  keep_bootcon_setup(char *str)
+{
+	keep_bootcon = 1;
+	printk(KERN_INFO "debug: skip boot console de-registration.\n");
+
+	return 0;
+}
+
+early_param("keep_bootcon", keep_bootcon_setup);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -1362,7 +1374,9 @@ void register_console(struct console *newcon)
 	 * users know there might be something in the kernel's log buffer that
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
-	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) = CON_CONSDEV)) {
+	if (bcon &&
+	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) = CON_CONSDEV) &&
+	    !keep_bootcon) {
 		/* we need to iterate through twice, to make sure we print
 		 * everything out, before we unregister the console(s)
 		 */
-- 
1.7.3.4

