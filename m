Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC552364934;
	Thu, 17 Sep 2026 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633585; cv=none; b=NhxPNhO6QECTWsXxbSQmVewlPwiRCWhWaF2DsPTQ2fFPkbP2LEgf91pHeRwGaQKDGbJGLdbjhGodBftL8if1Q/VIcKKh3STH/LHm9QTrHjopTHEyRItVQOLaiNblOLfnAs4fvpSEL21NMo4wuoxhVEqlDXRZWWCur8N2TdhYZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633585; c=relaxed/simple;
	bh=PPC4bFAI4BCch7EgHF5j0r9yHziks1G9isXPyZTKCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itiTt38UfbmAHNAcyeYtETSXqXd2vtChz005vUCBREpzMly5dx6eV4QXNdBbe06TCgjkTMXW2YdCn9MyYygn9A/HFQXPxoa/2R+Lw5m+wVOdCFg9KssShrInLENgqMl/zN2U0GJCw3fgbeYPMWnTXNa0SnHeGGyZx+gASZPz+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=hM64mcPi; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="hM64mcPi"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789633569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0HzMtWcDZuesNbX3zCWxprttqIym47DPTaea82q/YVs=;
	b=hM64mcPirrKo2T30ca05kQWS5uqKRHMs1NjybewPEgMHBi10DHYBXBc4cakOhxUjVVEHQh
	Qyd89acYlxk9+boHA+/uBNgSkuHStMm7SWQeidIPhJYs1s+1cOR+wp3xUL30LiNplU++Z6
	JE4B4/5xQBVNbPW+Vy1h85p41E4xGCM=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] sparc64: vdso: Flush the D-cache after updating the time data
Date: Thu, 17 Sep 2026 10:25:47 +0200
Message-ID: <20260917082547.223729-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vDSO time data page is written through the kernel linear mapping
and read through a user mapping placed without colour alignment.  On
sun4u the L1 D-cache is virtually indexed, so when the two differ in
colour the timekeeping CPU's stores leave stale lines behind the user
alias in its own D-cache.  The seqcount does not catch this: the line
holding seq and the lines holding the clock data are refreshed
independently, so a reader sees an even, unchanged seq together with a
mix of old and new fields.

On a Sun Fire V240 (UltraSPARC IIIi, clocksource stick) this makes
clock_gettime(CLOCK_MONOTONIC) via the vDSO wrong for most calls on
the tick CPU, by multiples of the 10 ms tick and up to a second, in
about half of all processes: those that drew the other colour at exec.
The syscall is correct, so a deadline derived from the vDSO can already
be in the past when handed to the kernel; MySQL's InnoDB
log_files_governor thread spun at ~24000 futex calls/s on ETIMEDOUT
this way.

Flush the page after every update, as arm does.  The helper lives in
vma.c because asm/vdso/vsyscall.h is also compiled into the vDSO, where
asm/cacheflush.h is unavailable.  On sun4v flush_dcache_folio() is a
no-op, the caches there being physically indexed.

The sparc-specific vDSO that v7.1-rc1 replaced had the same defect
(reproduced on 6.18), so the bug is as old as the sparc vDSO, but this
fix relies on __arch_sync_vdso_time_data() and applies from v7.1-rc1.

Verified on 7.2.6: 32 probe runs across mapping colours show no vDSO
deviation, and MySQL's governor idles at 0.2% CPU across five restarts
of an unpatched build.

Fixes: 9a08862a5d2e ("vDSO for sparc")
Closes: https://github.com/sparclinux/issues/issues/94
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/vdso/vsyscall.h | 10 ++++++++++
 arch/sparc/vdso/vma.c                  |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/sparc/include/asm/vdso/vsyscall.h b/arch/sparc/include/asm/vdso/vsyscall.h
index 8bfe703fedc5..4852f122ce47 100644
--- a/arch/sparc/include/asm/vdso/vsyscall.h
+++ b/arch/sparc/include/asm/vdso/vsyscall.h
@@ -5,6 +5,16 @@
 
 #define __VDSO_PAGES 4
 
+#ifndef __ASSEMBLER__
+
+/* The user mapping may alias the kernel one in the VIPT D-cache. */
+struct vdso_time_data;
+void __arch_sync_vdso_time_data(struct vdso_time_data *vdata);
+#define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
+
+#endif /* !__ASSEMBLER__ */
+
+/* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
 #endif /* _ASM_SPARC_VDSO_VSYSCALL_H */
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 60029d60f4d3..fe6a47af6b05 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -27,6 +27,12 @@
 
 unsigned int __read_mostly vdso_enabled = 1;
 
+/* Called by the timekeeping code after every update of the vDSO data. */
+void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
+{
+	flush_dcache_page(virt_to_page(vdata));
+}
+
 #ifdef	CONFIG_SPARC64
 static struct vm_special_mapping vdso_mapping64 = {
 	.name = "[vdso]"
-- 
2.43.0

