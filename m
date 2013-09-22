From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 22 Sep 2013 19:33:03 +0000
Subject: [PATCH 1/2] second/util: convert data to big endian
Message-Id: <1379878384-26476-2-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If SILO is cross-compiled, the "util" tool will be run in the host system
and we must ensure the output is big-endian.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 second/util.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/second/util.c b/second/util.c
index 67c9bca..3346823 100644
--- a/second/util.c
+++ b/second/util.c
@@ -21,6 +21,7 @@
 #include <stdlib.h>
 #include <ctype.h>
 #include <string.h>
+#include <arpa/inet.h>
 
 FILE *f, *e;
 unsigned char buffer[2048];
@@ -61,11 +62,11 @@ void save(FILE *out, int len, int type)
 			    goto bad1;
 			if (k >= prevoff)
 			    k = prevoff - 1;
-			diffs[type][ndiffs[type]] = k - lastv[type];
+			diffs[type][ndiffs[type]] = htons(k - lastv[type]);
 			lastv[type] = k;
 			ndiffs[type]++;
 		    }
-		    diffs[type][ndiffs[type]] = curoff + j - lastv[type]; 
+		    diffs[type][ndiffs[type]] = htons(curoff + j - lastv[type]);
 		    lastv[type] = curoff + j;
 		    ndiffs[type]++;
 		} else if (buffer2[j] = buffer[j] + 16) {
@@ -77,11 +78,13 @@ void save(FILE *out, int len, int type)
 			    goto bad2;
 			if (k >= prevoff)
 			    k = prevoff - 1;
-			diffs[type+1][ndiffs[type+1]] = k - lastv[type+1];
+			diffs[type+1][ndiffs[type+1]] +				htons(k - lastv[type+1]);
 			lastv[type+1] = k;
 			ndiffs[type+1]++;
 		    }
-		    diffs[type+1][ndiffs[type+1]] = curoff + j - lastv[type+1]; 
+		    diffs[type+1][ndiffs[type+1]] +			htons(curoff + j - lastv[type+1]);
 		    lastv[type+1] = curoff + j;
 		    ndiffs[type+1]++;
 		} else {
-- 
1.8.4.rc3

