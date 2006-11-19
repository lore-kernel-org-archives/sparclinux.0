From: David Miller <davem@davemloft.net>
Date: Sun, 19 Nov 2006 06:47:55 +0000
Subject: Re: sunhme lockup and udelay workaround
Message-Id: <20061119.014755.78712664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <455F81C4.2060409@gentoo.org>
In-Reply-To: <455F81C4.2060409@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Drake <dsd@gentoo.org>
Date: Sat, 18 Nov 2006 16:57:24 -0500

> Rewind a few years, I don't suppose you remember the sunhme lockup 
> issue, of which one ugly workaround was inserting a small delay in the 
> TX codepath?
> 
> http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.19-pre/1705_sparc-U1-hme-lockup.patch
> 
> Was this ever resolved? This is the last patch in Gentoo's base set of 
> kernel patches and I'm eager to remove it...
> 
> There is scattered discussion of this bug lying around, e.g.
> http://lists.debian.org/debian-sparc/2003/02/msg00011.html
> 
> but it's not clear if a mainline resolution was ever reached. Do you 
> know anything about the situation here?

I've never seen this problem reappear since gcc-3.x or so.
I am pretty sure you can kill that patch safely.
