From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 00:24:39 +0000
Subject: Re: [PATCH 03/12] Consolidate of_device_is_compatible
Message-Id: <20070719.172439.07641745.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011012.4eca281d.sfr@canb.auug.org.au>
In-Reply-To: <20070720011012.4eca281d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:10:12 +1000

> The only difference here is that Sparc uses strncmp to match compatibility
> names while PowerPC uses strncasecmp.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.

