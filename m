From: David Miller <davem@davemloft.net>
Date: Sat, 29 Dec 2007 08:14:11 +0000
Subject: Re: 2.6.24-rc6-mm1: some section mismatches on sparc64
Message-Id: <20071229.001411.210630819.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200712261329.08313.m.kozlowski@tuxland.pl>
	<20071226.190504.20990618.davem@davemloft.net>
	<20071228232255.GB9105@does.not.exist>
In-Reply-To: <20071228232255.GB9105@does.not.exist>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: errandir_news@mph.eclipse.co.uk, m.kozlowski@tuxland.pl, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Sat, 29 Dec 2007 01:22:56 +0200

> At least the sunserial_console_match() one is an obvious Oops 
> (EXPORT_SYMBOL of an __init function).
> 
> The comment in the description of
> commit 58d784a5c754cd66ecd4791222162504d3c16c74 the warning was bogus    
> is bullshit.
> 
> I'm not sure whether this might count as a 2.6.24-rc regression or 
> whether 2.6.23 is simply differently but similarly broken (does anyone 
> actually use the Sun console drivers modular?).

You can't do that, the FOO_CONSOLE config options depend upon
FOO=y.

That's why I'm not worried about this issue and it's not critical at
all.
