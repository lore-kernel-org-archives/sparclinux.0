From: Tobias Klauser <tklauser@nuerscht.ch>
Date: Tue, 08 Nov 2005 20:17:06 +0000
Subject: [PATCH] arch/sparc: Use ARRAY_SIZE macro
Message-Id: <20051108201706.GA7935@neon.tklauser.home>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]) and remove a
duplicate of ARRAY_SIZE which is never used anyways.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

---

 kernel/cpu.c  |    4 ++--
 kernel/pcic.c |    2 +-
 mm/fault.c    |    2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff -X dontdiff -urpN linux-2.6.14/arch/sparc/kernel/cpu.c linux-2.6.14~array_size/arch/sparc/kernel/cpu.c
--- linux-2.6.14/arch/sparc/kernel/cpu.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14~array_size/arch/sparc/kernel/cpu.c	2005-11-08 10:37:05.000000000 +0100
@@ -75,7 +75,7 @@ struct cpu_fp_info linux_sparc_fpu[] = {
   { 9, 3, "Fujitsu or Weitek on-chip FPU"},
 };
 
-#define NSPARCFPU  (sizeof(linux_sparc_fpu)/sizeof(struct cpu_fp_info))
+#define NSPARCFPU  ARRAY_SIZE(linux_sparc_fpu)
 
 struct cpu_iu_info linux_sparc_chips[] = {
   /* Sun4/100, 4/200, SLC */
@@ -120,7 +120,7 @@ struct cpu_iu_info linux_sparc_chips[]    { 0xf, 0, "UNKNOWN CPU-VENDOR/TYPE"},
 };
 
-#define NSPARCCHIPS  (sizeof(linux_sparc_chips)/sizeof(struct cpu_iu_info))
+#define NSPARCCHIPS  ARRAY_SIZE(linux_sparc_chips)
 
 char *sparc_cpu_type;
 char *sparc_fpu_type;
diff -X dontdiff -urpN linux-2.6.14/arch/sparc/kernel/pcic.c linux-2.6.14~array_size/arch/sparc/kernel/pcic.c
--- linux-2.6.14/arch/sparc/kernel/pcic.c	2005-10-28 08:56:26.000000000 +0200
+++ linux-2.6.14~array_size/arch/sparc/kernel/pcic.c	2005-11-08 10:38:15.000000000 +0100
@@ -143,7 +143,7 @@ static struct pcic_ca2irq pcic_i_jk[] = 
  * as several PROMs may be installed on the same physical board.
  */
 #define SN2L_INIT(name, map)	\
-  { name, map, sizeof(map)/sizeof(struct pcic_ca2irq) }
+  { name, map, ARRAY_SIZE(map) }
 
 static struct pcic_sn2list pcic_known_sysnames[] = {
 	SN2L_INIT("SUNW,JavaEngine1", pcic_i_je1a),	/* JE1, PROM 2.32 */
diff -X dontdiff -urpN linux-2.6.14/arch/sparc/mm/fault.c linux-2.6.14~array_size/arch/sparc/mm/fault.c
--- linux-2.6.14/arch/sparc/mm/fault.c	2005-10-28 08:56:26.000000000 +0200
+++ linux-2.6.14~array_size/arch/sparc/mm/fault.c	2005-11-08 10:37:24.000000000 +0100
@@ -33,8 +33,6 @@
 #include <asm/kdebug.h>
 #include <asm/uaccess.h>
 
-#define ELEMENTS(arr) (sizeof (arr)/sizeof (arr[0]))
-
 extern int prom_node_root;
 
 /* At boot time we determine these two values necessary for setting
