From: David Miller <davem@davemloft.net>
Date: Mon, 15 Aug 2011 21:52:35 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <20110815.145235.1865903877450528146.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 15 Aug 2011 15:55:00 -0400

> But if they use recordmcount.c instead, then nothing needs to be done
> with recordmcount.pl.

Thanks again Steven, I'll push the following via the sparc tree.

--------------------
From 178a29600340bef5b13cd4157053679debe35351 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 15 Aug 2011 14:45:17 -0700
Subject: [PATCH] sparc64: Set HAVE_C_RECORDMCOUNT

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 42c67be..1a6f20d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -55,6 +55,7 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select IRQ_PREFLOW_FASTEOI
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select HAVE_C_RECORDMCOUNT
 
 config ARCH_DEFCONFIG
 	string
-- 
1.7.6.401.g6a319

