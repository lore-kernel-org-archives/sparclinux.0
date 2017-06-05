From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 04:09:10 +0000
Subject: Re: [v1 2/6] sparc64: access tick function from variable
Message-Id: <20170605.000910.486186319269843913.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1496428854-936411-3-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496428854-936411-3-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 5 Jun 2017 00:00:07 -0400

> True, we could save one more load, by patching tick_get_tick() but
> that would save us only 3-5 instructions because with the changes done
> in this patchset the extra load comes from the same cacheline as the
> other two variables: offset and quotient. So overall, we still have 3
> loads as before, but they are much faster compared to what we have
> now, where every load is from a different cacheline.

But if you take things a step further, you can hide the other load
costs in the time it takes the %stick register read to complete.

So, for example, if we subsequently patch also sched_clock() in
assembler it becomes:

	load	timer_ticks_per_nsec_quotient, reg1
	load	timer_ticks_offset, reg2
	rd	%stick, reg3
	...

All 3 values will be in the cpu by the time the %stick read completes.

That is the fastest possible implementation of sched_clock().
