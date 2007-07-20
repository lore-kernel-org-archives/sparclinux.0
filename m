From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 03:21:26 +0000
Subject: Re: [PATCH 08/12] Begin to consolidate of_device.c
Message-Id: <20070719.202126.59466393.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011612.cc101b92.sfr@canb.auug.org.au>
In-Reply-To: <20070720011612.cc101b92.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:16:12 +1000

> This moves all the common parts for the Sparc, Sparc64 and PowerPC
> of_device.c files into drivers/of/device.c.
> 
> Apart from the simple move, Sparc gains of_match_node() and a call to
> of_node_put in of_release_dev().  PowerPC gains better recovery if
> device_create_file() fails in of_device_register().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.
