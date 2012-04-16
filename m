From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Apr 2012 19:57:02 +0000
Subject: [PATCH] sparc32: fix build of pcic
Message-Id: <20120416195702.GA19692@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 2f007277975e8bce2b9142b28b609d7a4e9a631e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Apr 2012 21:50:49 +0200
Subject: [PATCH] sparc32: fix build of pcic

Left-overs for an earlier iteration of the generic clock events patch removed.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This is obviously my bad!
I failed to pay enough attention to pcic.c - and furthermore did not
build-test defconfig.

This patch is build-testet with defconfig.

I assume you will not fold the two patches as sparc-next is out in the public.
But at least I do not mind if you decide to do so as I can quickly
re-produce my sparc-next git tree.

	Sam

 arch/sparc/kernel/pcic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 118a3f5..f0ec939 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -722,7 +722,7 @@ static unsigned int pcic_cycles_offset(void)
 	 */
 	count = ((count / HZ) * USECS_PER_JIFFY) / (TICK_TIMER_LIMIT / HZ);
 
-	/* Coordinate with the fact that timer_cs rate is 2MHz */
+	/* Coordinate with the sparc_config.clock_rate setting */
 	return count * 2;
 }
 
@@ -735,10 +735,10 @@ void __init pci_time_init(void)
 
 #ifndef CONFIG_SMP
 	/*
-	 * It's in SBUS dimension, because timer_cs is in this dimension.
+	 * The clock_rate is in SBUS dimension.
 	 * We take into account this in pcic_cycles_offset()
 	 */
-	timer_cs_period = SBUS_CLOCK_RATE / HZ;
+	sparc_config.clock_rate = SBUS_CLOCK_RATE / HZ;
 	sparc_config.features |= FEAT_L10_CLOCKEVENT;
 #endif
 	sparc_config.features |= FEAT_L10_CLOCKSOURCE;
-- 
1.6.0.6

