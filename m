From: David Miller <davem@davemloft.net>
Date: Thu, 08 May 2008 23:07:32 +0000
Subject: Re: enabling lockdep causes boot failure on a SUN T2000
Message-Id: <20080508.160732.67262443.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48238125.7040900@email.unc.edu>
In-Reply-To: <48238125.7040900@email.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Bjoern B. Brandenburg" <bbb@email.unc.edu>
Date: Thu, 08 May 2008 18:39:33 -0400

> I've been having a hard time getting Linux (vanilla 2.6.24 and 2.6.25) 
> to boot on our Niagara box.

We know about this problem already.  Thanks for reporting.

This changeset below was meant to improve things, but t1000/t2000
systems still get wedged.

I'll investigate when I get a chance.

commit 85a793533524f333e8d630dc22450e574b7e08d2
Author: David S. Miller <davem@davemloft.net>
Date:   Mon Mar 24 20:06:24 2008 -0700

    [SPARC64]: Make save_stack_trace() more efficient.
    
    Doing a 'flushw' every stack trace capture creates so much overhead
    that it makes lockdep next to unusable.
    
    We only care about the frame pointer chain and the function caller
    program counters, so flush those by hand to the stack frame.
    
    This is significantly more efficient than a 'flushw' because:
    
    1) We only save 16 bytes per active register window to the stack.
    
    2) This doesn't push the entire register window context of the current
       call chain out of the cpu, forcing register window fill traps as we
       return back down.
    
    Note that we can't use 'restore' and 'save' instructions to move
    around the register windows because that wouldn't work on Niagara
    processors.  They optimize 'save' into a new register window by
    simply clearing out the registers instead of pulling them in from
    the on-chip register window backing store.
    
    Based upon a report by Tom Callaway.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
