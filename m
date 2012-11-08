From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 08 Nov 2012 03:41:39 +0000
Subject: [PATCH] arch/sparc: additional len check in loop for prom_getbootargs
Message-Id: <509B29F3.2040006@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


  when cp >= barg_buf + BARG_LEN-2, it only break internel loop (while)
  but outside loop (for) still has effect, and "*cp++ = ' '" repeating
  so need additional checking for it.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sparc/prom/bootstr_32.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
index f5ec32e..25cda1c 100644
--- a/arch/sparc/prom/bootstr_32.c
+++ b/arch/sparc/prom/bootstr_32.c
@@ -40,6 +40,10 @@ prom_getbootargs(void)
 				*cp++ = *arg++;
 			}
 			*cp++ = ' ';
+			if(cp >= barg_buf + BARG_LEN-1){
+				/* We might issue a warning here. */
+				break;
+			}
 		}
 		*cp = 0;
 		break;
-- 
1.7.9.5
