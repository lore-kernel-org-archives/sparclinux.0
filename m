From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Aug 2008 22:39:53 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <1219358393.21386.158.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com> <1219356302.21386.147.camel@pasglop>
	<20080821.152857.84114588.davem@davemloft.net>
In-Reply-To: <20080821.152857.84114588.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org

On Thu, 2008-08-21 at 15:28 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 22 Aug 2008 08:05:02 +1000
> 
> > Apple additionally have different ways of representing multiple busses
> > on one controller though. On some machines, they just use bits 0xF00 of
> > the address as the bus number, which is a bit gross, and on some, they
> > have sub-nodes i2c-bus@NN under the controller.
> 
> Ok, Sun uses a 2-cell scheme.  We can handle both cases of reg
> encoding quite easily:
> 
> 1) If there is a single cell, tread bits 8 and above as bus number.
>    They will be zero on Sparc.

Depends if you want also to handle 10-bit addresses... though the
support for that could be enabled by an explicit property
10-bit-addresses in the controller node...  But as I said before, I
wouldn't worry too much about powermac for now, it's not using this code
and may never do.

> 2) If there are two cells, first cell is bus number.
> 
> For the hierarchical case, I'm not so sure how to handle it.
> 
> Also, last night, I posted patches to the I2C list to add bus
> addressing support to the I2C code and the PCF algo implementation.

Ben.


