From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 03 Aug 2011 21:02:22 +0000
Subject: [PATCH] sparc: use kbuild-generic support for true asm-generic
Message-Id: <20110803210222.GA11372@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From f856630b7a170e82a711455ecac4a29a805e0bd2 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 3 Aug 2011 21:30:42 +0200
Subject: [PATCH] sparc: use kbuild-generic support for true asm-generic header files

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild     |    5 +++++
 arch/sparc/include/asm/div64.h    |    1 -
 arch/sparc/include/asm/irq_regs.h |    1 -
 arch/sparc/include/asm/local.h    |    6 ------
 arch/sparc/include/asm/local64.h  |    1 -
 5 files changed, 5 insertions(+), 9 deletions(-)
 delete mode 100644 arch/sparc/include/asm/div64.h
 delete mode 100644 arch/sparc/include/asm/irq_regs.h
 delete mode 100644 arch/sparc/include/asm/local.h
 delete mode 100644 arch/sparc/include/asm/local64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 3c93f08..2c2e388 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -16,3 +16,8 @@ header-y += traps.h
 header-y += uctx.h
 header-y += utrap.h
 header-y += watchdog.h
+
+generic-y += div64.h
+generic-y += local64.h
+generic-y += irq_regs.h
+generic-y += local.h
diff --git a/arch/sparc/include/asm/div64.h b/arch/sparc/include/asm/div64.h
deleted file mode 100644
index 6cd978c..0000000
--- a/arch/sparc/include/asm/div64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/div64.h>
diff --git a/arch/sparc/include/asm/irq_regs.h b/arch/sparc/include/asm/irq_regs.h
deleted file mode 100644
index 3dd9c0b..0000000
--- a/arch/sparc/include/asm/irq_regs.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/irq_regs.h>
diff --git a/arch/sparc/include/asm/local.h b/arch/sparc/include/asm/local.h
deleted file mode 100644
index bc80815..0000000
--- a/arch/sparc/include/asm/local.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _SPARC_LOCAL_H
-#define _SPARC_LOCAL_H
-
-#include <asm-generic/local.h>
-
-#endif
diff --git a/arch/sparc/include/asm/local64.h b/arch/sparc/include/asm/local64.h
deleted file mode 100644
index 36c93b5..0000000
--- a/arch/sparc/include/asm/local64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/local64.h>
-- 
1.6.0.6

