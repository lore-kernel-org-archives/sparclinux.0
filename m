From: David Miller <davem@davemloft.net>
Date: Fri, 18 Mar 2011 22:02:03 +0000
Subject: Re: [PATCH] sparc: Implement irq_of_parse_and_map().
Message-Id: <20110318.150203.191419887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110318.145443.68116964.davem@davemloft.net>
In-Reply-To: <20110318.145443.68116964.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 18 Mar 2011 14:54:43 -0700 (PDT)

> 
> Mostly this is to get allmodconfig builds going clean again.
> Drivers using this interface aren't actually even possible
> on sparc systems.
> 
> On sparc we pre-compute IRQ values, therefore the implementation
> is simply to find the platform_device which matches the given
> device node, then return the pre-computed IRQ value if the
> requested index is in-range.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Ok, obviously this patch is bogus because we already have
an implementation in of_device_common.c

The real issue is the lack of NO_IRQ definition so I'll simply
add a patch for those defines instead.
