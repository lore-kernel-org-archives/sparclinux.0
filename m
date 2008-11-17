From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 18:34:13 +0000
Subject: CONFIG_SUN_AUXIO no longer needed
Message-Id: <20081117183413.GA29770@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While looking at sparc/kernel/MAkefile I noticed
that CONFIG_SUN_AUXIO was used to determine if auxio.o was
included in the link or not.

But in the Kconfig we have:

config SUN_AUXIO
	bool
	default y

So SUN_AUXIO is always enabled and it can be killed.
Following patch does this but serves as example only.
If it can be killed I will take care after the merge
of sparc and sparc64 has finished.

Did I miss something obvious or is it just something
awaiting cleaning up?

	Sam


diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index ad656b0..b171ae8 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -133,14 +133,12 @@ void __init device_scan(void)
 #endif /* !CONFIG_SMP */
 
 	cpu_probe();
-#ifdef CONFIG_SUN_AUXIO
 	{
 		extern void auxio_probe(void);
 		extern void auxio_power_probe(void);
 		auxio_probe();
 		auxio_power_probe();
 	}
-#endif
 	clock_stop_probe();
 
 	if (ARCH_SUN4C)
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index e8c43ff..69d9315 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -168,11 +168,9 @@ void machine_restart(char * cmd)
 
 void machine_power_off(void)
 {
-#ifdef CONFIG_SUN_AUXIO
 	if (auxio_power_register &&
 	    (strcmp(of_console_device->type, "serial") || scons_pwroff))
 		*auxio_power_register |= AUXIO_POWER_OFF;
-#endif
 	machine_halt();
 }
 
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index b0dfff8..3c80562 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -122,10 +122,8 @@ EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(rtc_lock);
-#ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(set_auxio);
 EXPORT_SYMBOL(get_auxio);
-#endif
 EXPORT_SYMBOL(io_remap_pfn_range);
 
 #ifndef CONFIG_SMP
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index fe65aee..6b0c490 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -240,9 +240,7 @@ void sun4c_complete_all_stores(void)
 
 	_unused = sun4c_get_context();
 	sun4c_set_context(_unused);
-#ifdef CONFIG_SUN_AUXIO
 	_unused = get_auxio();
-#endif
 }
 
 /* Bootup utility functions. */
diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
index 49b5057..cf6c3f6 100644
--- a/arch/sparc/prom/misc_32.c
+++ b/arch/sparc/prom/misc_32.c
@@ -61,9 +61,7 @@ prom_cmdline(void)
 	restore_current();
 	install_linux_ticker();
 	spin_unlock_irqrestore(&prom_lock, flags);
-#ifdef CONFIG_SUN_AUXIO
 	set_auxio(AUXIO_LED, 0);
-#endif
 }
 
 /* Drop into the prom, but completely terminate the program.
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 30bba8b..6736357 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -148,10 +148,8 @@ EXPORT_SYMBOL(flush_dcache_page);
 EXPORT_SYMBOL(__flush_dcache_range);
 #endif
 
-#ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(auxio_set_led);
 EXPORT_SYMBOL(auxio_set_lte);
-#endif
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_set_sbus64);
 #endif
