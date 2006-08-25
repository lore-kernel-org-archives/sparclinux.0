From: David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 23:24:58 +0000
Subject: Re: [PATCH] sparc32: max_cache_size fallback
Message-Id: <20060825.162458.107683420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44de28a4e7531@wp.pl>
In-Reply-To: <44de28a4e7531@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 12 Aug 2006 21:14:44 +0200

> From: Krzysztof Helt (krzysztof.h1@wp.pl)
> 
> It adds a fallback for CPU cache size detection. According to Sun
> documentation, it is possible to have SMP system with SM40 modules.
> 
> Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
> ---
> 
> It is added after sparc64 architecture.

This new fallback is "36 * 1024", ie. 36K?  That doesn't make any
sense.  I thought the smallest SM40 cache size was 512K or something
like that.

If anything it should be a power of two, not some weird number
like 36K.
