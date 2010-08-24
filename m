From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Aug 2010 12:06:38 +0000
Subject: Re: 64-bit ppc rwsem
Message-Id: <201008241406.38539.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100818.222925.233689776.davem@davemloft.net>
	<20100823.151853.108794567.davem@davemloft.net>
	<1282613477.22370.485.camel@pasglop>
In-Reply-To: <1282613477.22370.485.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>

On Tuesday 24 August 2010, Benjamin Herrenschmidt wrote:
> On Mon, 2010-08-23 at 15:18 -0700, David Miller wrote:
> > > I've seen drivers in the past do trylocks at interrupt time ... tho
> > I
> > > agree it sucks.
> > 
> > Recently there was a thread where this was declared absolutely
> > illegal.
> > 
> > Maybe it was allowed, or sort-of worked before, and that's why it's
> > accounted for with IRQ disables in some implementations.  I don't
> > know. 
> 
> Ok, I'm happy to say it's a big no-no then.
> 
> Arnd, do you want to take over the moving to asm-generic and take care
> of the spinlock case as well ? I can send Linus the first patch that
> changes powerpc to use atomic_long now along with a few other things I
> have pending, then you can pickup from there. Or do you want me to
> continue pushing my patch as-is and we can look at cleaning up the
> spinlock case separately ?

I'm currently doing too many things at once, please push in your existing
patch for now, we can continue from there.

For the asm-generic patch:
Acked-by: Arnd Bergmann <arnd@arndb.de>
