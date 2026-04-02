Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA437D101
	for <sparclinux@vger.kernel.org>; Thu,  2 Apr 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113003; cv=none; b=PxHgVhAsiOt9QLWalxUdmFD+uUN0SS1PWraStN39Sw8uNyU5+3NoLtOMbgFLgqj97cAs1lk975RIE244CmQCarCadGB9zXwTbC+HWXlAOFs1euHyECdnDM12WJudDfU6pG/jXI1AkVfQ9ceFYaiC8GgeHVFI+FeDR3b4UpxJ1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113003; c=relaxed/simple;
	bh=duIUmMHX/NLgaTXyePmtipwg8X2dHzvr4MT8FB07vLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JKjaGgX04P9BRyPyI0l0j41mU/8Yel7gn7v73hC/Z2Tz2RcfTE2YROF3XG9XSG7MX+lEUoWQSKd35wcyjIsn10BpzGHuR3xT2gvjwoKTu2xD/tDgRA4UgTb4JuSIHcc1Juw+nHk1GfJEnC4bT2ww0ocAjVyjZZWHcjcQqFBooCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IinDgIYH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IinDgIYH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2589c26e3so4352265ad.1
        for <sparclinux@vger.kernel.org>; Wed, 01 Apr 2026 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775112999; x=1775717799; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpdYf1WLDHAMV/rn1y6xYHlGkLnTRJ4f+O5zsHNUww=;
        b=IinDgIYH0oyXAPxGGKk4lI6hwBNshlo8FY9/XREnT8nuK7rFpzyb5WdqNr/oSKhPvl
         VOgjTHqLdijiOybFzWW92uFZPnlbRRb+tu1AmJtr1yTJw47vO+6J5kPKS8C+kM/1BpOx
         ZLnlhANXeDoCq32y6h+ypHi3Hi6kVz1PkIbpuMmHPcFwM7GkZ6jN13IL6WzhmpIdSmCh
         39ectPh0cHz/WE+SmEsrKALYpByT3XE7q8eSO/fPPPZ+Fn+zLhdf46kU8JxR6Va5rd3Q
         si2gpvewD8uZPkRXeF/S8cE84M/YlprKaOvEsClhalHTjEKcJVg8noPImb2+4XT9TEes
         Ow/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112999; x=1775717799;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlpdYf1WLDHAMV/rn1y6xYHlGkLnTRJ4f+O5zsHNUww=;
        b=EPa3JH1At9Rl8x94wFc9ag1kXcEo6kMZpzq62q8MAMNqesjl6qR2JCsy/93RXmOTBW
         I1TxxbZ02A/QyeBJEGH8f+FsTGoE0u8CuifxQWj43OxQti5NPM847AzOAm6LaQCYhck/
         yDq51KKKG3nwFcdOj4Rt0nyzGqaQH2dSw5JaxZmJr/aempgdMA6kNLgU1vyeK7KCPWWQ
         pC11psYZCitqCfwIN11hPhFFgk9oGyCAFy/lDKmhUBO9NxFelyDG3BytSOvacO9XUiTW
         AS5jp0YW9OEvMJ9K/wa2ryr0WT8OmN5nCzBCjz7RzDAtEv5AOI1Vr6ypj4ZRXFDFcmrY
         4B9w==
X-Forwarded-Encrypted: i=1; AJvYcCUF6IWo2BnHyAqDVemzvehOIvX3KGEAA9n7rq/QIwVs0QiYxwUniXVIVQpWAvFBYE2KPJpLE1RyIIna@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbba6CZ9ozZkWZNZLgyYddubbi9SgapPiprgZKnyiv0c9p7xWg
	l2i7Fij2YBzQpdpbZKZjapIsjfDVyHXA2YnH/aGsXNtZzVQ/+tgvJcwE
X-Gm-Gg: AeBDievU0ydPl95DMA6c+e3M9tDstsTYlHy09hxxvDtRm3rd6JPluITHyKfBWPEj9W1
	WUHcz+v9blM3MsdacAfD/udGLqzSI1+21MxKqM8uaJFBc/PFy1JaVIIHsrXnqAwsuKnHqC/wRiM
	JbXiTjSOlIcU8zve6skv8+ZD+R81U3/Y4sLqOWuEu2lgAWZWETDeO7pfDz2HBuXYK+Z5GUz7L3c
	QG7u3r8XwkGu1ECNXDpWyyxGIVgpqSvNZf7K8+rLzb+RanFJQXCcw6HR6hZQGPA1uGfBghwyVgQ
	04zNphA1Otyivm17kBzzhwGfuyHko/8E8JWZWh+cz5mggCSyfF26TSerVcE/jnmo1hQRwNOzg4s
	BX3kgv7VO1pAQYK65ZGnKq6rm9m3JF5v7JcT7ewnK7bTJbTdBnJEqokVhSVhrGXNRtdoPM0OPTQ
	QhthBHaSKG8hdOD39hO6lfYKTUNCWT9E/3zuya4wj5oAc30kUBFJkdW1+V9Jq8PHPeCCE=
X-Received: by 2002:a17:903:90b:b0:2b2:470d:6d18 with SMTP id d9443c01a7336-2b269adfea5mr73898055ad.8.1775112999356;
        Wed, 01 Apr 2026 23:56:39 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5765:500:7999:76d9:8e52:f837])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm19647945ad.55.2026.04.01.23.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:56:38 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu, 02 Apr 2026 14:56:01 +0800
