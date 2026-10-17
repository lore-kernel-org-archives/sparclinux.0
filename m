Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA092D1F7B;
	Sat, 17 Oct 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231517; cv=none; b=ORTXmD5Nt5EDeG/fofq7yQ/VkYG0J7ExqEsTtBUWTqtiv4fvogBbInHbnIp3E5A2ZJJmPVCx/MO8ElLnQGjdcxIDaknoSL08FdcwSrAuTGcn7tX+Std10DDtJ4CcYEgUsIfhNFL8EVxosdIi2+6mghRo9eAvEtaewq1tabsfNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231517; c=relaxed/simple;
	bh=Wki0KSde79SduX5Qkkp3zEh2u4Br51owgj9xlhdiL6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3YsW+I2OTp3JxVG5I0XAKimysr9UGJ2vrIfdY9lUGsHMZXSBdSKG41DM1GKK80MoxNRj3alCx/cCH7EvhQ5edvxDJkt+7eLldpaWjJOH7rmIfx3tkyVeXUM1GQ9OpcOQP6hrFR1oFdER743tM2nXOZutNEoO2SQSlHQEFauaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=oO56X0+1; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="oO56X0+1"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792231506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijHdyvgjkTozfCUmxF87O//t2rILUVcJInxAFYQhzOg=;
	b=oO56X0+1KSBelw+ynjRvG7iw1Gd6NSuf0/MAz50TKvcchGq8u0b2+xeWZY1ktqFCTkQEZ/
	lMo2P4Ja3hUatKjN+fg3KvhnY+oLWkhMSEy3qv0dgem5YjVVYUZX4iXjihcwB8t40ea7LZ
	ABWdCwtJObooesEEeXOHmEfnUmiLFgw=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Michel Lespinasse <michel@lespinasse.org>,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 2/2] sparc64: Randomize the load address of PIE executables
Date: Sat, 17 Oct 2026 12:04:51 +0200
Message-ID: <20261017100451.2266781-3-stian@itx.no>
In-Reply-To: <20261017100451.2266781-1-stian@itx.no>
References: <20261017100451.2266781-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On sparc64 every PIE executable (ET_DYN with PT_INTERP) is loaded at
exactly ELF_ET_DYN_BASE, with its brk heap at a fixed offset after it.
The stack and the mmap base are randomized; the program image and brk
are not.

load_elf_binary() adds arch_mmap_rnd() to the load bias and calls
arch_randomize_brk(), but without ARCH_HAS_ELF_RANDOMIZE both are
no-ops. sparc64 already has a suitable mmap_rnd() for the mmap base.
Rename it to arch_mmap_rnd(), add arch_randomize_brk() with the ranges
x86 and the generic version use, and select ARCH_HAS_ELF_RANDOMIZE.

Closes: https://github.com/sparclinux/issues/issues/119
Signed-off-by: Stian Halseth <stian@itx.no>
---
 .../features/vm/ELF-ASLR/arch-support.txt          |  2 +-
 arch/sparc/Kconfig                                 |  1 +
 arch/sparc/kernel/sys_sparc_64.c                   | 14 ++++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 57406c0d53531..d4a34c9fbae86 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -24,7 +24,7 @@
     |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |         x86: |  ok  |
     |      xtensa: | TODO |
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ab77d3f2536e1..82c989b9e7831 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -71,6 +71,7 @@ config SPARC64
 	def_bool 64BIT
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_HAS_DELAY_TIMER
+	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 087595fa43081..2948d5769e768 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -26,6 +26,8 @@
 #include <linux/ipc.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/elf-randomize.h>
+#include <linux/sizes.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
 #include <linux/timex.h>
@@ -280,7 +282,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 EXPORT_SYMBOL(get_fb_unmapped_area);
 
 /* Essentially the same as PowerPC.  */
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0UL;
 
@@ -294,9 +296,17 @@ static unsigned long mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+	if (test_thread_flag(TIF_32BIT))
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
+}
+
 void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
-	unsigned long random_factor = mmap_rnd();
+	unsigned long random_factor = arch_mmap_rnd();
 	unsigned long gap;
 
 	/*
-- 
2.43.0

