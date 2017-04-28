From: Petr Mladek <pmladek@suse.com>
Date: Fri, 28 Apr 2017 12:57:25 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170428125725.GA3452@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
 <20170428013532.GB383@jagdpanzerIV.localdomain>
In-Reply-To: <20170428013532.GB383@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2017-04-28 10:35:32, Sergey Senozhatsky wrote:
> On (04/27/17 12:14), Steven Rostedt wrote:
> [..]
> > I tried this patch. It's better because I get the end of the trace, but
> > I do lose the beginning of it:
> > 
> > ** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path
>
> many thanks!
> 
> so we now drop messages from logbuf, not from per-CPU buffers. that
> "queue printk_deferred irq_work on every online CPU when we bypass per-CPU
> buffers from NMI" idea *probably* might help here - we need someone to emit
> messages from the logbuf while we printk from NMI. there is still a
> possibility that we can drop messages, though, since log_store() from NMI
> CPU can be much-much faster than call_console_drivers() on other CPU.

ftrace log is dumped via trace_panic_notifier. It is done after
smp_send_stop(). It means that only a single CPU is available and
it is NMI context at the moment.

One possibility might be to put printk into a special mode and
drop the last messages instead of the first ones. But this would
need to be configurable.

Of course, if the problem is reproducible, the easiest solution
is to use bigger main log buffer, for example boot with
log_buf_len2M.

Best Regards,
Petr
