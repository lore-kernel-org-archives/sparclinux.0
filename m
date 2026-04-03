Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16945279DCE
	for <sparclinux@vger.kernel.org>; Fri,  3 Apr 2026 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179563; cv=none; b=dFtMAAJ5kJ02Ufi4GxImZscvbH6eH4KJ31zJtKdQqGZ8gQEx8XAeo3KjXCByq/ylk4sdshlWl/KSLnn3hVBti6/XpJQbbyF0Jsy+I6UEfjhqvOsnITXm0G3PaXJXYYL+WD9s8TrskPa8y62iSvbMaR7BNkR+oGcyaKvLGvUfk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179563; c=relaxed/simple;
	bh=Rca1Igq11csWkwtHUepRgwzoIt9D5QauYh/gGKi0oLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JBkdGOewGoID9yAYiUi8Yn337yX48uhRcwQzF632sjKeq/IkhLmrgcHm4pFg/g1SLea48AR7GFxTyXnmrShFXwO8P1ZG5DT/BCEsFWYOtp3U12adC6xLsmdWOQzwxBFrU2kk1bLf9ZeB8TOwwqth+iLcNz8Hns8WumUOAwm8id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWQ83985; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWQ83985"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1010401a91.0
        for <sparclinux@vger.kernel.org>; Thu, 02 Apr 2026 18:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775179561; x=1775784361; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rY2ciLkg8RtFIf8Sumay9p4mc2pCLq551+da1KF5JtU=;
        b=GWQ83985PWIK3VtqfTN03yGWL2Y728EBpAbS1xx0D9Pqgggd634J/2TCqj2LtsMwfo
         xHm4baDtbvi9Vc85Jmq4J97lUc35GPRIifPJBxWGByvrPdSJOMfRsBg/4hgx7ws7OM1T
         /Do4xDsfpOGkJ0ZMFus3uxBjQhJprWY8zQqm2NoJBnMbD7r4W3uQ2h8EMweVwSuuZqK8
         wMblo1uJ9yluCH/MR/vgFgyDefBd3ffidHykyTgIRkua7VfZ8GuzwTH7XHMBlwmfT3lw
         ZipYhDrogrvEvRq4AZoiPedVEgDhYPDvKU/gofpI3BwUZxzq/Sl7I7ewqqaSMI602hLo
         1TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775179561; x=1775784361;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY2ciLkg8RtFIf8Sumay9p4mc2pCLq551+da1KF5JtU=;
        b=HOmn+hSu6SMS3EZ4sfi2YpyfYlj/CdsMOjpGfEKxASoAOWJv7/HoIR4dwIB67/B8LZ
         xTVEnWKuLQgNm8Ai7yLfgkwLPwzpYM+P2CpsejSiYjxnjxbi9ImG+baGh85f9SWlvb70
         BVo+Mn+m1l84Vqc0K03pskgchvoWlvU3+oxGCVay3t7kW62na1xZnCIZzK3adwZmdAop
         8pRWrbN4/Xjtc3/h3mR2eKnGWpQzXfcM+BvBHj6FRztKYfh/FB9Y9fqucLpwRtCUrV9i
         CiW+NM0syCfeP5WIHguEH3zWWa0RnqQGgLsKRqrchtCjwO5XHb1oyYCC0kwUZLQvBNt6
         meaA==
X-Forwarded-Encrypted: i=1; AJvYcCWKmnq1bNdNZlhkZvdBKA0FWA8B/r9sn1oxnmvUbmhGWKaDswaG2DSw5p/1akgP0wjTq0DzPewDdz3c@vger.kernel.org
X-Gm-Message-State: AOJu0YykVGX8YhohqPHn7lpLzOXJwcQhMKbv1yZIpLwWZ/Rlbp7t8EZF
	RY2gYvABNsPyr+CPCde4Jb/W36nuWy7Tvvm4CQVA7/0wNxn1SWn3yk36
X-Gm-Gg: AeBDiesBojjRcrqMPJ/kX2CVJgcTmvsFgZauUwWO/CW6GG2ebqDjxXba5JUMfXAdmum
	WxLGh3EMjrAay6BL+XJcfItEiF3mtu4Ns/UYgkixB3diOwXxDQQqBK/V3QkE9UMAH16Qzpus8TB
	RWnp5ICFjRl28yTBiDiCaH3DWdvkeSoCtCy7bagrrjn66Um/UFNr2Havq9QqADSeRQG4ntGL9Y0
	Oxmoz3lOPsO1x9d0Ys+/LCIpX4ZJQlgVE0RyT2bIC3t8XBd4rdH178f40GgimcYqWiO5O3n2Ry+
	ejAf8lZ9kdO1P18RuzRKIlp0SrTFj9Fu6xqJadnUXzJSjU9Yq+xvfxUtMLAiZ4X/JYF10ikqUp2
	bGxSvbCE35JBqVsVmlYQJ6NplclSH5NYRWhWkyFb9UMp+f/CILp750l5NgqPrLedwyZfZrjS4Gu
	sLWP34nBt9f1WKt1g0obrXvfhAVskY+Sa6b4PDIVHEAemyudHF
