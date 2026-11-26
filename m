Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685491;
	b=QNzbK3I6bWeFeeHBCJk4TU0Op1/SM0Drf9I33UmlsSAqnxG6dCIfdIh7EHmIHZQOEtZ8
	 Q2RhwThuweC7RIxsF3Digc0UzqxB5iMMQbnblgRb/HzuY+6q2eFiZNUuwhNtXKTIJwuNN
	 jo/xJ+CF4X16dfQVJJUeTKdnWHSBSyPkky4hF+jFnyZmOLJUFvopyNwDWQ/eX2dqDkGXN
	 1ks3chmxXkLwDTfwGztf+/VGHNHnUy1pJ7w3WiGFn5Qk32HiAe6hXP6GeAp96+UBMLb9h
	 ZuAOPwnf0vx2d3yL4ZgUVMynICFBPYR+Q4BvFIKLNKk2QhiIlVPeW6aVNuLjBaHMe8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aW8PSRvfN4ou1JwDnlqhiYjySHFGdPDdCmV+vIIft58=;
	b=oZEH7q9efyr12AEXbzWyYHqP1W0gZALh/eISQsmUz1zxn+WzNxKOkyjb9sEtKRwjdyuY
	 mVvurJjB/5wLGhvKa+n2m/X5ro+YMdGZyPh9L8W81M5FqeHzl9FKFM5xb60diptTyxkjG
	 b0ZXwRKtw0oMPbUwyGivK4mU7LskP7c1Vw7obEgVxCH4DGZ2HFoYm9qXztRxCCUY0zI5n
	 7EF5kG592Z+8J5NY8dHKR73IcWgWxaHL/oaQnMveUmdNpHX1GGcFJO4MR6P294GNhmj1v
	 SSf2+HFNof1Awu43LIm5a8fJ0/gt3l4z06Dlpq65EkGvP+rHkThWRQDcghMZLELWwrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nlrykp4;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481A606A6B9
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2481A606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nlrykp4
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1384966566b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685489; x=1796290289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aW8PSRvfN4ou1JwDnlqhiYjySHFGdPDdCmV+vIIft58=;
        b=0nlrykp4vfD1Sne9ugdCEq2SN4qfia7T8lC0IdQJ53svNcVzTp7Z/dojHolTS1yHCG
         cLGcsY2Q/5KAq5aWhFrSaH41vfF4u3n/dpxLrfvJtxd3+aSB78KP2iOAi21cQsMltwvz
         a6eXHatdCe0HRsNjl6FsIUQaFMOs/ye7pdrFc2VPGm4CFfjQvJuKRTxNwiJX7+d9P8/1
         AbkB6wdxtbJko0fuKKxZUBW8ZcKnmUgLfYWHfuDs5LhN9vmpUbiG9/DrP/r3Tq59bDJ3
         baBfeGF9w/NlegPovhEl+8cIaKyJfpiKHff11u46HSLJEVqw6qXySO7kfkrQNiR1sSAV
         XLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685489; x=1796290289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aW8PSRvfN4ou1JwDnlqhiYjySHFGdPDdCmV+vIIft58=;
        b=g5NfVnrMCWHBlRmH/nf6kfft+KphrotZrESZEZ1RgIfveUqZ4PxlVlbtJjtLR2ndgD
         uVcbG0LteHB3/Iqrz9NvZfC2K7hUAQsskAbJ5LqXvdJ3FC6y8Rvz2YG26ruSLLeYToxE
         QdzfCjERW1O1zjLiG5jv6rz8rdMqxghjo6VfCoyt7JFwpyK+GuNrsBCvef1fSnweZG2P
         K5/mRXOwc89AlJHtktftge2heZWspceTrRJ+JHZoo/JG6mozvuaYU2MQvsHeESrujV7g
         HmrWuWltpjy/akMqH41/b2JkmY2hUWv7C5Nd7Tmo24nN3u0vnc3JTC77jNh9Ykf5lq7C
         288w==
X-Forwarded-Encrypted: i=1; AL+hErGFPzeXjzz0JRApUC2iaJhfzYwJy8s4Az+Tjt+v27f/pRthD95dcyG/5NhI8VMo5iKA3jqch/Xq5EKa@vger.kernel.org
X-Gm-Message-State: APuU4Z87XJC62jqUNwqAaqZIq6JmDOYVlWGiWYq7gh5UZ1pJ7hOaMWIs
	wU9eg5K3EO5H+oBPa5o29eiqMgpJlh2Mi1Zs2EoGnMj1sSxmxWguZm9k
