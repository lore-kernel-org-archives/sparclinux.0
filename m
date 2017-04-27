From: Petr Mladek <pmladek@suse.com>
Date: Thu, 27 Apr 2017 15:28:07 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170427152807.GY3452@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
 <20170427103118.56351d30@gandalf.local.home>
In-Reply-To: <20170427103118.56351d30@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu 2017-04-27 10:31:18, Steven Rostedt wrote:
> On Thu, 27 Apr 2017 15:38:19 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > > by the way,
> > > does this `nmi_print_seq' bypass even fix anything for Steven?  
> > 
> > I think that this is the most important question.
> > 
> > Steven, does the patch from
> > https://lkml.kernel.org/r/20170420131154.GL3452@pathway.suse.cz
> > help you to see the debug messages, please?
> 
> You'll have to wait for a bit. The box that I was debugging takes 45
> minutes to reboot. And I don't have much more time to play on it before
> I have to give it back. I already found the bug I was looking for and
> I'm trying not to crash it again (due to the huge bring up time).

I see.

> When I get a chance, I'll see if I can insert a trigger to crash the
> kernel from NMI on another box and see if this patch helps.

I actually tested it here using this hack:

diff --cc lib/nmi_backtrace.c
index d531f85c0c9b,0bc0a3535a8a..000000000000
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@@ -89,8 -90,7 +90,9 @@@ bool nmi_cpu_backtrace(struct pt_regs *
        int cpu = smp_processor_id();
  
        if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
 +              if (in_nmi())
 +                      panic("Simulating panic in NMI\n");
+               arch_spin_lock(&lock);
                if (regs && cpu_in_idle(instruction_pointer(regs))) {
                        pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
                                cpu, instruction_pointer(regs));

and triggered by:

   echo  l > /proc/sysrq-trigger

The patch really helped to see much more (all) messages from the ftrace
buffers in NMI mode.

But the test is a bit artifical. The patch might not help when there
is a big printk() activity on the system when the panic() is
triggered. We might wrongly use the small per-CPU buffer when
the logbuf_lock is tested and taken on another CPU at the same time.
It means that it will not always help.

I personally think that the patch might be good enough. I am not sure
if a perfect (more comlpex) solution is worth it.

Best Regards,
Petr
