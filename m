From: Eric Brower <ebrower@usa.net>
Date: Wed, 31 Mar 2004 22:32:11 +0000
Subject: Re: E250 LED indicators
Message-Id: <406B46EB.4030408@usa.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040308020606060601080204"
List-Id: <sparclinux.vger.kernel.org>
References: <406B2256.6000308@usa.net>
In-Reply-To: <406B2256.6000308@usa.net>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308020606060601080204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


David S. Miller wrote:
> On Wed, 31 Mar 2004 11:56:06 -0800
> Eric Brower <ebrower@usa.net> wrote:
> 
> 
>>DaveM-- I'll float you a sysctl 
>>patch for sparc64 and sparc if you'd consider it and find the current 
>>"protection" valuable, otherwise perhaps machine_power_off should 
>>actually power-off, machine_halt should halt and userspace commands 
>>should get smarter about whether they ask the system to halt or 
>>power-off.
> 
> 
> Ok, I'll check it out.

Attached, but a bit dated and against 2.4.x;  let me know what you 
think, concept-wise.

My preference would be for the kernel to always do as asked, and let the 
userspace tools provide the proper sys_reboot args (i.e. 
LINUX_REBOOT_CMD_HALT goes to OBP, LINUX_REBOOT_CMD_POWER_OFF goes to 
OBP).  I may have missed some subtlety, but it seems better to handle 
this outside of machine_power_off, as a driver MIGHT wish to call that 
directly under thermal failure scenarios, etc.

E



--------------040308020606060601080204
Content-Type: text/plain;
 name="scons_sysctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scons_sysctl.patch"

===== arch/sparc/kernel/process.c 1.12 vs edited =====
--- 1.12/arch/sparc/kernel/process.c	Wed Apr 30 01:15:11 2003
+++ edited/arch/sparc/kernel/process.c	Thu May 15 06:49:37 2003
@@ -54,6 +54,12 @@
  */
 void (*pm_power_off)(void);
 
+/*
+ * sysctl - toggle power-off restriction for serial console 
+ * systems in machine_power_off()
+ */
+int scons_pwroff = 1;
+
 extern void fpsave(unsigned long *, unsigned long *, void *, unsigned long *);
 
 struct task_struct *last_task_used_math = NULL;
@@ -189,7 +195,7 @@
 void machine_power_off(void)
 {
 #ifdef CONFIG_SUN_AUXIO
-	if (auxio_power_register && !serial_console)
+	if (auxio_power_register && (!serial_console || scons_pwroff))
 		*auxio_power_register |= AUXIO_POWER_OFF;
 #endif
 	machine_halt();
===== arch/sparc64/kernel/power.c 1.7 vs edited =====
--- 1.7/arch/sparc64/kernel/power.c	Tue May  6 07:32:38 2003
+++ edited/arch/sparc64/kernel/power.c	Thu May 15 06:49:04 2003
@@ -17,6 +17,12 @@
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 
+/*
+ * sysctl - toggle power-off restriction for serial console 
+ * systems in machine_power_off()
+ */
+int scons_pwroff = 1; 
+
 #ifdef CONFIG_PCI
 static unsigned long power_reg = 0UL;
 
@@ -40,7 +46,7 @@
 
 void machine_power_off(void)
 {
-	if (!serial_console) {
+	if (!serial_console || scons_pwroff) {
 #ifdef CONFIG_PCI
 		if (power_reg != 0UL) {
 			/* Both register bits seem to have the
===== include/linux/sysctl.h 1.24 vs edited =====
--- 1.24/include/linux/sysctl.h	Wed May 28 00:49:28 2003
+++ edited/include/linux/sysctl.h	Thu May 15 05:31:22 2003
@@ -125,6 +125,7 @@
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
  	KERN_CORE_PATTERN=56,	/* string: pattern for core-files */
+	KERN_SPARC_SCONS_PWROFF=57, /* int: serial console power-off halt */
 };
 
 
===== kernel/sysctl.c 1.19 vs edited =====
--- 1.19/kernel/sysctl.c	Fri Nov 29 13:50:48 2002
+++ edited/kernel/sysctl.c	Wed May 14 06:37:52 2003
@@ -78,6 +78,7 @@
 #ifdef __sparc__
 extern char reboot_command [];
 extern int stop_a_enabled;
+extern int scons_pwroff;
 #endif
 
 #ifdef CONFIG_ARCH_S390
@@ -186,6 +187,8 @@
 	{KERN_SPARC_REBOOT, "reboot-cmd", reboot_command,
 	 256, 0644, NULL, &proc_dostring, &sysctl_string },
 	{KERN_SPARC_STOP_A, "stop-a", &stop_a_enabled, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_SPARC_SCONS_PWROFF, "scons-poweroff", &scons_pwroff, sizeof (int),
 	 0644, NULL, &proc_dointvec},
 #endif
 #ifdef CONFIG_PPC32

--------------040308020606060601080204--

