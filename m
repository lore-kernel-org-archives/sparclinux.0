From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 20:22:32 +0000
Subject: [PATCH 4/5] second: Fix typo'd operator
Message-Id: <20200523202233.3063074-4-mattst88@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 second/disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/second/disk.c b/second/disk.c
index 40234b3..b81a465 100644
--- a/second/disk.c
+++ b/second/disk.c
@@ -293,7 +293,7 @@ int silo_disk_read(char *buff, int size, unsigned long long offset)
 	if (!net) {
 	    if (prom_vers != PROM_P1275) {
 		    if (((romvec->pv_printrev >> 16) < 2 || 
-		         ((romvec->pv_printrev >> 16) = 2 && (romvec->pv_printrev && 0xffff) < 6)) 
+		         ((romvec->pv_printrev >> 16) = 2 && (romvec->pv_printrev & 0xffff) < 6))
 		        && offset >= 0x40000000) {
 		    	printf ("Buggy old PROMs don't allow reading past 1GB from start of the disk. Send complaints to SMCC\n");
 	    		return -1;
-- 
2.26.2
