From: Don Zickus <dzickus@redhat.com>
Date: Thu, 18 May 2017 16:30:28 +0000
Subject: Re: [RFC] arch hardlockup detector interfaces improvement
Message-Id: <20170518163028.tf2llimuo4l4l5nv@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170518155026.23799-1-npiggin@gmail.com>
In-Reply-To: <20170518155026.23799-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-am33-list@redhat.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, uobergfe@redhat.com

(adding Uli)

On Fri, May 19, 2017 at 01:50:26AM +1000, Nicholas Piggin wrote:
> I'd like to make it easier for architectures that have their own NMI /
> hard lockup detector to reuse various configuration interfaces that are
> provided by generic detectors (cmdline, sysctl, suspend/resume calls).
> 
> I'd also like to remove the dependency of arch hard lockup detectors
> on the softlockup detector. The reason being these watchdogs can be
> very small (sparc's is like a page of core code that does not use any
> big subsystem like kthreads or timers).
> 
> So I do this by adding a separate CONFIG_SOFTLOCKUP_DETECTOR, and
> juggling around what goes under config options. HAVE_NMI_WATCHDOG
> continues to be the config for arch to override the hard lockup
> detector, which is expanded to cover a few more cases.

Basically you are trying to remove the heavy HARDLOCKUP pieces to minimize
the SOFTLOCKUP piece and use your own NMI detector, right?

I am guessing you would then disable SOFTLOCKUP to remove all the kthread
and timer stuff but continue to use the generic infrastructure to help
manager your own NMI detector?


A lot of the code is just re-organizing things and adding an explicit
ifdef on SOFTLOCKUP, which seems fine to me.

I just need to spend some time on some of your #else clauses to see what
functionality is dropped when you use your approach.

Cheers,
Don

