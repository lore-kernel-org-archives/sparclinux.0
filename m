From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 10:28:50 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100406.032850.137831355.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405194055.GA5265@nowhere>
	<20100406.025049.267615796.davem@davemloft.net>
	<20100406101925.GD5147@nowhere>
In-Reply-To: <20100406101925.GD5147@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: rostedt@goodmis.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 6 Apr 2010 12:19:28 +0200

> It means having such interrupt reentrancy is not a problem.

It's not reentrancy.

It's the fact that local_irq_disable() (read it again, it's the
"disable" that re-renables NMIs on sparc64) turns NMIs back on even in
code where we are still trying to figure out how to service the NMI
still.

It's because we implement NMIs on sparc64 by having the performance
counter interrupt come in on the level 15 interrupt, and we run the
entire kernel at level 14 when IRQs are "disabled".
