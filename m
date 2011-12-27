From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 21:28:50 +0000
Subject: [PATCH] sparc32: support atomic64_t
Message-Id: <20111227212850.GA8174@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 8d3ccd703b99564b119a6ddb4127c31f8f2fece3 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 21:46:53 +0100
Subject: [PATCH] sparc32: support atomic64_t

There is no-one that really require atomic64_t support on sparc32.
But several drivers fails to build without proper atomic64 support.
And for an allyesconfig build for sparc32 this is annoying.

Include the generic atomic64_t support for sparc32.
This has a text footprint cost:

$size vmlinux (before atomic64_t support)
   text    data     bss     dec     hex filename
3578860  134260  108781 3821901  3a514d vmlinux

$size vmlinux (after atomic64_t support)
   text    data     bss     dec     hex filename
3579892  130684  108781 3819357  3a475d vmlinux

text increase (3579892 - 3578860) = 1032 bytes

data decreases - but I fail to explain why!
I have rebuild twice to check my numbers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---


Note: This is only build tested because my faithful
SPARCclassic is non-functional atm :-(

	Sam

 arch/sparc/Kconfig                 |    1 +
 arch/sparc/include/asm/atomic_32.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f92602e..27060b2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -31,6 +31,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select GENERIC_ATOMIC64
 
 config SPARC64
 	def_bool 64BIT
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 03fd0c5..9dd0a76 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -13,6 +13,8 @@
 
 #include <linux/types.h>
 
+#include <asm-generic/atomic64.h>
+
 #include <asm/system.h>
 
 #define ATOMIC_INIT(i)  { (i) }
-- 
1.6.0.6

