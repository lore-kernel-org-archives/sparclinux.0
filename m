From: David Miller <davem@davemloft.net>
Date: Thu, 08 Mar 2007 22:19:22 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070308.141922.85686648.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Emanuele Rocca <ema@debian.org>
Date: Thu, 8 Mar 2007 23:12:57 +0100

> Hello David,
> 
> * David Miller <davem@davemloft.net>, [2007-03-05  1:11 -0800]:
> >  Anyone with a SunBlade100 or SunBlade150 trying to use
> >  kernels built with gcc-4.1.x or later and seeing hangs
> >  should try out this patch.
> >  
> >  GCC-4.1.x and later optimize away this poorly constructed
> >  delay, so there is no delay, and the chip hangs.
> >  
> >  I'll put a proper version of this fix, using a udelay(),
> >  upstream very soon.
> 
> My SunBlade2000 seems to hang at "Booting kernel...". However, the
> system seems to boot correctly (I'm able to login via ssh).

That's weird.  2000's usually ship wit Radeon cards, but your
dmesg diff certainly shows that you have an atyfb in there.

Does the device show up with "lspci" when the console doesn't come up
like this?  Also what do the ATYFB kernel config options in your build
look like?
