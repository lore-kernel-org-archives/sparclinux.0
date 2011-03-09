From: David Miller <davem@davemloft.net>
Date: Wed, 09 Mar 2011 21:01:18 +0000
Subject: Re: sparc32 build failure in fault_32.c
Message-Id: <20110309.130118.59686145.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D7410E5.3090904@mc.net>
In-Reply-To: <4D7410E5.3090904@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sun, 06 Mar 2011 16:55:33 -0600

> Would it be safe enough to initialize code to SEGV_MAPERR earlier, or
> should vmalloc_fault have a different fault code?

Yep, and that's how I'll fix this, thanks!

---
sparc32: Fix might-be-used-uninitialized warning in do_sparc_fault().

When we try to handle vmalloc faults, we can take a code
path which uses "code" before we actually set it.

Amusingly gcc-3.3 notices this yet gcc-4.x does not.

Reported-by: Bob Breuer <breuerr@mc.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_32.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 5b836f5..b10ac4d 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -240,11 +240,10 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
+	code = SEGV_MAPERR;
 	if (!ARCH_SUN4C && address >= TASK_SIZE)
 		goto vmalloc_fault;
 
-	code = SEGV_MAPERR;
-
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
-- 
1.7.4.1