X-Gm-Gg: AZFdTZdVXlxU93kgPDTadXMYgKOKZ7lQKI+/aUVbXKNOMzU3q6E1QKZeZo+M7mfLfo3
	So6R5OKYY51oHJkxsPhffyo7I+/caq3OQsk7jAVUp1H+IfTwtzeRUCE1hk4agkWmo/4GzhroA4k
	fl6sVfGrIP+GXJDO61ROqdRUfS8+lmZw70VPIxLKzomRp1cbd9AE9WuZQCsduRGqzyVopYl3XwT
	lpkdR57jyMQBC5ph4dcu7WGHyeiueLIGg4wqUVz+A6G5jE1/mMrm8txgvy2jIPWsJObNBcapCZt
	cYCpXwdkgohvv2p2hl1jl7X6yK+llEJ70hzF6tdTCT7wgR0EyUImHMo9M/r4oCYLLFIrwbGm2Yd
	hKuTiujyr6NMF5FISfoc0ZHo1a95676nBUYvpacT87egq2CqjPcJPgPv/BRk9JkxeSFN4JySwoL
	tgOlRbhzpgMBG3zBZT/TvAgJcbhom6goA50e2L9HUlHgw+t5WJ/bEIBVaSmp27qlAePHCQQw8S1
	ls5NisWfvVBKWDWlJHSu9vLYn4rPmOAsBMNV3bl3CB2wvwtpPbqzRQyGvUQaIxz0GvYJ7QJUKK2
	3+K1bODnlAco3uKiDKX1JIzRgRRiIp9TzoO6DNKwn4WOxvwpdWmzjV9dLk0s80RfH/ZX8jWw3kk
	th7YCbRPSgx8xPxEX
X-Received: by 2002:a17:907:d19:b0:c2d:d4dd:8d0 with SMTP id a640c23a62f3a-c5131873cdbmr1741821766b.16.1795685489411;
        Thu, 26 Nov 2026 01:31:29 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:29 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 10/18] sparc32,leon: use ASI 1 for locks on the GR-LEON4-ITX
Date: Thu, 26 Nov 2026 10:30:15 +0100
Message-ID: <20261126093106.1345825-11-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cached LDSTUB lock acquisitions stall on the dual-CPU GR-LEON4-ITX.
The same tests complete with LDSTUBA ASI 1. The cause and the range of
affected CPUs are unknown. LEON SMP already uses SWAPA with ASI 1 for
the secondary CPU handshake.

Match the full GRLIB system ID (0x01020db4) of the ASIC fitted to the
GR-LEON4-ITX. Read it from the AMBA firmware node or, on factory U-Boot,
from AHB plug-and-play. Use the saved match for kernel and module locks.
Userspace retains its LDSTUB and SWAP instructions. The SWAP in
srmmu_swap() operates on uncached LEON page tables.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/ldstub.h      | 46 +++++++++++++++++++++++
 arch/sparc/include/asm/leon.h        |  1 +
 arch/sparc/include/asm/leon_amba.h   |  2 +
 arch/sparc/include/asm/sections.h    |  2 +
 arch/sparc/include/asm/spinlock_32.h | 32 +++++++++++-----
 arch/sparc/kernel/module.c           | 25 +++++++++++++
 arch/sparc/kernel/setup_32.c         | 55 ++++++++++++++++++++--------
 arch/sparc/kernel/vmlinux.lds.S      |  5 +++
 arch/sparc/lib/locks.S               | 24 +++++++++---
 9 files changed, 162 insertions(+), 30 deletions(-)
 create mode 100644 arch/sparc/include/asm/ldstub.h

