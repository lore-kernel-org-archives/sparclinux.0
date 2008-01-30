From: Roel Kluin <12o3l@tiscali.nl>
Date: Wed, 30 Jan 2008 00:30:36 +0000
Subject: [PATCH][sparc64/solaris/fs.c] logical/bitor typos
Message-Id: <479FC52C.7010607@tiscali.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

These should be logical, correct?
--
logical/bitor typos

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/sparc64/solaris/fs.c b/arch/sparc64/solaris/fs.c
index 61be597..2ca724a 100644
--- a/arch/sparc64/solaris/fs.c
+++ b/arch/sparc64/solaris/fs.c
@@ -78,7 +78,8 @@ struct sol_stat64 {
 	s32		st_pad4[4];     /* expansion area */
 };
 
-#define UFSMAGIC (((unsigned)'u'<<24)||((unsigned)'f'<<16)||((unsigned)'s'<<8))
+#define UFSMAGIC (((unsigned)'u' << 24) | ((unsigned)'f' << 16) |	\
+							((unsigned)'s' << 8))
 
 static inline int putstat(struct sol_stat __user *ubuf, struct kstat *kbuf)
 {
