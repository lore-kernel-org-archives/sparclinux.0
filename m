From: David Miller <davem@davemloft.net>
Date: Fri, 07 Dec 2007 08:59:48 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071207.005948.32645530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Thu, 06 Dec 2007 13:09:18 +0100

> ERROR(0): Cheetah error trap taken afsr[0000100000000000]
> afar[0000040001c00000] TL1(0)
> ERROR(0): TPC[4351dc] TNPC[4351e0] O7[4353b4] TSTATE[80001606]
> ERROR(0): TPC<interpret_one_decode_reg+0x0/0xfc>
> ERROR(0): M_SYND(0),  E_SYND(0)

Please try this patch:

commit 980a9fd582ee9ac6729d6f0ac19ce21ca55aa401
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Fri Dec 7 00:58:55 2007 -0800

    [SPARC64]: Fix memory controller register access when non-SMP.
    
    get_cpu() always returns zero on non-SMP builds, but we
    really want the physical cpu number in this code in order
    to do the right thing.
    
    Based upon a non-SMP kernel boot failure report from Bernd Zeimetz.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/chmc.c b/arch/sparc64/kernel/chmc.c
index 777d345..6d4f02e 100644
--- a/arch/sparc64/kernel/chmc.c
+++ b/arch/sparc64/kernel/chmc.c
@@ -1,7 +1,6 @@
-/* $Id: chmc.c,v 1.4 2002/01/08 16:00:14 davem Exp $
- * memctrlr.c: Driver for UltraSPARC-III memory controller.
+/* memctrlr.c: Driver for UltraSPARC-III memory controller.
  *
- * Copyright (C) 2001 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2001, 2007 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/module.h>
@@ -16,6 +15,7 @@
 #include <linux/init.h>
 #include <asm/spitfire.h>
 #include <asm/chmctrl.h>
+#include <asm/cpudata.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -242,8 +242,11 @@ int chmc_getunumber(int syndrome_code,
  */
 static u64 read_mcreg(struct mctrl_info *mp, unsigned long offset)
 {
-	unsigned long ret;
-	int this_cpu = get_cpu();
+	unsigned long ret, this_cpu;
+
+	preempt_disable();
+
+	this_cpu = real_hard_smp_processor_id();
 
 	if (mp->portid = this_cpu) {
 		__asm__ __volatile__("ldxa	[%1] %2, %0"
@@ -255,7 +258,8 @@ static u64 read_mcreg(struct mctrl_info *mp, unsigned long offset)
 				     : "r" (mp->regs + offset),
 				       "i" (ASI_PHYS_BYPASS_EC_E));
 	}
-	put_cpu();
+
+	preempt_enable();
 
 	return ret;
 }
