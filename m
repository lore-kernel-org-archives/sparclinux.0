From: Petr Mladek <pmladek@suse.com>
Date: Tue, 08 Dec 2015 14:49:06 +0000
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI context
Message-Id: <20151208144906.GL20935@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
 <063D6719AE5E284EB5DD2968C1650D6D1CBE68C7@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBE68C7@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 2015-12-07 15:48:33, David Laight wrote:
> From: Russell King - ARM Linux
> > Sent: 04 December 2015 17:13
> ...
> > I have a slightly different view...
> > 
> > > > I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> > > > trying to make this work in NMI context strikes me as making the
> > > > existing solution more unreliable on ARM systems.
> > >
> > > bust_spinlocks() calls printk_nmi_flush() that would call printk()
> > > that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
> > > Yes, there might be more locks blocked but we try to break at least
> > > the first two walls. Also zapping is allowed only once per 30 seconds,
> > > see zap_locks(). Why do you think that it might make things more
> > > unreliable, please?
> > 
> > Take the scenario where CPU1 is in the middle of a printk(), and is
> > holding its lock.
> > 
> > CPU0 comes along and decides to trigger a NMI backtrace.  This sends
> > a NMI to CPU1, which takes it in the middle of the serial console
> > output.
> > 
> > With the existing solution, the NMI output will be written to the
> > temporary buffer, and CPU1 has finished handling the NMI it resumes
> > the serial console output, eventually dropping the lock.  That then
> > allows CPU0 to print the contents of all buffers, and we get NMI
> > printk output.
> 
> Is the traceback from inside printk() or serial console code
> likely to be useful?

It is useful if a problem is caused by the printk or serial console
code. For example, a slow serial console might cause a soft lockup
if there are too many messages to print.


> If not then why not get the stacktrace generated when the relevant
> lock is released? That should save any faffing with a special
> buffer.

Another question is how to detect that NMI interrupted printk() code.
We would either need to analyze backtrace. Or we would need to
know which CPU took the printk() or console locks. This check
should be race-safe vs. the NMI context.


Best Regards,
Petr
