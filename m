From: David Miller <davem@davemloft.net>
Date: Mon, 08 Dec 2008 07:42:50 +0000
Subject: Re: [PATCH] use sparc64 version of prom/printf.c
Message-Id: <20081207.234250.08989512.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <493C1616.6080206@earthlink.net>
In-Reply-To: <493C1616.6080206@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sun, 07 Dec 2008 20:53:40 -0500

> Sam Ravnborg wrote:
> > Hi Robert.
> >
> > On Sun, Dec 07, 2008 at 01:29:42PM -0500, Robert Reif wrote:
> >   
> >> Use sparc64 version of prom/printf.c.
> >>
> >> The only differences for sparc32 is that prom_printf is no longer exported for modules which should be OK.
> >>     
> >
> > cyber200fb uses prom_prinf and can be built as a module.
> > >From Kconfig:
> >
> > config FB_CYBER2000
> >         tristate "CyberPro 2000/2010/5000 support"
> >         depends on FB && PCI && (BROKEN || !SPARC64)
> >
> > So it looks to me we should keep the EXPORT.
> >
> > 	Sam
> >
> >   
> Since this is the only driver that can use prom_printf in a module
> and it appears that the only sparc system that uses it is an unreleased
> version of the java station, wouldn't it be better to change the
> prom_printf to a printk in this driver?

That's a reasonable way to handle this problem.

The reason that prom_printf() tends to be widespread
is that long ago we didn't have a "-p" kernel boot
command line option which is useful for debugging
console driver failures.

Otherwise you don't get the message so have no idea
what has gone wrong :)

I'll sort this out, thanks guys.
