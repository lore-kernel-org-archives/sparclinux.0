From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 23:22:26 +0000
Subject: [PATCH]: Kill asm/rtc.h
Message-Id: <20080903.162226.223338913.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is now no longer used by anything that can be compiled
on sparc.

sparc: Remove asm/rtc.h

No more users.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/rtc.h |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)
 delete mode 100644 arch/sparc/include/asm/rtc.h

diff --git a/arch/sparc/include/asm/rtc.h b/arch/sparc/include/asm/rtc.h
deleted file mode 100644
index f9ecb1f..0000000
--- a/arch/sparc/include/asm/rtc.h
+++ /dev/null
@@ -1,26 +0,0 @@
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
-- 
1.5.6.5.GIT

