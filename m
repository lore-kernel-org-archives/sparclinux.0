From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 30 May 2013 03:35:22 +0000
Subject: [PATCH] arch: sparc: prom: looping issue, need additional length check in the outside looping
Message-Id: <51A6C8FA.3080408@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org


When "cp >= barg_buf + BARG_LEN-2", it breaks internel looping 'while',
but outside loop 'for' still has effect, so "*cp++ = ' '" will continue
repeating which may cause memory overflow.

So need additional length check for it in the outside looping.

Also beautify the related code which found by "./scripts/checkpatch.pl"


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sparc/prom/bootstr_32.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
index f5ec32e..d2b49d2 100644
--- a/arch/sparc/prom/bootstr_32.c
+++ b/arch/sparc/prom/bootstr_32.c
@@ -23,23 +23,25 @@ prom_getbootargs(void)
 		return barg_buf;
 	}
 
-	switch(prom_vers) {
+	switch (prom_vers) {
 	case PROM_V0:
 		cp = barg_buf;
 		/* Start from 1 and go over fd(0,0,0)kernel */
-		for(iter = 1; iter < 8; iter++) {
+		for (iter = 1; iter < 8; iter++) {
 			arg = (*(romvec->pv_v0bootargs))->argv[iter];
 			if (arg = NULL)
 				break;
-			while(*arg != 0) {
+			while (*arg != 0) {
 				/* Leave place for space and null. */
-				if(cp >= barg_buf + BARG_LEN-2){
+				if (cp >= barg_buf + BARG_LEN - 2)
 					/* We might issue a warning here. */
 					break;
-				}
 				*cp++ = *arg++;
 			}
 			*cp++ = ' ';
+			if (cp >= barg_buf + BARG_LEN - 1)
+				/* We might issue a warning here. */
+				break;
 		}
 		*cp = 0;
 		break;
-- 
1.7.7.6
