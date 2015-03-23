From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 23 Mar 2015 23:08:11 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323230811.GA21966@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
In-Reply-To: <1427149265.4770.238.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On (03/24/15 09:21), Benjamin Herrenschmidt wrote:
> 
> So we have two choices here that I can see:
> 
>  - Keep that old platform use the old/simpler allocator

Problem with that approach is that the base "struct iommu" structure
for sparc gets a split personality: the older one is used with
the older allocator, and other ugly things ensue.  (alternatively,
you end up duplicating a version of the code with the flush_all 
inlined). 

>  - Try to regain the bulk of that benefit with the new one
> 
> Sowmini, I see various options for the second choice. We could stick to
> 1 pool, and basically do as before, ie, if we fail on the first pass of
> alloc, it means we wrap around and do a flush, I don't think that will
> cause a significant degradation from today, do you ? We might have an
> occasional additional flush but I would expect it to be in the noise.

Isn't this essentially what I have in patch v5 here:
http://www.spinics.net/lists/sparclinux/msg13534.html

(the ops->reset is the flushall indirection, can be renamed if the
latter is preferred)

> Dave, what's your feeling there ? Does anybody around still have some
> HW that we can test with ?

I actually tested this on a V440 and a ultra45 (had a heck of a
time finding these, since the owners keep them turned off because
they are too noisy and consume too much power :-). Thus while I
have no opinion, I would not shed any tears if we lost this extra
perf-tweak in the interest of being earth-friendly  :-))

so testing it is not a problem, though I dont have any perf
benchmarks for them either.

> Sowmini, I think we can still kill the ops and have a separate data
> structure exclusively concerned by allocations by having the alloc
> functions take the lazy flush function as an argument (which can be
> NULL), I don't think we should bother with ops.

I dont quite follow what you have in mind? The caller would somehow
have to specify a flush_all indirection for the legacy platforms 

Also, you mention

> You must hold the lock until you do the flush, otherwise somebody
> else might allocate the not-yet-flushed areas and try to use them...
> kaboom. However if that's the only callback left, pass it as an
> argument.

Passing  in a function pointer to the flushall to iommu_tbl_range_alloc
would work, or we could pass it in as an arg to iommu_tbl_init,
and stash it in the struct iommu_table.

--Sowmini

