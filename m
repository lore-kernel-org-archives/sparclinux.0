From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 22:28:57 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821.152857.84114588.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<1219356302.21386.147.camel@pasglop>
In-Reply-To: <1219356302.21386.147.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Aug 2008 08:05:02 +1000

> Apple additionally have different ways of representing multiple busses
> on one controller though. On some machines, they just use bits 0xF00 of
> the address as the bus number, which is a bit gross, and on some, they
> have sub-nodes i2c-bus@NN under the controller.

Ok, Sun uses a 2-cell scheme.  We can handle both cases of reg
encoding quite easily:

1) If there is a single cell, tread bits 8 and above as bus number.
   They will be zero on Sparc.

2) If there are two cells, first cell is bus number.

For the hierarchical case, I'm not so sure how to handle it.

Also, last night, I posted patches to the I2C list to add bus
addressing support to the I2C code and the PCF algo implementation.
