From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 22 Sep 2004 03:35:17 +0000
Subject: Re: RED State Exception on Ultra 1, 2.6.9-rc2
Message-Id: <20040921203517.3a171f0b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1095742791.3421.3.camel@ori.thedillows.org>
In-Reply-To: <1095742791.3421.3.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 21 Sep 2004 23:25:48 -0400
David Dillow <dave@thedillows.org> wrote:

> > Anyways, in free_streaming_cluster() we took a vectored interrupt (trap
> > type 0x60).  In tl0_ivec we took an illegal instruction trap, which is
> > very odd because the instruction at 0x408c00:tl0_ivec is a branch.
> 
> Should I track the vectored interrupt? What's it used for -- it looks
> like its used for cross-CPU calls, but this is a single CPU. Are there
> other uses?
> 
> I ask, because we took the first trap on "stx %g0, [%o2]", which
> corresponds with this line in free_streaming_cluster():
> 	iopte_val(*iopte) = 0UL;
> 
> Could iopte point somewhere nasty?
> Does this seem like a possible pointer to a bug, or just a red herring?

Just a red herring.  And the ivector is not going to be anything
special.

The interesting bit is the illegal instruction trap at the first
instruction of tl0_ivec, which should be a branch.  That's where
things start to go downhill.

Something is writing garbage to that instruction, that is my current
guess.
