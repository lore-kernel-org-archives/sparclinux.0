From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:14 +0000
Subject: [PATCH 11/14] sparc32: drop test for sun4c in signal_32
Message-Id: <1336772117-1539-11-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/signal_32.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 1e750e4..ac8e66b 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -217,12 +217,9 @@ segv:
 /* Checks if the fp is valid */
 static inline int invalid_frame_pointer(void __user *fp, int fplen)
 {
-	if ((((unsigned long) fp) & 7) ||
-	    !__access_ok((unsigned long)fp, fplen) ||
-	    ((sparc_cpu_model = sun4 || sparc_cpu_model = sun4c) &&
-	     ((unsigned long) fp < 0xe0000000 && (unsigned long) fp >= 0x20000000)))
+	if ((((unsigned long) fp) & 7) || !__access_ok((unsigned long)fp, fplen))
 		return 1;
-	
+
 	return 0;
 }
 
-- 
1.6.0.6

