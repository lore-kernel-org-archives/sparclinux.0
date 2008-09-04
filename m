From: "Bjoern B. Brandenburg" <bbb@cs.unc.edu>
Date: Thu, 04 Sep 2008 03:11:37 +0000
Subject: [PATCH] sparc: remove unused includes
Message-Id: <20080904031137.GA24664@swan5.cs.unc.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The spinlock code does not use NR_CPUS.
Compile tested using allyesconfig and allnoconfig.

Signed-off-by: Bjoern B. Brandenburg <bbb@cs.unc.edu>
---
 arch/sparc/include/asm/spinlock_32.h |    2 --
 arch/sparc/include/asm/spinlock_64.h |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/spinlock_32.h b/arch/sparc/include/asm/spinlock_32.h
index de2249b..bf2d532 100644
--- a/arch/sparc/include/asm/spinlock_32.h
+++ b/arch/sparc/include/asm/spinlock_32.h
@@ -6,8 +6,6 @@
 #ifndef __SPARC_SPINLOCK_H
 #define __SPARC_SPINLOCK_H
 
-#include <linux/threads.h>	/* For NR_CPUS */
-
 #ifndef __ASSEMBLY__
 
 #include <asm/psr.h>
diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
index 0006fe9..120cfe4 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -6,8 +6,6 @@
 #ifndef __SPARC64_SPINLOCK_H
 #define __SPARC64_SPINLOCK_H
 
-#include <linux/threads.h>	/* For NR_CPUS */
-
 #ifndef __ASSEMBLY__
 
 /* To get debugging spinlocks which detect and catch
-- 
1.6.0.1

- Bjoern
