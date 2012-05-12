From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 18:04:10 +0000
Subject: [PATCH 2/5] sparc32: code cleanup in floppy glue
Message-Id: <1336845853-30388-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Small cleanup to improve readability.
Dropped one test for sparc_cpu_model -
we already know that only sun4m support floppy.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/floppy_32.h |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 491eb68..c514864 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -288,10 +288,11 @@ static int sun_floppy_init(void)
 {
 	struct platform_device *op;
 	struct device_node *dp;
+	struct resource r;
 	char state[128];
-	phandle tnode, fd_node;
+	phandle fd_node;
+	phandle tnode;
 	int num_regs;
-	struct resource r;
 
 	use_virtual_dma = 1;
 
@@ -305,19 +306,18 @@ static int sun_floppy_init(void)
 	/* Well, try to find one. */
 	tnode = prom_getchild(prom_root_node);
 	fd_node = prom_searchsiblings(tnode, "obio");
-	if(fd_node != 0) {
+	if (fd_node != 0) {
 		tnode = prom_getchild(fd_node);
 		fd_node = prom_searchsiblings(tnode, "SUNW,fdtwo");
 	} else {
 		fd_node = prom_searchsiblings(tnode, "fd");
 	}
-	if(fd_node = 0) {
+	if (fd_node = 0) {
 		goto no_sun_fdc;
 	}
 
 	/* The sun4m lets us know if the controller is actually usable. */
-	if(sparc_cpu_model = sun4m &&
-	   prom_getproperty(fd_node, "status", state, sizeof(state)) != -1) {
+	if (prom_getproperty(fd_node, "status", state, sizeof(state)) != -1) {
 		if(!strcmp(state, "disabled")) {
 			goto no_sun_fdc;
 		}
@@ -328,8 +328,7 @@ static int sun_floppy_init(void)
 	memset(&r, 0, sizeof(r));
 	r.flags = fd_regs[0].which_io;
 	r.start = fd_regs[0].phys_addr;
-	sun_fdc = (struct sun_flpy_controller *)
-	    of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
+	sun_fdc = of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
 
 	/* Look up irq in platform_device.
 	 * We try "SUNW,fdtwo" and "fd"
@@ -353,7 +352,7 @@ static int sun_floppy_init(void)
 	FLOPPY_IRQ = op->archdata.irqs[0];
 
 	/* Last minute sanity check... */
-	if(sun_fdc->status_82072 = 0xff) {
+	if (sun_fdc->status_82072 = 0xff) {
 		sun_fdc = NULL;
 		goto no_sun_fdc;
 	}
-- 
1.6.0.6

