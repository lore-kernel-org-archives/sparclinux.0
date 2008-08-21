From: Scott Wood <scottwood@freescale.com>
Date: Thu, 21 Aug 2008 21:35:02 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <48ADDF86.2040200@freescale.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001012.265401427.davem@davemloft.net>	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
In-Reply-To: <20080821.142134.127315039.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

David Miller wrote:
>> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
>>> 2) When CONFIG_SPARC, shift the device address down by one bit before
>>>    giving it to the Linux I2C layer.
>> Maybe we should distinguish by the type of I2C bus node instead.
> 
> How so?  If a Sparc and a PowerPC system use similar I2C
> controllers, we risk double matches.

It's not really an instruction-set architecture issue, it's a binding 
issue.  What if a non-OF embedded SPARC comes along that copies i2c from 
a PowerPC DTS file, or we come across a real-OF PowerPC that does it the 
SPARC way?

If we do come across two systems that claim their i2c bus nodes are 
compatible but use different bindings, *then* we'll find some 
out-of-band information to disambiguate.

> If you guys created this format in your compressed openfirmware
> trees, is it possible for you to "fix" it to match what Sparc
> systems following the proper bindings do?

Possibly, though it'll cause some pain when old trees are used with a 
kernel that expects the new binding.

You mentioned having an actual binding document for I2C on Open 
Firmware; is it available online anywhere?

> Don't PowerMACs and such have I2C controllers and devices?
> How do they encode these I2C client device reg properties?

As far as I can tell from poking around 
http://penguinppc.org/historical/dev-trees-html/, they don't include reg 
at all for i2c clients.

-Scott
