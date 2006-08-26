From: David Miller <davem@davemloft.net>
Date: Sat, 26 Aug 2006 23:48:52 +0000
Subject: Re: [PATCH] sparc32: max_cache_size fallback
Message-Id: <20060826.164852.26965744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44de28a4e7531@wp.pl>
In-Reply-To: <44de28a4e7531@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 26 Aug 2006 10:59:23 +0200

> > If anything it should be a power of two, not some weird number
> > like 36K.
> 
> I added 20KB and 16Kb and got 36KB total cache size.

I think you should just use the data cache size on these
L2'less chips.
