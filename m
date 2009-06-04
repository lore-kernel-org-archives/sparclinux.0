From: David Miller <davem@davemloft.net>
Date: Thu, 04 Jun 2009 04:59:23 +0000
Subject: Re: [PATCH] sparc64: fix and optimize irq distribution
Message-Id: <20090603.215923.07197223.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Wed,  3 Jun 2009 12:41:02 -0400

> irq_choose_cpu() should compare the affinity mask against cpu_online_map
> rather than CPU_MASK_ALL, since irq_select_affinity() sets the interrupt's
> affinity mask to cpu_online_map "and" CPU_MASK_ALL (which ends up being
> just cpu_online_map).  The mask comparison in irq_choose_cpu() will always
> fail since the two masks are not the same.  So the CPU chosen is the first CPU
> in the intersection of cpu_online_map and CPU_MASK_ALL, which is always CPU0.
> That means all interrupts are reassigned to CPU0...
> 
> Distributing interrupts to CPUs in a linearly increasing round robin fashion
> is not optimal for the UltraSPARC T1/T2.  Also, the irq_rover in
> irq_choose_cpu() causes an interrupt to be assigned to a different
> processor each time the interrupt is allocated and released.  This may lead
> to an unbalanced distribution over time.
> 
> A static mapping of interrupts to processors is done to optimize and balance
> interrupt distribution.  For the T1/T2, interrupts are spread to different
> cores first, and then to strands within a core.
> 
> The following is some benchmarks showing the effects of interrupt
> distribution on a T2.  The test was done with iperf using a pair of T5220
> boxes, each with a 10GBe NIU (XAUI) connected back to back.
> 
>   TCP     | Stock       Linear RR IRQ  Optimized IRQ
>   Streams | 2.6.30-rc5  Distribution   Distribution
>           | GBits/sec   GBits/sec      GBits/sec
>   --------+-----------------------------------------
>     1       0.839       0.862          0.868
>     8       1.16        4.96           5.88
>    16       1.15        6.40           8.04
>   100       1.09        7.28           8.68
> 
> Signed-off-by: Hong H. Pham <hong.pham@windriver.com>

Applied to sparc-next-2.6, thanks a lot!

WRT. the NIU interrupt bug, I'm still thinking about how to make
further progress on that one.  I'll post a followup soon.
