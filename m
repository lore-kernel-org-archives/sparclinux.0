From: David Miller <davem@davemloft.net>
Date: Wed, 21 Aug 2013 19:30:29 +0000
Subject: Re: [sparc64] Question about loop interations in trampoline_64.S
Message-Id: <20130821.123029.981827254963819519.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1211376700742@web12h.yandex.ru>
In-Reply-To: <1211376700742@web12h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 17 Aug 2013 04:52:22 +0400

> %l5 iterates from 0 to %l6, where %l6 is (num_kernel_image_mappings + 1).
> 
> The loop is equal to:
> 
> for (l5 = 0; l5 < num_kernel_image_mappings + 1; l5++).
> 
> Is there no error? Looks like we don't have to lock 4MB page, which  number
> is num_kernel_image_mappings. Or prom call has any side effect?

That definitely looks like an off-by-one error, could you test the
following obvious fix?

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index e0b1e13..ad4bde3 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -129,7 +129,6 @@ startup_continue:
 	clr		%l5
 	sethi		%hi(num_kernel_image_mappings), %l6
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
-	add		%l6, 1, %l6
 
 	mov		15, %l7
 	BRANCH_IF_ANY_CHEETAH(g1,g5,2f)
@@ -222,7 +221,6 @@ niagara_lock_tlb:
 	clr		%l5
 	sethi		%hi(num_kernel_image_mappings), %l6
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
-	add		%l6, 1, %l6
 
 1:
 	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
