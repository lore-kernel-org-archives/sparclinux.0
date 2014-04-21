From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:33 +0000
Subject: [PATCH 21/24] sparc32: fix sparse warnings in leon_pmc.c
Message-Id: <1398100356-19794-21-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
leon_pmc.c:15:14: warning: symbol 'pmc_leon_fixup_ids' was not declared. Should it be static?
leon_pmc.c:22:5: warning: symbol 'pmc_leon_need_fixup' was not declared. Should it be static?
leon_pmc.c:41:6: warning: symbol 'pmc_leon_idle_fixup' was not declared. Should it be static?
leon_pmc.c:65:6: warning: symbol 'pmc_leon_idle' was not declared. Should it be static?

Add static to definitions.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_pmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index b0b3967..ddcf950 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -12,14 +12,14 @@
 #include <asm/processor.h>
 
 /* List of Systems that need fixup instructions around power-down instruction */
-unsigned int pmc_leon_fixup_ids[] = {
+static unsigned int pmc_leon_fixup_ids[] = {
 	AEROFLEX_UT699,
 	GAISLER_GR712RC,
 	LEON4_NEXTREME1,
 	0
 };
 
-int pmc_leon_need_fixup(void)
+static int pmc_leon_need_fixup(void)
 {
 	unsigned int systemid = amba_system_id >> 16;
 	unsigned int *id;
@@ -38,7 +38,7 @@ int pmc_leon_need_fixup(void)
  * CPU idle callback function for systems that need some extra handling
  * See .../arch/sparc/kernel/process.c
  */
-void pmc_leon_idle_fixup(void)
+static void pmc_leon_idle_fixup(void)
 {
 	/* Prepare an address to a non-cachable region. APB is always
 	 * none-cachable. One instruction is executed after the Sleep
@@ -62,7 +62,7 @@ void pmc_leon_idle_fixup(void)
  * CPU idle callback function
  * See .../arch/sparc/kernel/process.c
  */
-void pmc_leon_idle(void)
+static void pmc_leon_idle(void)
 {
 	/* Interrupts need to be enabled to not hang the CPU */
 	local_irq_enable();
-- 
1.8.3.1

