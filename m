From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Aug 2008 22:05:02 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <1219356302.21386.147.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
In-Reply-To: <48ADDF86.2040200@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Wood <scottwood@freescale.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, David Miller <davem@davemloft.net>


> It's not really an instruction-set architecture issue, it's a binding 
> issue.  What if a non-OF embedded SPARC comes along that copies i2c from 
> a PowerPC DTS file, or we come across a real-OF PowerPC that does it the 
> SPARC way?

Like PowerMac ? :-)

Apple additionally have different ways of representing multiple busses
on one controller though. On some machines, they just use bits 0xF00 of
the address as the bus number, which is a bit gross, and on some, they
have sub-nodes i2c-bus@NN under the controller.

But at least the address encoding (shifted by 1 bit) is common with sparc
and I think is a fairly common way of representing i2c addresses.

> As far as I can tell from poking around 
> http://penguinppc.org/historical/dev-trees-html/, they don't include reg 
> at all for i2c clients.

Most of the device-trees on penguinppc.org are obsolete. i2c is mostly
used in the device-tree for newer stuff such as G5s.

Ben.


