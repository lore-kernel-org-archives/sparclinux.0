From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 21:44:22 +0000
Subject: [PATCH 1/5] sparc: use generic headers
Message-Id: <1364679866-29982-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use "generic-y" to add generic headers where possible

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild              |    4 ++++
 arch/sparc/include/asm/cputime.h           |    6 ------
 arch/sparc/include/asm/emergency-restart.h |    6 ------
 arch/sparc/include/asm/mutex.h             |    9 ---------
 arch/sparc/include/asm/serial.h            |    6 ------
 5 files changed, 4 insertions(+), 27 deletions(-)
 delete mode 100644 arch/sparc/include/asm/cputime.h
 delete mode 100644 arch/sparc/include/asm/emergency-restart.h
 delete mode 100644 arch/sparc/include/asm/mutex.h
 delete mode 100644 arch/sparc/include/asm/serial.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index e26d430..f73884b 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -2,11 +2,15 @@
 
 
 generic-y += clkdev.h
+generic-y += cputime.h
 generic-y += div64.h
+generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += local64.h
+generic-y += mutex.h
 generic-y += irq_regs.h
 generic-y += local.h
 generic-y += module.h
+generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
diff --git a/arch/sparc/include/asm/cputime.h b/arch/sparc/include/asm/cputime.h
deleted file mode 100644
index 1a642b8..0000000
--- a/arch/sparc/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __SPARC_CPUTIME_H
-#define __SPARC_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __SPARC_CPUTIME_H */
diff --git a/arch/sparc/include/asm/emergency-restart.h b/arch/sparc/include/asm/emergency-restart.h
deleted file mode 100644
index 108d8c4..0000000
--- a/arch/sparc/include/asm/emergency-restart.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
-#include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/arch/sparc/include/asm/mutex.h b/arch/sparc/include/asm/mutex.h
deleted file mode 100644
index 458c1f7..0000000
--- a/arch/sparc/include/asm/mutex.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * Pull in the generic implementation for the mutex fastpath.
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or pick the atomic_xchg() based generic
- * implementation. (see asm-generic/mutex-xchg.h for details)
- */
-
-#include <asm-generic/mutex-dec.h>
diff --git a/arch/sparc/include/asm/serial.h b/arch/sparc/include/asm/serial.h
deleted file mode 100644
index f90d61c..0000000
--- a/arch/sparc/include/asm/serial.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __SPARC_SERIAL_H
-#define __SPARC_SERIAL_H
-
-#define BASE_BAUD ( 1843200 / 16 )
-
-#endif /* __SPARC_SERIAL_H */
-- 
1.6.0.6

