From: Pete Zaitcev <zaitcev@redhat.com>
Date: Mon, 05 Jan 2004 04:17:01 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <20040105041701.GA29126@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 04, 2004 at 02:48:28PM -0800, Keith M Wesolowski wrote:
> On Sun, Jan 04, 2004 at 04:38:06PM -0600, Tom 'spot' Callaway wrote:

> > @@ -10,6 +10,7 @@
> >  # The new 8250/16550 serial drivers
> >  config SERIAL_8250
> >  	tristate "8250/16550 and compatible serial support"
> > +	depends on !SPARC32
> >  	select SERIAL_CORE
> >  	---help---
> >  	  This selects whether you want to include the driver for the standard
> 
> This really isn't the right thing to depend on, although I'm not sure
> what is.  This chip is found almost everywhere.

We use sunsu to drive it. I thought about switching to 8250,
but never got around to do it.

-- Pete
