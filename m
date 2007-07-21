From: David Miller <davem@davemloft.net>
Date: Sat, 21 Jul 2007 00:20:16 +0000
Subject: Re: [PATCH 6/7] sparc64: fix section mismatch warning in pci_sunv4
Message-Id: <20070720.172016.104030827.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070720213440.GG25064@uranus.ravnborg.org>
In-Reply-To: <20070720213440.GG25064@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2007 23:34:40 +0200

> Fix following warning:
> WARNING: vmlinux.o(.text+0x3cf50): Section mismatch: reference to .init.text:page_in_phys_avail (between 'pci_sun4v_pbm_init' and 'sun4v_pci_init')
> 
> pci_sun4v_pbm_init and sun4v_pci_init was only used under __init
> context so declare them _init.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
