Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E9C0015E
	for <sparclinux@archiver.kernel.org>; Wed, 28 Jun 2023 10:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF1KF6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 28 Jun 2023 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjF1Jy1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 28 Jun 2023 05:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941DC30FC;
        Wed, 28 Jun 2023 02:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 246EE61260;
        Wed, 28 Jun 2023 09:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7838BC433C0;
        Wed, 28 Jun 2023 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687945792;
        bh=rQo+ivr1Jk6fLZn+NaRy01I9YN0NbBC+DKUTXazksTM=;
        h=From:To:Cc:Subject:Date:From;
        b=f+0sJIxIinYqm1D3xPb+WilOJAfna6B8zybTiF74kKZTT5Pgszfx3sVzUtxjl9PQW
         a1dVvDHbOipjBf7ktFnDjAyxjI3e8Gn01OwfBu3S61V/MlqeQfBpKyTyzI5XkvLggg
         nAnZr6J4bU6PIQ13rsscic0Q4RTDF2rq6R8/KwYHYqPHgJUkOFJ/x8S3BCJ0sxxal1
         5LLku+cMm6zV8wXuIO/5cym+y03rplp+d8FYpcHV4QwDlD6FMHf3gvPhpRbSRHBgvY
         ryjTzj9lfAzZ6NbkI/Yd884E9FOkI91GTF4EDlWts1vnk1r0TOGaXN3AMMuNooL0zV
         wCB3QXsHF4ykw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: mark __arch_xchg() as __always_inline
Date:   Wed, 28 Jun 2023 11:49:18 +0200
Message-Id: <20230628094938.2318171-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

An otherwise correct change to the atomic operations uncovered an
existing bug in the sparc __arch_xchg() function, which is calls
__xchg_called_with_bad_pointer() when its arguments are unknown at
compile time:

ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!

This now happens because gcc determines that it's better to not inline the
function. Avoid this by just marking the function as __always_inline
to force the compiler to do the right thing here.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/cmpxchg_32.h | 2 +-
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 7a1339533d1d7..d0af82c240b73 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -15,7 +15,7 @@
 unsigned long __xchg_u32(volatile u32 *m, u32 new);
 void __xchg_called_with_bad_pointer(void);
 
-static inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
+static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
 {
 	switch (size) {
 	case 4:
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 66cd61dde9ec1..3de25262c4118 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -87,7 +87,7 @@ xchg16(__volatile__ unsigned short *m, unsigned short val)
 	return (load32 & mask) >> bit_shift;
 }
 
-static inline unsigned long
+static __always_inline unsigned long
 __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
 {
 	switch (size) {
-- 
2.39.2

