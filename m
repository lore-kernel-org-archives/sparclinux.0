From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Jun 2008 22:04:55 +0000
Subject: [PATCH 23/25] sparc: when header files are equal use asm-sparc version
Message-Id: <1214690697-4631-23-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Used the following script to find equal header files:
SPARC64=`ls asm-sparc64`
for FILE in ${SPARC64}; do
	cmp -s asm-sparc/$FILE asm-sparc64/$FILE;
	if [ $? = 0 ]; then
		printf "#include <asm-sparc/%s>\n" $FILE > asm-sparc64/$FILE
	fi
done

A few of the equal files are a simple include from
asm-generic, but by including the file from asm-sparc
we know they are equal for sparc and sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/irq_regs.h  |    2 +-
 include/asm-sparc64/linkage.h   |    7 +------
 include/asm-sparc64/mutex.h     |   10 +---------
 include/asm-sparc64/rtc.h       |   27 +--------------------------
 include/asm-sparc64/semaphore.h |    2 +-
 include/asm-sparc64/vga.h       |   34 +---------------------------------
 6 files changed, 6 insertions(+), 76 deletions(-)

diff --git a/include/asm-sparc64/irq_regs.h b/include/asm-sparc64/irq_regs.h
index 3dd9c0b..1e2b8a1 100644
--- a/include/asm-sparc64/irq_regs.h
+++ b/include/asm-sparc64/irq_regs.h
@@ -1 +1 @@
-#include <asm-generic/irq_regs.h>
+#include <asm-sparc/irq_regs.h>
diff --git a/include/asm-sparc64/linkage.h b/include/asm-sparc64/linkage.h
index 291c2d0..3ea4fd1 100644
--- a/include/asm-sparc64/linkage.h
+++ b/include/asm-sparc64/linkage.h
@@ -1,6 +1 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* Nothing to see here... */
-
-#endif
+#include <asm-sparc/linkage.h>
diff --git a/include/asm-sparc64/mutex.h b/include/asm-sparc64/mutex.h
index 458c1f7..c0c0f8f 100644
--- a/include/asm-sparc64/mutex.h
+++ b/include/asm-sparc64/mutex.h
@@ -1,9 +1 @@
-/*
- * Pull in the generic implementation for the mutex fastpath.
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or pick the atomic_xchg() based generic
- * implementation. (see asm-generic/mutex-xchg.h for details)
- */
-
-#include <asm-generic/mutex-dec.h>
+#include <asm-sparc/mutex.h>
diff --git a/include/asm-sparc64/rtc.h b/include/asm-sparc64/rtc.h
index f9ecb1f..e49a968 100644
--- a/include/asm-sparc64/rtc.h
+++ b/include/asm-sparc64/rtc.h
@@ -1,26 +1 @@
-/*
- * rtc.h: Definitions for access to the Mostek real time clock
- *
- * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
- */
-
-#ifndef _RTC_H
-#define _RTC_H
-
-#include <linux/ioctl.h>
-
-struct rtc_time
-{
-	int	sec;	/* Seconds (0-59) */
-	int	min;	/* Minutes (0-59) */
-	int	hour;	/* Hour (0-23) */
-	int	dow;	/* Day of the week (1-7) */
-	int	dom;	/* Day of the month (1-31) */
-	int	month;	/* Month of year (1-12) */
-	int	year;	/* Year (0-99) */
-};
-
-#define RTCGET _IOR('p', 20, struct rtc_time)
-#define RTCSET _IOW('p', 21, struct rtc_time)
-
-#endif
+#include <asm-sparc/rtc.h>
diff --git a/include/asm-sparc64/semaphore.h b/include/asm-sparc64/semaphore.h
index d9b2034..39362af 100644
--- a/include/asm-sparc64/semaphore.h
+++ b/include/asm-sparc64/semaphore.h
@@ -1 +1 @@
-#include <linux/semaphore.h>
+#include <asm-sparc/semaphore.h>
diff --git a/include/asm-sparc64/vga.h b/include/asm-sparc64/vga.h
index c69d5b2..fbf4d58 100644
--- a/include/asm-sparc64/vga.h
+++ b/include/asm-sparc64/vga.h
@@ -1,33 +1 @@
-/*
- *	Access to VGA videoram
- *
- *	(c) 1998 Martin Mares <mj@ucw.cz>
- */
-
-#ifndef _LINUX_ASM_VGA_H_
-#define _LINUX_ASM_VGA_H_
-
-#include <asm/types.h>
-
-#define VT_BUF_HAVE_RW
-
-#undef scr_writew
-#undef scr_readw
-
-static inline void scr_writew(u16 val, u16 *addr)
-{
-	BUG_ON((long) addr >= 0);
-
-	*addr = val;
-}
-
-static inline u16 scr_readw(const u16 *addr)
-{
-	BUG_ON((long) addr >= 0);
-
-	return *addr;
-}
-
-#define VGA_MAP_MEM(x,s) (x)
-
-#endif
+#include <asm-sparc/vga.h>
-- 
1.5.4.1.143.ge7e51

