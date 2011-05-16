From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 20:08:31 +0000
Subject: Re: [PATCH 0/4 v2] sparc32: SMP IPI patches
Message-Id: <20110516.130831.112602825.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DBE8275.5060604@gaisler.com>
In-Reply-To: <4DBE8275.5060604@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 02 May 2011 12:07:49 +0200

> I have made a new set of IPI patches, this time it includes patches
> for all SPARC32 architectures. It looks to me as if sun4d does not
> have a pending soft-IRQ register, so I handle it as a normal hard IRQ.
> 
> I'm not sure if I should add a STBAR/memory barrier or a spinlock to
> the sun4d implementation of smp4d_ipi_{single,mask_one,resched}. I'm a
> bit worried that the memory write happens after the IPI is generated
> to the other CPUs. Also, I'm not sure that IRQ14 is the best choice
> for IPI, the best is probably of put it on a separate IRQ but I don't
> know if there are free IRQs.
> 
> I hope that someone could try SMP on sun4m and sun4d with these
> patches.

I'm not going to hold these patches back, if we find bugs that
need to be fixed on sun4m/sun4d then we will simply fix them.

Thanks for fixing a problem we've had for such a long time.
