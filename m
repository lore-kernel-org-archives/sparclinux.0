Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCD13AE4
	for <sparclinux@vger.kernel.org>; Fri, 29 Dec 2023 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="XtG0wCMR";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="0J9enZRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=ynnfHQAVyzxK7C1A33SeufC/Y4Zrdp9vy+YbewmKWCQ=;
	b=XtG0wCMR4SkvP+rmB0UE1KspJmFak0e6UGyAO0lrorjrhNQJWkNP5uh0Bj6Pg+a8t3v+JlMuHaEFe
	 URTCAGS1xZcy9fv/j7Dvg+mrHelZpiutUVgCC/G0lAGbyQD+e2Xc0ulskE59eI23MWQis6BlA6mDDq
	 C9ntDT18bjtJ87CNDvOaEmC4AW7Od34fck2NHfa82yqgRSp+HGe5u4QiERfglfvmaun23o0t0hS18A
	 WacVAmiQY8eyzTxmbhlCtJY9vOg2jVAxC6rWQt9pP1RhYrmyBeqEEqR4aa/TqtcYjybNDX0vOOG8ej
	 l1yQc0vT1/QSy51Nv4IqT7puIIk2emw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=ynnfHQAVyzxK7C1A33SeufC/Y4Zrdp9vy+YbewmKWCQ=;
	b=0J9enZRSX/DYPODmQpeh9VdC6/Oyoix0rKnTPKfSZhjSSQKjXk6EGSXDKKnE4F+EaUzV388dFy3y7
	 8y4u5i0DA==
X-HalOne-ID: 05ad9308-a686-11ee-bba8-2dc64a403fa2
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4 (Halon) with ESMTPSA
	id 05ad9308-a686-11ee-bba8-2dc64a403fa2;
	Fri, 29 Dec 2023 20:08:27 +0000 (UTC)
Date: Fri, 29 Dec 2023 21:08:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: [PATCH 3/4] sparc32: Add atomic bitops support using CAS
Message-ID: <20231229200825.GC4034411@ravnborg.org>
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

This implements the atomic bit operations using the CAS instruction
so they are atomic.

The implementation uses a single asm helper, to make the code as readable
as possible. The implementation is done inline in bitops/atomic.h to
mirror the structure used in asm-generic.
As an added benefit the bitops can be instrumented.

The generated code is more compact with the majority implemented in C as
this allows the compiler to do optimizations especially when the
arguments passed are constant.

The old emulated bitops implementation is no longer used and deleted.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/bitops/atomic_32.h | 124 ++++++++++++++++++++++
 arch/sparc/include/asm/bitops_32.h        |  71 +------------
 arch/sparc/lib/atomic32.c                 |  39 -------
 3 files changed, 125 insertions(+), 109 deletions(-)
 create mode 100644 arch/sparc/include/asm/bitops/atomic_32.h

