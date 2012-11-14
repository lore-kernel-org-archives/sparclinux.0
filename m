From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Nov 2012 12:23:21 +0000
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
Message-Id: <201211141223.21696.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net> <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com> <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
In-Reply-To: <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Monday 12 November 2012, Stephen Rothwell wrote:
>   Show Details
>   Make if easier for more architectures to select it and thus disable
> drivers that use virt_to_bus().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Very nice, I was recently looking into enabling this for ARM
as well, at least for the platforms that are known to not
need virt_to_bus.

Acked-by: Arnd Bergmann <arnd@arndb.de>
