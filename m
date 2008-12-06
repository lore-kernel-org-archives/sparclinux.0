From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 21:34:33 +0000
Subject: [PATCH 1/2] sparc: idprom_32.c cleanup
Message-Id: <20081206213433.GB28686@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o Use C99 initializer for struct members
o fix code style issues
o Add KERN_WARNING to all printk
o Update prints to match sparc64

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/idprom_32.c |   50 +++++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/kernel/idprom_32.c b/arch/sparc/kernel/idprom_32.c
index 223a658..3e2fe09 100644
--- a/arch/sparc/kernel/idprom_32.c
+++ b/arch/sparc/kernel/idprom_32.c
@@ -11,35 +11,36 @@
 
 #include <asm/oplib.h>
 #include <asm/idprom.h>
-#include <asm/machines.h>  /* Fun with Sun released architectures. */
 
 struct idprom *idprom;
 static struct idprom idprom_buffer;
 
+#include <asm/machines.h>  /* Fun with Sun released architectures. */
+
 /* Here is the master table of Sun machines which use some implementation
  * of the Sparc CPU and have a meaningful IDPROM machtype value that we
  * know about.  See asm-sparc/machines.h for empirical constants.
  */
 static struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES] = {
 /* First, Sun4's */
-{ "Sun 4/100 Series", (SM_SUN4 | SM_4_110) },
-{ "Sun 4/200 Series", (SM_SUN4 | SM_4_260) },
-{ "Sun 4/300 Series", (SM_SUN4 | SM_4_330) },
-{ "Sun 4/400 Series", (SM_SUN4 | SM_4_470) },
+{ .name = "Sun 4/100 Series",        .id_machtype = (SM_SUN4 | SM_4_110) },
+{ .name = "Sun 4/200 Series",        .id_machtype = (SM_SUN4 | SM_4_260) },
+{ .name = "Sun 4/300 Series",        .id_machtype = (SM_SUN4 | SM_4_330) },
+{ .name = "Sun 4/400 Series",        .id_machtype = (SM_SUN4 | SM_4_470) },
 /* Now, Sun4c's */
-{ "Sun4c SparcStation 1", (SM_SUN4C | SM_4C_SS1) },
-{ "Sun4c SparcStation IPC", (SM_SUN4C | SM_4C_IPC) },
-{ "Sun4c SparcStation 1+", (SM_SUN4C | SM_4C_SS1PLUS) },
-{ "Sun4c SparcStation SLC", (SM_SUN4C | SM_4C_SLC) },
-{ "Sun4c SparcStation 2", (SM_SUN4C | SM_4C_SS2) },
-{ "Sun4c SparcStation ELC", (SM_SUN4C | SM_4C_ELC) },
-{ "Sun4c SparcStation IPX", (SM_SUN4C | SM_4C_IPX) },
+{ .name = "Sun4c SparcStation 1",    .id_machtype = (SM_SUN4C | SM_4C_SS1) },
+{ .name = "Sun4c SparcStation IPC",  .id_machtype = (SM_SUN4C | SM_4C_IPC) },
+{ .name = "Sun4c SparcStation 1+",   .id_machtype = (SM_SUN4C | SM_4C_SS1PLUS) },
+{ .name = "Sun4c SparcStation SLC",  .id_machtype = (SM_SUN4C | SM_4C_SLC) },
+{ .name = "Sun4c SparcStation 2",    .id_machtype = (SM_SUN4C | SM_4C_SS2) },
+{ .name = "Sun4c SparcStation ELC",  .id_machtype = (SM_SUN4C | SM_4C_ELC) },
+{ .name = "Sun4c SparcStation IPX",  .id_machtype = (SM_SUN4C | SM_4C_IPX) },
 /* Finally, early Sun4m's */
-{ "Sun4m SparcSystem600", (SM_SUN4M | SM_4M_SS60) },
-{ "Sun4m SparcStation10/20", (SM_SUN4M | SM_4M_SS50) },
-{ "Sun4m SparcStation5", (SM_SUN4M | SM_4M_SS40) },
+{ .name = "Sun4m SparcSystem600",    .id_machtype = (SM_SUN4M | SM_4M_SS60) },
+{ .name = "Sun4m SparcStation10/20", .id_machtype = (SM_SUN4M | SM_4M_SS50) },
+{ .name = "Sun4m SparcStation5",     .id_machtype = (SM_SUN4M | SM_4M_SS40) },
 /* One entry for the OBP arch's which are sun4d, sun4e, and newer sun4m's */
-{ "Sun4M OBP based system", (SM_SUN4M_OBP | 0x0) } };
+{ .name = "Sun4M OBP based system",  .id_machtype = (SM_SUN4M_OBP | 0x0) } };
 
 static void __init display_system_type(unsigned char machtype)
 {
@@ -47,18 +48,19 @@ static void __init display_system_type(unsigned char machtype)
 	register int i;
 
 	for (i = 0; i < NUM_SUN_MACHINES; i++) {
-		if(Sun_Machines[i].id_machtype = machtype) {
+		if (Sun_Machines[i].id_machtype = machtype) {
 			if (machtype != (SM_SUN4M_OBP | 0x00) ||
 			    prom_getproperty(prom_root_node, "banner-name",
 					     sysname, sizeof(sysname)) <= 0)
-				printk("TYPE: %s\n", Sun_Machines[i].name);
+				printk(KERN_WARNING "TYPE: %s\n",
+				       Sun_Machines[i].name);
 			else
-				printk("TYPE: %s\n", sysname);
+				printk(KERN_WARNING "TYPE: %s\n", sysname);
 			return;
 		}
 	}
 
-	prom_printf("IDPROM: Bogus id_machtype value, 0x%x\n", machtype);
+	prom_printf("IDPROM: Warning, bogus id_machtype value, 0x%x\n", machtype);
 	prom_halt();
 }
 
@@ -80,20 +82,20 @@ void __init idprom_init(void)
 
 	idprom = &idprom_buffer;
 
-	if (idprom->id_format != 0x01)  {
-		prom_printf("IDPROM: Unknown format type!\n");
+	if (idprom->id_format != 0x01) {
+		prom_printf("IDPROM: Warning, unknown format type!\n");
 		prom_halt();
 	}
 
 	if (idprom->id_cksum != calc_idprom_cksum(idprom)) {
-		prom_printf("IDPROM: Checksum failure (nvram=%x, calc=%x)!\n",
+		prom_printf("IDPROM: Warning, checksum failure (nvram=%x, calc=%x)!\n",
 			    idprom->id_cksum, calc_idprom_cksum(idprom));
 		prom_halt();
 	}
 
 	display_system_type(idprom->id_machtype);
 
-	printk("Ethernet address: %x:%x:%x:%x:%x:%x\n",
+	printk(KERN_WARNING "Ethernet address: %02x:%02x:%02x:%02x:%02x:%02x\n",
 		    idprom->id_ethaddr[0], idprom->id_ethaddr[1],
 		    idprom->id_ethaddr[2], idprom->id_ethaddr[3],
 		    idprom->id_ethaddr[4], idprom->id_ethaddr[5]);
-- 
1.5.6.GIT

