From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 22:27:01 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821.152701.261427328.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48ADDF86.2040200@freescale.com>
	<20080821.144545.54542588.davem@davemloft.net>
	<1219356350.21386.150.camel@pasglop>
In-Reply-To: <1219356350.21386.150.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Aug 2008 08:05:50 +1000

> On Thu, 2008-08-21 at 14:45 -0700, David Miller wrote:
> > > As far as I can tell from poking around 
> > > http://penguinppc.org/historical/dev-trees-html/, they don't include
> > reg 
> > > at all for i2c clients.
> > 
> > That actually simplifies things for us, thanks for checking.
> 
> Unfortunately, while that may be true for old stuff, most recent
> powermacs do. Encoding is mostly like sparc though (see other mails).

Thanks for the clarification.  The bus encoding seems different
but we can solve that too.

I've started a dialogue between Scott and the openfirmware Sun
folks I know so that hopefully Scott can get a copy of the I2C
bindings Sun uses and we can sort all of this out.
