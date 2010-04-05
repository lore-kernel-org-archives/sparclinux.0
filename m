From: David Miller <davem@davemloft.net>
Date: Mon, 05 Apr 2010 20:46:47 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100405.134647.48384289.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405065701.GC5127@nowhere>
	<20100405.122233.188421941.davem@davemloft.net>
	<20100405194055.GA5265@nowhere>
In-Reply-To: <20100405194055.GA5265@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 5 Apr 2010 21:40:58 +0200

> It happens without CONFIG_FUNCTION_TRACER as well (but it happens
> when the function tracer runs). And I hadn't your perf_arch_save_caller_regs()
> when I triggered this.

Good clues, thanks.
