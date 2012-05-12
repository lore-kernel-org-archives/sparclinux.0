From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 07:28:08 +0000
Subject: [PATCH] sparc32: Remove sun4 and sun4c from enum sparc_cpu.
Message-Id: <20120512.032808.1324236106865636784.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


All the remaining references are trivially removed since we've
just eliminated the final reference to sparc_cpu_model from
assembler code in commit b7d96ce189564e661909fbf8df39d7358149885b
("sparc32: Remove sparc_cpu_model read from floppy interrupt handler.")

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cpu_type.h    |   16 +++++++---------
 arch/sparc/include/asm/shmparam_32.h |    4 +---
 arch/sparc/kernel/auxio_32.c         |   13 +++----------
 arch/sparc/kernel/setup_32.c         |   10 ----------
 arch/sparc/kernel/smp_32.c           |   24 ------------------------
 5 files changed, 11 insertions(+), 56 deletions(-)

diff --git a/arch/sparc/include/asm/cpu_type.h b/arch/sparc/include/asm/cpu_type.h
index 73a44dd..84d7d83 100644
--- a/arch/sparc/include/asm/cpu_type.h
+++ b/arch/sparc/include/asm/cpu_type.h
@@ -5,15 +5,13 @@
  * Sparc (general) CPU types
  */
 enum sparc_cpu {
-  sun4        = 0x00,
-  sun4c       = 0x01,
-  sun4m       = 0x02,
-  sun4d       = 0x03,
-  sun4e       = 0x04,
-  sun4u       = 0x05, /* V8 ploos ploos */
-  sun_unknown = 0x06,
-  ap1000      = 0x07, /* almost a sun4m */
-  sparc_leon  = 0x08, /* Leon SoC */
+  sun4m       = 0x00,
+  sun4d       = 0x01,
+  sun4e       = 0x02,
+  sun4u       = 0x03, /* V8 ploos ploos */
+  sun_unknown = 0x04,
+  ap1000      = 0x05, /* almost a sun4m */
+  sparc_leon  = 0x06, /* Leon SoC */
 };
 
 #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/include/asm/shmparam_32.h b/arch/sparc/include/asm/shmparam_32.h
index 59a1243..142825c 100644
--- a/arch/sparc/include/asm/shmparam_32.h
+++ b/arch/sparc/include/asm/shmparam_32.h
@@ -4,8 +4,6 @@
 #define __ARCH_FORCE_SHMLBA 	1
 
 extern int vac_cache_size;
-#define SHMLBA (vac_cache_size ? vac_cache_size : \
-		(sparc_cpu_model = sun4c ? (64 * 1024) : \
-		 (sparc_cpu_model = sun4 ? (128 * 1024) : PAGE_SIZE)))
+#define SHMLBA (vac_cache_size ? vac_cache_size : PAGE_SIZE)
 
 #endif /* _ASMSPARC_SHMPARAM_H */
diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index 56d0f52..e20cc55 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -32,7 +32,6 @@ void __init auxio_probe(void)
 	switch (sparc_cpu_model) {
 	case sparc_leon:
 	case sun4d:
-	case sun4:
 		return;
 	default:
 		break;
@@ -65,9 +64,8 @@ void __init auxio_probe(void)
 	r.start = auxregs[0].phys_addr;
 	r.end = auxregs[0].phys_addr + auxregs[0].reg_size - 1;
 	auxio_register = of_ioremap(&r, 0, auxregs[0].reg_size, "auxio");
-	/* Fix the address on sun4m and sun4c. */
-	if((((unsigned long) auxregs[0].phys_addr) & 3) = 3 ||
-	   sparc_cpu_model = sun4c)
+	/* Fix the address on sun4m. */
+	if ((((unsigned long) auxregs[0].phys_addr) & 3) = 3)
 		auxio_register += (3 - ((unsigned long)auxio_register & 3));
 
 	set_auxio(AUXIO_LED, 0);
@@ -86,12 +84,7 @@ void set_auxio(unsigned char bits_on, unsigned char bits_off)
 	unsigned char regval;
 	unsigned long flags;
 	spin_lock_irqsave(&auxio_lock, flags);
-	switch(sparc_cpu_model) {
-	case sun4c:
-		regval = sbus_readb(auxio_register);
-		sbus_writeb(((regval | bits_on) & ~bits_off) | AUXIO_ORMEIN,
-			auxio_register);
-		break;
+	switch (sparc_cpu_model) {
 	case sun4m:
 		if(!auxio_register)
 			break;     /* VME chassis sun4m, no auxio. */
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 3970a78..6f294f3 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -217,10 +217,6 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
-	if (!strcmp(&cputypval[0], "sun4 "))
-		sparc_cpu_model = sun4;
-	if (!strcmp(&cputypval[0], "sun4c"))
-		sparc_cpu_model = sun4c;
 	if (!strcmp(&cputypval[0], "sun4m"))
 		sparc_cpu_model = sun4m;
 	if (!strcmp(&cputypval[0], "sun4s"))
@@ -236,12 +232,6 @@ void __init setup_arch(char **cmdline_p)
 
 	printk("ARCH: ");
 	switch(sparc_cpu_model) {
-	case sun4:
-		printk("SUN4\n");
-		break;
-	case sun4c:
-		printk("SUN4C\n");
-		break;
 	case sun4m:
 		printk("SUN4M\n");
 		break;
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 569a8a9..7c11439 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -85,14 +85,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 		(bogosum/(5000/HZ))%100);
 
 	switch(sparc_cpu_model) {
-	case sun4:
-		printk("SUN4\n");
-		BUG();
-		break;
-	case sun4c:
-		printk("SUN4C\n");
-		BUG();
-		break;
 	case sun4m:
 		smp4m_smp_done();
 		break;
@@ -326,14 +318,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	smp_store_cpu_info(boot_cpu_id);
 
 	switch(sparc_cpu_model) {
-	case sun4:
-		printk("SUN4\n");
-		BUG();
-		break;
-	case sun4c:
-		printk("SUN4C\n");
-		BUG();
-		break;
 	case sun4m:
 		smp4m_boot_cpus();
 		break;
@@ -399,14 +383,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	int ret=0;
 
 	switch(sparc_cpu_model) {
-	case sun4:
-		printk("SUN4\n");
-		BUG();
-		break;
-	case sun4c:
-		printk("SUN4C\n");
-		BUG();
-		break;
 	case sun4m:
 		ret = smp4m_boot_one_cpu(cpu);
 		break;
-- 
1.7.10

