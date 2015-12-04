From: Petr Mladek <pmladek@suse.com>
Date: Fri, 04 Dec 2015 15:27:09 +0000
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI context
Message-Id: <20151204152709.GA20935@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
In-Reply-To: <20151201234437.GA8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue 2015-12-01 23:44:37, Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> > What we can do, though, is to zap all printk locks. We already do this
> > when a printk recursion is detected. This should be safe because
> > the system is crashing and there shouldn't be any printk caller
> > that would cause the deadlock.
> 
> What about serial consoles which may call out to subsystems like the
> clk subsystem to enable a clock, which would want to take their own
> spinlocks in addition to the serial console driver?

Yes, there might be more locks used by the serial console but I do
not know how to handle them all easily. IMHO, this patch is just better
than nothing.

> I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> trying to make this work in NMI context strikes me as making the
> existing solution more unreliable on ARM systems.

bust_spinlocks() calls printk_nmi_flush() that would call printk()
that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
Yes, there might be more locks blocked but we try to break at least
the first two walls. Also zapping is allowed only once per 30 seconds,
see zap_locks(). Why do you think that it might make things more
unreliable, please?


Thanks for looking,
Petr
