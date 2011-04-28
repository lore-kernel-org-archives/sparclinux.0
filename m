From: Thiago Farina <tfransosi@gmail.com>
Date: Thu, 28 Apr 2011 15:26:27 +0000
Subject: Re: [PATCH] sparc: convert old cpumask API into new one
Message-Id: <BANLkTimdWkLF3FLOd6CUTKQ_+Fhhor9VJA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110429001547.3D6C.A69D9226@jp.fujitsu.com>
In-Reply-To: <20110429001547.3D6C.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thu, Apr 28, 2011 at 12:14 PM, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com> wrote:
> Adapt new API. Almost change is trivial, most important change are to
> remove following like =3Doperator.
>
> =C2=A0cpumask_t cpu_mask =3D *mm_cpumask(mm);

Could you note that you are changing this to:

cpumask_t cpu_mask;
cpumask_copy(&cpu_mask, mm_cpumask(mm));

> =C2=A0cpus_allowed =3D current->cpus_allowed;
>

And this to:

cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));

> Because cpumask_var_t is =3Doperator unsafe. These usage might prevent
> kernel core improvement.
>
> No functional change.
>
> Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
> =C2=A0arch/sparc/include/asm/smp_32.h =C2=A0| =C2=A0 12 ++++----
> =C2=A0arch/sparc/kernel/cpumap.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +-
> =C2=A0arch/sparc/kernel/ds.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
14 ++++----
> =C2=A0arch/sparc/kernel/irq_64.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 ++=
--
> =C2=A0arch/sparc/kernel/leon_smp.c =C2=A0 =C2=A0 | =C2=A0 20 ++++++------
> =C2=A0arch/sparc/kernel/mdesc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02 +-
> =C2=A0arch/sparc/kernel/of_device_64.c | =C2=A0 =C2=A03 +-
> =C2=A0arch/sparc/kernel/pci_msi.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
> =C2=A0arch/sparc/kernel/smp_32.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 51 +++++++=
++++++++++++--------------
> =C2=A0arch/sparc/kernel/smp_64.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 58 +++++++=
++++++++++++-------------------
> =C2=A0arch/sparc/kernel/sun4d_smp.c =C2=A0 =C2=A0| =C2=A0 12 ++++----
> =C2=A0arch/sparc/kernel/sun4m_smp.c =C2=A0 =C2=A0| =C2=A0 12 ++++----
> =C2=A0arch/sparc/kernel/sysfs.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A03 +-
> =C2=A0arch/sparc/kernel/us2e_cpufreq.c | =C2=A0 =C2=A04 +-
> =C2=A0arch/sparc/kernel/us3_cpufreq.c =C2=A0| =C2=A0 =C2=A04 +-
> =C2=A0arch/sparc/mm/init_64.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
14 ++++----
> =C2=A016 files changed, 116 insertions(+), 106 deletions(-)
>
> diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp=
_32.h
> index d82d7f4..dd7a6be 100644
> --- a/arch/sparc/include/asm/smp_32.h
> +++ b/arch/sparc/include/asm/smp_32.h
> @@ -61,17 +61,17 @@ BTFIXUPDEF_BLACKBOX(load_current)
>
> =C2=A0#define smp_cross_call(func,mask,arg1,arg2,arg3,arg4) BTFIXUP_CALL(=
smp_cross_call)(func,mask,arg1,arg2,arg3,arg4)
>
> -static inline void xc0(smpfunc_t func) { smp_cross_call(func, cpu_online=
_map, 0, 0, 0, 0); }
> +static inline void xc0(smpfunc_t func) { smp_cross_call(func, *cpu_onlin=
e_mask, 0, 0, 0, 0); }
> =C2=A0static inline void xc1(smpfunc_t func, unsigned long arg1)
> -{ smp_cross_call(func, cpu_online_map, arg1, 0, 0, 0); }
> +{ smp_cross_call(func, *cpu_online_mask, arg1, 0, 0, 0); }
> =C2=A0static inline void xc2(smpfunc_t func, unsigned long arg1, unsigned=
 long arg2)
> -{ smp_cross_call(func, cpu_online_map, arg1, arg2, 0, 0); }
> +{ smp_cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0); }
> =C2=A0static inline void xc3(smpfunc_t func, unsigned long arg1, unsigned=
 long arg2,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unsigned long arg3)
