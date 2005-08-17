From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 17 Aug 2005 20:55:27 +0000
Subject: [PATCH 2/2] Add OpenBoot magic SysRq command
Message-Id: <20050817205527.GA9362@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch against 2.6.10 adds key 'o' to the Magic SysRq commands, which
drops down to the OpenBoot prompt.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- linux-2.6/arch/sparc/kernel/setup.c.orig	2005-01-13 20:01:11.000000000 +0000
+++ linux-2.6/arch/sparc/kernel/setup.c	2005-08-17 21:33:24.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/spinlock.h>
 #include <linux/root_dev.h>
+#include <linux/sysrq.h>
 
 #include <asm/segment.h>
 #include <asm/system.h>
@@ -222,6 +223,22 @@
 	}
 }
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_handle_openboot(int key, struct pt_regs *regs,
+			      struct tty_struct *tty)
+{
+	stop_a_enabled = 1;
+	sun_do_break();
+}
+
+static struct sysrq_key_op sysrq_openboot_op +{
+	.handler =	sysrq_handle_openboot,
+	.help_msg =	"Openboot",
+	.action_msg =	"Entering OpenBoot",
+};
+#endif
+
 /* This routine will in the future do all the nasty prom stuff
  * to probe for the mmu type and its parameters, etc. This will
  * also be where SMP things happen plus the Sparc specific memory
@@ -352,6 +369,10 @@
 	init_task.thread.kregs = &fake_swapper_regs;
 
 	paging_init();
+
+#ifdef CONFIG_MAGIC_SYSRQ
+	register_sysrq_key('o', &sysrq_openboot_op);
+#endif
 }
 
 static int __init set_preferred_console(void)
