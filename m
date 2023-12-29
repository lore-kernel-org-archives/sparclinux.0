Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B513FE1
	for <sparclinux@vger.kernel.org>; Fri, 29 Dec 2023 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="EXEdHdaB";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="pYUxhdPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=6VUDWzIbsGTunNIUfX4yrxks6yn2yowqEFeoftmH1c8=;
	b=EXEdHdaBV4ArHXIVXH/1hAWceTojDekbUu41ERRJV6etvrVek2ngH7gCN7puVAoeQS0D5+Fd2aynQ
	 u8iDPnVla+T6yDyrcInV+xQMBR/leLeKusAWs2l/mR2mx83T3ekKZWV3mesLmQHuUNndS4pIvPFg3U
	 k/L/MNzlW+QUP3SD1kL6875DyYr05wIvhe6pMNP7eGvjOnRDOiOFmZiVnFVutB570XdVRPVxa1TxWk
	 bczvSJsr3CyJF1z/2ra61AopjZhDpqi2wj69ohm51YGSwoY1IkIAq+J6UL+tIVEqk0VZQRcirtGzn3
	 CeXsVjBi8jeDHC//N+VsW5n5yHmKRCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=6VUDWzIbsGTunNIUfX4yrxks6yn2yowqEFeoftmH1c8=;
	b=pYUxhdPFeW6xi392Jy7do6Oq+Quvevu2811lmoptjWtJJ4sViIcRMWYdkzqqcSz3u/cr5pAc+ya3s
	 VJk/uMLDQ==
X-HalOne-ID: 1867d5ad-a686-11ee-979e-a71ee59276a3
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5 (Halon) with ESMTPSA
	id 1867d5ad-a686-11ee-979e-a71ee59276a3;
	Fri, 29 Dec 2023 20:08:58 +0000 (UTC)
Date: Fri, 29 Dec 2023 21:08:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: [PATCH 4/4] sparc32: Add atomic support using CAS
Message-ID: <20231229200856.GD4034411@ravnborg.org>
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

Implement the atomic operations using the leon casa
instruction.

The implmentation uses a single asm helper, to make the code as readable
as possible. The generated code is more compact with the majority
implemented in C as this allows the compiler to do optimizations
especially when the arguments passed are constant.

The old emulated atomic implementation is no longer used and deleted.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
---
 arch/sparc/include/asm/atomic_32.h | 151 +++++++++++++++++++----------
 arch/sparc/lib/Makefile            |   2 +-
 arch/sparc/lib/atomic32.c          | 121 -----------------------
 3 files changed, 100 insertions(+), 174 deletions(-)
 delete mode 100644 arch/sparc/lib/atomic32.c

diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 60ce2fe57fcd..54f39148c492 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -1,61 +1,108 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* atomic.h: These still suck, but the I-cache hit rate is higher.
- *
- * Copyright (C) 1996 David S. Miller (davem@davemloft.net)
- * Copyright (C) 2000 Anton Blanchard (anton@linuxcare.com.au)
- * Copyright (C) 2007 Kyle McMartin (kyle@parisc-linux.org)
- *
- * Additions by Keith M Wesolowski (wesolows@foobazco.org) based
- * on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.
- */
-
 #ifndef __ARCH_SPARC_ATOMIC__
 #define __ARCH_SPARC_ATOMIC__
 
 #include <linux/types.h>
 
 #include <asm/cmpxchg.h>
