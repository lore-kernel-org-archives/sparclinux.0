From: David Miller <davem@davemloft.net>
Date: Sat, 07 Apr 2012 17:40:42 +0000
Subject: Re: [sparc] BUG: NMI Watchdog detected LOCKUP on CPU0
Message-Id: <20120407.134042.985073951336791482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1333819298.7150.63.camel@deadeye>
In-Reply-To: <1333819298.7150.63.camel@deadeye>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 07 Apr 2012 18:21:38 +0100

> cheetah_xcall_deliver() does appear to be relevant to the problem and it
> looks like it could loop indefinitely - though presumably only if a
> processor is behaving strangely?

I can only loop indefinitely if one of the cpus is hung and
does not respond to the cross-call interrupt.

> It appears to periodically enable and disable interrupts, but then
> I'm not sure how the PSTATE.IE and PIL interrupt control fields
> interact and I don't think this will reset the NMI watchdog.

PSTATE.IE controls delivery of all interrupts, both PIL
based and vectored interrupts.

PIL only controls delivery of PIL interrupts.

The NMI watchdog interrupt is a special PIL interrupt, and
most of the standard local_irq_disable() et al. routines on
sparc will adjust the %pil such that NMI watchdog interrupts
are still delivered.

See include/asm/pil.h for details.

