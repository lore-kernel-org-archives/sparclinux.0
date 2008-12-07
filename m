From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 20:37:33 +0000
Subject: [PATCH 2/5] sparc: fix trivial style issues in kernel/pmc.c
Message-Id: <1228682256-27812-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o drop trailing whitespaces
o align a fix things properly

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/pmc.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 33cd499..5e4563d 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -24,32 +24,32 @@
  */
 
 #define PMC_OBPNAME	"SUNW,pmc"
-#define PMC_DEVNAME "pmc"
+#define PMC_DEVNAME	"pmc"
 
 #define PMC_IDLE_REG	0x00
-#define PMC_IDLE_ON		0x01
+#define PMC_IDLE_ON	0x01
 
 static u8 __iomem *regs;
 
 #define pmc_readb(offs)		(sbus_readb(regs+offs))
-#define pmc_writeb(val, offs) 	(sbus_writeb(val, regs+offs))
+#define pmc_writeb(val, offs)	(sbus_writeb(val, regs+offs))
 
-/* 
+/*
  * CPU idle callback function
  * See .../arch/sparc/kernel/process.c
  */
 static void pmc_swift_idle(void)
 {
 #ifdef PMC_DEBUG_LED
-	set_auxio(0x00, AUXIO_LED); 
+	set_auxio(0x00, AUXIO_LED);
 #endif
 
 	pmc_writeb(pmc_readb(PMC_IDLE_REG) | PMC_IDLE_ON, PMC_IDLE_REG);
 
 #ifdef PMC_DEBUG_LED
-	set_auxio(AUXIO_LED, 0x00); 
+	set_auxio(AUXIO_LED, 0x00);
 #endif
-} 
+}
 
 static int __devinit pmc_probe(struct of_device *op,
 			       const struct of_device_id *match)
@@ -63,7 +63,7 @@ static int __devinit pmc_probe(struct of_device *op,
 
 #ifndef PMC_NO_IDLE
 	/* Assign power management IDLE handler */
-	pm_idle = pmc_swift_idle;	
+	pm_idle = pmc_swift_idle;
 #endif
 
 	printk(KERN_INFO "%s: power management initialized\n", PMC_DEVNAME);
-- 
1.5.6.GIT

