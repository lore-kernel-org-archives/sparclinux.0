From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 20:37:32 +0000
Subject: [PATCH 1/5] sparc: fix sparse warning in kernel/pmc.c
Message-Id: <1228682256-27812-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
arch/sparc/kernel/pmc.c:41:6: warning: symbol 'pmc_swift_idle'
was not declared. Should it be static?

It was not used outside this file - make it static

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/pmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 2afcfab..33cd499 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -38,7 +38,7 @@ static u8 __iomem *regs;
  * CPU idle callback function
  * See .../arch/sparc/kernel/process.c
  */
-void pmc_swift_idle(void)
+static void pmc_swift_idle(void)
 {
 #ifdef PMC_DEBUG_LED
 	set_auxio(0x00, AUXIO_LED); 
-- 
1.5.6.GIT

