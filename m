From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 02 Dec 2009 14:30:22 +0000
Subject: [PATCH 3/3] sparc,leon: init_leon srmmu cleanup
Message-Id: <1259764222-1802-4-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Removed unused assignment and capitalized srmmu name for sparc_leon

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/mm/srmmu.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d55c255..367321a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1990,7 +1990,7 @@ void __init poke_leonsparc(void)
 void __init init_leon(void)
 {
 
-	srmmu_name = "Leon";
+	srmmu_name = "LEON";
 
 	BTFIXUPSET_CALL(flush_cache_all, leon_flush_cache_all,
 			BTFIXUPCALL_NORM);
@@ -2037,8 +2037,6 @@ static void __init get_srmmu_type(void)
 
 	/* First, check for sparc-leon. */
 	if (sparc_cpu_model = sparc_leon) {
-		psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
-		psr_vers = 2;
 		init_leon();
 		return;
 	}
-- 
1.6.4.1

