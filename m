From: David Miller <davem@davemloft.net>
Date: Fri, 07 Jul 2006 10:15:22 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <20060707.031522.102553069.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 07 Jul 2006 12:09:15 +0200

> I would like, but Xserver over fbdev doesn't work. Accelerated Xserver 
> too because in Xorg is bug with multi PCI domain and driver doesn't 
> recognize my Raptor card :-).

Yes, these problems are known.

In fact I was playing with a Raptor card in an SB2500 just
the other week.

But those problems are totally unrelated to the ioctl messages.
