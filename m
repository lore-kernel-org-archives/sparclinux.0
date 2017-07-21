From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 02:50:05 +0000
Subject: Re: [PATCH v1 0/4] Context domains
Message-Id: <20170721.035005.1773741271807870610.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 20 Jul 2017 21:50:57 -0400

> Most of this work was done by: bob.picco@oracle.com
> 
> Currently, there is only one context domain per-system. This means
> when wrap occurs we must go through a cpu-count proportional loop
> in order to invalidate context ids. It also means, that context wraps
> can occur more frequently. This patchset solves this problem by
> introducing multiple context domains. By default one context domain
> per physical core (on most sun4v it is actually one per two cores,
> because the defined max strands per core is set to 16 to match
> match T3.).

Thanks for working on this.

I guess this is a story of many tradeoffs.

In another thread we are trying to make sparc64 MONDOs happen less
often and be less expensive.  And these changes make TLB shootdowns
more expensive.

Having to allocate a full trap frame just to TLB flush one page or an
MM is a serious regression.

Next, allocating a whole new data structure and clearing it out on
every new address creation is going to be a significant new cost as
well.

I can guarantee you will be able to measure this with lmbench or a
similar set of microbenchmarks which measure fork/exit speed.

It's hard to swallow this given that these changes only help extremely
large systems running specific kinds of loads, yet pessimize all other
cases.

Even when the number of context domains is configured to zero, we eat
all of this overhead.

I have some clerical feedback as well, which I will make in response
to the individual patches.