X-Received: by 2002:a17:902:ea0b:b0:2b2:5da8:14be with SMTP id d9443c01a7336-2b28190a213mr12256705ad.41.1775179561300;
        Thu, 02 Apr 2026 18:26:01 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d688sm42536555ad.8.2026.04.02.18.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 18:25:59 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 03 Apr 2026 09:19:54 +0800
Subject: [PATCH v2] cmpxchg: allow const-qualified old value in cmpxchg()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-cmpxchg-v2-1-23acd2727447@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMSwrDIBSF4a2EO65Fb00KHXUfJQPxeaHGoEFSg
 nuvzbTD/3D4Dig2ky3wGA7ItlKhtPTAywA6qMVbRqY3IMeJS45Mx3XXwTN05sbvTkolBfT3mq2
 j/ZRec+9AZUv5c8JV/NZ/owommBwnYVHz0aB++qjofdUpwtxa+wIngfApngAAAA==
X-Change-ID: 20260402-cmpxchg-2fd307f44a41
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 David Laight <david.laight.linux@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

The old value passed to cmpxchg() is semantically read-only: it is
only loaded into a register as a comparand and is never written back.
However, the macro currently assigns it implicitly to a local variable
of type __typeof__(*(ptr)), which triggers -Werror=discarded-qualifiers
when old is a const-qualified pointer and ptr points to a non-const type.

Fix this by using __auto_type with the conditional expression trick:

  __auto_type _o_ = 1 ? (o) : *(ptr);

The __auto_type deduces the type from the expression, so _o_ naturally
takes the const-qualified type when o is const-qualified, avoiding the
discarded-qualifiers warning. The conditional expression forces the
compiler to verify that o and *(ptr) have compatible types, preserving
the type-safety check that a bare __auto_type _o_ = (o) would lose.
Since the condition is the constant 1, the compiler optimizes away the
*(ptr) branch entirely with no runtime cost.

For macros where ptr is already captured in a local variable (arc's
_p_, hexagon's __ptr, riscv's __ptr), the captured variable is used
in the conditional expression to avoid re-evaluating ptr.

The new value is intentionally left without this treatment: new will
be stored into *ptr, so silently accepting a const-qualified new would
allow callers to store a pointer-to-const into a non-const location
without any compiler warning.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Changes in v2:
- Use __auto_type as the previous way will loose ptr type checking (David Laight)
- Link to v1: https://lore.kernel.org/r/20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com
---
 arch/alpha/include/asm/cmpxchg.h     | 4 ++--
 arch/arc/include/asm/cmpxchg.h       | 4 ++--
 arch/hexagon/include/asm/cmpxchg.h   | 2 +-
 arch/parisc/include/asm/cmpxchg.h    | 2 +-
 arch/powerpc/include/asm/cmpxchg.h   | 8 ++++----
 arch/riscv/include/asm/cmpxchg.h     | 4 ++--
 arch/sh/include/asm/cmpxchg.h        | 2 +-
 arch/sparc/include/asm/cmpxchg_32.h  | 2 +-
 arch/sparc/include/asm/cmpxchg_64.h  | 2 +-
 arch/x86/include/asm/cmpxchg.h       | 2 +-
 arch/xtensa/include/asm/cmpxchg.h    | 2 +-
 tools/arch/x86/include/asm/cmpxchg.h | 2 +-
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index ae1b96479d0c..e6cb60ca35bf 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__auto_type _o_ = 1 ? (o) : *(ptr);				\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
 					  (unsigned long)_n_,		\
