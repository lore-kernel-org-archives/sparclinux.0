From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 20:09:31 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329.130931.149161813.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100328043446.GA11748@nowhere>
In-Reply-To: <20100328043446.GA11748@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sun, 28 Mar 2010 06:34:49 +0200

> I get kernel crashes each time I use perf with callchains
> on sparc 64.
> 
> It triggers with a simple:
> 
> 	perf record -a -f -g sleep 1

This should fix it, thanks again.

sparc64: Properly truncate pt_regs framepointer in perf callback.

For 32-bit processes, we save the full 64-bits of the regs in pt_regs.

But unlike when the userspace actually does load and store
instructions, the top 32-bits don't get automatically truncated by the
cpu in kernel mode (because the kernel doesn't execute with PSTATE_AM
address masking enabled).

So we have to do it by hand.

Reported-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 9f2b2ba..610112e 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1337,7 +1337,7 @@ static void perf_callchain_user_32(struct pt_regs *regs,
 	callchain_store(entry, PERF_CONTEXT_USER);
 	callchain_store(entry, regs->tpc);
 
-	ufp = regs->u_regs[UREG_I6];
+	ufp = regs->u_regs[UREG_I6] & 0xffffffffUL;
 	do {
 		struct sparc_stackf32 *usf, sf;
 		unsigned long pc;
-- 
1.7.0.3

