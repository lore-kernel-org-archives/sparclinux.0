From: David Miller <davem@davemloft.net>
Date: Wed, 07 Mar 2007 23:05:06 +0000
Subject: Re: Sunfire v880
Message-Id: <20070307.150506.28789569.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Wed, 7 Mar 2007 17:55:31 -0500

>  I built 2.6.20.1 and tried to netboot it.  I got the same thing
> "booting linux..." then nothing.  adding -p did not provide any
> additional output.

This sucks, I wish I had one of these machines so I could
keep them from breaking as these kinds of bugs are nearly
impossible to fix remotely in a sane manner.

Hohum... let's try to see where it dies, add this patch and
reboot with "-p" again, thanks.  BTW, you also could certainly
add tracing printk() statements like this too in order to help
narrow down where it dies.  This is just debugging monkey work.

Also, if you can, please get me "/usr/sbin/prtconf -pv" output
from this computer, thanks.

diff --git a/arch/sparc64/kernel/devices.c b/arch/sparc64/kernel/devices.c
index ec10f7e..cdf8fdc 100644
--- a/arch/sparc64/kernel/devices.c
+++ b/arch/sparc64/kernel/devices.c
@@ -138,6 +138,7 @@ void __init device_scan(void)
 	prom_printf("Booting Linux...\n");
 
 #ifndef CONFIG_SMP
+	printk("not-SMP: init clock_tick et al.\n");
 	{
 		struct device_node *dp;
 		int err, def;
@@ -190,7 +191,10 @@ void __init device_scan(void)
 	}
 #endif
 
+	printk("central_probe()\n");
+
 	central_probe();
 
+	printk("cpu_probe()\n");
 	cpu_probe();
 }
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index bf033b3..fb1eb62 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -368,6 +368,7 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	printk("smp_setup_cpu_possible_map()\n");
 	smp_setup_cpu_possible_map();
 }
 
diff --git a/init/main.c b/init/main.c
index 8b4a7d7..acade66 100644
--- a/init/main.c
+++ b/init/main.c
@@ -508,8 +508,11 @@ asmlinkage void __init start_kernel(void)
 	printk(KERN_NOTICE);
 	printk(linux_banner);
 	setup_arch(&command_line);
+	printk("unwind_setup()\n");
 	unwind_setup();
+	printk("setup_per_cpu_areas()\n");
 	setup_per_cpu_areas();
+	printk("smp_prepare_boot_cpu()\n");
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 
 	/*
@@ -517,13 +520,17 @@ asmlinkage void __init start_kernel(void)
 	 * timer interrupt). Full topology setup happens at smp_init()
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
+	printk("sched_init()\n");
 	sched_init();
 	/*
 	 * Disable preemption - early bootup scheduling is extremely
 	 * fragile until we cpu_idle() for the first time.
 	 */
+	printk("preempt_disable()\n");
 	preempt_disable();
+	printk("build_all_zonelists()\n");
 	build_all_zonelists();
+	printk("page_alloc_init()\n");
 	page_alloc_init();
 	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
 	parse_early_param();