diff --git a/arch/sparc/include/asm/bitops/atomic_32.h b/arch/sparc/include/asm/bitops/atomic_32.h
new file mode 100644
index 000000000000..b9e33d21b58d
--- /dev/null
+++ b/arch/sparc/include/asm/bitops/atomic_32.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SPARC_BITOPS_ATOMIC_H_
+#define __ASM_SPARC_BITOPS_ATOMIC_H_
+
+#include <linux/atomic.h>
+#include <linux/compiler.h>
+
+#include <asm/asi.h>
+#include <asm/barrier.h>
+
+static __always_inline
+int __boa_casa(volatile unsigned long *p,
+	       unsigned long check,
+	       unsigned long swap)
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
+static __always_inline void
+arch_set_bit(unsigned int nr, volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long check;
+	unsigned long swap;
+
+	p += BIT_WORD(nr);
+
+	do {
+		check = *p;
+		swap = check | mask;
+	} while (__boa_casa(p, check, swap) != check);
+}
+
+static __always_inline void
+arch_clear_bit(unsigned int nr, volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long check;
+	unsigned long swap;
+
+	p += BIT_WORD(nr);
+
+	do {
+		check = *p;
+		swap = check & ~mask;
+	} while (__boa_casa(p, check, swap) != check);
+}
+
+static __always_inline void
+arch_change_bit(unsigned int nr, volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long check;
+	unsigned long swap;
+
+	p += BIT_WORD(nr);
+
+	do {
+		check = *p;
+		swap = check ^ mask;
+	} while (__boa_casa(p, check, swap) != check);
+}
+
+static __always_inline int
+arch_test_and_set_bit(unsigned int nr, volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long check;
+	unsigned long swap;
+
+	p += BIT_WORD(nr);
+
+	do {
+		check = *p;
+		swap = check | mask;
+	} while (__boa_casa(p, check, swap) != check);
+
+	return !!(check & mask);
+}
+
+static __always_inline int
+arch_test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long check;
+	unsigned long swap;
+
+	p += BIT_WORD(nr);
+
+	do {
+		check = *p;
+		swap = check & ~mask;
+	} while (__boa_casa(p, check, swap) != check);
+
+	return !!(check & mask);
+}
+
+static __always_inline int
+arch_test_and_change_bit(unsigned int nr, volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long check;
+	unsigned long swap;
+
+	p += BIT_WORD(nr);
+
+	do {
+		check = *p;
+		swap = check ^ mask;
+	} while (__boa_casa(p, check, swap) != check);
+
+	return !!(check & mask);
+}
+
+#include <asm-generic/bitops/instrumented-atomic.h>
+
+#endif /* __ASM_SPARC_BITOPS_ATOMIC_H_ */
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
index 3448c191b484..34279e9572a4 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -19,76 +19,7 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-unsigned long sp32___set_bit(unsigned long *addr, unsigned long mask);
-unsigned long sp32___clear_bit(unsigned long *addr, unsigned long mask);
-unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask);
-
-/*
- * Set bit 'nr' in 32-bit quantity at address 'addr' where bit '0'
- * is in the highest of the four bytes and bit '31' is the high bit
- * within the first byte. Sparc is BIG-Endian. Unless noted otherwise
- * all bit-ops return 0 if bit was previously clear and != 0 otherwise.
- */
-static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
-{
-	unsigned long *ADDR, mask;
-
-	ADDR = ((unsigned long *) addr) + (nr >> 5);
-	mask = 1 << (nr & 31);
-
-	return sp32___set_bit(ADDR, mask) != 0;
-}
-
-static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
-{
-	unsigned long *ADDR, mask;
-
-	ADDR = ((unsigned long *) addr) + (nr >> 5);
-	mask = 1 << (nr & 31);
-
-	(void) sp32___set_bit(ADDR, mask);
-}
-
-static inline int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
-{
-	unsigned long *ADDR, mask;
-
-	ADDR = ((unsigned long *) addr) + (nr >> 5);
-	mask = 1 << (nr & 31);
-
-	return sp32___clear_bit(ADDR, mask) != 0;
-}
-
-static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
-{
-	unsigned long *ADDR, mask;
-
-	ADDR = ((unsigned long *) addr) + (nr >> 5);
-	mask = 1 << (nr & 31);
-
-	(void) sp32___clear_bit(ADDR, mask);
-}
-
-static inline int test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
-{
-	unsigned long *ADDR, mask;
-
-	ADDR = ((unsigned long *) addr) + (nr >> 5);
-	mask = 1 << (nr & 31);
-
-	return sp32___change_bit(ADDR, mask) != 0;
-}
-
-static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
-{
-	unsigned long *ADDR, mask;
-
-	ADDR = ((unsigned long *) addr) + (nr >> 5);
-	mask = 1 << (nr & 31);
-
-	(void) sp32___change_bit(ADDR, mask);
-}
-
+#include <asm/bitops/atomic_32.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 #include <asm-generic/bitops/ffz.h>
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index f378471adeca..ed778f7ebe97 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -119,42 +119,3 @@ void arch_atomic_set(atomic_t *v, int i)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 }
 EXPORT_SYMBOL(arch_atomic_set);
-
-unsigned long sp32___set_bit(unsigned long *addr, unsigned long mask)
-{
-	unsigned long old, flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old | mask;
-	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
-
-	return old & mask;
-}
-EXPORT_SYMBOL(sp32___set_bit);
-
-unsigned long sp32___clear_bit(unsigned long *addr, unsigned long mask)
-{
-	unsigned long old, flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old & ~mask;
-	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
-
-	return old & mask;
-}
-EXPORT_SYMBOL(sp32___clear_bit);
-
-unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
-{
-	unsigned long old, flags;
-
-	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old ^ mask;
-	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
-
-	return old & mask;
-}
-EXPORT_SYMBOL(sp32___change_bit);
-- 
2.34.1

