From: David Miller <davem@davemloft.net>
Date: Thu, 19 Jul 2007 23:48:16 +0000
Subject: Re: [PATCH 02/12] Start split out of common open firmware code
Message-Id: <20070719.164816.25912004.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720010911.01402add.sfr@canb.auug.org.au>
In-Reply-To: <20070720010911.01402add.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:09:11 +1000

> This creates drivers/of/base.c (depending on CONFIG_OF) and puts
> the first trivially common bits from the prom.c files into it.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.

