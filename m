From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 08:47:36 +0000
Subject: [PATCH 4/2] sparc32: drop unused prototype from timer_32.h
Message-Id: <20120513084736.GB25608@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From aadd21823de12fbaac5f0d5150ac86af2d6ad79e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 10:35:20 +0200
Subject: [PATCH 4/2] sparc32: drop unused prototype from timer_32.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/timer_32.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index e6e6667..703653e 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -42,9 +42,4 @@ DECLARE_PER_CPU(struct clock_event_device, sparc32_clockevent);
 extern void register_percpu_ce(int cpu);
 #endif
 
-/* FIXME: Make do_[gs]ettimeofday btfixup calls */
-struct timespec;
-BTFIXUPDEF_CALL(int, bus_do_settimeofday, struct timespec *tv)
-#define bus_do_settimeofday(tv) BTFIXUP_CALL(bus_do_settimeofday)(tv)
-
 #endif /* !(_SPARC_TIMER_H) */
-- 
1.6.0.6

