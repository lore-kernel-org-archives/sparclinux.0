From: David Miller <davem@davemloft.net>
Date: Thu, 16 Oct 2014 16:12:00 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141016.121200.308280127588605035.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 16 Oct 2014 08:36:54 -0400

> You're welcome. Thanx for the splendid changelog! Otherwise time reviewing
> the fpu paths and etc. would have been a challenge to schedule. Boots and
> tests without issue on T5-2. Though I had configure them in and 
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> . I did review the patch modifications too.

Thanks Bob.

I started working on a text document explaining how the FPU saving
stuff works on sparc64, and will use that to sprinkle comments around
and perhaps clean some of it up.

I think there is one bug I discovered during this documenting process,
in that if we do a VISEntryHalf I think we might not restore the %gsr
register on trap return.  In the rtrap pseudo-code below there are
two code paths which bypass the %gsr load, it is a combination of two
checks which run in sequence, the first is:

	!(t->fpsaved[depth] & (FPRS_FSF | FPRS_DU))

and the second is:

	!(t->fpsaved[depth] & FPRS_FSF)

The second check therefore can only trigger if only FPRS_DU is set.
There might be a reason why skipping the %gsr load is kosher in this
case, but I haven't figure it out yet.

Anyways, here is my doc in progress.

==========

struct thread_info:

       convention is that slot [0] of save arrays is for the user's FPU
       state, and slot [1] and later are for kernel FPU state

       thread_info->fpdepth bit zero indicates if there is user FPU
       state saved or not, bits one and higher are the kernel FPU
       save depth.  So user stuff is saved in slot zero, and kernel
       stuff is saved in slot "(fpdepth >> 1) + 1".

VisEntry:
	struct thread_info *t = current_thread_info();

	/* %o5 = %fprs */
	if (t->fpdepth = 0) {
		t->fpsaved[0] = 0;
		t->xfsr[0] = %fsr;
		return;
	}
	if (t->fpdepth = 1) {
	vis1:

	}


VisEntryHalf:
	struct thread_info *t = current_thread_info();

	/* %o5 = %fprs */
	g1 = t->fpdepth;
	if (t->fpdepth = 0) {
		t->fpsaved[0] = 0;
		t->xfsr[0] = %fsr;
		o5 = 0;
		%fprs = FPRS_FEF;
		return;
	}
	if (t->fpdepth = 1) {
		backtrack_return_pc(8);
		goto vis1;
	}

	tp->fpsaved[tp->fpdepth] = o5 & ~FPRS_DU;
	tp->gsr[tp->fpdepth] = %gsr;
	if (o5 & FPRS_DL) {
		store_block(f0, tp->fpregs + (g1 << 5) + 0x00);
		store_block(f16, tp->fpregs + (g1 << 5) + 0x40);
	}
	%fprs = (o5 & FPRS_DU) ^ FPRS_FEF;
	return;

VisExit/VisExitHalf:
	%fprs = 0

etrap:
	( from kernel )
	struct thread_info *t = current_thread_info();
	t->fpsaved[(t->fpdepth >> 1) + 1] = 0;
	t->fpdepth += 2;

rtrap:
	( to kernel )
	struct thread_info *t = current_thread_info();
	if (t->fpdepth) {
		l2 = t->fpsaved[t->fpdepth >> 1];
		o0 = tp->fpdepth >> 1;
		o1 = t + TI_GSR;
		l6 = l2 & FPRS_DL;
		if (!(l2 & (FPRS_FEF | FPRS_DU)))
			goto out_2;
		o5 = o0 << 3;
		if (!(l2 & FPRS_FEF))
			goto out_5;

		g1 = %fprs;
		%fprs = %g1 ^ FPRS_FEF;

		g1 = t->gsr[tp->fpdepth];
		o2 = o0 << 8;
		if (l6) {
			load_block(f0, tp->fpregs + %o2)
			load_block(f16, tp->fpregs + 0x40 + %o2)
		}
		%gsr = %g1
		if (l2 & FPRS_DU) {
			load_block(f32, tp->fpregs + 0x80 + %o2)
			load_block(f48, tp->fpregs + 0xc0 + %o2)
		}
		/* fallthru */
	out_2:
		t->fpdepth -= 2;
		goto out_99;
	out_5:
		%fprs = FPRS_FEF;
		o2 = o0 << 8;
		load_block(f32, tp->fpregs + 0x80 + %o2)
		load_block(f48, tp->fpregs + 0xc0 + %o2)
		%fprs = FPRS_DU;
		tp->fpdepth -= 2;
		goto out_99;
	}
	out_99:

{TSTATE,PSTATE}_PEF management:

	Firstly, as per V9, all traps set PSTATE_PEF in %pstate for
	the trap handler.  The "predefined" state for %pstate upon
	entry to a trap handler is:

		PSTATE.MM = unchanged
		PSTATE.RED = 0
		PSTATE.PEF = 1
		PSTATE.AM = 0
		PSTATE.PRIV = 1
		PSTATE.IE = 0
		PSTATE.AG = 1
		PSTATE.CLE = PSTATE.TLE

	1) start_thread{,32}() clears TSTATE_PEF
	2) All traps into kernel (both from user and kernel) set TSTATE_PEF in
	   %tstate and do a 'done' which propagates it into PSTATE_PEF in
	   %pstate.
	3) fpu_disabled trap sets TSTATE_PEF in %tstate before finishing
	   with 'retry' (which like 'done' propagates it to PSTATE_PEF in
	   %pstate).
	4) If the 64-bit set_context system call saves FPU state, TSTATE_PEF
	   is cleared in the task's registers.