diff --git a/arch/sparc/include/asm/ldstub.h b/arch/sparc/include/asm/ldstub.h
new file mode 100644
index 000000000000..f5d95deaf4cf
--- /dev/null
+++ b/arch/sparc/include/asm/ldstub.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Written by Magnus Lindholm, linmag7@gmail.com
+ *
+ * Use ASI 1 to avoid stalled lock acquisitions on the GR-LEON4-ITX.
+ */
+
+#ifndef _SPARC_LDSTUB_H
+#define _SPARC_LDSTUB_H
+
+#include <linux/stringify.h>
+#include <asm/asi.h>
+
+/*
+ * Emit LDSTUB at each lock site. On the GR-LEON4-ITX, early boot and the
+ * module loader replace it with the corresponding LDSTUBA ASI 1.
+ * The address must use registers only: alternate-space loads have no simm13.
+ */
+#if defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP)
+#define SPARC_RWLOCK_SETUP "mov 3, %%g5\n\t"
+#define SPARC_RWLOCK_ADDR "%%g1 + %%g5"
+#define SPARC_RWLOCK_CLOBBER "g5",
+#define SPARC_LDSTUB(addr, reg)				\
+	"663: ldstub [" addr "], " reg "\n\t"		\
+	".pushsection .leon_ldstub_patch, \"ax\"\n\t"	\
+	".align 4\n\t"					\
+	".word 663b\n\t"					\
+	"ldstuba [" addr "] " __stringify(ASI_LEON_DCACHE_MISS) \
+	", " reg "\n\t"					\
+	".popsection\n\t"
+#else
+#define SPARC_RWLOCK_SETUP ""
+#define SPARC_RWLOCK_ADDR "%%g1 + 3"
+#define SPARC_RWLOCK_CLOBBER
+#define SPARC_LDSTUB(addr, reg) "ldstub [" addr "], " reg "\n\t"
+#endif
+
+struct leon_1insn_patch_entry {
+	unsigned int addr;
+	unsigned int insn;
+};
+
+void leon_patch_1insn_range(struct leon_1insn_patch_entry *start,
+			    struct leon_1insn_patch_entry *end);
+
+#endif /* _SPARC_LDSTUB_H */
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 2a1bdc2c2f1d..67f2822d5fc6 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -224,6 +224,7 @@ unsigned int leon_build_device_irq(unsigned int real_irq,
 void leon_update_virq_handling(unsigned int virq,
 			       irq_flow_handler_t flow_handler,
 			       const char *name, int do_ack);
+extern bool leon_gr_leon4_itx;
 void leon_init_timers(void);
 void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 void init_leon(void);
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index 2ff5714d7a63..6663f8afa098 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -193,6 +193,8 @@ extern unsigned int sparc_leon_eirq;
 
 #define LEON3_IO_AREA 0xfff00000
 #define LEON3_CONF_AREA 0xff000
+#define LEON3_AHB_SYSTEMID 0xff0
+#define GR_LEON4_ITX_SYSTEMID 0x01020db4
 #define LEON3_AHB_SLAVE_CONF_AREA (1 << 11)
 
 #define LEON3_AHB_CONF_WORDS 8
diff --git a/arch/sparc/include/asm/sections.h b/arch/sparc/include/asm/sections.h
index 08f833453ab3..675745aa5d42 100644
--- a/arch/sparc/include/asm/sections.h
+++ b/arch/sparc/include/asm/sections.h
@@ -10,5 +10,7 @@ extern char _start[];
 
 extern char __leon_1insn_patch[];
 extern char __leon_1insn_patch_end[];
+extern char __leon_ldstub_patch[];
+extern char __leon_ldstub_patch_end[];
 
 #endif
diff --git a/arch/sparc/include/asm/spinlock_32.h b/arch/sparc/include/asm/spinlock_32.h
index 6d6d261bf8d2..a467bbff0bef 100644
--- a/arch/sparc/include/asm/spinlock_32.h
+++ b/arch/sparc/include/asm/spinlock_32.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/psr.h>
+#include <asm/ldstub.h>
 #include <asm/barrier.h>
 #include <asm/processor.h> /* for cpu_relax */
 
@@ -19,7 +20,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	__asm__ __volatile__(
 	"\n1:\n\t"
-	"ldstub	[%0], %%g2\n\t"
+	SPARC_LDSTUB("%0", "%%g2")
 	"orcc	%%g2, 0x0, %%g0\n\t"
 	"bne,a	2f\n\t"
 	" ldub	[%0], %%g2\n\t"
@@ -38,7 +39,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	unsigned int result;
-	__asm__ __volatile__("ldstub [%1], %0"
+	__asm__ __volatile__(SPARC_LDSTUB("%1", "%0")
 			     : "=r" (result)
 			     : "r" (lock)
 			     : "memory");
@@ -82,11 +83,12 @@ static inline void __arch_read_lock(arch_rwlock_t *rw)
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
+	SPARC_RWLOCK_SETUP
 	"call	___rw_read_enter\n\t"
-	" ldstub	[%%g1 + 3], %%g2\n"
+	SPARC_LDSTUB(SPARC_RWLOCK_ADDR, "%%g2")
 	: /* no outputs */
 	: "r" (lp)
-	: "g2", "g4", "memory", "cc");
+	: "g2", "g4", SPARC_RWLOCK_CLOBBER "memory", "cc");
 }
 
 #define arch_read_lock(lock) \
@@ -102,11 +104,12 @@ static inline void __arch_read_unlock(arch_rwlock_t *rw)
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
+	SPARC_RWLOCK_SETUP
 	"call	___rw_read_exit\n\t"
