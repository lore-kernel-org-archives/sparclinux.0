From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 05 Oct 2012 21:36:44 +0000
Subject: Re: [PATCH v2 0/8] THP support for Sparc64
Message-Id: <20121005143644.abb14c2b.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.154624.923241475790311926.davem@davemloft.net>
In-Reply-To: <20121004.154624.923241475790311926.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, aarcange@redhat.com, hannes@cmpxchg.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, 04 Oct 2012 15:46:24 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> 
> Changes since V1:
> 
> 1) Respun against mmotm
> 
> 2) Bug fix for pgtable allocation, need real locking instead of
>    just preemption disabling.
> 
> Andrew, you can probably take patch #5 in this series and combine
> it into:
> 
> mm-thp-fix-the-update_mmu_cache-last-argument-passing-in-mm-huge_memoryc.patch
> 
> in your batch.  And finally add a NOP implementation for S390
> and any other huge page supporting architectures.
> 

David, I don't know what to do until there's some clarity on the
numa/sched changes.  Andrea has a new autonuma patchset, Peter's code
is in -next and I don't know if it's planned for 3.7 merging.  And I
suspect (hope) that it won't be merged if that is indeed planned.

Two days I asked what's going on and didn't get told.  I put the entire
MM merge on hold yesterday and went off to do other things.  At present
I plan to restage MM against mainline and send it all along to Linus on
Monday.  If that happens and if you wish that the sparc changes be
merged for 3.7, I suggest that you rebase and retest on Tuesday and ask
Linus to pull it, with my ack.

Sorry.
