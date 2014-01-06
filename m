From: Hugh Dickins <hughd@google.com>
Date: Mon, 06 Jan 2014 08:42:34 +0000
Subject: Re: [PATCH] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <alpine.LSU.2.11.1401060002580.5292@eggly.anvils>
List-Id: <sparclinux.vger.kernel.org>
References: <52AF6A0C.4000400@oracle.com>
In-Reply-To: <52AF6A0C.4000400@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 4 Jan 2014, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Mon, 16 Dec 2013 15:01:00 -0600
> 
> > This reverts commit 145e1c0023585e0e8f6df22316308ec61c5066b2.
> > 
> > This commit broke the behavior of __copy_from_user_inatomic when
> > it is only partially successful. Instead of returning the number
> > of bytes not copied, it now returns 1. This translates to the
> > wrong value being returned by iov_iter_copy_from_user_atomic.
> > 
> > xfstests generic/246 and LTP writev01 both fail on btrfs and nfs
> > because of this.
> > 
> > Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> Applied and queued up for -stable, thanks.

Good, thank you both.

I'm afraid it's taken me until this evening to set aside
some quiet time to look into this, and the original report.

I now agree that my 2.6.28 patch was completely bogus: relying
upon wishful thinking of what ___copy_from_user() might return,
and not actually addressing the bug in question - the fault in
fixup's __bzero was on the kernel address 0xfffff80037c1c000,
whereas I was fussing over user address faults and atomicity.

I apologize for endangering sparc64 writes over five years.

> 
> But I wonder about the original bug that Hugh was trying to
> fix :-/

That worried me too, but I think you're okay.  I bet your
b270ee8a9fc9 "sparc64: Fix offset calculation in compute_size()"
    
    The fault address is somewhere inside of the buffer, not
    before it.

, also included in 2.6.38, was the actual fix to that bug.

Perhaps that would require CONFIG_DEBUG_PAGEALLOC to have
been in force, and there was no mention of it in the report.
But I see sparc64 was supporting it at the time, and the line
which might have shown it was cut from the report.  And I see
from other reports by Alexander Beregalov that he often had
lockdep on, so there's a good chance he used other such debug
options too.  But it seems a bit late to go asking him now:
let's assume your fix to compute_size() was the answer.

Hugh
