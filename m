From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 15:45:03 +0000
Subject: [PATCH 2/4] fix sparc32 modpost warnings
Message-Id: <20061010154503.GC30909@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix these 2.6.19-rc1 build warnings from modpost:

WARNING: vmlinux - Section mismatch: reference to .init.data:boot_flags from .text between 'obp_system_intr' (at offset 0x12dd0) and 'show_cpuinfo'
WARNING: vmlinux - Section mismatch: reference to .init.data:boot_flags from .text between 'obp_system_intr' (at offset 0x12dd4) and 'show_cpuinfo'

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/arch/sparc/kernel/setup.c
=================================--- linux.orig/arch/sparc/kernel/setup.c	2006-10-06 01:08:29.000000000 +0100
+++ linux/arch/sparc/kernel/setup.c	2006-10-07 02:32:20.000000000 +0100
@@ -122,7 +122,7 @@
 	.index =	-1,
 };
 
-int obp_system_intr(void)
+int __init obp_system_intr(void)
 {
 	if (boot_flags & BOOTME_DEBUG) {
 		printk("OBP: system interrupted\n");
