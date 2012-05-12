From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 03:50:02 +0000
Subject: [PATCH] sparc: Clear out unused asm/machines.h values.
Message-Id: <20120511.235002.1542664080954471669.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Remove sun4 and sun4c machine ID values from asm/machines.h

Also kill NUM_SUN_MACHINES, use ARRAY_SIZE instead.

Kill asm/machines.h include and sun4c checks from asm/floppy_32.h

Remove asm/machines.h include from setup_32.c and time_32.c, unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

This also gets us a tiny bit closer to being able to remove some of
the sparc_cpu_model values.

 arch/sparc/include/asm/floppy_32.h |    5 +----
 arch/sparc/include/asm/machines.h  |   21 ---------------------
 arch/sparc/kernel/idprom.c         |   19 +++----------------
 arch/sparc/kernel/setup_32.c       |    1 -
 arch/sparc/kernel/time_32.c        |    1 -
 5 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 698d955..80382ab 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -12,7 +12,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/idprom.h>
-#include <asm/machines.h>
 #include <asm/oplib.h>
 #include <asm/auxio.h>
 #include <asm/irq.h>
@@ -311,9 +310,7 @@ static int sun_floppy_init(void)
 	/* Forget it if we aren't on a machine that could possibly
 	 * ever have a floppy drive.
 	 */
-	if((sparc_cpu_model != sun4c && sparc_cpu_model != sun4m) ||
-	   ((idprom->id_machtype = (SM_SUN4C | SM_4C_SLC)) ||
-	    (idprom->id_machtype = (SM_SUN4C | SM_4C_ELC)))) {
+	if (sparc_cpu_model != sun4m) {
 		/* We certainly don't have a floppy controller. */
 		goto no_sun_fdc;
 	}
diff --git a/arch/sparc/include/asm/machines.h b/arch/sparc/include/asm/machines.h
index cd9c099..597c478 100644
--- a/arch/sparc/include/asm/machines.h
+++ b/arch/sparc/include/asm/machines.h
@@ -12,11 +12,6 @@ struct Sun_Machine_Models {
 	unsigned char id_machtype;
 };
 
-/* Current number of machines we know about that has an IDPROM
- * machtype entry including one entry for the 0x80 OBP machines.
- */
-#define NUM_SUN_MACHINES   16
-
 /* The machine type in the idprom area looks like this:
  *
  * ---------------
@@ -29,31 +24,15 @@ struct Sun_Machine_Models {
  */
 
 #define SM_ARCH_MASK  0xf0
-#define SM_SUN4       0x20
 #define  M_LEON       0x30
-#define SM_SUN4C      0x50
 #define SM_SUN4M      0x70
 #define SM_SUN4M_OBP  0x80
 
 #define SM_TYP_MASK   0x0f
-/* Sun4 machines */
-#define SM_4_260      0x01    /* Sun 4/200 series */
-#define SM_4_110      0x02    /* Sun 4/100 series */
-#define SM_4_330      0x03    /* Sun 4/300 series */
-#define SM_4_470      0x04    /* Sun 4/400 series */
 
 /* Leon machines */
 #define M_LEON3_SOC   0x02    /* Leon3 SoC */
 
-/* Sun4c machines                Full Name              - PROM NAME */
-#define SM_4C_SS1     0x01    /* Sun4c SparcStation 1   - Sun 4/60  */
-#define SM_4C_IPC     0x02    /* Sun4c SparcStation IPC - Sun 4/40  */
-#define SM_4C_SS1PLUS 0x03    /* Sun4c SparcStation 1+  - Sun 4/65  */
-#define SM_4C_SLC     0x04    /* Sun4c SparcStation SLC - Sun 4/20  */
-#define SM_4C_SS2     0x05    /* Sun4c SparcStation 2   - Sun 4/75  */
-#define SM_4C_ELC     0x06    /* Sun4c SparcStation ELC - Sun 4/25  */
-#define SM_4C_IPX     0x07    /* Sun4c SparcStation IPX - Sun 4/50  */
-
 /* Sun4m machines, these predate the OpenBoot.  These values only mean
  * something if the value in the ARCH field is SM_SUN4M, if it is
  * SM_SUN4M_OBP then you have the following situation:
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index 9167db4..6bd7501 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -25,22 +25,9 @@ static struct idprom idprom_buffer;
  * of the Sparc CPU and have a meaningful IDPROM machtype value that we
  * know about.  See asm-sparc/machines.h for empirical constants.
  */
-static struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES] = {
-/* First, Sun4's */
-{ .name = "Sun 4/100 Series",        .id_machtype = (SM_SUN4 | SM_4_110) },
-{ .name = "Sun 4/200 Series",        .id_machtype = (SM_SUN4 | SM_4_260) },
-{ .name = "Sun 4/300 Series",        .id_machtype = (SM_SUN4 | SM_4_330) },
-{ .name = "Sun 4/400 Series",        .id_machtype = (SM_SUN4 | SM_4_470) },
-/* Now Leon */
+static struct Sun_Machine_Models Sun_Machines[] = {
+/* First, Leon */
 { .name = "Leon3 System-on-a-Chip",  .id_machtype = (M_LEON | M_LEON3_SOC) },
-/* Now, Sun4c's */
-{ .name = "Sun4c SparcStation 1",    .id_machtype = (SM_SUN4C | SM_4C_SS1) },
-{ .name = "Sun4c SparcStation IPC",  .id_machtype = (SM_SUN4C | SM_4C_IPC) },
-{ .name = "Sun4c SparcStation 1+",   .id_machtype = (SM_SUN4C | SM_4C_SS1PLUS) },
-{ .name = "Sun4c SparcStation SLC",  .id_machtype = (SM_SUN4C | SM_4C_SLC) },
-{ .name = "Sun4c SparcStation 2",    .id_machtype = (SM_SUN4C | SM_4C_SS2) },
-{ .name = "Sun4c SparcStation ELC",  .id_machtype = (SM_SUN4C | SM_4C_ELC) },
-{ .name = "Sun4c SparcStation IPX",  .id_machtype = (SM_SUN4C | SM_4C_IPX) },
 /* Finally, early Sun4m's */
 { .name = "Sun4m SparcSystem600",    .id_machtype = (SM_SUN4M | SM_4M_SS60) },
 { .name = "Sun4m SparcStation10/20", .id_machtype = (SM_SUN4M | SM_4M_SS50) },
@@ -53,7 +40,7 @@ static void __init display_system_type(unsigned char machtype)
 	char sysname[128];
 	register int i;
 
-	for (i = 0; i < NUM_SUN_MACHINES; i++) {
+	for (i = 0; i < ARRAY_SIZE(Sun_Machines); i++) {
 		if (Sun_Machines[i].id_machtype = machtype) {
 			if (machtype != (SM_SUN4M_OBP | 0x00) ||
 			    prom_getproperty(prom_root_node, "banner-name",
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index a2123ad..3970a78 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -42,7 +42,6 @@
 #include <asm/vaddrs.h>
 #include <asm/mbus.h>
 #include <asm/idprom.h>
-#include <asm/machines.h>
 #include <asm/cpudata.h>
 #include <asm/setup.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 89e890b..157dcc5 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -42,7 +42,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/idprom.h>
-#include <asm/machines.h>
 #include <asm/page.h>
 #include <asm/pcic.h>
 #include <asm/irq_regs.h>
-- 
1.7.10

