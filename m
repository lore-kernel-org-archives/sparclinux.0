Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C49C07E96
	for <sparclinux@archiver.kernel.org>; Tue,  6 Jul 2021 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5016198E
	for <sparclinux@archiver.kernel.org>; Tue,  6 Jul 2021 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGFJOG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 05:14:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhGFJOG (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 6 Jul 2021 05:14:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DFF731B;
        Tue,  6 Jul 2021 02:11:27 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.31.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2003C3F5A1;
        Tue,  6 Jul 2021 02:11:25 -0700 (PDT)
Date:   Tue, 6 Jul 2021 10:11:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anatoly Pugachev <matorola@gmail.com>,
        Peter Zijlstra <peterz@lists.infradead.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: [sparc64] locking/atomic, kernel OOPS on running stress-ng
Message-ID: <20210706091104.GA69200@C02TD0UTHF1T.local>
References: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
 <20210705195638.GA53988@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705195638.GA53988@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Jul 05, 2021 at 08:56:54PM +0100, Mark Rutland wrote:
> On Mon, Jul 05, 2021 at 06:16:49PM +0300, Anatoly Pugachev wrote:
> > Hello!
> 
> Hi Anatoly,
> 
> > latest sparc64 git kernel produces the following OOPS on running stress-ng as :
> > 
> > $ stress-ng -v --mmap 1 -t 30s
> > 
> > kernel OOPS (console logs):
> > 
> > [   27.276719] Unable to handle kernel NULL pointer dereference
> > [   27.276782] tsk->{mm,active_mm}->context = 00000000000003cb
> > [   27.276818] tsk->{mm,active_mm}->pgd = fff800003a2a0000
> > [   27.276853]               \|/ ____ \|/
> > [   27.276853]               "@'/ .. \`@"
> > [   27.276853]               /_| \__/ |_\
> > [   27.276853]                  \__U_/
> > [   27.276927] stress-ng(928): Oops [#1]
> 
> I can reproduce this under QEMU; following your bisection (and working
> around the missing ifdeferry that breaks bisection), I can confirm that
> the first broken commit is:
> 
>   ff5b4f1ed580 ("locking/atomic: sparc: move to ARCH_ATOMIC")
> 
> Sorry about this.
>  
> > Can someone please look at this commit ids?
> 
> From digging into this, I can't spot an obvious bug in the commit above.

Looking again with fresh eyes, there is a trivial bug after all.

Could you give the patch below a spin? It works for me locally under
QEMU.

Sorry again about this!

Thanks,
Mark
---->8----
From afb683b2ce749dca426d27f05af3ea08455a52d7 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 6 Jul 2021 09:55:56 +0100
Subject: [PATCH] locking/atomic: sparc: fix arch_cmpxchg64_local()

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

Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@lists.infradead.org>
---
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

