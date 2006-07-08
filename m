From: Bob Breuer <breuerr@mc.net>
Date: Sat, 08 Jul 2006 23:10:49 +0000
Subject: Re: sparc-2.6.git sparc32
Message-Id: <44B03B79.3000703@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070805090905040906000906"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607081238470.30008-200000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607081238470.30008-200000@coalcreekmill.cm.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070805090905040906000906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Raymond Burns wrote:
> Hi
> 
> Working with a June 29th pull of davem's tree I found a sequence of
> events which poses a problem causing BUG and then Oops.
> 
> This impacts platforms with the mostek clock 
> 
> kernel/main.c calls out time_init() which ultimatly leads to a call
> of clock_init() which calls of_register_driver() for the mostek clock.
> 
> This occurs prior to the kobject, klist and friends being initialized
> which occurs as postcore_initcall(of_bus_driver_init), This leads to
> the BUGs and oops.
> 
> The clock initialization is needed prior to local_irq_enable
> 
> I have not found reasons for the postcore_initcall calls timing but
> assume they're concrete for other platforms.
> 
> I have not found a work around.

I'm seeing the same thing.

Based on sparc64, it should be possible to defer the initialization of
the mostek clock until later.

The attached patch gets me past the clock driver, but it ends up with a
watchdog reset after switching to malloc:

  io scheduler cfq registered (default)
  ioremap: done with statics, switching to malloc

  Watchdog Reset
  Type  help  for more information
  <#0> ok

Bob

--------------070805090905040906000906
Content-Type: text/plain;
 name="sparc32-delayed-clock_init.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-delayed-clock_init.txt"

diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 04eb1ea..845081b 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -225,6 +225,32 @@ static __inline__ int has_low_battery(vo
 	return (data1 == data2);	/* Was the write blocked? */
 }
 
+static void __init mostek_set_system_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+	struct mostek48t02 *mregs;
+
+	mregs = (struct mostek48t02 *)mstk48t02_regs;
+	if(!mregs) {
+		prom_printf("Something wrong, clock regs not mapped yet.\n");
+		prom_halt();
+	}		
+	spin_lock_irq(&mostek_lock);
+	mregs->creg |= MSTK_CREG_READ;
+	sec = MSTK_REG_SEC(mregs);
+	min = MSTK_REG_MIN(mregs);
+	hour = MSTK_REG_HOUR(mregs);
+	day = MSTK_REG_DOM(mregs);
+	mon = MSTK_REG_MONTH(mregs);
+	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
+	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
+	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+        set_normalized_timespec(&wall_to_monotonic,
+                                -xtime.tv_sec, -xtime.tv_nsec);
+	mregs->creg &= ~MSTK_CREG_READ;
+	spin_unlock_irq(&mostek_lock);
+}
+
 /* Probe for the real time clock chip on Sun4 */
 static __inline__ void sun4_clock_probe(void)
 {
@@ -273,6 +299,7 @@ #ifdef CONFIG_SUN4
 #endif
 }
 
+#ifndef CONFIG_SUN4
 static int __devinit clock_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
@@ -307,6 +334,8 @@ static int __devinit clock_probe(struct 
 	if (mostek_read(mstk48t02_regs + MOSTEK_SEC) & MSTK_STOP)
 		kick_start_clock();
 
+	mostek_set_system_time();
+
 	return 0;
 }
 
@@ -325,56 +354,37 @@ static struct of_platform_driver clock_d
 
 
 /* Probe for the mostek real time clock chip. */
-static void clock_init(void)
+static int __init clock_init(void)
 {
-	of_register_driver(&clock_driver, &of_bus_type);
+	return of_register_driver(&clock_driver, &of_bus_type);
 }
 
+/* Must be after subsys_initcall() so that busses are probed.  Must
+ * be before device_initcall() because things like the RTC driver
+ * need to see the clock registers.
+ */
+fs_initcall(clock_init);
+#endif /* !CONFIG_SUN4 */
+
 void __init sbus_time_init(void)
 {
-	unsigned int year, mon, day, hour, min, sec;
-	struct mostek48t02 *mregs;
-
-#ifdef CONFIG_SUN4
-	int temp;
-	struct intersil *iregs;
-#endif
 
 	BTFIXUPSET_CALL(bus_do_settimeofday, sbus_do_settimeofday, BTFIXUPCALL_NORM);
 	btfixup();
 
 	if (ARCH_SUN4)
 		sun4_clock_probe();
-	else
-		clock_init();
 
 	sparc_init_timers(timer_interrupt);
 	
 #ifdef CONFIG_SUN4
 	if(idprom->id_machtype == (SM_SUN4 | SM_4_330)) {
-#endif
-	mregs = (struct mostek48t02 *)mstk48t02_regs;
-	if(!mregs) {
-		prom_printf("Something wrong, clock regs not mapped yet.\n");
-		prom_halt();
-	}		
-	spin_lock_irq(&mostek_lock);
-	mregs->creg |= MSTK_CREG_READ;
-	sec = MSTK_REG_SEC(mregs);
-	min = MSTK_REG_MIN(mregs);
-	hour = MSTK_REG_HOUR(mregs);
-	day = MSTK_REG_DOM(mregs);
-	mon = MSTK_REG_MONTH(mregs);
-	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-        set_normalized_timespec(&wall_to_monotonic,
-                                -xtime.tv_sec, -xtime.tv_nsec);
-	mregs->creg &= ~MSTK_CREG_READ;
-	spin_unlock_irq(&mostek_lock);
-#ifdef CONFIG_SUN4
+		mostek_set_system_time();
 	} else if(idprom->id_machtype == (SM_SUN4 | SM_4_260) ) {
 		/* initialise the intersil on sun4 */
+		unsigned int year, mon, day, hour, min, sec;
+		int temp;
+		struct intersil *iregs;
 
 		iregs=intersil_clock;
 		if(!iregs) {

--------------070805090905040906000906--
