From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 00:45:31 +0000
Subject: Re: [PATCH 04/12] Consolidate of_find_property
Message-Id: <20070719.174531.03979262.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011127.8c700e59.sfr@canb.auug.org.au>
In-Reply-To: <20070720011127.8c700e59.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:11:27 +1000

> The only change here is that a readlock is taken while the property list
> is being traversed on Sparc where it was not taken previously.
> 
> Also, Sparc uses strcasecmp to compare property names while PowerPC
> uses strcmp.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.