-	" ldstub	[%%g1 + 3], %%g2\n"
+	SPARC_LDSTUB(SPARC_RWLOCK_ADDR, "%%g2")
 	: /* no outputs */
 	: "r" (lp)
-	: "g2", "g4", "memory", "cc");
+	: "g2", "g4", SPARC_RWLOCK_CLOBBER "memory", "cc");
 }
 
 #define arch_read_unlock(lock) \
@@ -122,11 +125,12 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
+	SPARC_RWLOCK_SETUP
 	"call	___rw_write_enter\n\t"
-	" ldstub	[%%g1 + 3], %%g2\n"
+	SPARC_LDSTUB(SPARC_RWLOCK_ADDR, "%%g2")
 	: /* no outputs */
 	: "r" (lp)
-	: "g2", "g4", "memory", "cc");
+	: "g2", "g4", SPARC_RWLOCK_CLOBBER "memory", "cc");
 	*(volatile __u32 *)&lp->lock = ~0U;
 }
 
@@ -143,10 +147,17 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned int val;
 
+#if defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP)
+	__asm__ __volatile__(SPARC_LDSTUB("%1", "%0")
+			     : "=r" (val)
+			     : "r" ((unsigned char *)&rw->lock + 3)
+			     : "memory");
+#else
 	__asm__ __volatile__("ldstub [%1 + 3], %0"
 			     : "=r" (val)
 			     : "r" (&rw->lock)
 			     : "memory");
+#endif
 
 	if (val == 0) {
 		val = rw->lock & ~0xff;
@@ -166,11 +177,12 @@ static inline int __arch_read_trylock(arch_rwlock_t *rw)
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
+	SPARC_RWLOCK_SETUP
 	"call	___rw_read_try\n\t"
-	" ldstub	[%%g1 + 3], %%g2\n"
+	SPARC_LDSTUB(SPARC_RWLOCK_ADDR, "%%g2")
 	: "=r" (res)
 	: "r" (lp)
-	: "g2", "g4", "memory", "cc");
+	: "g2", "g4", SPARC_RWLOCK_CLOBBER "memory", "cc");
 	return res;
 }
 
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 2a8770369beb..9fa8b346416d 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -19,6 +19,11 @@
 #include <asm/spitfire.h>
 #include <asm/cacheflush.h>
 
+#ifdef CONFIG_SPARC32
+#include <asm/leon.h>
+#include <asm/ldstub.h>
+#endif
+
 #include "entry.h"
 
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
@@ -191,4 +196,24 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
+#else /* CONFIG_SPARC32 */
+int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+	const Elf_Shdr *s;
+	const char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	if (!IS_ENABLED(CONFIG_SPARC_LEON) || !IS_ENABLED(CONFIG_SMP) ||
+	    !leon_gr_leon4_itx)
+		return 0;
+
+	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
+		if (!strcmp(".leon_ldstub_patch", secstrings + s->sh_name)) {
+			void *p = (void *)s->sh_addr;
+
+			leon_patch_1insn_range(p, p + s->sh_size);
+		}
+	}
+	return 0;
+}
 #endif /* CONFIG_SPARC64 */
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 246533fba60d..c84ac2f1ad15 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -48,6 +48,9 @@
 #include <asm/setup.h>
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
+#include <asm/ldstub.h>
+#include <asm/leon.h>
+#include <asm/leon_amba.h>
 
 #include "kernel.h"
 
@@ -226,33 +229,55 @@ static void __init per_cpu_patch(void)
 	}
 }
 
-struct leon_1insn_patch_entry {
-	unsigned int addr;
-	unsigned int insn;
-};
-
 enum sparc_cpu sparc_cpu_model;
 EXPORT_SYMBOL(sparc_cpu_model);
 
-static __init void leon_patch(void)
+void leon_patch_1insn_range(struct leon_1insn_patch_entry *start,
+			    struct leon_1insn_patch_entry *end)
 {
-	struct leon_1insn_patch_entry *start = (void *)__leon_1insn_patch;
-	struct leon_1insn_patch_entry *end = (void *)__leon_1insn_patch_end;
-
-	/* Default instruction is leon - no patching */
-	if (sparc_cpu_model == sparc_leon)
-		return;
-
 	while (start < end) {
 		unsigned long addr = start->addr;
 
-		*(unsigned int *)(addr) = start->insn;
+		*(unsigned int *)addr = start->insn;
 		flushi(addr);
-
 		start++;
 	}
 }
 