-#include <asm/barrier.h>
-#include <asm-generic/atomic64.h>
-
-int arch_atomic_add_return(int, atomic_t *);
-#define arch_atomic_add_return arch_atomic_add_return
-
-int arch_atomic_fetch_add(int, atomic_t *);
-#define arch_atomic_fetch_add arch_atomic_fetch_add
-
-int arch_atomic_fetch_and(int, atomic_t *);
-#define arch_atomic_fetch_and arch_atomic_fetch_and
-
-int arch_atomic_fetch_or(int, atomic_t *);
-#define arch_atomic_fetch_or arch_atomic_fetch_or
-
-int arch_atomic_fetch_xor(int, atomic_t *);
-#define arch_atomic_fetch_xor arch_atomic_fetch_xor
-
-int arch_atomic_cmpxchg(atomic_t *, int, int);
-#define arch_atomic_cmpxchg arch_atomic_cmpxchg
-
-int arch_atomic_xchg(atomic_t *, int);
-#define arch_atomic_xchg arch_atomic_xchg
-
-int arch_atomic_fetch_add_unless(atomic_t *, int, int);
-#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
-
-void arch_atomic_set(atomic_t *, int);
-
-#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
-
-#define arch_atomic_read(v)		READ_ONCE((v)->counter)
-
-#define arch_atomic_add(i, v)	((void)arch_atomic_add_return( (int)(i), (v)))
-#define arch_atomic_sub(i, v)	((void)arch_atomic_add_return(-(int)(i), (v)))
-
-#define arch_atomic_and(i, v)	((void)arch_atomic_fetch_and((i), (v)))
-#define arch_atomic_or(i, v)	((void)arch_atomic_fetch_or((i), (v)))
-#define arch_atomic_xor(i, v)	((void)arch_atomic_fetch_xor((i), (v)))
-
-#define arch_atomic_sub_return(i, v)	(arch_atomic_add_return(-(int)(i), (v)))
-#define arch_atomic_fetch_sub(i, v)	(arch_atomic_fetch_add (-(int)(i), (v)))
+#include <asm/rwonce.h>
+
+static __always_inline int arch_atomic_read(const atomic_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+
+static __always_inline void arch_atomic_set(atomic_t *v, int i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+static __always_inline
+int __atomic_casa(volatile int *p, int check, int swap)
+{
+	// casa [p], check, swap
+	// check == swap for success, otherwise try again
+	asm volatile("casa      [%2] 0xb, %3, %0"
+		     : "=&r" (swap)
+		     : "0" (swap), "r" (p), "r" (check)
+		     : "memory");
+
+	return swap;
+}
+
+/* Do v->counter c_op i */
+#define ATOMIC_OP(op, c_op)						\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
+{									\
+	int check;							\
+	int swap;							\
+									\
+	do {								\
+		check = v->counter;					\
+		swap = check c_op i;					\
+	} while (__atomic_casa(&v->counter, check, swap) != check);	\
+}
+
+/* Do v->counter c_op i, and return the result */
+#define ATOMIC_OP_RETURN(op, c_op)					\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	int check;							\
+	int swap;							\
+									\
+	do {								\
+		check = v->counter;					\
+		swap = check c_op i;					\
+	} while (__atomic_casa(&v->counter, check, swap) != check);	\
+									\
+	return swap;							\
+}
+
+/* Do v->counter c_op i, and return the original v->counter value */
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	int check;							\
+	int swap;							\
+									\
+	do {								\
+		check = v->counter;					\
+		swap = check c_op i;					\
+	} while (__atomic_casa(&v->counter, check, swap) != check);	\
+									\
+	return check;							\
+}
+
+ATOMIC_OP_RETURN(add, +)
+ATOMIC_OP_RETURN(sub, -)
+
+ATOMIC_FETCH_OP(add, +)
+ATOMIC_FETCH_OP(sub, -)
+ATOMIC_FETCH_OP(and, &)
+ATOMIC_FETCH_OP(or,  |)
+ATOMIC_FETCH_OP(xor, ^)
+
+ATOMIC_OP(add, +)
+ATOMIC_OP(sub, -)
+ATOMIC_OP(and, &)
+ATOMIC_OP(or,  |)
+ATOMIC_OP(xor, ^)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#define arch_atomic_add_return	arch_atomic_add_return
+#define arch_atomic_sub_return	arch_atomic_sub_return
+#define arch_atomic_fetch_add	arch_atomic_fetch_add
+#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+#define arch_atomic_add		arch_atomic_add
+#define arch_atomic_sub		arch_atomic_sub
+#define arch_atomic_and		arch_atomic_and
+#define arch_atomic_or		arch_atomic_or
+#define arch_atomic_xor		arch_atomic_xor
 
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 063556fe2cb1..907f497bfcec 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -52,5 +52,5 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
-obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
+obj-$(CONFIG_SPARC32) += ucmpdi2.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
deleted file mode 100644
index ed778f7ebe97..000000000000
--- a/arch/sparc/lib/atomic32.c
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * atomic32.c: 32-bit atomic_t implementation
- *
- * Copyright (C) 2004 Keith M Wesolowski
- * Copyright (C) 2007 Kyle McMartin
- * 
- * Based on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf
- */
-
-#include <linux/atomic.h>
-#include <linux/spinlock.h>
-#include <linux/module.h>
-
-#ifdef CONFIG_SMP
-#define ATOMIC_HASH_SIZE	4
-#define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_HASH_SIZE-1)])
-
-spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
-	[0 ... (ATOMIC_HASH_SIZE-1)] = __SPIN_LOCK_UNLOCKED(__atomic_hash)
-};
-
-#else /* SMP */
-
-static DEFINE_SPINLOCK(dummy);
-#define ATOMIC_HASH_SIZE	1
-#define ATOMIC_HASH(a)		(&dummy)
-
-#endif /* SMP */
-
-#define ATOMIC_FETCH_OP(op, c_op)					\
-int arch_atomic_fetch_##op(int i, atomic_t *v)				\
-{									\
-	int ret;							\
-	unsigned long flags;						\
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
-									\
-	ret = v->counter;						\
-	v->counter c_op i;						\
-									\
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
-	return ret;							\
-}									\
-EXPORT_SYMBOL(arch_atomic_fetch_##op);
-
-#define ATOMIC_OP_RETURN(op, c_op)					\
-int arch_atomic_##op##_return(int i, atomic_t *v)			\
-{									\
-	int ret;							\
-	unsigned long flags;						\
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
-									\
-	ret = (v->counter c_op i);					\
-									\
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
-	return ret;							\
-}									\
-EXPORT_SYMBOL(arch_atomic_##op##_return);
-
-ATOMIC_OP_RETURN(add, +=)
-
-ATOMIC_FETCH_OP(add, +=)
-ATOMIC_FETCH_OP(and, &=)
-ATOMIC_FETCH_OP(or, |=)
-ATOMIC_FETCH_OP(xor, ^=)
-
-#undef ATOMIC_FETCH_OP
-#undef ATOMIC_OP_RETURN
-
-int arch_atomic_xchg(atomic_t *v, int new)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);
-	ret = v->counter;
-	v->counter = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-	return ret;
-}
-EXPORT_SYMBOL(arch_atomic_xchg);
-
-int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);
-	ret = v->counter;
-	if (likely(ret == old))
-		v->counter = new;
-
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-	return ret;
-}
-EXPORT_SYMBOL(arch_atomic_cmpxchg);
-
-int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);
-	ret = v->counter;
-	if (ret != u)
-		v->counter += a;
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-	return ret;
-}
-EXPORT_SYMBOL(arch_atomic_fetch_add_unless);
-
-/* Atomic operations are already serializing */
-void arch_atomic_set(atomic_t *v, int i)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);
-	v->counter = i;
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-}
-EXPORT_SYMBOL(arch_atomic_set);
-- 
2.34.1

