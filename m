From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 12 Feb 2005 07:44:00 +0000
Subject: Re: Xorg doesn't work on the cg3
Message-Id: <20050211234400.36801a97.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1108062924.3919.22.camel@localhost.localdomain>
In-Reply-To: <1108062924.3919.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 12 Feb 2005 00:10:00 -0600
Bob Breuer <breuerr@mc.net> wrote:

> Tom 'spot' Callaway wrote:
> > But the cg3 remains stubborn.
> 
> I came upon this when comparing the mmap address for cg14 and cg3:
> cg14.c:	.voff	= CG3_MMAP_OFFSET,
> cg3.c:	.poff	= CG3_MMAP_OFFSET,
> 
> I have appended a patch to squash this bug.  But a question remains,
> how did this bug go undetected like this?  Either the mmap should
> have returned an error, or we should have got a segmentation fault
> on writes, but it seems that neither one happened.  Any ideas?

Nasty.  Maybe X.org doesn't check the return value.  But you're
right in that it should have segfaulted afterwards if so.

One explanation is that X.out perhaps catches SIGSEGV and tries
to handle it somehow (for example, if the SIGSEGV is due to an
I/O register access which times out or is for an address the chip
refuses to respond to)

Oh I see what might be happening.  In drivers/video/sbuslib.c
the sbusfb_mmap_helper() just skips over addresses that don't
match one of the sbus_mmap_map entries.  No error is returned
even if none of the pages match an area in sbus_mmap_map.

As a result, the user just gets a bunch of anonymous memory
mapped there.  The faults generated here just map in normal
zeroed main memory.

We could have caught this sooner if sbusfb_mmap_helper() returned
errors in such a case.  But who knows what that might break. :-)

I'm applying this obvious cg3 fix.  There is a bunch of other
patches that are necessary to get X fully working on both cg14
and cg3 aren't there?  At a minimum there's that BUG() removal
in the srmmu code, right?
