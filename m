From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Aug 2008 22:05:50 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <1219356350.21386.150.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<20080821.144545.54542588.davem@davemloft.net>
In-Reply-To: <20080821.144545.54542588.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org

On Thu, 2008-08-21 at 14:45 -0700, David Miller wrote:
> > As far as I can tell from poking around 
> > http://penguinppc.org/historical/dev-trees-html/, they don't include
> reg 
> > at all for i2c clients.
> 
> That actually simplifies things for us, thanks for checking.

Unfortunately, while that may be true for old stuff, most recent
powermacs do. Encoding is mostly like sparc though (see other mails).

Ben.


