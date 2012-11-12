From: David Miller <davem@davemloft.net>
Date: Mon, 12 Nov 2012 21:27:23 +0000
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
Message-Id: <20121112.162723.264622334265396904.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
	<CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
	<20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
In-Reply-To: <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: akpm@linux-foundation.org, bhelgaas@google.com, hartleys@visionengravers.com, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Nov 2012 08:26:15 +1100

> Make if easier for more architectures to select it and thus disable
> drivers that use virt_to_bus().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>
