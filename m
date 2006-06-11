From: David Miller <davem@davemloft.net>
Date: Sun, 11 Jun 2006 01:11:39 +0000
Subject: Re: [PATCH] migration cost tune up in sparc smp
Message-Id: <20060610.181139.85410856.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4483db6b9a343@wp.pl>
In-Reply-To: <4483db6b9a343@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Mon, 05 Jun 2006 09:21:15 +0200

> This patch sets the max_cache_size value required to tune up
> scheduler in SMP systems. Otherwise, the calculated
> migration_cost is too high and task scheduling may lock up.
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thanks for this, yes sparc64 needs this too.

But why in the world does the scheduler "lock up" just because the
migration cost is too large?

It should continue to function properly even if the migration cost is
very large.
