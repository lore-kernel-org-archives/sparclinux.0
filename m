From: David Miller <davem@davemloft.net>
Date: Fri, 26 Sep 2014 23:57:04 +0000
Subject: Re: [PATCH 0/6] sparc64: MM/IRQ patch queue.
Message-Id: <20140926.195704.838536202519408251.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154047.2222645314356554322.davem@davemloft.net>
In-Reply-To: <20140925.154047.2222645314356554322.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 26 Sep 2014 19:18:03 -0400 (EDT)

> From: David Miller <davem@davemloft.net>
> Date: Fri, 26 Sep 2014 16:41:37 -0400 (EDT)
> 
>> From: Bob Picco <bpicco@meloft.net>
>> Date: Fri, 26 Sep 2014 16:04:18 -0400
>> 
>>> This should provide you sufficient data to arrive at an initial vmalloc size
>>> for percpu. I'll eventually examine my T5-8 information too. Hm, just did
>>> quickly:
>>> PERCPU: max_distance=0x380001c10000 too large for vmalloc space 0xff00000000
>>> . Note I haven't considered impact of this in quite a bit.
>> 
>> Thanks, several things certainly are not happy.
>> 
>> I'll take a look, thanks Bob.
> 
> Bob can I see the 'memory' OF node on the machine where this happens?

Nevermind, I have it in my 'prtconfs' GIT repo.

The embedded percpu allocator always failed on this machine, it should
always have gone to the the page based percpu allocator fallback.

You can verify this with past boot logs.

It shouldn't crash later though, that's troubling :-)

As to why the embedded handler can't cope with this config, it's because
of how far apart the various NUMA memory nodes are, physical address wise.

What happens is the per-cpu allocator allocates per-cpu memory, enough on
each NUMA node for the cpus on that NUMA node.  Then it walks all of these
pointers and computes the largest distance, in bytes, between any two of
them.   Basically the lowest pointer value, subtracted from the highest
pointer value.

This is the "max distance" thing.  And it cannot be larger than 3/4's the
size of the vmalloc area.

The distance between numa node physical areas seems to be something like
0x80000000000 on the T5 machine.

Anyways, we don't have enough virtual address space with 3-level
kernel page tables to accomodate what the embedded percpu allocator
wants.

Sound like a familiar problem? :-/

So we might have to backtrack and really move to 4-level page tables.