+bool leon_gr_leon4_itx __ro_after_init;
+
+static bool __init leon_detect_itx(void)
+{
+	phandle bus;
+	u32 id = 0;
+
+	if (prom_leon_legacy) {
+		/* The factory PROM omits the AMBA bus from its device tree. */
+		id = LEON3_BYPASS_LOAD_PA(LEON3_IO_AREA | LEON3_CONF_AREA |
+					  LEON3_AHB_SYSTEMID);
+	} else {
+		bus = prom_finddevice("/ambapp0");
+		if (!bus || prom_getproplen(bus, "systemid") != sizeof(id) ||
+		    prom_getproperty(bus, "systemid", (char *)&id, sizeof(id)) < 0)
+			return false;
+	}
+	return id == GR_LEON4_ITX_SYSTEMID;
+}
+
+static __init void leon_patch(void)
+{
+	if (sparc_cpu_model == sparc_leon) {
+		if (IS_ENABLED(CONFIG_SPARC_LEON))
+			leon_gr_leon4_itx = leon_detect_itx();
+		if (IS_ENABLED(CONFIG_SMP) && leon_gr_leon4_itx)
+			leon_patch_1insn_range((void *)__leon_ldstub_patch,
+					       (void *)__leon_ldstub_patch_end);
+	} else {
+		leon_patch_1insn_range((void *)__leon_1insn_patch,
+				       (void *)__leon_1insn_patch_end);
+	}
+}
+
 struct tt_entry *sparc_ttable;
 
 unsigned long phys_base;
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 7ea510d9b42f..da93457c45f3 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -123,6 +123,11 @@ SECTIONS
 		*(.leon_1insn_patch)
 		__leon_1insn_patch_end = .;
 	}
+	.leon_ldstub_patch : {
+		__leon_ldstub_patch = .;
+		*(.leon_ldstub_patch)
+		__leon_ldstub_patch_end = .;
+	}
 	.swapper_tsb_phys_patch : {
 		__swapper_tsb_phys_patch = .;
 		*(.swapper_tsb_phys_patch)
diff --git a/arch/sparc/lib/locks.S b/arch/sparc/lib/locks.S
index 47a39f4384a2..d5d9d4c93af5 100644
--- a/arch/sparc/lib/locks.S
+++ b/arch/sparc/lib/locks.S
@@ -12,6 +12,7 @@
 #include <asm/psr.h>
 #include <asm/smp.h>
 #include <asm/spinlock.h>
+#include <asm/asi.h>
 
 	.text
 	.align	4
@@ -20,17 +21,30 @@
 	 * as fast as possible.
 	 */
 
-	/* caches... */
+	.macro	rw_ldstub
+#if defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP)
+	/* The inline caller supplies the writer-lock byte offset in %g5. */
+1:	ldstub	[%g1 + %g5], %g2
+	.pushsection .leon_ldstub_patch, "ax"
+	.align	4
+	.word	1b
+	ldstuba	[%g1 + %g5] ASI_LEON_DCACHE_MISS, %g2
+	.popsection
+#else
+	ldstub	[%g1 + 3], %g2
+#endif
+	.endm
+
 ___rw_read_enter_spin_on_wlock:
 	orcc	%g2, 0x0, %g0
 	be,a	___rw_read_enter
-	 ldstub	[%g1 + 3], %g2
+	 rw_ldstub
 	b	___rw_read_enter_spin_on_wlock
 	 ldub	[%g1 + 3], %g2
 ___rw_read_try_spin_on_wlock:
 	andcc	%g2, 0xff, %g0
 	be,a	___rw_read_try
-	 ldstub	[%g1 + 3], %g2
+	 rw_ldstub
 	xnorcc	%g2, 0x0, %o0	/* if g2 is ~0, set o0 to 0 and bugger off */
 	bne,a	___rw_read_enter_spin_on_wlock
 	 ld	[%g1], %g2
@@ -39,13 +53,13 @@ ___rw_read_try_spin_on_wlock:
 ___rw_read_exit_spin_on_wlock:
 	orcc	%g2, 0x0, %g0
 	be,a	___rw_read_exit
-	 ldstub	[%g1 + 3], %g2
+	 rw_ldstub
 	b	___rw_read_exit_spin_on_wlock
 	 ldub	[%g1 + 3], %g2
 ___rw_write_enter_spin_on_wlock:
 	orcc	%g2, 0x0, %g0
 	be,a	___rw_write_enter
-	 ldstub	[%g1 + 3], %g2
+	 rw_ldstub
 	b	___rw_write_enter_spin_on_wlock
 	 ld	[%g1], %g2
 
-- 
2.43.0

