From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:22 +0000
Subject: [PATCH 12/18] sparc32: drop sparc model check in paging_init
Message-Id: <1343336548-3879-12-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We already check the model in head_32.S so no need to
repeat the check here

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index fc77bb8..6dce086 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -291,19 +291,7 @@ extern void device_scan(void);
 
 void __init paging_init(void)
 {
-	switch(sparc_cpu_model) {
-	case sparc_leon:
-	case sun4m:
-	case sun4d:
-		srmmu_paging_init();
-		break;
-	default:
-		prom_printf("paging_init: Cannot init paging on this Sparc\n");
-		prom_printf("paging_init: sparc_cpu_model = %d\n", sparc_cpu_model);
-		prom_printf("paging_init: Halting...\n");
-		prom_halt();
-	}
-
+	srmmu_paging_init();
 	prom_build_devicetree();
 	of_fill_in_cpu_data();
 	device_scan();
-- 
1.6.0.6

