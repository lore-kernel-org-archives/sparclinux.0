From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:10:10 +0000
Subject: [PATCH 0257/1529] Fix typo
Message-Id: <20160521121010.13480-1-andrea.gelmini@gelma.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sparc/include/uapi/asm/errno.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 20423e17..6ff035f 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -95,7 +95,7 @@
 #define	EISNAM		120	/* Is a named type file */
 #define	EREMOTEIO	121	/* Remote I/O error */
 #define	EILSEQ		122	/* Illegal byte sequence */
-#define	ELIBMAX		123	/* Atmpt to link in too many shared libs */
+#define	ELIBMAX		123	/* Attempt to link in too many shared libs */
 #define	ELIBSCN		124	/* .lib section in a.out corrupted */
 
 #define	ENOMEDIUM	125	/* No medium found */
-- 
2.8.2.534.g1f66975

