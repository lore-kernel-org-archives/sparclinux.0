From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 14 Jan 2009 20:08:39 +0000
Subject: Re: sparc32 compile error: =?utf-8?Q?redef?=
Message-Id: <20090114200839.GA1556@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <496D4274.6000304@earthlink.net> <20090113.181039.185575172.davem@davemloft.net> <20090113184239.e6b6e68e.akpm@linux-foundation.org> <20090113184536.95ebc973.akpm@linux-foundation.org> <496D5E19.7040802@earthlink.net> <20090113235940.12d856d0.akpm@linux-foundation.org> <20090114153255.GA32082@uranus.ravnborg.org> <20090114102544.71893225.akpm@linux-foundation.org>
In-Reply-To: <20090114102544.71893225.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Robert Reif <reif@earthlink.net>, David Miller <davem@davemloft.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, mingo@elte.hu, linux-kernel@vger.kernel.org

On Wed, Jan 14, 2009 at 10:25:44AM -0800, Andrew Morton wrote:
> On Wed, 14 Jan 2009 16:32:55 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Tue, Jan 13, 2009 at 11:59:40PM -0800, Andrew Morton wrote:
> > > On Tue, 13 Jan 2009 22:38:01 -0500 Robert Reif <reif@earthlink.net> wrote:
> > > 
> > > > This worked:
> > > > 
> > > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > > index 2aebc4c..368227d 100644
> > > > --- a/kernel/Makefile
> > > > +++ b/kernel/Makefile
> > > > @@ -43,8 +43,10 @@ obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
> > > >  ifeq ($(CONFIG_USE_GENERIC_SMP_HELPERS),y)
> > > >  obj-y += smp.o
> > > >  else
> > > > +ifneq ($(CONFIG_SMP),y)
> > > >  obj-y += up.o
> > > >  endif
> > > > +endif
> > > >  obj-$(CONFIG_SMP) += spinlock.o
> > > >  obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
> > > >  obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
> > > 
> > > This all can be simplified, can't it?
> > > 
> > > obj-$(CONFIG_USE_GENERIC_SMP_HELPERS) += smp.o
> > > ifneq ($(CONFIG_SMP),y)
> > > obj-y += up.o
> > > endif
> > > 
> > > (someone please check my homework - I don't have a good track
> > > record here ;))
> > 
> > Looks correct. We pull in smp.o only for SPARC64 AND SMP
> 
> SPARC64=n and SMP, actually (assuming sparc64 is the only
> USE_GENERIC_SMP_HELPERS=n arch)
> 
> > But I find the next lines distastefull in a Makefile:
> > > ifneq ($(CONFIG_SMP),y)
> > > obj-y += up.o
> > > endif
> 
> me too.
> 
> > I would prefer a small Kconfig helper symbol:
> > 
> > config SPARC_UP
> > 	def_bool y
> > 	depends on !SMP
> > 
> > And then we would do the Makefile bits like this:
> > obj-$(CONFIG_SPARC_UP) += up.o
> 
> eek.  Mentioning sparc explicitly in kernel/Makefile is badder.

Ups - I my horry I did not notice this was _taht_ kernel/Makefile.

> 
> we could remove zillions of these conditionals if something somewhere
> were to generate negated symbols for us.  Say, when kbuild sees
> CONFIG_SMP=y, it will generate another symbol: NOT_CONFIG_SMP=y.  So
> then we can do
> 
> obj-$NOT_CONFIG_SMP += up.o
> 
> Or is that too cheesy?

If we can remove a zillion lines - then no.
But maybe the actual figure is a bit less :-)

	Sam
