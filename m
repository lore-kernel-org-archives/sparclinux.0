From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 05:00:34 +0000
Subject: [PATCH] sparc32: Remove asm/sysen.h header.
Message-Id: <20120520.010034.1484091469844641207.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Defines a sun4c register, thus completely unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sysen.h |   15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 arch/sparc/include/asm/sysen.h

diff --git a/arch/sparc/include/asm/sysen.h b/arch/sparc/include/asm/sysen.h
deleted file mode 100644
index 6af34ab..0000000
--- a/arch/sparc/include/asm/sysen.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * sysen.h:  Bit fields within the "System Enable" register accessed via
- *           the ASI_CONTROL address space at address AC_SYSENABLE.
- *
- * Copyright (C) 1994 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef _SPARC_SYSEN_H
-#define _SPARC_SYSEN_H
-
-#define SENABLE_DVMA   0x20   /* enable dvma transfers */
-#define SENABLE_CACHE  0x10   /* enable VAC cache */
-#define SENABLE_RESET  0x04   /* reset whole machine, danger Will Robinson */
-
-#endif /* _SPARC_SYSEN_H */
-- 
1.7.10

