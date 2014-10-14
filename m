From: David Miller <davem@davemloft.net>
Date: Tue, 14 Oct 2014 00:04:16 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141013.200416.641735303627599182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141012.132012.254712930139255731.davem@davemloft.net>
	<alpine.LRH.2.11.1410132320110.9586@adalberg.ut.ee>
	<20141013235219.GA11191@js1304-P5Q-DELUXE>
In-Reply-To: <20141013235219.GA11191@js1304-P5Q-DELUXE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iamjoonsoo.kim@lge.com
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Tue, 14 Oct 2014 08:52:19 +0900

> I'd like to know that your another problem is related to commit
> bf0dea23a9c0 ("mm/slab: use percpu allocator for cpu cache").  So,
> if the commit is reverted, your another problem is also gone
> completely?

The other problem has been present forever.
