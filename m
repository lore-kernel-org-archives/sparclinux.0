From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:11 +0000
Subject: [PATCH 01/18] sparc32: define a few srmmu functions __init
Message-Id: <1343336548-3879-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

They are only used during early init so lets get rid of them
after init to save some RAM.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 62e3f57..b2ba9d1 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -232,7 +232,7 @@ extern unsigned long probe_memory(void);	/* in fault.c */
  * Reserve nocache dynamically proportionally to the amount of
  * system RAM. -- Tomas Szepe <szepe@pinerecords.com>, June 2002
  */
-static void srmmu_nocache_calcsize(void)
+static void __init srmmu_nocache_calcsize(void)
 {
 	unsigned long sysmemavail = probe_memory() / 1024;
 	int srmmu_nocache_npages;
@@ -776,7 +776,7 @@ static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
 	return vstart;
 }
 
-static inline void map_kernel(void)
+static void __init map_kernel(void)
 {
 	int i;
 
-- 
1.6.0.6