Subject: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMj3eTcgorkjHRdo7QUYwPzNBOTRBNDJaDqgqLUtMwKsEnRsbW1AGI
 cTBRZAAAA
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
 Max Filippov <jcmvbkbc@gmail.com>
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

To avoid this, let's add an explicit cast to __typeof__(*(ptr)) for the
old local variable in the cmpxchg macros. This explicit cast suppresses
the -Wdiscarded-qualifiers diagnostic.

The new value is intentionally left without a cast: new will be stored
into *ptr, so silently accepting a const-qualified new would allow
callers to store a pointer-to-const into a non-const location without
any compiler warning.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
This is my first time posting a patch with multi-architecture specific
changes, so I'm not sure which target repository I should use. Please
correct me if I made any mistakes.
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
index ae1b96479d0c..b4b8dac759c4 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
 					  (unsigned long)_n_,		\
@@ -265,7 +265,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	smp_mb();							\
 	__ret = (__typeof__(*(ptr))) ____cmpxchg((ptr),			\
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..9637e2cdb5b1 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -42,7 +42,7 @@
 #define arch_cmpxchg_relaxed(ptr, old, new)				\
 ({									\
 	__typeof__(ptr) _p_ = (ptr);					\
-	__typeof__(*(ptr)) _o_ = (old);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(old);			\
 	__typeof__(*(ptr)) _n_ = (new);					\
 	__typeof__(*(ptr)) _prev_;					\
 									\
@@ -64,7 +64,7 @@
 #define arch_cmpxchg(ptr, old, new)				        \
 ({									\
 	volatile __typeof__(ptr) _p_ = (ptr);				\
-	__typeof__(*(ptr)) _o_ = (old);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(old);			\
 	__typeof__(*(ptr)) _n_ = (new);					\
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 9c58fb81f7fd..7e117964cb6b 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -54,7 +54,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 #define arch_cmpxchg(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(*(ptr)) __old = (old);			\
+	__typeof__(*(ptr)) __old = (__typeof__(*(ptr)))(old);	\
 	__typeof__(*(ptr)) __new = (new);			\
 	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index bf0a0f1189eb..2a87942227f8 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -78,7 +78,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 
 #define arch_cmpxchg(ptr, o, n)						 \
 ({									 \
-	__typeof__(*(ptr)) _o_ = (o);					 \
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		 \
 	__typeof__(*(ptr)) _n_ = (n);					 \
 	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index dbb50c06f0bf..36d113b13623 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -698,7 +698,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 }
 #define arch_cmpxchg(ptr, o, n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
@@ -707,7 +707,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_local(ptr, o, n)					 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
@@ -715,7 +715,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
 			(unsigned long)_o_, (unsigned long)_n_,		\
@@ -724,7 +724,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
 			(unsigned long)_o_, (unsigned long)_n_,		\
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 8712cf9c69dc..3026a9ff43c4 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -215,7 +215,7 @@
 		      cas_prepend, cas_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(__ptr)) __old = (old);				\
+	__typeof__(*(__ptr)) __old = (__typeof__(*(__ptr)))(old);	\
 	__typeof__(*(__ptr)) __new = (new);				\
 	__typeof__(*(__ptr)) __ret;					\
 									\
@@ -331,7 +331,7 @@ union __u128_halves {
 
 #define __arch_cmpxchg128(p, o, n, cas_sfx)					\
 ({										\
-	__typeof__(*(p)) __o = (o);                                             \
+	__typeof__(*(p)) __o = (__typeof__(*(p)))(o);                           \
 	union __u128_halves __hn = { .full = (n) };				\
 	union __u128_halves __ho = { .full = (__o) };				\
 	register unsigned long t1 asm ("t1") = __hn.low;			\
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..7fb9214d246f 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -68,7 +68,7 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 
 #define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 8c1a3ca34eeb..f733bd5b5d3b 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -55,7 +55,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	\
 			(unsigned long)_n_, sizeof(*(ptr)));		\
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 3de25262c411..4a9ccf80487a 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -170,7 +170,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 
 #define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a88b06f1c35e..a7984842c58a 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -85,7 +85,7 @@ extern void __add_wrong_size(void)
 #define __raw_cmpxchg(ptr, old, new, size, lock)			\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __old = (__typeof__(*(ptr)))(old);		\
 	__typeof__(*(ptr)) __new = (new);				\
 	switch (size) {							\
 	case __X86_CASE_B:						\
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..0f68eddb6d2d 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -83,7 +83,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 }
 
 #define arch_cmpxchg(ptr,o,n)						      \
-	({ __typeof__(*(ptr)) _o_ = (o);				      \
+	({ __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		      \
 	   __typeof__(*(ptr)) _n_ = (n);				      \
 	   (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	      \
 	   			        (unsigned long)_n_, sizeof (*(ptr))); \
diff --git a/tools/arch/x86/include/asm/cmpxchg.h b/tools/arch/x86/include/asm/cmpxchg.h
index 0ed9ca2766ad..b71938db9422 100644
--- a/tools/arch/x86/include/asm/cmpxchg.h
+++ b/tools/arch/x86/include/asm/cmpxchg.h
@@ -35,7 +35,7 @@ extern void __cmpxchg_wrong_size(void)
 #define __raw_cmpxchg(ptr, old, new, size, lock)			\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __old = (__typeof__(*(ptr)))(old);		\
 	__typeof__(*(ptr)) __new = (new);				\
 	switch (size) {							\
 	case __X86_CASE_B:						\

---
base-commit: 48b3cd69265f346f64b93064723492da46206e9b
change-id: 20260402-cmpxchg-2fd307f44a41

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>

