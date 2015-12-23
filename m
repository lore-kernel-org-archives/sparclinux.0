From: David Miller <davem@davemloft.net>
Date: Wed, 23 Dec 2015 05:45:43 +0000
Subject: Re: [PATCH 1/2] sparc64: Ensure perf can access user stacks
Message-Id: <20151223.004543.1496411443529232075.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 22 Dec 2015 21:16:06 -0700

> When an interrupt (such as a perf counter interrupt) is delivered
> while executing in user space, the trap entry code puts ASI_AIUS in
> %asi so that copy_from_user() and copy_to_user() will access the
> correct memory. But if a perf counter interrupt is delivered while the
> cpu is already executing in kernel space, then the trap entry code
> will put ASI_P in %asi, and this will prevent copy_from_user() from
> reading any useful stack data in either of the perf_callchain_user_X
> functions, and thus no user callgraph data will be collected for this
> sample period. An additional problem is that a fault is guaranteed
> to occur, and though it will be silently covered up, it wastes time
> and could perturb state.
> 
> In perf_callchain_user(), we ensure that %asi contains ASI_AIUS
> because we know for a fact that the subsequent calls to
> copy_from_user() are intended to read the user's stack.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>

Thanks for tracking this down, David Ahern and I spent quite some time
trying to figure this one out.
