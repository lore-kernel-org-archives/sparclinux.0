From: David Miller <davem@davemloft.net>
Date: Sat, 15 Sep 2012 16:20:48 +0000
Subject: [PATCH] sparc64: Add missing pr_fmt define to crypto opcode drivers.
Message-Id: <20120915.122048.1936025121859185977.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The hashes and crc32c had it, only the AES/DES/CAMELLIA drivers were
missing it.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/aes_glue.c      |    2 ++
 arch/sparc/crypto/camellia_glue.c |    2 ++
 arch/sparc/crypto/des_glue.c      |    2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/sparc/crypto/aes_glue.c b/arch/sparc/crypto/aes_glue.c
index 180bed4..8f1c998 100644
--- a/arch/sparc/crypto/aes_glue.c
+++ b/arch/sparc/crypto/aes_glue.c
@@ -14,6 +14,8 @@
  *    Copyright (c) 2010, Intel Corporation.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/crypto.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/sparc/crypto/camellia_glue.c b/arch/sparc/crypto/camellia_glue.c
index f45ae69..42905c0 100644
--- a/arch/sparc/crypto/camellia_glue.c
+++ b/arch/sparc/crypto/camellia_glue.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2012 David S. Miller <davem@davemloft.net>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/crypto.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/sparc/crypto/des_glue.c b/arch/sparc/crypto/des_glue.c
index 77d2ad6..c4940c2 100644
--- a/arch/sparc/crypto/des_glue.c
+++ b/arch/sparc/crypto/des_glue.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2012 David S. Miller <davem@davemloft.net>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/crypto.h>
 #include <linux/init.h>
 #include <linux/module.h>
-- 
1.7.10.4

