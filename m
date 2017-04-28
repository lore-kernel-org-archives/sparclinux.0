From: Petr Mladek <pmladek@suse.com>
Date: Fri, 28 Apr 2017 12:38:38 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170428123838.GZ3452@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170428012530.GA383@jagdpanzerIV.localdomain>
In-Reply-To: <20170428012530.GA383@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2017-04-28 10:25:30, Sergey Senozhatsky wrote:
> 
> On (04/20/17 15:11), Petr Mladek wrote:
> [..]
> >  void printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	/*
> > +	 * The size of the extra per-CPU buffer is limited. Use it
> > +	 * only when really needed.
> > +	 */
> > +	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
> > +	    raw_spin_is_locked(&logbuf_lock)) {
> 
> can we please have && here?

OK, it sounds reasonable after all.

> [..]
> > diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> > index 4e8a30d1c22f..0bc0a3535a8a 100644
> > --- a/lib/nmi_backtrace.c
> > +++ b/lib/nmi_backtrace.c
> > @@ -86,9 +86,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> >  
> >  bool nmi_cpu_backtrace(struct pt_regs *regs)
> >  {
> > +	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
> >  	int cpu = smp_processor_id();
> >  
> >  	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
> > +		arch_spin_lock(&lock);
> >  		if (regs && cpu_in_idle(instruction_pointer(regs))) {
> >  			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
> >  				cpu, instruction_pointer(regs));
> > @@ -99,6 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
> >  			else
> >  				dump_stack();
> >  		}
> > +		arch_spin_unlock(&lock);
> >  		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
> >  		return true;
> >  	}
> 
> can the nmi_backtrace part be a patch on its own?

I would prefer to keep it in the same patch. The backtrace from
all CPUs is completely unusable when all CPUs push to the global
log buffer in parallel. Single patch might safe hair of some
poor bisectors.

Best Regards,
Petr
