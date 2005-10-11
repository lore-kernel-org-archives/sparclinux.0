From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Oct 2005 22:41:59 +0000
Subject: Re: linux-2.6.14-rc does not boot on Ultra 5
Message-Id: <20051011.154159.130697547.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051011210428.GC2865@leonov.stosberg.net>
In-Reply-To: <20051011210428.GC2865@leonov.stosberg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Stosberg <dennis@stosberg.net>
Date: Tue, 11 Oct 2005 23:49:49 +0200

> ok .registers
>         Normal          Alternate       MMU               Vector
> 0:                 0                0                0                0
> 1:                 f         fffde6c0       9900001600       2000002402
> 2:            4042ec         f0000000               14    2220000080000
> 3:                 0                0         fffe0000 8220200000020000
> 4:                 0                0 ffffffffffffffff        200800400
> 5:                 0                f         fffda000     a00000000a00
> 6:                 0       4400001601         fffe0000        200000d00
> 7:                17               10         f0000e00   10080000180080
> %PC  4042f0 %nPC 6c421084
> %TBA f0000000 %CCR 99 XCC:NzvC   ICC:NzvC

Not aligning the kernel mapping physical address correctly.
Please try this fix:

diff --git a/arch/sparc64/kernel/head.S b/arch/sparc64/kernel/head.S
index f1dcdf8..4c942f7 100644
--- a/arch/sparc64/kernel/head.S
+++ b/arch/sparc64/kernel/head.S
@@ -191,8 +191,9 @@ prom_boot_mapping_phys_low:
 	stx	%l3, [%sp + 2047 + 128 + 0x10]	! num_rets, 5
 	stx	%l2, [%sp + 2047 + 128 + 0x18]	! arg1: "translate"
 	stx	%l5, [%sp + 2047 + 128 + 0x20]	! arg2: prom_mmu_ihandle_cache
-	srlx	%l0, 22, %l3
-	sllx	%l3, 22, %l3
+	/* PAGE align */
+	srlx	%l0, 13, %l3
+	sllx	%l3, 13, %l3
 	stx	%l3, [%sp + 2047 + 128 + 0x28]	! arg3: vaddr, our PC
 	stx	%g0, [%sp + 2047 + 128 + 0x30]	! res1
 	stx	%g0, [%sp + 2047 + 128 + 0x38]	! res2
@@ -211,6 +212,9 @@ prom_boot_mapping_phys_low:
 	ldx	[%sp + 2047 + 128 + 0x48], %l2	! physaddr high
 	stx	%l2, [%l4 + 0x0]
 	ldx	[%sp + 2047 + 128 + 0x50], %l3	! physaddr low
+	/* 4MB align */
+	srlx	%l3, 22, %l3
+	sllx	%l3, 22, %l3
 	stx	%l3, [%l4 + 0x8]
 
 	/* Leave service as-is, "call-method" */
