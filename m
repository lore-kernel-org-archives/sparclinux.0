From: Andres Salomon <dilinger@queued.net>
Date: Fri, 12 Nov 2010 06:42:06 +0000
Subject: [PATCH] sparc: explicitly cast negative phandle checks to s32
Message-Id: <20101111224206.79239902@queued.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


When we switched sparc from using 'int's to 'phandle's (which is a u32), we
neglected to do anything with the various checks for -1.  For those tests,
explicitly cast the phandles to s32.

My sparc machine is down, so I was unable to build-test this..

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 arch/sparc/kernel/auxio_32.c |    2 +-
 arch/sparc/kernel/starfire.c |    2 +-
 arch/sparc/prom/init_32.c    |    2 +-
 arch/sparc/prom/init_64.c    |    4 ++--
 arch/sparc/prom/tree_32.c    |   22 ++++++++++++----------
 arch/sparc/prom/tree_64.c    |   20 ++++++++++----------
 drivers/sbus/char/jsflash.c  |    2 +-
 7 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index 35f4883..8505e0a 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -121,7 +121,7 @@ void __init auxio_power_probe(void)
 	node = prom_searchsiblings(node, "obio");
 	node = prom_getchild(node);
 	node = prom_searchsiblings(node, "power");
-	if (node = 0 || node = -1)
+	if (node = 0 || (s32)node = -1)
 		return;
 
 	/* Map the power control register. */
diff --git a/arch/sparc/kernel/starfire.c b/arch/sparc/kernel/starfire.c
index a4446c0..82281a5 100644
--- a/arch/sparc/kernel/starfire.c
+++ b/arch/sparc/kernel/starfire.c
@@ -24,7 +24,7 @@ int this_is_starfire = 0;
 void check_if_starfire(void)
 {
 	phandle ssnode = prom_finddevice("/ssp-serial");
-	if (ssnode != 0 && ssnode != -1)
+	if (ssnode != 0 && (s32)ssnode != -1)
 		this_is_starfire = 1;
 }
 
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index d342dba..0a601b3 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -60,7 +60,7 @@ void __init prom_init(struct linux_romvec *rp)
 	prom_nodeops = romvec->pv_nodeops;
 
 	prom_root_node = prom_getsibling(0);
