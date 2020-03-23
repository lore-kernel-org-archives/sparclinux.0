From: "Paul E. McKenney" <paulmck@kernel.org>
Date: Mon, 23 Mar 2020 15:00:34 +0000
Subject: Re: [PATCH v4 01/17] cpu: Add new {add,remove}_cpu() functions
Message-Id: <20200323150034.GG3199@paulmck-ThinkPad-P72>
List-Id: <sparclinux.vger.kernel.org>
References: <20200323135110.30522-1-qais.yousef@arm.com>
 <20200323135110.30522-2-qais.yousef@arm.com>
In-Reply-To: <20200323135110.30522-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Qais Yousef <qais.yousef@arm.com>
Cc: Juergen Gross <jgross@suse.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Mon, Mar 23, 2020 at 01:50:54PM +0000, Qais Yousef wrote:
> The new functions use device_{online,offline}() which are userspace
> safe.
> 
> This is in preparation to move cpu_{up, down} kernel users to use
> a safer interface that is not racy with userspace.
> 
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "Paul E. McKenney" <paulmck@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> CC: Helge Deller <deller@gmx.de>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Juergen Gross <jgross@suse.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: xen-devel@lists.xenproject.org
> CC: linux-parisc@vger.kernel.org
> CC: sparclinux@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: x86@kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 1ca2baf817ed..cf8cf38dca43 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -89,6 +89,7 @@ extern ssize_t arch_cpu_release(const char *, size_t);
>  #ifdef CONFIG_SMP
>  extern bool cpuhp_tasks_frozen;
>  int cpu_up(unsigned int cpu);
> +int add_cpu(unsigned int cpu);
>  void notify_cpu_starting(unsigned int cpu);
>  extern void cpu_maps_update_begin(void);
>  extern void cpu_maps_update_done(void);
> @@ -118,6 +119,7 @@ extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
>  int cpu_down(unsigned int cpu);
> +int remove_cpu(unsigned int cpu);
>  
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c706af713fb..069802f7010f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1057,6 +1057,18 @@ int cpu_down(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpu_down);
>  
> +int remove_cpu(unsigned int cpu)
> +{
> +	int ret;
> +
> +	lock_device_hotplug();
> +	ret = device_offline(get_cpu_device(cpu));
> +	unlock_device_hotplug();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(remove_cpu);
> +
>  #else
>  #define takedown_cpu		NULL
>  #endif /*CONFIG_HOTPLUG_CPU*/
> @@ -1209,6 +1221,18 @@ int cpu_up(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpu_up);
>  
> +int add_cpu(unsigned int cpu)
> +{
> +	int ret;
> +
> +	lock_device_hotplug();
> +	ret = device_online(get_cpu_device(cpu));
> +	unlock_device_hotplug();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(add_cpu);
> +
>  #ifdef CONFIG_PM_SLEEP_SMP
>  static cpumask_var_t frozen_cpus;
>  
> -- 
> 2.17.1
> 
