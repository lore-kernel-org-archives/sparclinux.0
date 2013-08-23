From: David Miller <davem@davemloft.net>
Date: Fri, 23 Aug 2013 18:08:25 +0000
Subject: Re: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <20130823.110825.383383384885721827.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <8311377178790@web14g.yandex.ru>
In-Reply-To: <8311377178790@web14g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 23 Aug 2013 19:43:56 +0400

> It looks like nobody supports this. I saw an old patch for x86
> (https://lkml.org/lkml/2003/6/16/226) and several others, but they
> were not integrated. So, sparc64 can be the first.

Exciting, sparc64 is becomming such a groundbreaking platform :-)

> Other architectures have no as cheap replication as sparc64 has. They must
> modify page table top every switch_to(), while sparc64 is free from this thing.
> And it looks like they have to flush all instruction cache every context switch.
> 
> I'll work on the patch a little bit more and test it in different boundary cases,
> before submit it as a ready patch.

I'd be interested in any performance improvement you can show because that's
the reason to do this right?

A parallel kernel build utilizing all nodes ought to show at least something.
