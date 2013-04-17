From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 17 Apr 2013 22:07:26 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <516F1D1E.5020307@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/17/2013 04:31 PM, David Miller wrote:
> 
> I also don't agree with this approach to fix the bug.

I'm not wild about it myself, but it's relatively simple and fixes the
problem.

> I'd much rather we properly synchronize.  One idea is to have
> a pendulum which sways every time a remove batch flush is
> performed.
> 
> The pendulum is a pointer, which points to one of two per-cpu batch
> datastructures.  A remote flush is issued by setting an atomic counter
> to the number of remote cpus doing the flush in the per-cpu batch
> area, each remote cpu decrements the atomic counter.

The remote function doesn't operate with a stack, so it can't simply
call atomic_dec (or atomic_sub) but would need to open code it.
Possible, but it makes the fix a bit more complicated.

> The submitter also "sways the pendulum" by adjusting the pointer to
> other per-cpu batch datastructure.
> 
> If a submitter sees that there is a reference count on the per-cpu
> batch the pendulum points to, it waits until the counter hits zero.
