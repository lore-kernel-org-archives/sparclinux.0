From: David Miller <davem@davemloft.net>
Date: Sat, 14 Mar 2009 19:49:15 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <20090314.124915.70069010.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 12:53:52 -0600

> (PS: I have not thought nearly enough about this, but: in the
> ultrasparc code I did in another lifetime, I did not bother fiddling
> %cwp in the task-switch code, because we know the register windows
> are empty both before and after, so %cwp does not really matter:
> we are going to fault in all the "above" windows as usual, and in
> that system, nothing ever let you peek at the %cwp value.  It may
> be possible to do the same in the linux code.  In which case the
> switch code has many more registers available to it, plus this
> saves you one whole "wrpr" instruction. :-) Something for those
> better-versed than I to consider, anyway.)

Oh, CWP _does_ matter.

You have to specifically use the saved CWP in the task switch because
when we later get to the trap return into userspace we'll restore the
%tstate register from the trap stack and that has a very specific CWP
encoded into it.  So it all has to line up properly.

I suppose we could mask out the CWP in the pt_regs we restore in trap
return, but that seems like more work than the CWP writes here :-)

I'll address the rest of your email soon.
