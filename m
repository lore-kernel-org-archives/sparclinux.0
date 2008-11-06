From: David Miller <davem@davemloft.net>
Date: Thu, 06 Nov 2008 04:25:57 +0000
Subject: Re: tty warning
Message-Id: <20081105.202557.233628145.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
In-Reply-To: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 6 Nov 2008 15:24:21 +1100

> These are things like:
> 
>                 termios->c_cc[VTIME] = 0;
> 
> termios is a (struct ktermios *) which has "cc_t c_cc[NCCS];".  NCCS is
> 17 and VTIME is also 17.  I assume the intention is to actually fill in
> _x_cc[0], but why is it done this way and not more directly?

It's just some historical stuff.

I've tried to rectify it, but it is non-trivial to fix and
all it does is pacify a warning rather than fix a real problem
so... ;-)

This has been brought up perhaps 5 or 6 times in the past half
year :)
