From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 28 Apr 2017 01:35:32 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170428013532.GB383@jagdpanzerIV.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
In-Reply-To: <20170427121458.2be577cc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On (04/27/17 12:14), Steven Rostedt wrote:
[..]
> I tried this patch. It's better because I get the end of the trace, but
> I do lose the beginning of it:
> 
> ** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path

many thanks!

so we now drop messages from logbuf, not from per-CPU buffers. that
"queue printk_deferred irq_work on every online CPU when we bypass per-CPU
buffers from NMI" idea *probably* might help here - we need someone to emit
messages from the logbuf while we printk from NMI. there is still a
possibility that we can drop messages, though, since log_store() from NMI
CPU can be much-much faster than call_console_drivers() on other CPU.

	-ss
