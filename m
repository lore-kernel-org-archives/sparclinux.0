From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2019 11:49:13 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
In-Reply-To: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On Fri, Mar 15, 2019 at 10:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Currently we call these notifiers once for each CPU of the policy->cpus
> cpumask. It would be more optimal if the notifier can be called only
> once and all the relevant information be provided to it. Out of the 24
> drivers that register for the transition notifiers today, only 5 of them
> do per-cpu updates and the callback for the rest can be called only once
> for the policy without any impact.
>
> This would also avoid multiple function calls to the notifier callbacks
> and reduce multiple iterations of notifier core's code (which does
> locking as well).
>
> This patch adds pointer to the cpufreq policy to the struct
> cpufreq_freqs, so the notifier callback has all the information
> available to it with a single call. The five drivers which perform
> per-cpu updates are updated to use the cpufreq policy. The freqs->cpu
> field is redundant now and is removed.
>
> Acked-by: David S. Miller <davem@davemloft.net> (sparc)
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Add cpufreq policy instead of cpus in struct cpufreq_freqs.
> - Use policy->cpus instead of related_cpus everywhere in order not to
>   change the existing behavior.
> - Merged all 7 patches into a single patch.
> - Updated changlog and included Ack from David.
>
>  arch/arm/kernel/smp.c       | 24 +++++++++++++++---------
>  arch/arm/kernel/smp_twd.c   |  9 ++++++---
>  arch/sparc/kernel/time_64.c | 28 ++++++++++++++++------------
>  arch/x86/kernel/tsc.c       | 32 +++++++++++++++++++++-----------
>  arch/x86/kvm/x86.c          | 31 ++++++++++++++++++++-----------
>  drivers/cpufreq/cpufreq.c   | 19 ++++++++++---------
>  include/linux/cpufreq.h     | 14 +++++++-------
>  7 files changed, 95 insertions(+), 62 deletions(-)
>
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 1d6f5ea522f4..6f6b981fecda 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -758,15 +758,20 @@ static int cpufreq_callback(struct notifier_block *nb,
>                                         unsigned long val, void *data)
>  {
>         struct cpufreq_freqs *freq = data;
> -       int cpu = freq->cpu;
> +       struct cpumask *cpus = freq->policy->cpus;
> +       int cpu, first = cpumask_first(cpus);
> +       unsigned int lpj;
>
>         if (freq->flags & CPUFREQ_CONST_LOOPS)
>                 return NOTIFY_OK;
>
> -       if (!per_cpu(l_p_j_ref, cpu)) {
> -               per_cpu(l_p_j_ref, cpu) > -                       per_cpu(cpu_data, cpu).loops_per_jiffy;
> -               per_cpu(l_p_j_ref_freq, cpu) = freq->old;
> +       if (!per_cpu(l_p_j_ref, first)) {
> +               for_each_cpu(cpu, cpus) {
> +                       per_cpu(l_p_j_ref, cpu) > +                               per_cpu(cpu_data, cpu).loops_per_jiffy;
> +                       per_cpu(l_p_j_ref_freq, cpu) = freq->old;
> +               }
> +
>                 if (!global_l_p_j_ref) {
>                         global_l_p_j_ref = loops_per_jiffy;
>                         global_l_p_j_ref_freq = freq->old;
> @@ -778,10 +783,11 @@ static int cpufreq_callback(struct notifier_block *nb,
>                 loops_per_jiffy = cpufreq_scale(global_l_p_j_ref,
>                                                 global_l_p_j_ref_freq,
>                                                 freq->new);
> -               per_cpu(cpu_data, cpu).loops_per_jiffy > -                       cpufreq_scale(per_cpu(l_p_j_ref, cpu),
> -                                       per_cpu(l_p_j_ref_freq, cpu),
> -                                       freq->new);
> +
> +               lpj = cpufreq_scale(per_cpu(l_p_j_ref, first),
> +                                   per_cpu(l_p_j_ref_freq, first), freq->new);
> +               for_each_cpu(cpu, cpus)
> +                       per_cpu(cpu_data, cpu).loops_per_jiffy = lpj;
>         }
>         return NOTIFY_OK;
>  }
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index b30eafeef096..495cc7282096 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -162,15 +162,18 @@ static int twd_cpufreq_transition(struct notifier_block *nb,
>         unsigned long state, void *data)
>  {
>         struct cpufreq_freqs *freqs = data;
> +       int cpu;
>
>         /*
>          * The twd clock events must be reprogrammed to account for the new
>          * frequency.  The timer is local to a cpu, so cross-call to the
>          * changing cpu.
>          */
> -       if (state = CPUFREQ_POSTCHANGE)
> -               smp_call_function_single(freqs->cpu, twd_update_frequency,
> -                       NULL, 1);
> +       if (state != CPUFREQ_POSTCHANGE)
> +               return NOTIFY_OK;
> +
> +       for_each_cpu(cpu, freqs->policy->cpus)
> +               smp_call_function_single(cpu, twd_update_frequency, NULL, 1);
>
>         return NOTIFY_OK;
>  }
> diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
> index 3eb77943ce12..89fb05f90609 100644
> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -653,19 +653,23 @@ static int sparc64_cpufreq_notifier(struct notifier_block *nb, unsigned long val
>                                     void *data)
>  {
>         struct cpufreq_freqs *freq = data;
> -       unsigned int cpu = freq->cpu;
> -       struct freq_table *ft = &per_cpu(sparc64_freq_table, cpu);
> +       unsigned int cpu;
> +       struct freq_table *ft;
>
> -       if (!ft->ref_freq) {
> -               ft->ref_freq = freq->old;
> -               ft->clock_tick_ref = cpu_data(cpu).clock_tick;
> -       }
> -       if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> -           (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> -               cpu_data(cpu).clock_tick > -                       cpufreq_scale(ft->clock_tick_ref,
> -                                     ft->ref_freq,
> -                                     freq->new);
> +       for_each_cpu(cpu, freq->policy->cpus) {
> +               ft = &per_cpu(sparc64_freq_table, cpu);
> +
> +               if (!ft->ref_freq) {
> +                       ft->ref_freq = freq->old;
> +                       ft->clock_tick_ref = cpu_data(cpu).clock_tick;
> +               }
> +
> +               if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> +                   (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> +                       cpu_data(cpu).clock_tick > +                               cpufreq_scale(ft->clock_tick_ref, ft->ref_freq,
> +                                             freq->new);
> +               }
>         }
>
>         return 0;
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..cff8779fc0d2 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>                                 void *data)
>  {
>         struct cpufreq_freqs *freq = data;
> -       unsigned long *lpj;
> -
> -       lpj = &boot_cpu_data.loops_per_jiffy;
> -#ifdef CONFIG_SMP
> -       if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -               lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> -#endif
> +       struct cpumask *cpus = freq->policy->cpus;
> +       bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> +       unsigned long lpj;
> +       int cpu;
>
>         if (!ref_freq) {
>                 ref_freq = freq->old;
> -               loops_per_jiffy_ref = *lpj;
>                 tsc_khz_ref = tsc_khz;
> +
> +               if (boot_cpu)
> +                       loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> +               else
> +                       loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
>         }
> +
>         if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
>                         (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> -               *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> -
> +               lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
>                 tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> +
>                 if (!(freq->flags & CPUFREQ_CONST_LOOPS))
>                         mark_tsc_unstable("cpufreq changes");
>
> -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> +               if (boot_cpu) {
> +                       boot_cpu_data.loops_per_jiffy = lpj;
> +               } else {
> +                       for_each_cpu(cpu, cpus)
> +                               cpu_data(cpu).loops_per_jiffy = lpj;
> +               }
> +
> +               for_each_cpu(cpu, cpus)
> +                       set_cyc2ns_scale(tsc_khz, cpu, rdtsc());

To summarize, I think that it would be sufficient to do this just for
policy->cpu and, as Peter said, warn once if there are more CPUs in
the policy or policy->cpu is not the CPU running this code.  And mark
the TSC as unstable in both of these cases.
