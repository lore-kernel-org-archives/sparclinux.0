From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jul 2006 03:52:33 +0000
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Message-Id: <20060705.205233.39177061.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060144.k661iH8d010317@harpo.it.uu.se>
In-Reply-To: <200607060144.k661iH8d010317@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 6 Jul 2006 03:44:17 +0200 (MEST)

> That could work. But it's a much larger patch than mine,
> and I don't want to go around hacking random other stuff
> just to repair atyfb. It's up the the Powers That Be to
> decide whether a local fix or a global one is most appropriate.
 ...
> That would require sbuslib.h to be completely benign on
> non-SPARC machines. If it is, great, but I can't currently
> guarantee that it is.

I've been aware of these warnings for a long time, but I've
done nothing about it because the fix is much worse than the
cure.

The is no reason the mach64 driver should be aware in any way
of these SBUS framebuffer ioctls.

Either we can find a way to make X stop issuing these ioctls
or simply ignore the kernel message, which frankly is harmless.
