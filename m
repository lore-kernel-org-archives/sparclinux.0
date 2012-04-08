From: David Miller <davem@davemloft.net>
Date: Sun, 08 Apr 2012 21:49:35 +0000
Subject: Re: [sparc] BUG: NMI Watchdog detected LOCKUP on CPU0
Message-Id: <20120408.174935.1422476833112543503.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1333819298.7150.63.camel@deadeye>
In-Reply-To: <1333819298.7150.63.camel@deadeye>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 08 Apr 2012 22:12:06 +0100

> Will the recipient NACK if the cross-call interrupt is disabled, or do
> the processors have a buffer/FIFO for such IRQs?

Recipient's NACK when their incoming cross-call queue is
full.  A cpu hung with PSTATE_IE clear will not take
vectorred interrupts and therefore not empty the queue.

> Obviously the NMI watchdog is not being disabled, but I was wondering
> how its timer gets reset.

The NMI watchdog is controlled by the performance counter
infrastructure.

When the performance counters are not being used for 'perf',
they are used to implement the NMI watchdog.

See arch/sparc/kernel/{pcr,nmi}.c
