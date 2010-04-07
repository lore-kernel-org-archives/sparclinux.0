From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 07 Apr 2010 07:24:19 +0000
Subject: Re: [PATCH 1/2] sparc64: Implement local_irq_save_nmi().
Message-Id: <1270625059.5109.537.camel@twins>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406.163955.28809295.davem@davemloft.net>
	 <1270623146.5109.532.camel@twins>
	 <20100407.000625.203083228.davem@davemloft.net>
In-Reply-To: <20100407.000625.203083228.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 2010-04-07 at 00:06 -0700, David Miller wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed, 07 Apr 2010 08:52:26 +0200
> 
> > On Tue, 2010-04-06 at 16:39 -0700, David Miller wrote:
> >> @@ -49,6 +49,16 @@ static inline void raw_local_irq_disable(void)
> >>  	);
> >>  }
> >>  
> >> +static inline void raw_local_irq_disable_nmi(void)
> >> +{
> >> +	__asm__ __volatile__(
> >> +		"wrpr	%0, %%pil"
> >> +		: /* no outputs */
> >> +		: "i" (PIL_NMI)
> >> +		: "memory"
> >> +	);
> >> +}
> >> +
> > 
> > Isn't this wrong when used from !NMI context?
> > 
> > Should this thing do something like:
> > 
> >   if (rdpr() < PIL_NORMAL_MAX)
> >     wrpr(PIL_NORMAL_MAX);
> > 
> > so that it only disables IRQs, but doesn't enable NMIs.
> 
> It's immaterial, local_irq_restore() will do the right thing,
> and it's ok to disable NMIs in these few cases I think.
> 
> I desperately want to avoid that "test and maybe change the
> value %pil value we write" business, and honestly that's
> the whole point of this exercise.

Sure, its your architecture.. but could you explain why you're trying to
avoid that compare so desperately, the local_irq_save_nmi() calls are
few so surely they could carry that overhead.

Also, doesn't __raw_local_irq_save_flags() already do the read? So its
really just the compare that's gone missing.
