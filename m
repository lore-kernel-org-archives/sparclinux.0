Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBC29AB16;
	Mon,  7 Jul 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899680; cv=none; b=uKZ89ZiwixAG8rkrz/CkzrVeuSPjlrHnoqxXwklP/Lyxa0E7h9f/2MtQGDuiXY2/AHQIeTk1LqZpbUoIW+STol8jo2p/sCpHuTNO5Jb347V6OtPd91YzINpaG9+IKJ7gduWHDaXpM+knq2aS8Je+ez004lml8zdpb7B8HspxH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899680; c=relaxed/simple;
	bh=Rn4+W5zcQaq13Eehq1XtzANcnfVecvz9/tICU6VWCWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFeur0ynrog8XZGAnVVXCsbEVYolDiusKwP86TzdhrJsBpEY1uteLcjl6zQ7NQeCWQsSKyZEKg/f66seeSwtYWBCDHF3n/hmyRUqcipHy6kcB8DLpFKW5jSHc4f3Av79k85bneZ6+VqqYg/+8mLpcRNj74acuIT+tSQYpivW1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyEaX5EC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyEaX5EC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E1BC4CEE3;
	Mon,  7 Jul 2025 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751899680;
	bh=Rn4+W5zcQaq13Eehq1XtzANcnfVecvz9/tICU6VWCWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyEaX5ECZe1A7LMTYeEJSWJTgkTTda61Ni4X30MaD7JAoFdre+ZiyOkCdzbCKKrEN
	 AoZ18QaBBCT0iauT1aAes4NnFedwi5feO9TFuTeKK71oKa0+7U1qWT/xbinWulB0J3
	 g66m/KD1UQPpia9dT98hwwSdawgHlVt+sRPNK9vknPbMNw1oBKjSqXKvWoZhE0/6nc
	 FXA84hkS/hycOCO5fqcsKJ/sojZfLAkhfccy2iZQ3gqZKBhXeJZqJ/drx4JcQezMRD
	 E5kE4hJgpv3qFkLJ0knbr3KOwpXrYNbVArUPDXUm3LZhtxXRW+dLrZwfQiAswZLnp5
	 PXVJkDAMGKaZw==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	John Stultz <jstultz@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	shuah <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@google.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clocksource: remove ARCH_CLOCKSOURCE_DATA
Date: Mon,  7 Jul 2025 16:46:38 +0200
Message-Id: <20250707144726.4008707-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707144726.4008707-1-arnd@kernel.org>
References: <20250707144726.4008707-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Without the sparc64 vdso, there are no remaining users
of ARCH_CLOCKSOURCE_DATA, and it can just be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/Kconfig                   |  1 -
 arch/sparc/include/asm/clocksource.h | 17 -----------------
 arch/sparc/kernel/time_64.c          |  3 ---
 include/linux/clocksource.h          |  6 +-----
 kernel/time/Kconfig                  |  4 ----
 5 files changed, 1 insertion(+), 30 deletions(-)
 delete mode 100644 arch/sparc/include/asm/clocksource.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 776ce79ef188..b126a421db9c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -101,7 +101,6 @@ config SPARC64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
diff --git a/arch/sparc/include/asm/clocksource.h b/arch/sparc/include/asm/clocksource.h
deleted file mode 100644
index d63ef224befe..000000000000
--- a/arch/sparc/include/asm/clocksource.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
- */
-
-#ifndef _ASM_SPARC_CLOCKSOURCE_H
-#define _ASM_SPARC_CLOCKSOURCE_H
-
-/* VDSO clocksources */
-#define VCLOCK_NONE   0  /* Nothing userspace can do. */
-#define VCLOCK_TICK   1  /* Use %tick.  */
-#define VCLOCK_STICK  2  /* Use %stick. */
-
-struct arch_clocksource_data {
-	int vclock_mode;
-};
-
-#endif /* _ASM_SPARC_CLOCKSOURCE_H */
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 422ec5d03160..547c6f8bef36 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -838,14 +838,11 @@ void __init time_init_early(void)
 	if (tlb_type == spitfire) {
 		if (is_hummingbird()) {
 			init_tick_ops(&hbtick_operations);
-			clocksource_tick.archdata.vclock_mode = VCLOCK_NONE;
 		} else {
 			init_tick_ops(&tick_operations);
-			clocksource_tick.archdata.vclock_mode = VCLOCK_TICK;
 		}
 	} else {
 		init_tick_ops(&stick_operations);
-		clocksource_tick.archdata.vclock_mode = VCLOCK_STICK;
 	}
 }
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c3..12d853b18832 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -25,8 +25,7 @@ struct clocksource_base;
 struct clocksource;
 struct module;
 
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
 
@@ -106,9 +105,6 @@ struct clocksource {
 	u64			max_idle_ns;
 	u32			maxadj;
 	u32			uncertainty_margin;
-#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
-	struct arch_clocksource_data archdata;
-#endif
 	u64			max_cycles;
 	u64			max_raw_delta;
 	const char		*name;
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b0b97a60aaa6..d7e67d397c86 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -9,10 +9,6 @@
 config CLOCKSOURCE_WATCHDOG
 	bool
 
-# Architecture has extra clocksource data
-config ARCH_CLOCKSOURCE_DATA
-	bool
-
 # Architecture has extra clocksource init called from registration
 config ARCH_CLOCKSOURCE_INIT
 	bool
-- 
2.39.5