> 
> These config options are pretty ugly, but they already were. I don't
> think they've become a lot worse after this.
> 
> Architectures can then use watchdog_nmi_reconfigure() which gets
> called every time something changes (sysctls, suspend/resume, etc) and
> adjust according to relevant parameters (watchdog_enabled,
> watchdog_thresh, watchdog_cpumask, watchdog_suspended).
> 
> I have something for powerpc but I want to make sure this generic code
> change is reasonable and could work for other archs.
> 
> Thanks,
> Nick
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index aa3cd0878270..5c2265f84fa3 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -8,16 +8,25 @@
>  #include <asm/irq.h>
>  
>  #ifdef CONFIG_LOCKUP_DETECTOR
> +void lockup_detector_init(void);
> +#else
> +static inline void lockup_detector_init(void)
> +{
> +}
> +#endif
> +
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +extern int proc_dowatchdog_thresh(struct ctl_table *table, int write,
> +				  void __user *buffer,
> +				  size_t *lenp, loff_t *ppos);
> +
>  extern void touch_softlockup_watchdog_sched(void);
>  extern void touch_softlockup_watchdog(void);
>  extern void touch_softlockup_watchdog_sync(void);
>  extern void touch_all_softlockup_watchdogs(void);
> -extern int proc_dowatchdog_thresh(struct ctl_table *table, int write,
> -				  void __user *buffer,
> -				  size_t *lenp, loff_t *ppos);
>  extern unsigned int  softlockup_panic;
> -extern unsigned int  hardlockup_panic;
> -void lockup_detector_init(void);
> +extern int soft_watchdog_enabled;
> +extern atomic_t watchdog_park_in_progress;
>  #else
>  static inline void touch_softlockup_watchdog_sched(void)
>  {
> @@ -31,9 +40,6 @@ static inline void touch_softlockup_watchdog_sync(void)
>  static inline void touch_all_softlockup_watchdogs(void)
>  {
>  }
> -static inline void lockup_detector_init(void)
> -{
> -}
>  #endif
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK
> @@ -70,17 +76,14 @@ static inline void reset_hung_task_detector(void)
>   */
>  #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
>  #include <asm/nmi.h>
> +extern unsigned int hardlockup_panic;
>  extern void touch_nmi_watchdog(void);
> +extern void hardlockup_detector_disable(void);
>  #else
>  static inline void touch_nmi_watchdog(void)
>  {
>  	touch_softlockup_watchdog();
>  }
> -#endif
> -
> -#if defined(CONFIG_HARDLOCKUP_DETECTOR)
> -extern void hardlockup_detector_disable(void);
> -#else
>  static inline void hardlockup_detector_disable(void) {}
>  #endif
>  
> @@ -139,15 +142,18 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
>  }
>  #endif
>  
> -#ifdef CONFIG_LOCKUP_DETECTOR
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR
>  u64 hw_nmi_get_sample_period(int watchdog_thresh);
> +#endif
> +
> +#ifdef CONFIG_LOCKUP_DETECTOR
>  extern int nmi_watchdog_enabled;
> -extern int soft_watchdog_enabled;
>  extern int watchdog_user_enabled;
>  extern int watchdog_thresh;
>  extern unsigned long watchdog_enabled;
> +extern struct cpumask watchdog_cpumask;
>  extern unsigned long *watchdog_cpumask_bits;
> -extern atomic_t watchdog_park_in_progress;
> +extern int __read_mostly watchdog_suspended;
>  #ifdef CONFIG_SMP
>  extern int sysctl_softlockup_all_cpu_backtrace;
>  extern int sysctl_hardlockup_all_cpu_backtrace;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 4dfba1a76cc3..bb747d8f8521 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -880,6 +880,14 @@ static struct ctl_table kern_table[] = {
>  #endif
>  	},
>  	{
> +		.procname	= "watchdog_cpumask",
> +		.data		= &watchdog_cpumask_bits,
> +		.maxlen		= NR_CPUS,
> +		.mode		= 0644,
> +		.proc_handler	= proc_watchdog_cpumask,
> +	},
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +	{
>  		.procname       = "soft_watchdog",
>  		.data           = &soft_watchdog_enabled,
>  		.maxlen         = sizeof (int),
> @@ -889,13 +897,6 @@ static struct ctl_table kern_table[] = {
>  		.extra2		= &one,
>  	},
>  	{
> -		.procname	= "watchdog_cpumask",
> -		.data		= &watchdog_cpumask_bits,
> -		.maxlen		= NR_CPUS,
> -		.mode		= 0644,
> -		.proc_handler	= proc_watchdog_cpumask,
> -	},
> -	{
>  		.procname	= "softlockup_panic",
>  		.data		= &softlockup_panic,
>  		.maxlen		= sizeof(int),
> @@ -904,7 +905,8 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= &zero,
>  		.extra2		= &one,
>  	},
> -#ifdef CONFIG_HARDLOCKUP_DETECTOR
> +#endif
> +#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
>  	{
>  		.procname	= "hardlockup_panic",
>  		.data		= &hardlockup_panic,
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 03e0b69bb5bf..192125f3f8aa 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -29,15 +29,54 @@
>  #include <linux/kvm_para.h>
>  #include <linux/kthread.h>
>  
> +/* Watchdog configuration */
>  static DEFINE_MUTEX(watchdog_proc_mutex);
>  
>  #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
>  unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
> +int __read_mostly nmi_watchdog_enabled;
> +
> +/* boot commands */
> +/*
> + * Should we panic when a soft-lockup or hard-lockup occurs:
> + */
> +unsigned int __read_mostly hardlockup_panic > +			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
> +/*
> + * We may not want to enable hard lockup detection by default in all cases,
> + * for example when running the kernel as a guest on a hypervisor. In these
> + * cases this function can be called to disable hard lockup detection. This
> + * function should only be executed once by the boot processor before the
> + * kernel command line parameters are parsed, because otherwise it is not
> + * possible to override this in hardlockup_panic_setup().
> + */
> +void hardlockup_detector_disable(void)
> +{
> +	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
> +}
> +
> +static int __init hardlockup_panic_setup(char *str)
> +{
> +	if (!strncmp(str, "panic", 5))
> +		hardlockup_panic = 1;
> +	else if (!strncmp(str, "nopanic", 7))
> +		hardlockup_panic = 0;
> +	else if (!strncmp(str, "0", 1))
> +		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
> +	else if (!strncmp(str, "1", 1))
> +		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
> +	return 1;
> +}
> +__setup("nmi_watchdog=", hardlockup_panic_setup);
> +
>  #else
>  unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
>  #endif
> -int __read_mostly nmi_watchdog_enabled;
> +
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
>  int __read_mostly soft_watchdog_enabled;
> +#endif
> +
>  int __read_mostly watchdog_user_enabled;
>  int __read_mostly watchdog_thresh = 10;
>  
> @@ -45,15 +84,9 @@ int __read_mostly watchdog_thresh = 10;
>  int __read_mostly sysctl_softlockup_all_cpu_backtrace;
>  int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
>  #endif
> -static struct cpumask watchdog_cpumask __read_mostly;
> +struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
>  
> -/* Helper for online, unparked cpus. */
> -#define for_each_watchdog_cpu(cpu) \
> -	for_each_cpu_and((cpu), cpu_online_mask, &watchdog_cpumask)
> -
> -atomic_t watchdog_park_in_progress = ATOMIC_INIT(0);
> -
>  /*
>   * The 'watchdog_running' variable is set to 1 when the watchdog threads
>   * are registered/started and is set to 0 when the watchdog threads are
> @@ -72,7 +105,32 @@ static int __read_mostly watchdog_running;
>   * of 'watchdog_running' cannot change while the watchdog is deactivated
>   * temporarily (see related code in 'proc' handlers).
>   */
> -static int __read_mostly watchdog_suspended;
> +int __read_mostly watchdog_suspended;
> +
> +/*
> + * These functions can be overridden if an architecture implements its
> + * own hardlockup detector.
> + */
> +int __weak watchdog_nmi_enable(unsigned int cpu)
> +{
> +	return 0;
> +}
> +void __weak watchdog_nmi_disable(unsigned int cpu)
> +{
> +}
> +
> +void __weak watchdog_nmi_reconfigure(void)
> +{
> +}
> +
> +
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +
> +/* Helper for online, unparked cpus. */
> +#define for_each_watchdog_cpu(cpu) \
> +	for_each_cpu_and((cpu), cpu_online_mask, &watchdog_cpumask)
> +
> +atomic_t watchdog_park_in_progress = ATOMIC_INIT(0);
>  
>  static u64 __read_mostly sample_period;
>  
> @@ -120,6 +178,7 @@ static int __init softlockup_all_cpu_backtrace_setup(char *str)
>  	return 1;
>  }
>  __setup("softlockup_all_cpu_backtrace=", softlockup_all_cpu_backtrace_setup);
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR
>  static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>  {
>  	sysctl_hardlockup_all_cpu_backtrace > @@ -128,6 +187,7 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>  }
>  __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>  #endif
> +#endif
>  
>  /*
>   * Hard-lockup warnings should be triggered after just a few seconds. Soft-
> @@ -213,18 +273,6 @@ void touch_softlockup_watchdog_sync(void)
>  	__this_cpu_write(watchdog_touch_ts, 0);
>  }
>  
> -/* watchdog detector functions */
> -bool is_hardlockup(void)
> -{
> -	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
> -
> -	if (__this_cpu_read(hrtimer_interrupts_saved) = hrint)
> -		return true;
> -
> -	__this_cpu_write(hrtimer_interrupts_saved, hrint);
> -	return false;
> -}
> -
>  static int is_softlockup(unsigned long touch_ts)
>  {
>  	unsigned long now = get_timestamp();
> @@ -237,21 +285,21 @@ static int is_softlockup(unsigned long touch_ts)
>  	return 0;
>  }
>  
> -static void watchdog_interrupt_count(void)
> +/* watchdog detector functions */
> +bool is_hardlockup(void)
>  {
> -	__this_cpu_inc(hrtimer_interrupts);
> -}
> +	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
>  
> -/*
> - * These two functions are mostly architecture specific
> - * defining them as weak here.
> - */
> -int __weak watchdog_nmi_enable(unsigned int cpu)
> -{
> -	return 0;
> +	if (__this_cpu_read(hrtimer_interrupts_saved) = hrint)
> +		return true;
> +
> +	__this_cpu_write(hrtimer_interrupts_saved, hrint);
> +	return false;
>  }
> -void __weak watchdog_nmi_disable(unsigned int cpu)
> +
> +static void watchdog_interrupt_count(void)
>  {
> +	__this_cpu_inc(hrtimer_interrupts);
>  }
>  
>  static int watchdog_enable_all_cpus(void);
> @@ -502,57 +550,6 @@ static void watchdog_unpark_threads(void)
>  		kthread_unpark(per_cpu(softlockup_watchdog, cpu));
>  }
>  
> -/*
> - * Suspend the hard and soft lockup detector by parking the watchdog threads.
> - */
> -int lockup_detector_suspend(void)
> -{
> -	int ret = 0;
> -
> -	get_online_cpus();
> -	mutex_lock(&watchdog_proc_mutex);
> -	/*
> -	 * Multiple suspend requests can be active in parallel (counted by
> -	 * the 'watchdog_suspended' variable). If the watchdog threads are
> -	 * running, the first caller takes care that they will be parked.
> -	 * The state of 'watchdog_running' cannot change while a suspend
> -	 * request is active (see related code in 'proc' handlers).
> -	 */
> -	if (watchdog_running && !watchdog_suspended)
> -		ret = watchdog_park_threads();
> -
> -	if (ret = 0)
> -		watchdog_suspended++;
> -	else {
> -		watchdog_disable_all_cpus();
> -		pr_err("Failed to suspend lockup detectors, disabled\n");
> -		watchdog_enabled = 0;
> -	}
> -
> -	mutex_unlock(&watchdog_proc_mutex);
> -
> -	return ret;
> -}
> -
> -/*
> - * Resume the hard and soft lockup detector by unparking the watchdog threads.
> - */
> -void lockup_detector_resume(void)
> -{
> -	mutex_lock(&watchdog_proc_mutex);
> -
> -	watchdog_suspended--;
> -	/*
> -	 * The watchdog threads are unparked if they were previously running
> -	 * and if there is no more active suspend request.
> -	 */
> -	if (watchdog_running && !watchdog_suspended)
> -		watchdog_unpark_threads();
> -
> -	mutex_unlock(&watchdog_proc_mutex);
> -	put_online_cpus();
> -}
> -
>  static int update_watchdog_all_cpus(void)
>  {
>  	int ret;
> @@ -604,6 +601,96 @@ static void watchdog_disable_all_cpus(void)
>  	}
>  }
>  
> +static int watchdog_update_cpus(void)
> +{
> +	return smpboot_update_cpumask_percpu_thread(
> +		    &watchdog_threads, &watchdog_cpumask);
> +}
> +
> +#else /* SOFTLOCKUP */
> +static int watchdog_park_threads(void)
> +{
> +	return 0;
> +}
> +
> +static void watchdog_unpark_threads(void)
> +{
> +}
> +
> +static int watchdog_enable_all_cpus(void)
> +{
> +	return 0;
> +}
> +
> +static void watchdog_disable_all_cpus(void)
> +{
> +}
> +
> +static int watchdog_update_cpus(void)
> +{
> +	return 0;
> +}
> +
> +static void set_sample_period(void)
> +{
> +}
> +#endif /* SOFTLOCKUP */
> +
> +/*
> + * Suspend the hard and soft lockup detector by parking the watchdog threads.
> + */
> +int lockup_detector_suspend(void)
> +{
> +	int ret = 0;
> +
> +	get_online_cpus();
> +	mutex_lock(&watchdog_proc_mutex);
> +	/*
> +	 * Multiple suspend requests can be active in parallel (counted by
> +	 * the 'watchdog_suspended' variable). If the watchdog threads are
> +	 * running, the first caller takes care that they will be parked.
> +	 * The state of 'watchdog_running' cannot change while a suspend
> +	 * request is active (see related code in 'proc' handlers).
> +	 */
> +	if (watchdog_running && !watchdog_suspended)
> +		ret = watchdog_park_threads();
> +
> +	if (ret = 0)
> +		watchdog_suspended++;
> +	else {
> +		watchdog_disable_all_cpus();
> +		pr_err("Failed to suspend lockup detectors, disabled\n");
> +		watchdog_enabled = 0;
> +	}
> +
> +	watchdog_nmi_reconfigure();
> +
> +	mutex_unlock(&watchdog_proc_mutex);
> +
> +	return ret;
> +}
> +
> +/*
> + * Resume the hard and soft lockup detector by unparking the watchdog threads.
> + */
> +void lockup_detector_resume(void)
> +{
> +	mutex_lock(&watchdog_proc_mutex);
> +
> +	watchdog_suspended--;
> +	/*
> +	 * The watchdog threads are unparked if they were previously running
> +	 * and if there is no more active suspend request.
> +	 */
> +	if (watchdog_running && !watchdog_suspended)
> +		watchdog_unpark_threads();
> +
> +	watchdog_nmi_reconfigure();
> +
> +	mutex_unlock(&watchdog_proc_mutex);
> +	put_online_cpus();
> +}
> +
>  #ifdef CONFIG_SYSCTL
>  
>  /*
> @@ -625,6 +712,8 @@ static int proc_watchdog_update(void)
>  	else
>  		watchdog_disable_all_cpus();
>  
> +	watchdog_nmi_reconfigure();
> +
>  	return err;
>  
>  }
> @@ -810,10 +899,11 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
>  			 * a temporary cpumask, so we are likely not in a
>  			 * position to do much else to make things better.
>  			 */
> -			if (smpboot_update_cpumask_percpu_thread(
> -				    &watchdog_threads, &watchdog_cpumask) != 0)
> +			if (watchdog_update_cpus() != 0)
>  				pr_err("cpumask update failed\n");
>  		}
> +
> +		watchdog_nmi_reconfigure();
>  	}
>  out:
>  	mutex_unlock(&watchdog_proc_mutex);
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 54a427d1f344..2b328d6c0bc8 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -22,39 +22,7 @@ static DEFINE_PER_CPU(bool, hard_watchdog_warn);
>  static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
>  static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
>  
> -/* boot commands */
> -/*
> - * Should we panic when a soft-lockup or hard-lockup occurs:
> - */
> -unsigned int __read_mostly hardlockup_panic > -			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
>  static unsigned long hardlockup_allcpu_dumped;
> -/*
> - * We may not want to enable hard lockup detection by default in all cases,
> - * for example when running the kernel as a guest on a hypervisor. In these
> - * cases this function can be called to disable hard lockup detection. This
> - * function should only be executed once by the boot processor before the
> - * kernel command line parameters are parsed, because otherwise it is not
> - * possible to override this in hardlockup_panic_setup().
> - */
> -void hardlockup_detector_disable(void)
> -{
> -	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
> -}
> -
> -static int __init hardlockup_panic_setup(char *str)
> -{
> -	if (!strncmp(str, "panic", 5))
> -		hardlockup_panic = 1;
> -	else if (!strncmp(str, "nopanic", 7))
> -		hardlockup_panic = 0;
> -	else if (!strncmp(str, "0", 1))
> -		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
> -	else if (!strncmp(str, "1", 1))
> -		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
> -	return 1;
> -}
> -__setup("nmi_watchdog=", hardlockup_panic_setup);
>  
>  void touch_nmi_watchdog(void)
>  {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e4587ebe52c7..68685d3ddac0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -801,14 +801,18 @@ config LOCKUP_DETECTOR
>  	  The frequency of hrtimer and NMI events and the soft and hard lockup
>  	  thresholds can be controlled through the sysctl watchdog_thresh.
>  
> +config SOFTLOCKUP_DETECTOR
> +	bool "Detect Soft Lockups"
> +	depends on LOCKUP_DETECTOR
> +
>  config HARDLOCKUP_DETECTOR
> -	def_bool y
> -	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
> +	bool "Detect Hard Lockups"
> +	depends on SOFTLOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
>  	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>  
>  config BOOTPARAM_HARDLOCKUP_PANIC
>  	bool "Panic (Reboot) On Hard Lockups"
> -	depends on HARDLOCKUP_DETECTOR
> +	depends on HARDLOCKUP_DETECTOR || HAVE_NMI_WATCHDOG
>  	help
>  	  Say Y here to enable the kernel to panic on "hard lockups",
>  	  which are bugs that cause the kernel to loop in kernel
> @@ -819,14 +823,14 @@ config BOOTPARAM_HARDLOCKUP_PANIC
>  
>  config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
>  	int
> -	depends on HARDLOCKUP_DETECTOR
> +	depends on HARDLOCKUP_DETECTOR || HAVE_NMI_WATCHDOG
>  	range 0 1
>  	default 0 if !BOOTPARAM_HARDLOCKUP_PANIC
>  	default 1 if BOOTPARAM_HARDLOCKUP_PANIC
>  
>  config BOOTPARAM_SOFTLOCKUP_PANIC
>  	bool "Panic (Reboot) On Soft Lockups"
> -	depends on LOCKUP_DETECTOR
> +	depends on SOFTLOCKUP_DETECTOR
>  	help
>  	  Say Y here to enable the kernel to panic on "soft lockups",
>  	  which are bugs that cause the kernel to loop in kernel
> @@ -843,7 +847,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
>  
>  config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
>  	int
> -	depends on LOCKUP_DETECTOR
> +	depends on SOFTLOCKUP_DETECTOR
>  	range 0 1
>  	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
>  	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
> @@ -851,7 +855,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
>  config DETECT_HUNG_TASK
>  	bool "Detect Hung Tasks"
>  	depends on DEBUG_KERNEL
> -	default LOCKUP_DETECTOR
> +	default SOFTLOCKUP_DETECTOR
>  	help
>  	  Say Y here to enable the kernel to detect "hung tasks",
>  	  which are bugs that cause the task to be stuck in
> -- 
> 2.11.0
> 
