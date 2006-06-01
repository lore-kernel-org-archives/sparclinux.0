From: "Molnar Bence" <mbence@gmail.com>
Date: Thu, 01 Jun 2006 00:18:29 +0000
Subject: [PATCH] export symbol ds1287_regs
Message-Id: <7b0ba3d10605311718t4f49b679v@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just a small patch, applies cleanly on 2.6.16.19.
(Maybe it would be nicer to put it in sparc64_ksyms.c?)

Symptom:
CONFIG_PCI=y
CONFIG_RTC=m
# modprobe rtc
FATAL: Error inserting rtc (/lib/modules/.../rtc.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
# dmesg
rtc: Unknown symbol ds1287_regs

--- linux-2.6.16/arch/sparc64/kernel/time.c     2006-03-20
05:53:29.000000000 +0000
+++ linux-2.6.16/arch/sparc64/kernel/time.c     2006-03-22
14:36:57.000000000 +0000
@@ -51,6 +51,7 @@
 void __iomem *mstk48t02_regs = NULL;
 #ifdef CONFIG_PCI
 unsigned long ds1287_regs = 0UL;
+EXPORT_SYMBOL(ds1287_regs);
 #endif

 extern unsigned long wall_jiffies;
