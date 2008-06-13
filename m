From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:21 +0000
Subject: [PATCH] sparc: export openprom.h to userspace
Message-Id: <1213387042-9711-20-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc64 exports openprom.h to userspace so let sparc follow
the example.
As openprom.h pulled in another not-for-export vaddrs.h header
file it required a few changes to fix the build.

The definition af VMALLOC_* were moved to pgtable as this is
where sparc64 has them.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/entry.S    |    1 +
 include/asm-sparc/Kbuild     |    1 +
 include/asm-sparc/openprom.h |    2 --
 include/asm-sparc/pgtable.h  |    7 ++++++-
 include/asm-sparc/vaddrs.h   |    5 -----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 55d3be1..2f96256 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -19,6 +19,7 @@
 #include <asm/vaddrs.h>
 #include <asm/memreg.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #ifdef CONFIG_SUN4
 #include <asm/pgtsun4.h>
 #else
diff --git a/include/asm-sparc/Kbuild b/include/asm-sparc/Kbuild
index c843248..c83e3c0 100644
--- a/include/asm-sparc/Kbuild
+++ b/include/asm-sparc/Kbuild
@@ -6,6 +6,7 @@ header-y += bpp.h
 header-y += display7seg.h
 header-y += envctrl.h
 header-y += jsflash.h
+header-y += openprom.h
 header-y += openpromio.h
 header-y += psrcompat.h
 header-y += pstate.h
diff --git a/include/asm-sparc/openprom.h b/include/asm-sparc/openprom.h
index ed4b6bc..e812cf3 100644
--- a/include/asm-sparc/openprom.h
+++ b/include/asm-sparc/openprom.h
@@ -7,8 +7,6 @@
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  */
 
-#include <asm/vaddrs.h>
-
 /* Empirical constants... */
 #define	LINUX_OPPROM_MAGIC      0x10010407
 
diff --git a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
index 6051229..b63ac6b 100644
--- a/include/asm-sparc/pgtable.h
+++ b/include/asm-sparc/pgtable.h
@@ -8,6 +8,7 @@
  *  Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
+#ifndef __ASSEMBLY__
 #include <asm-generic/4level-fixup.h>
 
 #include <linux/spinlock.h>
@@ -24,7 +25,6 @@
 #include <asm/btfixup.h>
 #include <asm/system.h>
 
-#ifndef __ASSEMBLY__
 
 struct vm_area_struct;
 struct page;
@@ -464,6 +464,11 @@ extern int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #endif /* !(__ASSEMBLY__) */
 
+#define VMALLOC_START           0xfe600000
+/* XXX Alter this when I get around to fixing sun4c - Anton */
+#define VMALLOC_END             0xffc00000
+
+
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
 #define HAVE_ARCH_UNMAPPED_AREA
 
diff --git a/include/asm-sparc/vaddrs.h b/include/asm-sparc/vaddrs.h
index f6ca477..a22fed5 100644
--- a/include/asm-sparc/vaddrs.h
+++ b/include/asm-sparc/vaddrs.h
@@ -34,11 +34,6 @@
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe600000
 
-#define VMALLOC_START		0xfe600000
-
-/* XXX Alter this when I get around to fixing sun4c - Anton */
-#define VMALLOC_END		0xffc00000
-
 /*
  * On the sun4/4c we need a place
  * to reliably map locked down kernel data.  This includes the
-- 
1.5.4.1.143.ge7e51

