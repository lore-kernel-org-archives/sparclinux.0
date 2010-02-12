From: David Miller <davem@davemloft.net>
Date: Fri, 12 Feb 2010 20:03:07 +0000
Subject: Re: Spurious unaligned access messages during bootup
Message-Id: <20100212.120307.19150137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 21 Jan 2010 15:26:42 +0200 (EET)

> Got these from current 2.6.33-rc4+git:
> 
> [  125.765427] Kernel unaligned access at TPC[43e3a4] __save_stack_trace+0x84/0x220
> [  125.765627] Kernel unaligned access at TPC[43e3b8] __save_stack_trace+0x98/0x220
> [  125.765802] Kernel unaligned access at TPC[43e3bc] __save_stack_trace+0x9c/0x220
> 
> This was during the bootup. Never seen these specific messages before 
> (last kernel was 2.6.32). The second bootup with current kernel did not 
> yield these messages either.

Thanks for the report.

I wonder if we're walking randomly past the top of the firmware's stack
during these backtraces.

In any event, I'll add the following sanity check to the tree, thanks
for your report.

sparc64: Tighten checks in kstack_valid().

The kernel stack pointer is invalid if it is not 16-byte
aligned.

Based upon a report by Meelis Roos <mroos@linux.ee>

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/kstack.h b/arch/sparc/kernel/kstack.h
index 4248d96..5247283 100644
--- a/arch/sparc/kernel/kstack.h
+++ b/arch/sparc/kernel/kstack.h
@@ -11,6 +11,10 @@ static inline bool kstack_valid(struct thread_info *tp, unsigned long sp)
 {
 	unsigned long base = (unsigned long) tp;
 
+	/* Stack pointer must be 16-byte aligned.  */
+	if (sp & (16UL - 1))
+		return false;
+
 	if (sp >= (base + sizeof(struct thread_info)) &&
 	    sp <= (base + THREAD_SIZE - sizeof(struct sparc_stackf)))
 		return true;
