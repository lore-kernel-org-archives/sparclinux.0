From: David Miller <davem@davemloft.net>
Date: Fri, 07 Jul 2006 07:17:07 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <20060707.001707.39180766.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 06 Jul 2006 21:35:43 +0200

> I have similar problem with my Raptor GFX (Permedia2). If I run 
> Xserver in fb driver I get this:
> 
> 
> ioctl32(Xorg:13334): Unknown cmd fd(7) cmd(40584606){00} arg(ff25bb9c) 
> on /dev/fb0
> ioctl32(Xorg:13334): Unknown cmd fd(7) cmd(40184600){00} arg(ff25bba4) 
> on /dev/fb0
> 
> Is it same problem as in Atyfb ?

Yes, it is the same problem.

And I've used ATI R128 cards without Sun firmware on them too,
and they would cause the same messages.

It makes zero sense to put knowledge of this SBUS framebuffer
ioctl into every single framebuffer driver, because that is what
you would need to do in order to cover all possible cases.
