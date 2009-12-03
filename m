From: David Miller <davem@davemloft.net>
Date: Thu, 03 Dec 2009 21:29:04 +0000
Subject: Re: No MC sched domains
Message-Id: <20091203.132904.256296994.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Thu, 3 Dec 2009 20:53:35 +0100 (CET)

> 
> On Wednesday 2009-12-02 23:57, David Miller wrote:
> 
>>From: Jan Engelhardt <jengelh@medozas.de>
>>Date: Wed, 2 Dec 2009 19:41:34 +0100 (CET)
>>
>>> the T1 is said to be multi-core, however, I am not seeing any MC sched 
>>> levels in dmesg as I do on x86. Why is that?
>>
>>The T1 cores are repesented as SMT units.
>>
>>On multi-chip T2 systems such as 5140 et al., we use MC to repesent
>>the physical CPU chips.
> 
> Well I wonder, because htop gives me only something like the following
> on `nice -n20 make -j24` in a Linux kernel build, and it surprises
> me that it does not use all threads. I can generated some userspace
> compiling load that distributes equally over all 24 threads, though.
> Could it be something with the scheduler, or this very fact that
> they are represented as SIBLING rather than MC?

I've never used htop, I'll have to check it out.

When I have checked in the past when I do "make -jN" builds on T1
the scheduler fills processes the first of every 4 cpus, then the
second on every 4 cpus, etc. etc.  loading the cores evenly as
the number of processes increases.

And that's the desired behavior.

On T2 we have 8 threads per core, but two integer units (one
for every 4 cpu threads) so the scheduler fills (within a core)
cpu 1 on all cores, then cpu 4 on all cores, then cpu 2 on all
cores, then cpu 5 on all cores, etc. etc.

If this isn't happening, please investigate further :-)
