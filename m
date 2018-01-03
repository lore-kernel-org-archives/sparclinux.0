From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Wed, 03 Jan 2018 20:27:09 +0000
Subject: [PATCH] sparc64: drop unneeded compat include
Message-Id: <10175291.0E3267SrcQ@eto>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From a806bbb6385d6428e8484722d7320f3f9c1d622e Mon Sep 17 00:00:00 2001
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Wed, 3 Jan 2018 21:24:20 +0100
Subject: [PATCH] sparc64: drop unneeded compat include

The last user of compat_old_sigset_t was removed in commit
2d7d5f05111a9d913131a2764d8b20157f8f758d.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
---
 arch/sparc/kernel/signal_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 20426a1c28f2..48366e5eb5b2 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -9,9 +9,6 @@
  *  Copyright (C) 1997,1998 Jakub Jelinek   (jj@sunsite.mff.cuni.cz)
  */
 
-#ifdef CONFIG_COMPAT
-#include <linux/compat.h>	/* for compat_old_sigset_t */
-#endif
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
-- 
2.12.3


