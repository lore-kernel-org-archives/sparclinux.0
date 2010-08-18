From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 20:21:33 +0000
Subject: Re: [PATCH] sparc64: fix atomic64 prototypes
Message-Id: <20100818.132133.104053232.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181316160.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181316160.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 14:02:37 -0400 (EDT)

> This patch fixes atomic64 for sparc64. I'm sending another one, that does 
> tiny microoptimization by using retl delay slot.

I've already fixed this, as I said I would to Linus yesterday, in
my sparc-2.6 tree.

There is also a 64-bit rwsem implementation in there now too, which
I posted yesterday as well.
