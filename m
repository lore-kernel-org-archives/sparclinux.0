From: Petr Mladek <pmladek@suse.com>
Date: Tue, 08 Dec 2015 11:21:45 +0000
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI context
Message-Id: <20151208112145.GK20935@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
In-Reply-To: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> Take the scenario where CPU1 is in the middle of a printk(), and is
> holding its lock.
> 
> CPU0 comes along and decides to trigger a NMI backtrace.  This sends
> a NMI to CPU1, which takes it in the middle of the serial console
> output.
> 
> With the existing solution, the NMI output will be written to the
> temporary buffer, and CPU1 has finished handling the NMI it resumes
> the serial console output, eventually dropping the lock.  That then
> allows CPU0 to print the contents of all buffers, and we get NMI
> printk output.
> 
> With this solution, as I understand it, we'll instead end up with
> CPU1's printk trying to output direct to the console, and although
> we've busted a couple of locks, we won't have busted the serial
> console locks, so CPU1 will deadlock - and that will stop any output
> what so ever.
> 
> If this is correct, then the net result is that we go from NMI with
> serial console producing output to NMI with serial console being
> less reliable at producing output.

You are right. I thought about it a lot and I think that the best
solution is to avoid this patch at all. I guess that it will make
Peter Zijlstra happy as well.

Best Regards,
Petr
