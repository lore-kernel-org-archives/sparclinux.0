From: David Miller <davem@davemloft.net>
Date: Fri, 18 Sep 2009 00:01:56 +0000
Subject: Re: [PATCH] fix BUILD_BUG_ON() and a couple of bogus uses of it
Message-Id: <20090917.170156.152594715.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A8AEBFD0200007800010580@vpn.id2.novell.com>
	<20090917162437.b1a890de.akpm@linux-foundation.org>
In-Reply-To: <20090917162437.b1a890de.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: JBeulich@novell.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 17 Sep 2009 16:24:37 -0700

> sparc64:
> 
> In file included from arch/sparc/kernel/vio.c:17:
> /usr/src/devel/arch/sparc/include/asm/vio.h: In function `vio_dring_avail':
> /usr/src/devel/arch/sparc/include/asm/vio.h:261: error: bit-field `<anonymous>' width not an integer constant
> 
> static inline u32 vio_dring_avail(struct vio_dring_state *dr,
> 				  unsigned int ring_size)
> {
> 	BUILD_BUG_ON(!is_power_of_2(ring_size));
> 
> 	return (dr->pending -
> 		((dr->prod - dr->cons) & (ring_size - 1)));
> }
> 
> changing it to MAYBE_BUILD_BUG_ON seems to have fixed it.

That's completely bogus.

First of all, arch/sparc/kernel/vio.c never calls this function
so it should never be evaluated.

Second of all, all the places that do call this function only
pass pure constants as the 'ring_size' parameter.

drivers/block/sunvdc.c:

static inline u32 vdc_tx_dring_avail(struct vio_dring_state *dr)
{
	return vio_dring_avail(dr, VDC_TX_RING_SIZE);
}

drivers/net/sunvnet.c:

static inline u32 vnet_tx_dring_avail(struct vio_dring_state *dr)
{
	return vio_dring_avail(dr, VNET_TX_RING_SIZE);
}

Making this MAYBE_BUILD_BUG_ON shouldn't be necessary.
