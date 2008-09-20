From: David Miller <davem@davemloft.net>
Date: Sat, 20 Sep 2008 03:42:22 +0000
Subject: Re: [PATCH]: Updated PROM sun4m IRQ register patch.
Message-Id: <20080919.204222.128625344.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080913.214526.47086017.davem@davemloft.net>
In-Reply-To: <20080913.214526.47086017.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 19 Sep 2008 22:27:13 -0400

> > @@ -272,17 +272,18 @@ smp4m_ticker:
> >  	 */
> >  maybe_smp4m_msg:
> >  	GET_PROCESSOR4M_ID(o3)
> > -	set	sun4m_interrupts, %l5
> > -	ld	[%l5], %o5
> > +	sethi	%hi(sun4m_irq_percpu), %l5
> > +	sll	%o3, 2, %o3
> > +	or	%l5, %lo(sun4m_irq_percpu), %l5
> >   
> This patch works SMP when this line is changed to:
>        or      %l5, %lo(sun4m_irq_percpu), %o5

Thanks a lot Robert, I'll fix that up and check this in.
