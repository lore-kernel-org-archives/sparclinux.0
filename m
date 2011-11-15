From: David Miller <davem@davemloft.net>
Date: Tue, 15 Nov 2011 17:40:32 +0000
Subject: Re: [PATCH] sparc: Fix handling of orig_i0 wrt. debugging when
Message-Id: <20111115.124032.1821407186517169645.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111114.235351.467624122814997359.davem@davemloft.net>
In-Reply-To: <20111114.235351.467624122814997359.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 14 Nov 2011 23:53:51 -0500 (EST)

> Luckily we can solve this problem without having to make debuggers
> aware of the issue.  Across system calls, several registers are
> considered volatile and can be safely clobbered.
> 
> Therefore we use the pt_regs save area of one of those registers, %g2,
> as a place to save and restore orig_i0.

Unfortunately this doesn't work, for example the clone implementation
in glibc expects %g2 and several other global registers to be preserved
across a system call.

I'll need to find another place to stash this value away.