@@ -265,7 +265,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__auto_type _o_ = 1 ? (o) : *(ptr);				\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	smp_mb();							\
 	__ret = (__typeof__(*(ptr))) ____cmpxchg((ptr),			\
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..e18609174133 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -42,7 +42,7 @@
 #define arch_cmpxchg_relaxed(ptr, old, new)				\
 ({									\
 	__typeof__(ptr) _p_ = (ptr);					\
-	__typeof__(*(ptr)) _o_ = (old);					\
+	__auto_type _o_ = 1 ? (old) : *(_p_);				\
 	__typeof__(*(ptr)) _n_ = (new);					\
 	__typeof__(*(ptr)) _prev_;					\
 									\
@@ -64,7 +64,7 @@
 #define arch_cmpxchg(ptr, old, new)				        \
 ({									\
 	volatile __typeof__(ptr) _p_ = (ptr);				\
-	__typeof__(*(ptr)) _o_ = (old);					\
+	__auto_type _o_ = 1 ? (old) : *(_p_);				\
 	__typeof__(*(ptr)) _n_ = (new);					\
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 9c58fb81f7fd..88986fe04072 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -54,7 +54,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 #define arch_cmpxchg(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(*(ptr)) __old = (old);			\
+	__auto_type __old = 1 ? (old) : *(__ptr);		\
 	__typeof__(*(ptr)) __new = (new);			\
 	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index bf0a0f1189eb..30748e31aa17 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -78,7 +78,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 
 #define arch_cmpxchg(ptr, o, n)						 \
 ({									 \
-	__typeof__(*(ptr)) _o_ = (o);					 \
+	__auto_type _o_ = 1 ? (o) : *(ptr);				 \
 	__typeof__(*(ptr)) _n_ = (n);					 \
 	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index dbb50c06f0bf..eaf88b7d0443 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -698,7 +698,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 }
 #define arch_cmpxchg(ptr, o, n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __auto_type _o_ = 1 ? (o) : *(ptr);				 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
@@ -707,7 +707,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_local(ptr, o, n)					 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __auto_type _o_ = 1 ? (o) : *(ptr);				 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
@@ -715,7 +715,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__auto_type _o_ = 1 ? (o) : *(ptr);				\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
 			(unsigned long)_o_, (unsigned long)_n_,		\
@@ -724,7 +724,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__auto_type _o_ = 1 ? (o) : *(ptr);				\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
 			(unsigned long)_o_, (unsigned long)_n_,		\
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 8712cf9c69dc..30ade671298f 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -215,7 +215,7 @@
 		      cas_prepend, cas_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(__ptr)) __old = (old);				\
+	__auto_type __old = 1 ? (old) : *(__ptr);			\
 	__typeof__(*(__ptr)) __new = (new);				\
 	__typeof__(*(__ptr)) __ret;					\
 									\
@@ -331,7 +331,7 @@ union __u128_halves {
 
 #define __arch_cmpxchg128(p, o, n, cas_sfx)					\
 ({										\
-	__typeof__(*(p)) __o = (o);                                             \
+	__auto_type __o = 1 ? (o) : *(p);					\
 	union __u128_halves __hn = { .full = (n) };				\
 	union __u128_halves __ho = { .full = (__o) };				\
 	register unsigned long t1 asm ("t1") = __hn.low;			\
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..6c1bfb367f11 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -68,7 +68,7 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 
 #define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __auto_type _o_ = 1 ? (o) : *(ptr);				 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 8c1a3ca34eeb..df40a16dd021 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -55,7 +55,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__auto_type _o_ = 1 ? (o) : *(ptr);				\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	\
 			(unsigned long)_n_, sizeof(*(ptr)));		\
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 3de25262c411..4b540405fcc7 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -170,7 +170,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 
 #define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __auto_type _o_ = 1 ? (o) : *(ptr);				 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a88b06f1c35e..e0340579ef69 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -85,7 +85,7 @@ extern void __add_wrong_size(void)
 #define __raw_cmpxchg(ptr, old, new, size, lock)			\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
+	__auto_type __old = 1 ? (old) : *(ptr);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	switch (size) {							\
 	case __X86_CASE_B:						\
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..057fd24ed125 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -83,7 +83,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 }
 
 #define arch_cmpxchg(ptr,o,n)						      \
-	({ __typeof__(*(ptr)) _o_ = (o);				      \
+	({ __auto_type _o_ = 1 ? (o) : *(ptr);				      \
 	   __typeof__(*(ptr)) _n_ = (n);				      \
 	   (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	      \
 	   			        (unsigned long)_n_, sizeof (*(ptr))); \
diff --git a/tools/arch/x86/include/asm/cmpxchg.h b/tools/arch/x86/include/asm/cmpxchg.h
index 0ed9ca2766ad..bbd3960c2218 100644
--- a/tools/arch/x86/include/asm/cmpxchg.h
+++ b/tools/arch/x86/include/asm/cmpxchg.h
@@ -35,7 +35,7 @@ extern void __cmpxchg_wrong_size(void)
 #define __raw_cmpxchg(ptr, old, new, size, lock)			\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
+	__auto_type __old = 1 ? (old) : *(ptr);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	switch (size) {							\
 	case __X86_CASE_B:						\

---
base-commit: f8f5627a8aeab15183eef8930bf75ba88a51622f
change-id: 20260402-cmpxchg-2fd307f44a41

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>

