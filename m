Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F97C07E99
	for <sparclinux@archiver.kernel.org>; Mon,  5 Jul 2021 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6505161483
	for <sparclinux@archiver.kernel.org>; Mon,  5 Jul 2021 19:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhGET7n (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:59:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhGET7n (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Mon, 5 Jul 2021 15:59:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECABA1FB;
        Mon,  5 Jul 2021 12:57:05 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.8.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D6B3F73B;
        Mon,  5 Jul 2021 12:57:04 -0700 (PDT)
Date:   Mon, 5 Jul 2021 20:56:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        Peter Zijlstra <peterz@lists.infradead.org>
Subject: Re: [sparc64] locking/atomic, kernel OOPS on running stress-ng
Message-ID: <20210705195638.GA53988@C02TD0UTHF1T.local>
References: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Jul 05, 2021 at 06:16:49PM +0300, Anatoly Pugachev wrote:
> Hello!

Hi Anatoly,

> latest sparc64 git kernel produces the following OOPS on running stress-ng as :
> 
> $ stress-ng -v --mmap 1 -t 30s
> 
> kernel OOPS (console logs):
> 
> [   27.276719] Unable to handle kernel NULL pointer dereference
> [   27.276782] tsk->{mm,active_mm}->context = 00000000000003cb
> [   27.276818] tsk->{mm,active_mm}->pgd = fff800003a2a0000
> [   27.276853]               \|/ ____ \|/
> [   27.276853]               "@'/ .. \`@"
> [   27.276853]               /_| \__/ |_\
> [   27.276853]                  \__U_/
> [   27.276927] stress-ng(928): Oops [#1]

I can reproduce this under QEMU; following your bisection (and working
around the missing ifdeferry that breaks bisection), I can confirm that
the first broken commit is:

  ff5b4f1ed580 ("locking/atomic: sparc: move to ARCH_ATOMIC")

Sorry about this.
 
> Can someone please look at this commit ids?

From digging into this, I can't spot an obvious bug in the commit above.

It looks like this happens when some of the xchg/cmpxchg variants are
wrapped by <asm-generic/atomic-instrumented.h>, but I can't immediately
explain why. This might be a latent bug that's being tickled by the
structure of the wrappers, or some subtlety with the typecasting that
happens in the wrappers.

Starting with:

  ff5b4f1ed580 ("locking/atomic: sparc: move to ARCH_ATOMIC")

... and atop that, cherry-picking:

  bccf1ec369ac ("locking/atomics: atomic-instrumented: simplify ifdeffery")

... the below hack seems to make the stress-ng run pass without issue,
even after running for multiple minutes (when it would usually fail in a
few seconds).

In case this is a codegen issue, I'm using the kernel.org GCC 10.3.0
cross toolchain.

Thanks,
Mark.

---->8----
From 9a77ebd7005a9d4492686c45207642eeb4d13a8c Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 5 Jul 2021 20:38:06 +0100
Subject: [PATCH] HACK: disable instrumentation of xchg/cmpxchg

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/asm-generic/atomic-instrumented.h | 86 ++++++++++++++++++++++++++++++-
 scripts/atomic/gen-atomic-instrumented.sh | 10 ++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index bc45af52c93b..7d0c38091c82 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1177,90 +1177,139 @@ atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
 
+#if 0
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define xchg 	arch_xchg
+#endif
 
+#if 0
 #define xchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define xchg_acquire 	arch_xchg_acquire
+#endif
 
+#if 0
 #define xchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define xchg_release 	arch_xchg_release
+#endif
 
+#if 0
 #define xchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define xchg_relaxed 	arch_xchg_relaxed
+#endif
 
+#if 0
 #define cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg 	arch_cmpxchg
+#endif
 
+#if 0
 #define cmpxchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg_acquire 	arch_cmpxchg_acquire
+#endif
 
+#if 0
 #define cmpxchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg_release 	arch_cmpxchg_release
+#endif
 
+#if 0
 #define cmpxchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg_relaxed 	arch_cmpxchg_relaxed
+#endif
 
+#if 0
 #define cmpxchg64(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg64 	arch_cmpxchg64
+#endif
 
+#if 0
 #define cmpxchg64_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg64_acquire 	arch_cmpxchg64_acquire
+#endif
 
+#if 0
 #define cmpxchg64_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg64_release 	arch_cmpxchg64_release
+#endif
 
+#if 0
 #define cmpxchg64_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg64_relaxed 	arch_cmpxchg64_relaxed
+#endif
 
+#if 0
 #define try_cmpxchg(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1269,7 +1318,11 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
+#else
+#define try_cmpxchg 	arch_try_cmpxchg
+#endif
 
+#if 0
 #define try_cmpxchg_acquire(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1278,7 +1331,11 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
+#else
+#define try_cmpxchg_acquire 	arch_try_cmpxchg_acquire
+#endif
 
+#if 0
 #define try_cmpxchg_release(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1287,7 +1344,11 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
+#else
+#define try_cmpxchg_release 	arch_try_cmpxchg_release
+#endif
 
+#if 0
 #define try_cmpxchg_relaxed(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1296,42 +1357,65 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
+#else
+#define try_cmpxchg_relaxed 	arch_try_cmpxchg_relaxed
+#endif
 
+#if 0
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg_local 	arch_cmpxchg_local
+#endif
 
+#if 0
 #define cmpxchg64_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg64_local 	arch_cmpxchg64_local
+#endif
 
+#if 0
 #define sync_cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define sync_cmpxchg 	arch_sync_cmpxchg
+#endif
 
+#if 0
 #define cmpxchg_double(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg_double 	arch_cmpxchg_double
+#endif
 
 
+#if 0
 #define cmpxchg_double_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
+#else
+#define cmpxchg_double_local 	arch_cmpxchg_double_local
+#endif
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 1d7c3a25aca5c7fb031c307be4c3d24c7b48fcd5
+// 2a4279557c0aea18c2784cefd4a26d58e6ee66d0
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index b0c45aee19d7..bfadca4046fb 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -80,6 +80,7 @@ gen_xchg()
 	if [ "${xchg%${xchg#try_cmpxchg}}" = "try_cmpxchg" ] ; then
 
 cat <<EOF
+#if 0
 #define ${xchg}(ptr, oldp, ...) \\
 ({ \\
 	typeof(ptr) __ai_ptr = (ptr); \\
@@ -88,17 +89,26 @@ cat <<EOF
 	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
 	arch_${xchg}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
 })
+#else
+#define ${xchg} \
+	arch_${xchg}
+#endif
 EOF
 
 	else
 
 cat <<EOF
+#if 0
 #define ${xchg}(ptr, ...) \\
 ({ \\
 	typeof(ptr) __ai_ptr = (ptr); \\
 	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
 	arch_${xchg}(__ai_ptr, __VA_ARGS__); \\
 })
+#else
+#define ${xchg} \
+	arch_${xchg}
+#endif
 EOF
 
 	fi
-- 
2.11.0

