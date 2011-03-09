From: David Miller <davem@davemloft.net>
Date: Wed, 09 Mar 2011 20:17:46 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110309.121746.112586063.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Wed, 09 Mar 2011 00:16:50 -0600

> My guess is that we're no longer using the special hyperSparc block copy
> and fill from mm/hypersparc.S and are now leaving some data in the cache
> that wasn't there before.

That is a possibility.

But let's be clear that this only applies to:

1) memcpy calls with constant "count" of PAGE_SIZE
2) memset calls with constant "c" of zero and "count" of PAGE_SIZE

Since those are the only cases where memset/memcpy gets translated
into calls to those optimized Hypersparc routines.
