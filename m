From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:08 +0000
Subject: [PATCH 05/14] sparc32: remove all uses of ARCH_SUN4C
Message-Id: <1336772117-1539-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/cpu_type.h |    4 ----
 arch/sparc/include/asm/elf_32.h   |    5 ++---
 arch/sparc/kernel/process_32.c    |   32 --------------------------------
 arch/sparc/kernel/sys_sparc_32.c  |   11 -----------
 arch/sparc/mm/btfixup.c           |   15 +++++----------
 arch/sparc/mm/fault_32.c          |    2 +-
 6 files changed, 8 insertions(+), 61 deletions(-)

diff --git a/arch/sparc/include/asm/cpu_type.h b/arch/sparc/include/asm/cpu_type.h
index 4ca184d..73a44dd 100644
--- a/arch/sparc/include/asm/cpu_type.h
+++ b/arch/sparc/include/asm/cpu_type.h
@@ -19,16 +19,12 @@ enum sparc_cpu {
 #ifdef CONFIG_SPARC32
 extern enum sparc_cpu sparc_cpu_model;
 
-#define ARCH_SUN4C (sparc_cpu_model=sun4c)
-
 #define SUN4M_NCPUS            4              /* Architectural limit of sun4m. */
 
 #else
 
 #define sparc_cpu_model sun4u
 
-/* This cannot ever be a sun4c :) That's just history. */
-#define ARCH_SUN4C 0
 #endif
 
 #endif /* __ASM_CPU_TYPE_H */
diff --git a/arch/sparc/include/asm/elf_32.h b/arch/sparc/include/asm/elf_32.h
index 4269ca6..b5beb11 100644
--- a/arch/sparc/include/asm/elf_32.h
+++ b/arch/sparc/include/asm/elf_32.h
@@ -118,11 +118,10 @@ typedef struct {
    instruction set this cpu supports.  This can NOT be done in userspace
    on Sparc.  */
 
-/* Sun4c has none of the capabilities, most sun4m's have them all.
+/* Most sun4m's have them all.
  * XXX This is gross, set some global variable at boot time. -DaveM
  */
-#define ELF_HWCAP	((ARCH_SUN4C) ? 0 : \
-			 (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | \
+#define ELF_HWCAP	((HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | \
 			  HWCAP_SPARC_SWAP | \
 			  ((srmmu_modtype != Cypress && \
 			    srmmu_modtype != Cypress_vE && \
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index de81e21..d8e973d 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -67,8 +67,6 @@ struct thread_info *current_set[NR_CPUS];
 
 #ifndef CONFIG_SMP
 
-#define SUN4C_FAULT_HIGH 100
-
 /*
  * the idle loop on a Sparc... ;)
  */
@@ -76,36 +74,6 @@ void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	for (;;) {
-		if (ARCH_SUN4C) {
-			static int count = HZ;
-			static unsigned long last_jiffies;
-			static unsigned long last_faults;
-			static unsigned long fps;
-			unsigned long now;
-			unsigned long faults;
-
-			extern unsigned long sun4c_kernel_faults;
-			extern void sun4c_grow_kernel_ring(void);
-
-			local_irq_disable();
-			now = jiffies;
-			count -= (now - last_jiffies);
-			last_jiffies = now;
-			if (count < 0) {
-				count += HZ;
-				faults = sun4c_kernel_faults;
-				fps = (fps + (faults - last_faults)) >> 1;
-				last_faults = faults;
-#if 0
-				printk("kernel faults / second = %ld\n", fps);
-#endif
-				if (fps >= SUN4C_FAULT_HIGH) {
-					/*sun4c_grow_kernel_ring();*/
-				}
-			}
-			local_irq_enable();
-		}
-
 		if (pm_idle) {
 			while (!need_resched())
 				(*pm_idle)();
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 42b282f..627e89a 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -53,8 +53,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	/* See asm-sparc/uaccess.h */
 	if (len > TASK_SIZE - PAGE_SIZE)
 		return -ENOMEM;
-	if (ARCH_SUN4C && len > 0x20000000)
-		return -ENOMEM;
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 
@@ -65,10 +63,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (ARCH_SUN4C && addr < 0xe0000000 && 0x20000000 - len < addr) {
-			addr = PAGE_OFFSET;
-			vmm = find_vma(current->mm, PAGE_OFFSET);
-		}
 		if (TASK_SIZE - PAGE_SIZE - len < addr)
 			return -ENOMEM;
 		if (!vmm || addr + len <= vmm->vm_start)
@@ -99,11 +93,6 @@ out:
 
 int sparc_mmap_check(unsigned long addr, unsigned long len)
 {
-	if (ARCH_SUN4C &&
-	    (len > 0x20000000 ||
-	     (addr < 0xe0000000 && addr + len > 0x20000000)))
-		return -EINVAL;
-
 	/* See asm-sparc/uaccess.h */
 	if (len > TASK_SIZE - PAGE_SIZE || addr + len > TASK_SIZE - PAGE_SIZE)
 		return -EINVAL;
diff --git a/arch/sparc/mm/btfixup.c b/arch/sparc/mm/btfixup.c
index 09d6af2..1b7aa56 100644
--- a/arch/sparc/mm/btfixup.c
+++ b/arch/sparc/mm/btfixup.c
@@ -19,7 +19,6 @@
 
 extern char *srmmu_name;
 static char version[] __initdata = "Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for ";
-static char str_sun4c[] __initdata = "sun4c\n";
 static char str_srmmu[] __initdata = "srmmu[%s]/";
 static char str_iommu[] __initdata = "iommu\n";
 static char str_iounit[] __initdata = "io-unit\n";
@@ -81,15 +80,11 @@ void __init btfixup(void)
 	if (!visited) {
 		visited++;
 		printk(version);
-		if (ARCH_SUN4C)
-			printk(str_sun4c);
-		else {
-			printk(str_srmmu, srmmu_name);
-			if (sparc_cpu_model = sun4d)
-				printk(str_iounit);
-			else
-				printk(str_iommu);
-		}
+		printk(str_srmmu, srmmu_name);
+		if (sparc_cpu_model = sun4d)
+			printk(str_iounit);
+		else
+			printk(str_iommu);
 	}
 	for (p = ___btfixup_start; p < ___btfixup_end; ) {
 		count = p[2];
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 7348121..a0f4db9 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -235,7 +235,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * nothing more.
 	 */
 	code = SEGV_MAPERR;
-	if (!ARCH_SUN4C && address >= TASK_SIZE)
+	if (address >= TASK_SIZE)
 		goto vmalloc_fault;
 
 	/*
-- 
1.6.0.6

