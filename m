From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 14:15:08 +0000
Subject: [PATCH 1/2] sparc32: enable different preemptions models
Message-Id: <20111229141508.GA3146@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 09175e8e5c75d18bb023a26e295c5184241c3b72 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 14:54:49 +0100
Subject: [PATCH 1/2] sparc32: enable different preemptions models

While chasing following warning from kconfig I noticed that the
kconfig preemption model symbols were all dependent on sparc64.

warning: (PREEMPT && DEBUG_ATOMIC_SLEEP) selects PREEMPT_COUNT which has unmet direct dependencies (SPARC64)

From arch/sparc/Kconfig:

        if SPARC64
        source "kernel/Kconfig.preempt"
        endif

But looking a bit closer I see nothing obvious why
sparc32 should not support the various preemption models.
Drop the "if SPARC64" conditional to enable selection of
preemption model on sparc32 too.

Build-tested - but not run-time tested all three models.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 27060b2..7cb8adf 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -386,9 +386,7 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
-if SPARC64
 source "kernel/Kconfig.preempt"
-endif
 
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
-- 
1.6.0.6

