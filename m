From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 21:45:45 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821.144545.54542588.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
In-Reply-To: <48ADDF86.2040200@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: scottwood@freescale.com
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

From: Scott Wood <scottwood@freescale.com>
Date: Thu, 21 Aug 2008 16:35:02 -0500

> David Miller wrote:
> > If you guys created this format in your compressed openfirmware
> > trees, is it possible for you to "fix" it to match what Sparc
> > systems following the proper bindings do?
> 
> Possibly, though it'll cause some pain when old trees are used with a 
> kernel that expects the new binding.
> 
> You mentioned having an actual binding document for I2C on Open 
> Firmware; is it available online anywhere?

It's a Sun internal document I got from a Sun employee, I'll ask
if there is a way I can at least share it with you privately so
you can use it as a reference.

> > Don't PowerMACs and such have I2C controllers and devices?
> > How do they encode these I2C client device reg properties?
> 
> As far as I can tell from poking around 
> http://penguinppc.org/historical/dev-trees-html/, they don't include reg 
> at all for i2c clients.

That actually simplifies things for us, thanks for checking.
