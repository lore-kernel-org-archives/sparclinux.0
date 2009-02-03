From: David Miller <davem@davemloft.net>
Date: Tue, 03 Feb 2009 05:58:30 +0000
Subject: Re: [PATCH 0/3]: NMI watchdog support for sparc64
Message-Id: <20090202.215830.227857358.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090130.002549.12348127.davem@davemloft.net>
In-Reply-To: <20090130.002549.12348127.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 01 Feb 2009 02:05:09 -0800 (PST)

> The bad news is that the NMI watchdog can trigger spuriously
> when using NOHZ and I have to figure out a way to fix that.

I've just pushed the following fix for this bug.

sparc64: On non-Niagara, need to touch NMI watchdog in NOHZ mode.

When we're idling in NOHZ mode, timer interrupts are not running.

Evidence of processing timer interrupts is what the NMI watchdog
uses to determine if the CPU is stuck.

On Niagara, we'll yield the cpu.  This will make the cpu, at
worst, hang out in the hypervisor until an interrupt arrives.
This will prevent the NMI watchdog timer from firing.

However on non-Niagara we just loop executing instructions
which will cause the NMI watchdog to keep firing.  It won't
see timer interrupts happening so it will think the cpu is
stuck.

Fix this by touching the NMI watchdog in the cpu idle loop
on non-Niagara machines.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/process_64.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index cc8b560..a73954b 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -29,6 +29,7 @@
 #include <linux/cpu.h>
 #include <linux/elfcore.h>
 #include <linux/sysrq.h>
+#include <linux/nmi.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -52,8 +53,10 @@
 
 static void sparc64_yield(int cpu)
 {
-	if (tlb_type != hypervisor)
+	if (tlb_type != hypervisor) {
+		touch_nmi_watchdog();
 		return;
+	}
 
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb__after_clear_bit();
-- 
1.6.1.2.253.ga34a

