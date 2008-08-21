From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 21:21:34 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821.142134.127315039.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: scottwood@freescale.com
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

From: Scott Wood <scottwood@freescale.com>
Date: Thu, 21 Aug 2008 11:32:56 -0500

> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> > 2) When CONFIG_SPARC, shift the device address down by one bit before
> >    giving it to the Linux I2C layer.
> 
> Maybe we should distinguish by the type of I2C bus node instead.

How so?  If a Sparc and a PowerPC system use similar I2C
controllers, we risk double matches.

If you guys created this format in your compressed openfirmware
trees, is it possible for you to "fix" it to match what Sparc
systems following the proper bindings do?

This way we won't need any of these ifdefs at all.

Don't PowerMACs and such have I2C controllers and devices?
How do they encode these I2C client device reg properties?