> -{ smp_cross_call(func, cpu_online_map, arg1, arg2, arg3, 0); }
> +{ smp_cross_call(func, *cpu_online_mask, arg1, arg2, arg3, 0); }
> =C2=A0static inline void xc4(smpfunc_t func, unsigned long arg1, unsigned=
 long arg2,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unsigned long arg3, unsigned long arg4)
> -{ smp_cross_call(func, cpu_online_map, arg1, arg2, arg3, arg4); }
> +{ smp_cross_call(func, *cpu_online_mask, arg1, arg2, arg3, arg4); }
>
> =C2=A0static inline int smp_call_function(void (*func)(void *info), void =
*info, int wait)
> =C2=A0{
> @@ -82,7 +82,7 @@ static inline int smp_call_function(void (*func)(void *=
info), void *info, int wa
> =C2=A0static inline int smp_call_function_single(int cpuid, void (*func) =
(void *info),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
oid *info, int wait)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 smp_cross_call((smpfunc_t)func, cpumask_of_cpu(cpu=
id),
> + =C2=A0 =C2=A0 =C2=A0 smp_cross_call((smpfunc_t)func, *cpumask_of(cpuid),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned long) info, 0, 0, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
> index 8de64c8..d91fd78 100644
> --- a/arch/sparc/kernel/cpumap.c
> +++ b/arch/sparc/kernel/cpumap.c
> @@ -202,7 +202,7 @@ static struct cpuinfo_tree *build_cpuinfo_tree(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_tree->total_nodes =3D n;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&new_tree->level, tmp_level, sizeof(tmp=
_level));
>
> - =C2=A0 =C2=A0 =C2=A0 prev_cpu =3D cpu =3D first_cpu(cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 prev_cpu =3D cpu =3D cpumask_first(cpu_online_mask=
);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize all levels in the tree with the =
first CPU */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (level =3D CPUINFO_LVL_PROC; level >=3D CP=
UINFO_LVL_ROOT; level--) {
> @@ -381,7 +381,7 @@ static int simple_map_to_cpu(unsigned int index)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Impossible, since num_online_cpus() <=3D nu=
m_possible_cpus() */
> - =C2=A0 =C2=A0 =C2=A0 return first_cpu(cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 return cpumask_first(cpu_online_mask);
> =C2=A0}
>
> =C2=A0static int _map_to_cpu(unsigned int index)
> diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
> index 3add4de..dd1342c 100644
> --- a/arch/sparc/kernel/ds.c
> +++ b/arch/sparc/kernel/ds.c
> @@ -497,7 +497,7 @@ static void dr_cpu_init_response(struct ds_data *resp=
, u64 req_num,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tag->num_records =3D ncpus;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(cpu, *mask) {
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu, mask) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ent[i].cpu =3D cpu;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ent[i].result =3D =
DR_CPU_RES_OK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ent[i].stat =3D de=
fault_stat;
> @@ -534,7 +534,7 @@ static int __cpuinit dr_cpu_configure(struct ds_info =
*dp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int resp_len, ncpus, cpu;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
>
> - =C2=A0 =C2=A0 =C2=A0 ncpus =3D cpus_weight(*mask);
> + =C2=A0 =C2=A0 =C2=A0 ncpus =3D cpumask_weight(mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0resp_len =3D dr_cpu_size_response(ncpus);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0resp =3D kzalloc(resp_len, GFP_KERNEL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!resp)
> @@ -547,7 +547,7 @@ static int __cpuinit dr_cpu_configure(struct ds_info =
*dp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mdesc_populate_present_mask(mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mdesc_fill_in_cpu_data(mask);
>
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(cpu, *mask) {
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu, mask) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "=
ds-%llu: Starting cpu %d...\n",
> @@ -593,7 +593,7 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int resp_len, ncpus, cpu;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
>
> - =C2=A0 =C2=A0 =C2=A0 ncpus =3D cpus_weight(*mask);
> + =C2=A0 =C2=A0 =C2=A0 ncpus =3D cpumask_weight(mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0resp_len =3D dr_cpu_size_response(ncpus);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0resp =3D kzalloc(resp_len, GFP_KERNEL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!resp)
> @@ -603,7 +603,7 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 resp_len, ncpus, mask,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 DR_CPU_STAT_UNCONFIGURED);
>
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(cpu, *mask) {
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu, mask) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "=
ds-%llu: Shutting down cpu %d...\n",
> @@ -649,13 +649,13 @@ static void __cpuinit dr_cpu_data(struct ds_info *d=
p,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0purge_dups(cpu_list, tag->num_records);
>
> - =C2=A0 =C2=A0 =C2=A0 cpus_clear(mask);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < tag->num_records; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_list[i] =
=3D CPU_SENTINEL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_list[i] < =
nr_cpu_ids)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_set(cpu_list[i], mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_set_cpu(cpu_list[i], &mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tag->type =3D DR_CPU_CONFIGURE)
> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index b1d275c..4e78862 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -224,13 +224,13 @@ static int irq_choose_cpu(unsigned int irq, const s=
truct cpumask *affinity)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int cpuid;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpumask_copy(&mask, affinity);
> - =C2=A0 =C2=A0 =C2=A0 if (cpus_equal(mask, cpu_online_map)) {
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_equal(&mask, cpu_online_mask)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpuid =3D map_to_c=
pu(irq);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpumask_t tmp;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpus_and(tmp, cpu_onli=
ne_map, mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpuid =3D cpus_empty(t=
mp) ? map_to_cpu(irq) : first_cpu(tmp);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_and(&tmp, cpu_=
online_mask, &mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpuid =3D cpumask_empt=
y(&tmp) ? map_to_cpu(irq) : cpumask_first(&tmp);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return cpuid;
> diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
> index 8f5de4a..3c5014b 100644
> --- a/arch/sparc/kernel/leon_smp.c
> +++ b/arch/sparc/kernel/leon_smp.c
> @@ -104,11 +104,11 @@ void __cpuinit leon_callin(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_inc(&init_mm.mm_count);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0current->active_mm =3D &init_mm;
>
> - =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(cpuid, smp_commenced_mask))
> + =C2=A0 =C2=A0 =C2=A0 while (!cpumask_test_cpu(cpuid, &smp_commenced_mas=
k))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mb();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable();
> - =C2=A0 =C2=A0 =C2=A0 cpu_set(cpuid, cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 set_cpu_online(cpuid, true);
> =C2=A0}
>
> =C2=A0/*
> @@ -262,21 +262,21 @@ void __init leon_smp_done(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_cache_all();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Free unneeded trap tables */
> - =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(1, cpu_present_map)) {
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_present(1)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ClearPageReserved(=
virt_to_page(&trapbase_cpu1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_page_count(vi=
rt_to_page(&trapbase_cpu1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_page((unsigne=
d long)&trapbase_cpu1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0totalram_pages++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_physpages++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(2, cpu_present_map)) {
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_present(2)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ClearPageReserved(=
virt_to_page(&trapbase_cpu2));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_page_count(vi=
rt_to_page(&trapbase_cpu2));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_page((unsigne=
d long)&trapbase_cpu2);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0totalram_pages++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_physpages++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(3, cpu_present_map)) {
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_present(3)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ClearPageReserved(=
virt_to_page(&trapbase_cpu3));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_page_count(vi=
rt_to_page(&trapbase_cpu3));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_page((unsigne=
d long)&trapbase_cpu3);
> @@ -337,10 +337,10 @@ static void leon_cross_call(smpfunc_t func, cpumask=
_t mask, unsigned long arg1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0register int i;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_clear(smp_processor_id(), mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpus_and(mask, cpu_online_map, mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_clear_cpu(smp_processor_id(), &mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_and(&mask, cpu_online_mask, &mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (i =3D 0; i <=3D high; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(i, mask)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(i, &mask)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ccall_inf=
o.processors_in[i] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ccall_inf=
o.processors_out[i] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpu_i=
nt(i, LEON3_IRQ_CROSS_CALL);
> @@ -354,7 +354,7 @@ static void leon_cross_call(smpfunc_t func, cpumask_t=
 mask, unsigned long arg1,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(i, mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(i, &mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!ccall_info.processors_in[i])
> @@ -363,7 +363,7 @@ static void leon_cross_call(smpfunc_t func, cpumask_t=
 mask, unsigned long arg1,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(i, mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(i, &mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!ccall_info.processors_out[i])
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 56db064..42f28c7 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -768,7 +768,7 @@ static void * __cpuinit mdesc_iterate_over_cpus(void =
*(*func)(struct mdesc_handl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpuid, NR_CPUS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(cpuid, =
*mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(=
cpuid, mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
> =C2=A0#endif
>
> diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_devi=
ce_64.c
> index 5c14968..3bb2eac 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device_64.c
> @@ -622,8 +622,9 @@ static unsigned int __init build_one_device_irq(struc=
t platform_device *op,
> =C2=A0out:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nid =3D of_node_to_nid(dp);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nid !=3D -1) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t numa_mask =
=3D *cpumask_of_node(nid);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t numa_mask;
>
please, could you remove the extra blank line?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&numa_mas=
k, cpumask_of_node(nid));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_set_affinity(i=
rq, &numa_mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
> index 30982e9..580651a 100644
> --- a/arch/sparc/kernel/pci_msi.c
> +++ b/arch/sparc/kernel/pci_msi.c
> @@ -284,8 +284,9 @@ static int bringup_one_msi_queue(struct pci_pbm_info =
*pbm,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nid =3D pbm->numa_node;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nid !=3D -1) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t numa_mask =
=3D *cpumask_of_node(nid);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t numa_mask;
>
please, could you remove the extra blank line?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&numa_mas=
k, cpumask_of_node(nid));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_set_affinity(i=
rq, &numa_mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D request_irq(irq, sparc64_msiq_interrup=
t, 0,
> diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
> index f95690c..e6b74b5 100644
> --- a/arch/sparc/kernel/smp_32.c
> +++ b/arch/sparc/kernel/smp_32.c
> @@ -149,9 +149,10 @@ void smp_flush_tlb_all(void)
> =C2=A0void smp_flush_cache_mm(struct mm_struct *mm)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if(mm->context !=3D NO_CONTEXT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D=
 *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processo=
r_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_ma=
sk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask=
, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_=
processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cp=
u_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xc1((smpfunc_t) BTFIXUP_CALL(local_flush_cache_mm), (unsigned lon=
g) mm);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_cache_=
mm(mm);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -160,9 +161,10 @@ void smp_flush_cache_mm(struct mm_struct *mm)
> =C2=A0void smp_flush_tlb_mm(struct mm_struct *mm)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if(mm->context !=3D NO_CONTEXT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D=
 *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processo=
r_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_ma=
sk)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask=
, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_=
processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cp=
u_mask)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xc1((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_mm), (unsigned long)=
 mm);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if(atomic_read(&mm->mm_users) =3D 1 && current->active_mm =3D mm)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpumask_copy(mm_cpumask(mm),
> @@ -178,9 +180,10 @@ void smp_flush_cache_range(struct vm_area_struct *vm=
a, unsigned long start,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm =3D vma->vm_mm;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mm->context !=3D NO_CONTEXT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D=
 *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processo=
r_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_ma=
sk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask=
, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_=
processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cp=
u_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xc3((smpfunc_t) BTFIXUP_CALL(local_flush_cache_range), (unsigned =
long) vma, start, end);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_cache_=
range(vma, start, end);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -192,9 +195,10 @@ void smp_flush_tlb_range(struct vm_area_struct *vma,=
 unsigned long start,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm =3D vma->vm_mm;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mm->context !=3D NO_CONTEXT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D=
 *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processo=
r_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_ma=
sk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask=
, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_=
processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cp=
u_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xc3((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_range), (unsigned lo=
ng) vma, start, end);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_tlb_ra=
nge(vma, start, end);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -205,9 +209,10 @@ void smp_flush_cache_page(struct vm_area_struct *vma=
, unsigned long page)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm =3D vma->vm_mm;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if(mm->context !=3D NO_CONTEXT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D=
 *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processo=
r_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_ma=
sk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask=
, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_=
processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cp=
u_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xc2((smpfunc_t) BTFIXUP_CALL(local_flush_cache_page), (unsigned l=
ong) vma, page);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_cache_=
page(vma, page);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -218,9 +223,10 @@ void smp_flush_tlb_page(struct vm_area_struct *vma, =
unsigned long page)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm =3D vma->vm_mm;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if(mm->context !=3D NO_CONTEXT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D=
 *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processo=
r_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_ma=
sk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask=
, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_=
processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cp=
u_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xc2((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_page), (unsigned lon=
g) vma, page);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_tlb_pa=
ge(vma, page);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -247,9 +253,10 @@ void smp_flush_page_to_ram(unsigned long page)
>
> =C2=A0void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_a=
ddr)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask =3D *mm_cpumask(mm);
> - =C2=A0 =C2=A0 =C2=A0 cpu_clear(smp_processor_id(), cpu_mask);
> - =C2=A0 =C2=A0 =C2=A0 if (!cpus_empty(cpu_mask))
> + =C2=A0 =C2=A0 =C2=A0 cpumask_t cpu_mask;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpu_mask, mm_cpumask(mm));
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> + =C2=A0 =C2=A0 =C2=A0 if (!cpumask_empty(&cpu_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xc2((smpfunc_t) BT=
FIXUP_CALL(local_flush_sig_insns), (unsigned long) mm, insn_addr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_flush_sig_insns(mm, insn_addr);
> =C2=A0}
> @@ -403,7 +410,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(cpu, smp_comme=
nced_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(cpu, &=
smp_commenced_mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!cpu_online=
(cpu))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mb();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 9478da7..99cb172 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -121,11 +121,11 @@ void __cpuinit smp_callin(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* inform the notifiers about the new cpu */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notify_cpu_starting(cpuid);
>
> - =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(cpuid, smp_commenced_mask))
> + =C2=A0 =C2=A0 =C2=A0 while (!cpumask_test_cpu(cpuid, &smp_commenced_mas=
k))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmb();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ipi_call_lock_irq();
> - =C2=A0 =C2=A0 =C2=A0 cpu_set(cpuid, cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 set_cpu_online(cpuid, true);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ipi_call_unlock_irq();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* idle thread is expected to have preempt dis=
abled */
> @@ -785,7 +785,7 @@ static void xcall_deliver(u64 data0, u64 data1, u64 d=
ata2, const cpumask_t *mask
>
> =C2=A0/* Send cross call to all processors mentioned in MASK_P
> =C2=A0* except self. =C2=A0Really, there are only two cases currently,
> - * "&cpu_online_map" and "&mm->cpu_vm_mask".
> + * "cpu_online_mask" and "mm_cpumask(mm)".
> =C2=A0*/
> =C2=A0static void smp_cross_call_masked(unsigned long *func, u32 ctx, u64=
 data1, u64 data2, const cpumask_t *mask)
> =C2=A0{
> @@ -797,7 +797,7 @@ static void smp_cross_call_masked(unsigned long *func=
, u32 ctx, u64 data1, u64 d
> =C2=A0/* Send cross call to all processors except self. */
> =C2=A0static void smp_cross_call(unsigned long *func, u32 ctx, u64 data1,=
 u64 data2)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 smp_cross_call_masked(func, ctx, data1, data2, &cp=
u_online_map);
> + =C2=A0 =C2=A0 =C2=A0 smp_cross_call_masked(func, ctx, data1, data2, cpu=
_online_mask);
> =C2=A0}
>
> =C2=A0extern unsigned long xcall_sync_tick;
> @@ -805,7 +805,7 @@ extern unsigned long xcall_sync_tick;
> =C2=A0static void smp_start_sync_tick_client(int cpu)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xcall_deliver((u64) &xcall_sync_tick, 0, 0,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
cpumask_of_cpu(cpu));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
pumask_of(cpu));
> =C2=A0}
>
> =C2=A0extern unsigned long xcall_call_function;
> @@ -820,7 +820,7 @@ extern unsigned long xcall_call_function_single;
> =C2=A0void arch_send_call_function_single_ipi(int cpu)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xcall_deliver((u64) &xcall_call_function_singl=
e, 0, 0,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
cpumask_of_cpu(cpu));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
pumask_of(cpu));
> =C2=A0}
>
> =C2=A0void __irq_entry smp_call_function_client(int irq, struct pt_regs *=
regs)
> @@ -918,7 +918,7 @@ void smp_flush_dcache_page_impl(struct page *page, in=
t cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xcall_deliver(data0, __pa(pg_addr),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u64) pg_addr, &cpu=
mask_of_cpu(cpu));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u64) pg_addr, cpum=
ask_of(cpu));
> =C2=A0#ifdef CONFIG_DEBUG_DCFLUSH
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0atomic_inc(&dcpage_flushes_xcall);
> =C2=A0#endif
> @@ -954,7 +954,7 @@ void flush_dcache_page_all(struct mm_struct *mm, stru=
ct page *page)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xcall_deliver(data=
0, __pa(pg_addr),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (u64) pg_addr, &cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (u64) pg_addr, cpu_online_mask);
> =C2=A0#ifdef CONFIG_DEBUG_DCFLUSH
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_inc(&dcpage=
_flushes_xcall);
> =C2=A0#endif
> @@ -1197,32 +1197,32 @@ void __devinit smp_fill_in_sib_core_maps(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_present_cpu(i) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int j;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpus_clear(cpu_core_ma=
p[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&cpu_cor=
e_map[i]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_data(i).co=
re_id =3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_set(i, cpu_core_map[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_set_cpu(i, &cpu_core_map[i]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_present_c=
pu(j) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (cpu_data(i).core_id =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cpu_data(j).core_id)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(j, cpu_core_map[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(j, &cpu_core_map[i]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_present_cpu(i) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int j;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpus_clear(per_cpu(cpu=
_sibling_map, i));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&per_cpu=
(cpu_sibling_map, i));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_data(i).pr=
oc_id =3D -1) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_set(i, per_cpu(cpu_sibling_map, i));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_set_cpu(i, &per_cpu(cpu_sibling_map, i));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_present_c=
pu(j) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (cpu_data(i).proc_id =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cpu_data(j).proc_id)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(j, per_cpu(cpu_sibling_map, i));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(j, &per_cpu(cpu_sibling_=
map, i));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> @@ -1232,10 +1232,10 @@ int __cpuinit __cpu_up(unsigned int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D smp_boot_one_cpu(cpu);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(cpu, smp_comme=
nced_mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(cpu,=
 cpu_online_map))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(cpu, &=
smp_commenced_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (!cpu_online(cpu=
))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mb();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(cpu, cp=
u_online_map)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_online(cpu)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -ENODEV;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* On SUN4V, writes to %tick and %stick are
> @@ -1269,7 +1269,7 @@ void cpu_play_dead(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb->nonresum_mondo_pa, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, smp_commenced_mask);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(cpu, &smp_commenced_mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0membar_safe("#Sync");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_disable();
> @@ -1290,13 +1290,13 @@ int __cpu_disable(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpuinfo_sparc *c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(i, cpu_core_map[cpu])
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, cpu_cor=
e_map[i]);
> - =C2=A0 =C2=A0 =C2=A0 cpus_clear(cpu_core_map[cpu]);
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(i, &cpu_core_map[cpu])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(cpu,=
 &cpu_core_map[i]);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&cpu_core_map[cpu]);
>
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(i, per_cpu(cpu_sibling_map, cpu))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, per_cpu=
(cpu_sibling_map, i));
> - =C2=A0 =C2=A0 =C2=A0 cpus_clear(per_cpu(cpu_sibling_map, cpu));
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(i, &per_cpu(cpu_sibling_map, cpu))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(cpu,=
 &per_cpu(cpu_sibling_map, i));
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&per_cpu(cpu_sibling_map, cpu));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0c =3D &cpu_data(cpu);
>
> @@ -1313,7 +1313,7 @@ int __cpu_disable(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_disable();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ipi_call_lock();
> - =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 set_cpu_online(cpu, false);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ipi_call_unlock();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_map_rebuild();
> @@ -1327,11 +1327,11 @@ void __cpu_die(unsigned int cpu)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 100; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_rmb();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(cpu, sm=
p_commenced_mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(=
cpu, &smp_commenced_mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(100);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(cpu, smp_commenced_mask)) {
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(cpu, &smp_commenced_mask)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "C=
PU %u didn't die...\n", cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0#if defined(CONFIG_SUN_LDOMS)
> @@ -1341,7 +1341,7 @@ void __cpu_die(unsigned int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hv_err =3D sun4v_cpu_stop(cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (hv_err =3D HV_EOK) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, cpu_present_map);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_cpu_present(cpu, false);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (--limit >=
 0);
> @@ -1362,7 +1362,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
> =C2=A0void smp_send_reschedule(int cpu)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xcall_deliver((u64) &xcall_receive_signal, 0, =
0,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
cpumask_of_cpu(cpu));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
pumask_of(cpu));
> =C2=A0}
>
> =C2=A0void __irq_entry smp_receive_signal_client(int irq, struct pt_regs =
*regs)
> diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
> index 475d50b..3d4185c 100644
> --- a/arch/sparc/kernel/sun4d_smp.c
> +++ b/arch/sparc/kernel/sun4d_smp.c
> @@ -105,7 +105,7 @@ void __cpuinit smp4d_callin(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable(); =C2=A0 =C2=A0 /* We don't =
allow PIL 14 yet */
>
> - =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(cpuid, smp_commenced_mask))
> + =C2=A0 =C2=A0 =C2=A0 while (!cpumask_test_cpu(cpuid, &smp_commenced_mas=
k))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0barrier();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&sun4d_imsk_lock, flags);
> @@ -239,10 +239,10 @@ static void smp4d_cross_call(smpfunc_t func, cpumas=
k_t mask, unsigned long arg1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0register int i;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_clear(smp_processor_id(), mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpus_and(mask, cpu_online_map, mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_clear_cpu(smp_processor_id(), &mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_and(&mask, cpu_online_mask, &mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (i =3D 0; i <=3D high; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(i, mask)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(i, &mask)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ccall_inf=
o.processors_in[i] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ccall_inf=
o.processors_out[i] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sun4d_sen=
d_ipi(i, IRQ_CROSS_CALL);
> @@ -255,7 +255,7 @@ static void smp4d_cross_call(smpfunc_t func, cpumask_=
t mask, unsigned long arg1,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(i, mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(i, &mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!ccall_info.processors_in[i])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0barrier();
> @@ -263,7 +263,7 @@ static void smp4d_cross_call(smpfunc_t func, cpumask_=
t mask, unsigned long arg1,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(i, mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(i, &mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!ccall_info.processors_out[i])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0barrier();
> diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
> index 5cc7dc5..68e6011 100644
> --- a/arch/sparc/kernel/sun4m_smp.c
> +++ b/arch/sparc/kernel/sun4m_smp.c
> @@ -70,7 +70,7 @@ void __cpuinit smp4m_callin(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_inc(&init_mm.mm_count);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0current->active_mm =3D &init_mm;
>
> - =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(cpuid, smp_commenced_mask))
> + =C2=A0 =C2=A0 =C2=A0 while (!cpumask_test_cpu(cpuid, &smp_commenced_mas=
k))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mb();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable();
> @@ -199,10 +199,10 @@ static void smp4m_cross_call(smpfunc_t func, cpumas=
k_t mask, unsigned long arg1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0register int i;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_clear(smp_processor_id(), mask);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpus_and(mask, cpu_online_map, mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_clear_cpu(smp_processor_id(), &mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_and(&mask, cpu_online_mask, &mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (i =3D 0; i < ncpus; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(i, mask)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(i, &mask)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ccall_inf=
o.processors_in[i] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ccall_inf=
o.processors_out[i] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpu_i=
nt(i, IRQ_CROSS_CALL);
> @@ -218,7 +218,7 @@ static void smp4m_cross_call(smpfunc_t func, cpumask_=
t mask, unsigned long arg1,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(i, mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(i, &mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!ccall_info.processors_in[i])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0barrier();
> @@ -226,7 +226,7 @@ static void smp4m_cross_call(smpfunc_t func, cpumask_=
t mask, unsigned long arg1,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(i, mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(i, &mask))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!ccall_info.processors_out[i])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0barrier();
> diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
> index 1eb8b00..7408201 100644
> --- a/arch/sparc/kernel/sysfs.c
> +++ b/arch/sparc/kernel/sysfs.c
> @@ -103,9 +103,10 @@ static unsigned long run_on_cpu(unsigned long cpu,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long (*func)(unsigned long),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long arg)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 cpumask_t old_affinity =3D current->cpus_allowed;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_t old_affinity;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long ret;
>
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&old_affinity, tsk_cpus_allowed(curre=
nt));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* should return -EINVAL to userspace */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (set_cpus_allowed_ptr(current, cpumask_of(c=
pu)))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> diff --git a/arch/sparc/kernel/us2e_cpufreq.c b/arch/sparc/kernel/us2e_cp=
ufreq.c
> index 8f982b7..531d54f 100644
> --- a/arch/sparc/kernel/us2e_cpufreq.c
> +++ b/arch/sparc/kernel/us2e_cpufreq.c
> @@ -237,7 +237,7 @@ static unsigned int us2e_freq_get(unsigned int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_online(cpu))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> - =C2=A0 =C2=A0 =C2=A0 cpus_allowed =3D current->cpus_allowed;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpus_allowed, tsk_cpus_allowed(curre=
nt));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpus_allowed_ptr(current, cpumask_of(cpu));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clock_tick =3D sparc64_get_clock_tick(cpu) / 1=
000;
> @@ -258,7 +258,7 @@ static void us2e_set_cpu_divider_index(unsigned int c=
pu, unsigned int index)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_online(cpu))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 cpus_allowed =3D current->cpus_allowed;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpus_allowed, tsk_cpus_allowed(curre=
nt));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpus_allowed_ptr(current, cpumask_of(cpu));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_freq =3D clock_tick =3D sparc64_get_clock_=
tick(cpu) / 1000;
> diff --git a/arch/sparc/kernel/us3_cpufreq.c b/arch/sparc/kernel/us3_cpuf=
req.c
> index f35d1e7..9a8ceb7 100644
> --- a/arch/sparc/kernel/us3_cpufreq.c
> +++ b/arch/sparc/kernel/us3_cpufreq.c
> @@ -85,7 +85,7 @@ static unsigned int us3_freq_get(unsigned int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_online(cpu))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> - =C2=A0 =C2=A0 =C2=A0 cpus_allowed =3D current->cpus_allowed;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpus_allowed, tsk_cpus_allowed(curre=
nt));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpus_allowed_ptr(current, cpumask_of(cpu));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D read_safari_cfg();
> @@ -105,7 +105,7 @@ static void us3_set_cpu_divider_index(unsigned int cp=
u, unsigned int index)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_online(cpu))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 cpus_allowed =3D current->cpus_allowed;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&cpus_allowed, tsk_cpus_allowed(curre=
nt));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpus_allowed_ptr(current, cpumask_of(cpu));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_freq =3D sparc64_get_clock_tick(cpu) / 100=
0;
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 2f6ae1d..e10cd03 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -862,7 +862,7 @@ static void init_node_masks_nonnuma(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < NR_CPUS; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0numa_cpu_lookup_ta=
ble[i] =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 numa_cpumask_lookup_table[0] =3D CPU_MASK_ALL;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_setall(&numa_cpumask_lookup_table[0]);
> =C2=A0}
>
> =C2=A0#ifdef CONFIG_NEED_MULTIPLE_NODES
> @@ -1080,7 +1080,7 @@ static void __init numa_parse_mdesc_group_cpus(stru=
ct mdesc_handle *md,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 arc;
>
> - =C2=A0 =C2=A0 =C2=A0 cpus_clear(*mask);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(mask);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mdesc_for_each_arc(arc, md, grp, MDESC_ARC_TYP=
E_BACK) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 target =3D mde=
sc_arc_target(md, arc);
> @@ -1091,7 +1091,7 @@ static void __init numa_parse_mdesc_group_cpus(stru=
ct mdesc_handle *md,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id =3D mdesc_get_p=
roperty(md, target, "id", NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*id < nr_cpu_i=
ds)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_set(*id, *mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_set_cpu(*id, mask);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> @@ -1153,13 +1153,13 @@ static int __init numa_parse_mdesc_group(struct m=
desc_handle *md, u64 grp,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0numa_parse_mdesc_group_cpus(md, grp, &mask);
>
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(cpu, mask)
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu, &mask)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0numa_cpu_lookup_ta=
ble[cpu] =3D index;
> - =C2=A0 =C2=A0 =C2=A0 numa_cpumask_lookup_table[index] =3D mask;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&numa_cpumask_lookup_table[index], &m=
ask);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (numa_debug) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "=
NUMA GROUP[%d]: cpus [ ", index);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(cpu,=
 mask)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu, &mas=
k)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printk("%d ", cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk("]\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -1218,7 +1218,7 @@ static int __init numa_parse_jbus(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_present_cpu(cpu) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0numa_cpu_lookup_ta=
ble[cpu] =3D index;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 numa_cpumask_lookup_ta=
ble[index] =3D cpumask_of_cpu(cpu);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&numa_cpu=
mask_lookup_table[index], cpumask_of(cpu));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_masks[index].=
mask =3D ~((1UL << 36UL) - 1UL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_masks[index].=
val =3D cpu << 36UL;
>
> --
> 1.7.3.1
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
