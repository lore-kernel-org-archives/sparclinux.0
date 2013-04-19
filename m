From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 19 Apr 2013 18:03:37 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <517186F9.3080500@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/19/2013 12:41 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Fri, 19 Apr 2013 09:46:26 -0500
> 
>> Why not pass mm into smp_flush_tlb_page() and use mm_cpumask(mm) as is
>> done in smp_flush_tlb_pending()? I don't see why we wouldn't want to
>> duplicate that logic to avoid cross calls to every cpu for every
>> non-batched flush.
> 
> Yes, I noticed that too when doing some tests and fixed that last night.
> 
> I also noticed that 2 out of every 3 batch flushes are singletons, so
> I optimized that case.  That took a few seconds off of a parallel
> kernel build.

It looks good to me. I'm about to take off for a 3-day vacation, so I
won't be able to rebuild and test this until Tuesday. I don't anticipate
any problems because it is very nearly what I last tested with.

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> 
> We should probably annotate the sparc specific transparent hugepage
> pte loops in arch/sparc/mm/tlb.c with some lazy mmu calls, but I'll
> leave that for another time.
