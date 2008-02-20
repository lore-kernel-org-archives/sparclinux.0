From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Feb 2008 21:50:20 +0000
Subject: sparc64 section mismatch warnings
Message-Id: <20080220215020.GA22031@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

I was looking into the few remaining section mismatch
warnings on sparc64 (with my previous posted patchset applied).

This is more an RFC than a real patch submission.
Can you try to look through my mumblings and see if anything makes sense.


The ones I have is:
WARNING: vmlinux.o(.text+0x3d76c): Section mismatch in reference from the variable after_lock_tlb to the function .cpuinit.text:sun4v_register_mondo_queues()
The function after_lock_tlb() references
the function __cpuinit sun4v_register_mondo_queues().
This is often because after_lock_tlb lacks a __cpuinit
annotation or the annotation of sun4v_register_mondo_queues is wrong.

WARNING: vmlinux.o(.text+0x3d88c): Section mismatch in reference from the variable after_lock_tlb to the function .devinit.text:smp_callin()
The function after_lock_tlb() references
the function __devinit smp_callin().
This is often because after_lock_tlb lacks a __devinit
annotation or the annotation of smp_callin is wrong.

This is due to the calls to smp_callin and sun4v_register_mondo_queues in trampoline.S
after_lock_tlb is blamed because this is the first symbol modpost could find.

I assume this code is executed only once for non HOTPLUG_CPU cases and
for HOTPLUG_CPU cases when a CPU is brought online.
So it should be __cpuinit code.

Like this:
diff --git a/arch/sparc64/kernel/trampoline.S b/arch/sparc64/kernel/trampoline.S
index 04e81dd..7cd4636 100644
--- a/arch/sparc64/kernel/trampoline.S
+++ b/arch/sparc64/kernel/trampoline.S
@@ -36,7 +36,7 @@ dtlb_load:
 tramp_stack:
 	.skip	TRAMP_STACK_SIZE
 
-	.text
+	__CPUINIT
 	.align		8
 	.globl		sparc64_cpu_startup, sparc64_cpu_startup_end
 sparc64_cpu_startup:

That would match the declaration of sun4v_register_mondo_queues but not
smp_callin. Looking at the code (not claiming I understand it
I guess it should be __cpuinit as this is again only executed
after init in HOTPLUG_CPU cases.
So something like this:

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index a8052b7..cc45473 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -86,7 +86,7 @@ extern void setup_sparc64_timer(void);
 
 static volatile unsigned long callin_flag = 0;
 
-void __devinit smp_callin(void)
+void __cpuinit smp_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
 

WARNING: vmlinux.o(.text+0x3d9ac): Section mismatch in reference from the variable hv_cpu_startup to the function .cpuinit.text:sun4v_register_mondo_queues()
The function hv_cpu_startup() references
the function __cpuinit sun4v_register_mondo_queues().
This is often because hv_cpu_startup lacks a __cpuinit
annotation or the annotation of sun4v_register_mondo_queues is wrong.

WARNING: vmlinux.o(.text+0x3d9c0): Section mismatch in reference from the variable hv_cpu_startup to the function .devinit.text:smp_callin()
The function hv_cpu_startup() references
the function __devinit smp_callin().
This is often because hv_cpu_startup lacks a __devinit
annotation or the annotation of smp_callin is wrong.

Same story as above - so something like this:

diff --git a/arch/sparc64/kernel/hvtramp.S b/arch/sparc64/kernel/hvtramp.S
index b692e04..014fb45 100644
--- a/arch/sparc64/kernel/hvtramp.S
+++ b/arch/sparc64/kernel/hvtramp.S
@@ -13,7 +13,7 @@
 #include <asm/head.h>
 #include <asm/asi.h>
 
-	.text
+	__CPUINIT
 	.align		8
 	.globl		hv_cpu_startup, hv_cpu_startup_end
 


WARNING: vmlinux.o(.text+0x47094): Section mismatch in reference from the function dr_cpu_data() to the function .devinit.text:mdesc_fill_in_cpu_data()
The function dr_cpu_data() references
the function __devinit mdesc_fill_in_cpu_data().
This is often because dr_cpu_data lacks a __devinit
annotation or the annotation of mdesc_fill_in_cpu_data is wrong.

I could not see how to fix this in a clean way.
dr_cpu_data() references mdesc_fill_in_cpu_data() via dr_cpu_configure()
and that looks bogus.

Full diff of the included changes below.

If you can use this in part or in toal they have my:
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>


	Sam

diff --git a/arch/sparc64/kernel/hvtramp.S b/arch/sparc64/kernel/hvtramp.S
index b692e04..0236c43 100644
--- a/arch/sparc64/kernel/hvtramp.S
+++ b/arch/sparc64/kernel/hvtramp.S
@@ -3,6 +3,8 @@
  * Copyright (C) 2007 David S. Miller <davem@davemloft.net>
  */
 
+#include <linux/init.h>
+
 #include <asm/thread_info.h>
 #include <asm/hypervisor.h>
 #include <asm/scratchpad.h>
@@ -13,7 +15,7 @@
 #include <asm/head.h>
 #include <asm/asi.h>
 
-	.text
+	__CPUINIT
 	.align		8
 	.globl		hv_cpu_startup, hv_cpu_startup_end
 
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index a8052b7..cc45473 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -86,7 +86,7 @@ extern void setup_sparc64_timer(void);
 
 static volatile unsigned long callin_flag = 0;
 
-void __devinit smp_callin(void)
+void __cpuinit smp_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
 
diff --git a/arch/sparc64/kernel/trampoline.S b/arch/sparc64/kernel/trampoline.S
index 04e81dd..4ae2e52 100644
--- a/arch/sparc64/kernel/trampoline.S
+++ b/arch/sparc64/kernel/trampoline.S
@@ -4,6 +4,8 @@
  * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/init.h>
+
 #include <asm/head.h>
 #include <asm/asi.h>
 #include <asm/lsu.h>
@@ -36,7 +38,7 @@ dtlb_load:
 tramp_stack:
 	.skip	TRAMP_STACK_SIZE
 
-	.text
+	__CPUINIT
 	.align		8
 	.globl		sparc64_cpu_startup, sparc64_cpu_startup_end
 sparc64_cpu_startup:
