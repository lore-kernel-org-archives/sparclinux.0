Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B813FF1
	for <sparclinux@vger.kernel.org>; Fri, 29 Dec 2023 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="G1VXb/wa";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="jaWnDv46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=EGpU/wBREU1TuW0HNalg3hWWoCzJ9fEHAfVCsF2Pf7c=;
	b=G1VXb/waTvmLVCaoyhnNp9mH+k0dTudIAYQ/cR+oSOF1EQqLo4jFiSv6CHKP/NN7I5TWc0JL/PPN2
	 zjdSKNkrVgRoI5yxhmGJ6V+yd4oH7KElGBPWbfV+HVe1BrQTF/J4wJ8sPaEroere9dWC9pchY7OZo/
	 D/uaLjd1qRAvng2OfqxIRKzUe0KhiuPpFlttuOUYfOqM1bi71M4z+rjruwPjcZrZSAqRU1iZxdlSHQ
	 HKrJA6GFRvyhZvY1+WKVxjnBHxfo1kykNMqXepXikjsmOEDI/QeLXzRE5K6zZ5+87GVt2VLfDmUKCf
	 E4pgED0B45GrHep/VZ8UepovUfXYOQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=EGpU/wBREU1TuW0HNalg3hWWoCzJ9fEHAfVCsF2Pf7c=;
	b=jaWnDv46p+OmzU0dsGkv0wmgmOaiZI/KweQnWvMckgcuCn3CjUFtZfMQkQEyV53N2qJ/+h1dy01j0
	 hqpo/44Ag==
X-HalOne-ID: f5d8b1f6-a685-11ee-a342-2b733b0ff8f0
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1 (Halon) with ESMTPSA
	id f5d8b1f6-a685-11ee-a342-2b733b0ff8f0;
	Fri, 29 Dec 2023 20:07:59 +0000 (UTC)
Date: Fri, 29 Dec 2023 21:07:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: [PATCH 2/4] sparc32: Add cmpxchg support using CAS
Message-ID: <20231229200758.GB4034411@ravnborg.org>
References: <20231229200604.GA4033529@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229200604.GA4033529@ravnborg.org>

Utilize the casa instruction to implement cmpxchg support.

The implementation is based on the patch:

    0002-sparc32-leon-Add-support-for-atomic-operations-with-.patch
    included in gaisler-buildroot-2023.02-1.0

Drop the emulated version as the minimum supported CPU is leon3, and
leon3 has CAS support.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Arnd Bergmann <arnd@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_32.h | 72 +++++++++++++++++------------
 arch/sparc/lib/atomic32.c           | 42 -----------------
 2 files changed, 42 insertions(+), 72 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index d0af82c240b7..a35f2aa5d2ce 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -12,10 +12,21 @@
 #ifndef __ARCH_SPARC_CMPXCHG__
 #define __ARCH_SPARC_CMPXCHG__
 
-unsigned long __xchg_u32(volatile u32 *m, u32 new);
-void __xchg_called_with_bad_pointer(void);
+void __xchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for xchg");
 
-static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
+static __always_inline
+unsigned long __xchg_u32(volatile unsigned long *m, unsigned long val)
+{
+	asm volatile("swap [%2], %0"
+		     : "=&r" (val)
+		     : "0" (val), "r" (m)
+		     : "memory");
+	return val;
+}
+
+static __always_inline
+unsigned long __arch_xchg(unsigned long x, volatile void * ptr, int size)
 {
 	switch (size) {
 	case 4:
@@ -25,25 +36,31 @@ static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ v
 	return x;
 }
 
-#define arch_xchg(ptr,x) ({(__typeof__(*(ptr)))__arch_xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
+#define arch_xchg(ptr,x)						\
+({									\
+ 	(__typeof__(*(ptr))) __arch_xchg((unsigned long)(x),		\
+					 (ptr),				\
+					 sizeof(*(ptr)));		\
+})
 
-/* Emulate cmpxchg() the same way we emulate atomics,
- * by hashing the object address and indexing into an array
- * of spinlocks to get a bit of performance...
- *
- * See arch/sparc/lib/atomic32.c for implementation.
- *
- * Cribbed from <asm-parisc/atomic.h>
- */
+void __cmpxchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for cmpxchg");
 
-/* bug catcher for when unsupported size is used - won't link */
-void __cmpxchg_called_with_bad_pointer(void);
 /* we only need to support cmpxchg of a u32 on sparc */
-unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
+static __always_inline
+unsigned long __cmpxchg_u32(volatile int *m, int old, int new)
+{
+	asm volatile("casa [%2] 0xb, %3, %0"
+		     : "=&r" (new)
+		     : "0" (new), "r" (m), "r" (old)
+		     : "memory");
+
+	return new;
+}
 
 /* don't worry...optimizer will get rid of most of this */
-static inline unsigned long
-__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
+static __always_inline
+unsigned long __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
 	switch (size) {
 	case 4:
@@ -52,6 +69,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 		__cmpxchg_called_with_bad_pointer();
 		break;
 	}
+
 	return old;
 }
 
@@ -59,22 +77,16 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	\
-			(unsigned long)_n_, sizeof(*(ptr)));		\
+									\
+	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
+				       (unsigned long)_o_,		\
+				       (unsigned long)_n_,		\
+				       sizeof(*(ptr)));			\
 })
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
-#define arch_cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
-
-#include <asm-generic/cmpxchg-local.h>
-
 /*
- * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
- * them available.
+ * We can not support 64-bit cmpxchg using LEON CASA. Better fail to link than
+ * pretend we can support something that is not atomic towards 64-bit writes.
  */
-#define arch_cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))))
-#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC_CMPXCHG__ */
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index cf80d1ae352b..f378471adeca 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -158,45 +158,3 @@ unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
 	return old & mask;
 }
 EXPORT_SYMBOL(sp32___change_bit);
-
-unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
-{
-	unsigned long flags;
-	u32 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return (unsigned long)prev;
-}
-EXPORT_SYMBOL(__cmpxchg_u32);
-
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
-{
-	unsigned long flags;
-	u64 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return prev;
-}
-EXPORT_SYMBOL(__cmpxchg_u64);
-
-unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
-{
-	unsigned long flags;
-	u32 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	prev = *ptr;
-	*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return (unsigned long)prev;
-}
-EXPORT_SYMBOL(__xchg_u32);
-- 
2.34.1

