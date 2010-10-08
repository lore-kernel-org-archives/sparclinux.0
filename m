From: David Miller <davem@davemloft.net>
Date: Fri, 08 Oct 2010 21:20:13 +0000
Subject: Re: [PATCH v3] sparc: convert various prom_* functions to use
Message-Id: <20101008.142013.68132581.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008141811.19074b7c@debxo>
In-Reply-To: <20101008141811.19074b7c@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dilinger@queued.net
Cc: grant.likely@secretlab.ca, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Andres Salomon <dilinger@queued.net>
Date: Fri, 8 Oct 2010 14:18:11 -0700

> 
> Rather than passing around ints everywhere, use the
> phandle type where appropriate for the various functions
> that talk to the PROM.
> 
> v3: revert v2 changes, and include linux/of.h in openprom.h
>     instead of linux/types.h.
> 
> Note: this has only been compile-tested for 64bit sparc.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Acked-by: David S. Miller <davem@davemloft.net>