-	if((prom_root_node = 0) || (prom_root_node = -1))
+	if ((prom_root_node = 0) || ((s32)prom_root_node = -1))
 		prom_halt();
 
 	if((((unsigned long) prom_nodeops) = 0) || 
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 3ff911e..200528b 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -35,14 +35,14 @@ void __init prom_init(void *cif_handler, void *cif_stack)
 	prom_cif_init(cif_handler, cif_stack);
 
 	prom_chosen_node = prom_finddevice(prom_chosen_path);
-	if (!prom_chosen_node || prom_chosen_node = -1)
+	if (!prom_chosen_node || (s32)prom_chosen_node = -1)
 		prom_halt();
 
 	prom_stdin = prom_getint(prom_chosen_node, "stdin");
 	prom_stdout = prom_getint(prom_chosen_node, "stdout");
 
 	node = prom_finddevice("/openprom");
-	if (!node || node = -1)
+	if (!node || (s32)node = -1)
 		prom_halt();
 
 	prom_getstring(node, "version", prom_version, sizeof(prom_version));
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 63e08e1..486e32e 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -40,11 +40,11 @@ phandle prom_getchild(phandle node)
 {
 	phandle cnode;
 
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 
 	cnode = __prom_getchild(node);
-	if (cnode = 0 || cnode = -1)
+	if (cnode = 0 || (s32)cnode = -1)
 		return 0;
 
 	return cnode;
@@ -72,11 +72,11 @@ phandle prom_getsibling(phandle node)
 {
 	phandle sibnode;
 
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 
 	sibnode = __prom_getsibling(node);
-	if (sibnode = 0 || sibnode = -1)
+	if (sibnode = 0 || (s32)sibnode = -1)
 		return 0;
 
 	return sibnode;
@@ -231,7 +231,7 @@ char *__prom_nextprop(phandle node, char * oprop)
 /* buffer is unused argument, but as v9 uses it, we need to have the same interface */
 char *prom_firstprop(phandle node, char *bufer)
 {
-	if (node = 0 || node = -1)
+	if (node = 0 || (s32)node = -1)
 		return "";
 
 	return __prom_nextprop(node, "");
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(prom_firstprop);
  */
 char *prom_nextprop(phandle node, char *oprop, char *buffer)
 {
-	if (node = 0 || node = -1)
+	if (node = 0 || (s32)node = -1)
 		return "";
 
 	return __prom_nextprop(node, oprop);
@@ -278,7 +278,7 @@ phandle prom_finddevice(char *name)
 				if (d != s + 3 && (!*d || *d = '/')
 				    && d <= s + 3 + 8) {
 					node2 = node;
-					while (node2 && node2 != -1) {
+					while (node2 && (s32)node2 != -1) {
 						if (prom_getproperty (node2, "reg", (char *)reg, sizeof (reg)) > 0) {
 							if (which_io = reg[0].which_io && phys_addr = reg[0].phys_addr) {
 								node = node2;
@@ -286,7 +286,7 @@ phandle prom_finddevice(char *name)
 							}
 						}
 						node2 = prom_getsibling(node2);
-						if (!node2 || node2 = -1)
+						if (!node2 || (s32)node2 = -1)
 							break;
 						node2 = prom_searchsiblings(prom_getsibling(node2), nbuf);
 					}
@@ -339,7 +339,8 @@ phandle prom_inst2pkg(int inst)
 	node = (*romvec->pv_v2devops.v2_inst2pkg)(inst);
 	restore_current();
 	spin_unlock_irqrestore(&prom_lock, flags);
-	if (node = -1) return 0;
+	if ((s32)node = -1)
+		return 0;
 	return node;
 }
 
@@ -355,6 +356,7 @@ phandle prom_pathtoinode(char *path)
 	if (inst = -1) return 0;
 	node = prom_inst2pkg (inst);
 	prom_devclose (inst);
-	if (node = -1) return 0;
+	if ((s32)node = -1)
+		return 0;
 	return node;
 }
diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 691be68..d287ce9 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -43,10 +43,10 @@ inline phandle prom_getchild(phandle node)
 {
 	phandle cnode;
 
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 	cnode = __prom_getchild(node);
-	if (cnode = -1)
+	if ((s32)cnode = -1)
 		return 0;
 	return cnode;
 }
@@ -56,10 +56,10 @@ inline phandle prom_getparent(phandle node)
 {
 	phandle cnode;
 
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 	cnode = prom_node_to_node("parent", node);
-	if (cnode = -1)
+	if ((s32)cnode = -1)
 		return 0;
 	return cnode;
 }
@@ -76,10 +76,10 @@ inline phandle prom_getsibling(phandle node)
 {
 	phandle sibnode;
 
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 	sibnode = __prom_getsibling(node);
-	if (sibnode = -1)
+	if ((s32)sibnode = -1)
 		return 0;
 
 	return sibnode;
@@ -240,7 +240,7 @@ inline char *prom_firstprop(phandle node, char *buffer)
 	unsigned long args[7];
 
 	*buffer = 0;
-	if (node = -1)
+	if ((s32)node = -1)
 		return buffer;
 
 	args[0] = (unsigned long) prom_nextprop_name;
@@ -266,7 +266,7 @@ inline char *prom_nextprop(phandle node, const char *oprop, char *buffer)
 	unsigned long args[7];
 	char buf[32];
 
-	if (node = -1) {
+	if ((s32)node = -1) {
 		*buffer = 0;
 		return buffer;
 	}
@@ -369,7 +369,7 @@ inline phandle prom_inst2pkg(int inst)
 	p1275_cmd_direct(args);
 
 	node = (int) args[4];
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 	return node;
 }
@@ -387,7 +387,7 @@ phandle prom_pathtoinode(const char *path)
 		return 0;
 	node = prom_inst2pkg(inst);
 	prom_devclose(inst);
-	if (node = -1)
+	if ((s32)node = -1)
 		return 0;
 	return node;
 }
diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index a624f5a..e856622 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -467,7 +467,7 @@ static int jsflash_init(void)
 
 	node = prom_getchild(prom_root_node);
 	node = prom_searchsiblings(node, "flash-memory");
-	if (node != 0 && node != -1) {
+	if (node != 0 && (s32)node != -1) {
 		if (prom_getproperty(node, "reg",
 		    (char *)&reg0, sizeof(reg0)) = -1) {
 			printk("jsflash: no \"reg\" property\n");
-- 
1.7.2.3

