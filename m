From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2012 20:26:19 +0000
Subject: [PATCH 2/3 v2] kernel: Move REPEAT_BYTE definition into linux/kernel.h
Message-Id: <20120524.162619.664806190601525554.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: sparclinux@vger.kernel.org


And make sure that everything using it explicitly includes
that header file.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/usercopy.c             |    3 +--
 arch/x86/include/asm/word-at-a-time.h |    4 ++--
 fs/namei.c                            |    1 +
 include/linux/kernel.h                |    2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index f61ed82..0b12e91 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/bug.h>
 
@@ -11,8 +12,6 @@ void copy_from_user_overflow(void)
 }
 EXPORT_SYMBOL(copy_from_user_overflow);
 
-#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
-
 static inline long find_zero(unsigned long mask)
 {
 	long byte = 0;
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index e58f03b..ae03fac 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
+#include <linux/kernel.h>
+
 /*
  * This is largely generic for little-endian machines, but the
  * optimal byte mask counting is probably going to be something
@@ -35,8 +37,6 @@ static inline long count_masked_bytes(long mask)
 
 #endif
 
-#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
-
 /* Return the high bit set in the first byte that is a zero */
 static inline unsigned long has_zero(unsigned long a)
 {
diff --git a/fs/namei.c b/fs/namei.c
index f9e883c..8d2ba42 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 645231c..fbe9bfa 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -38,6 +38,8 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
+#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
+
 #define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
 #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
-- 
1.7.10

