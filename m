Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7442C07E95
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jul 2021 08:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA61619A9
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jul 2021 08:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGGIdS (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:33:18 -0400
Received: from foss.arm.com ([217.140.110.172]:59714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGGIdR (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 7 Jul 2021 04:33:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B58CBED1;
        Wed,  7 Jul 2021 01:30:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF5683F694;
        Wed,  7 Jul 2021 01:30:36 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, peterz@lists.infradead.org,
        davem@davemloft.net
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH] locking/atomic: sparc: fix arch_cmpxchg64_local()
Date:   Wed,  7 Jul 2021 09:30:32 +0100
Message-Id: <20210707083032.567-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Anatoly reports that since commit:

  ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")

... it's possible to reliably trigger an oops by running:

  stress-ng -v --mmap 1 -t 30s

... which results in a NULL pointer dereference in
__split_huge_pmd_locked().

The underlying problem is that commit ff5b4f1ed580c59d left
arch_cmpxchg64_local() defined in terms of cmpxchg_local() rather than
arch_cmpxchg_local(). In <asm-generic/atomic-instrumented.h> we wrap
these with macros which use identically-named variables. When
cmpxchg_local() nests inside cmpxchg64_local(), this casues it to use an
unitialized variable as the pointer, which can be NULL.

This can also be seen in pmdp_establish(), where the compiler can
generate the pointer with a `clr` instruction:

0000000000000360 <pmdp_establish>:
 360:   9d e3 bf 50     save  %sp, -176, %sp
 364:   fa 5e 80 00     ldx  [ %i2 ], %i5
 368:   82 10 00 1b     mov  %i3, %g1
 36c:   84 10 20 00     clr  %g2
 370:   c3 f0 90 1d     casx  [ %g2 ], %i5, %g1
 374:   80 a7 40 01     cmp  %i5, %g1
 378:   32 6f ff fc     bne,a   %xcc, 368 <pmdp_establish+0x8>
 37c:   fa 5e 80 00     ldx  [ %i2 ], %i5
 380:   d0 5e 20 40     ldx  [ %i0 + 0x40 ], %o0
 384:   96 10 00 1b     mov  %i3, %o3
 388:   94 10 00 1d     mov  %i5, %o2
 38c:   92 10 00 19     mov  %i1, %o1
 390:   7f ff ff 84     call  1a0 <__set_pmd_acct>
 394:   b0 10 00 1d     mov  %i5, %i0
 398:   81 cf e0 08     return  %i7 + 8
 39c:   01 00 00 00     nop

This patch fixes the problem by defining arch_cmpxchg64_local() in terms
of arch_cmpxchg_local(), avoiding potential shadowing, and resulting in
working cmpxchg64_local() and variants, e.g.

0000000000000360 <pmdp_establish>:
 360:   9d e3 bf 50     save  %sp, -176, %sp
 364:   fa 5e 80 00     ldx  [ %i2 ], %i5
 368:   82 10 00 1b     mov  %i3, %g1
 36c:   c3 f6 90 1d     casx  [ %i2 ], %i5, %g1
 370:   80 a7 40 01     cmp  %i5, %g1
 374:   32 6f ff fd     bne,a   %xcc, 368 <pmdp_establish+0x8>
 378:   fa 5e 80 00     ldx  [ %i2 ], %i5
 37c:   d0 5e 20 40     ldx  [ %i0 + 0x40 ], %o0
 380:   96 10 00 1b     mov  %i3, %o3
 384:   94 10 00 1d     mov  %i5, %o2
 388:   92 10 00 19     mov  %i1, %o1
 38c:   7f ff ff 85     call  1a0 <__set_pmd_acct>
 390:   b0 10 00 1d     mov  %i5, %i0
 394:   81 cf e0 08     return  %i7 + 8
 398:   01 00 00 00     nop
 39c:   01 00 00 00     nop

Link: https://lore.kernel.org/r/CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com
Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@lists.infradead.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Peter, David, could one of you please apply this? It's an urgent fix for
fallout from the ARCH_ATOMIC conversion, and it'd be good to fix before -rc1.

Thanks,
Mark.

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 8c39a9981187..12d00a42c0a3 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));					\
   })
 #define arch_cmpxchg64(ptr, o, n)	arch_cmpxchg64_local((ptr), (o), (n))
 
-- 
2.11.0

