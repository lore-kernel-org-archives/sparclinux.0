From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Aug 2008 22:38:23 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <1219358303.21386.155.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <48ADDF86.2040200@freescale.com>
	<20080821.144545.54542588.davem@davemloft.net>
	<1219356350.21386.150.camel@pasglop>
	<20080821.152701.261427328.davem@davemloft.net>
In-Reply-To: <20080821.152701.261427328.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org


> Thanks for the clarification.  The bus encoding seems different
> but we can solve that too.
> 
> I've started a dialogue between Scott and the openfirmware Sun
> folks I know so that hopefully Scott can get a copy of the I2C
> bindings Sun uses and we can sort all of this out.

Sure. Currently the powermac stuff isn't too relevant because I
use my own infrastructure (not a huge thing, but I have a special
layer of low level polled i2c drivers that I can use early during
boot or during low level suspend/resume with IRQs off etc... that
hooks up on to the main linux i2c stack etc...)

So I'll let you guys come up with something, and we can later see if
there's any interest in moving some of the pmac stuff over to it.

Ben.



