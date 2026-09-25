Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F512470E8B;
	Fri, 25 Sep 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323382; cv=none; b=GbLJY3sxPtVGB0NpVwn0HX4MEo5NuilBX7MZICeNskL503VYAF5MqcxXlTkjmhXY+BEPta5XhRyRCMtk3NJrhdQs9g2CyImHxDSfvYabkMW6EG4vE/Mj7DzLmEnIop9vlEyM7axXfpBb6Wv9olhd7aANftemjoXvv1zulI11nc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323382; c=relaxed/simple;
	bh=TgRYGnzwRhNgP5FQnSma4S6kkCs+3PAsJfZfNgeqgdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3/TZufLNpIuM/8mzDrKEvlfZ/Lyul3fQdurC1jj5YQnL4kK/twCn80Pqd4SYgg7kxsWeGRkNsvdrhjkGDe19f4SPu4L7Uj5xPKBoj9lOC0630qArhCvm7PdMAONqFzQ9BzUZZjZasYxyp4m3pJ9SQPxe0hnPqoRvHbym5aBf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Z4RQXCFe; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Z4RQXCFe"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790323378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlPWaL/rIMb9Av+7frzxb/HY0Sru9mrRgToabhszOc0=;
	b=Z4RQXCFezhLteOik0+WRNXznxqkkYQS/zmmhMLKnQnGlTL/A7AyOgzdhtbxpLeoMXaWprd
	6zi9F8ViAfO42EkfVark72iI0dXO9iZXnDh5fxG6w5bhfdxHANIG5oviiUyEUDroa40qjw
	/vvy4UsGJpwPc5awDx3J5AgUyJn0n+Y=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2] sparc64: vdso: Flush the D-cache after updating the time data
Date: Fri, 25 Sep 2026 10:02:50 +0200
Message-ID: <20260925080250.2874750-1-stian@itx.no>
In-Reply-To: <20260917082547.223729-1-stian@itx.no>
References: <20260917082547.223729-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Fixes: 7c5fc16c7a56 ("sparc64: vdso: Switch to the generic vDSO library")
Closes: https://github.com/sparclinux/issues/issues/94
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
v2: add the Fixes: tag for the switch to the generic vDSO library, as
    the diff is against that code (Thomas); collect Reviewed-by.

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

