From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 13 Mar 2017 16:44:39 +0000
Subject: [PATCH v2 4/4] sparc64: stop duplicating boot messages
Message-Id: <1489423479-654395-5-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Boot messages are duplicated on console when ttvHV0 is enabled.

The reason for this issue is that on sun4v we have three consoles during
boot:

1 OpenBoot: earlyprom0
2 VT: tty0
3 Hypervisor: ttyHV0

After we enable tty0 we disable earlyprom0 console, but we do not duplicate
the messages that were already printed because tty0 uses a different
output. In fact, until we register ttyHV0 nothing new appears on the
screen, so if we panic during this interval (which is quite long), we do
not have any information about the panic.

The fix is to unregister boot console only when ttyHV is registered, also,
since OpenBoot can modify the output device (using output-device variable),
we must check that the output-device was virtual-console, which uses the
same output method as the hypervisor.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/setup.h |    1 +
 arch/sparc/kernel/setup_64.c   |   62 ++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/sunhv.c     |    2 +-
 3 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 7cf712f..589a7ef 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -62,6 +62,7 @@ static inline int con_is_present(void)
 
 #ifdef CONFIG_SERIAL_SUNHV
 void sunhv_migrate_hvcons_irq(int cpu);
+#define SUNHV_CONSOLE_NAME	"ttyHV"
 #endif
 #endif
 void sun_do_break(void);
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 446abe2..16fb157 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -695,3 +695,65 @@ void sun_do_break(void)
 
 int stop_a_enabled = 1;
 EXPORT_SYMBOL(stop_a_enabled);
+
+#ifdef CONFIG_SERIAL_SUNHV
+
+/*
+ * Unregister boot console (prom_early_console), only when ttyHV console is
+ * registered. But, only if prom_early_console is using "virtual-console"
+ * output device, as that means it is the same device that ttyHV is using.
+ */
+bool plat_unregister_bootcon(struct console *newcon, struct console *bcon)
+{
+	bool unreg = bcon &&
+		(newcon->flags & (CON_CONSDEV | CON_BOOT)) = CON_CONSDEV;
+	static enum {
+		FIRST_TIME = 0, /* first time here */
+		NOT_VC,		/* output device is not 'virtual-console' */
+		VC,		/* output device is 'virtual-console' */
+		HV		/* ttyHV is registered */
+	} virt_con = FIRST_TIME;
+
+	if (tlb_type != hypervisor)
+		return unreg;
+
+	if (&prom_early_console = newcon)
+		return false;
+
+	/*
+	 * read output-device property value from /options, the default value
+	 * is virtual-console, which means send output to ILOM, or the same
+	 * device that hypervisor is using.
+	 */
+	if (virt_con = FIRST_TIME) {
+		char *output_dev_name = NULL;
+		struct device_node *dp;
+		int len;
+
+		virt_con = NOT_VC;
+		dp = of_find_node_by_path("/options");
+		if (dp)
+			output_dev_name = (char *)of_get_property(dp,
+				"output-device", &len);
+
+		if (output_dev_name)
+			if (!strncmp("virtual-console", output_dev_name, len))
+				virt_con = VC;
+	}
+
+	if (virt_con = NOT_VC || virt_con = HV)
+		return unreg;
+
+	if (!strcmp(newcon->name, SUNHV_CONSOLE_NAME)) {
+		virt_con = HV;
+		/*
+		 * We know ttyHV and prom_early_console are using the same
+		 * output device, do not print everything out again
+		 */
+		newcon->flags &= ~CON_PRINTBUFFER;
+		return true;
+	}
+
+	return false;
+}
+#endif
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 46e4689..178b1f3 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -512,7 +512,7 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 }
 
 static struct console sunhv_console = {
-	.name	=	"ttyHV",
+	.name	=	SUNHV_CONSOLE_NAME,
 	.write	=	sunhv_console_write_bychar,
 	.device	=	uart_console_device,
 	.flags	=	CON_PRINTBUFFER,
-- 
1.7.1

