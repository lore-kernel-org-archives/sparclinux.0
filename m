From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 12 Oct 2006 15:22:43 +0000
Subject: [PATCH] sparc32: remove '-s' boot argument
Message-Id: <20061012152243.GA21924@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The '-s' boot argument is not working and not needed. Users should use
argument 's' or '1' to boot into single user mode.
This patch removes the remains of the '-s' argument.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/arch/sparc/kernel/setup.c
=================================--- linux.orig/arch/sparc/kernel/setup.c	2006-10-12 13:07:14.000000000 +0100
+++ linux/arch/sparc/kernel/setup.c	2006-10-12 13:14:35.000000000 +0100
@@ -104,7 +104,6 @@
 
 unsigned int boot_flags __initdata = 0;
 #define BOOTME_DEBUG  0x1
-#define BOOTME_SINGLE 0x2
 
 /* Exported for mm/init.c:paging_init. */
 unsigned long cmdline_memory_size __initdata = 0;
@@ -132,9 +131,6 @@
 	case 'd':
 		boot_flags |= BOOTME_DEBUG;
 		break;
-	case 's':
-		boot_flags |= BOOTME_SINGLE;
-		break;
 	case 'h':
 		prom_printf("boot_flags_init: Halt!\n");
 		prom_halt();
