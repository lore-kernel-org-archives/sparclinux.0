Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB63D646B;
	Fri, 28 Aug 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920675; cv=none; b=hwrkbIpKbx1wz/s7Uzi+lqdxqKRBqi7uDSYuISVzCceXxSMobmc4oEHORi278FC4T08OLQmrDYe1WhtO8wpLT60aUwrK2AFEMZhZkRRwHniq3BPcNE98aJ1nVxLG5QReRc2/WXxapohwKoFFFw1fdM/CWHoxSdZ7Y6oJF6gKsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920675; c=relaxed/simple;
	bh=oo6KV7zUyyEiWTF/mpP3ZgTJ52TgOt9ofBBLTeyNrNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYg8wSWBXAaz0jQMtSnecZD0gtVJNe55xlizx+ISe5gGxiPTrB85WU6OEGQfLEdPswyc0hjE99k8eKIptDzb21jU29dJwPj8zQdxHWmnyDsfAxoEfcszpliGlviNbupM39VFem9JjJE2h5vj+sJ20IUoTlSUCTN0kX1ygwqqzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=lXxyGBOZ; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="lXxyGBOZ"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1787920659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxrgltKwht0j2/GB66AG5cKTYHSGd5M+OZGr77Ffeps=;
	b=lXxyGBOZsc9LbfVTjuxGvaK9k/v97BxkhiyTWetJNV8x6bddDhNyQIw6pYabQtho68TJF2
	Q35siAt/0IcrsOqDfuy3hXOgoG4bmWeUgmFJPXidtDSmcqlevHzGgNqPWZUQzof6vuuksa
	EQlsAC/TWy6jXmpiv/y7XV0Z4jEpggs=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 1/3] sparc64: restore %asi in user_rtt_fill_fixup_common
Date: Fri, 28 Aug 2026 14:37:05 +0200
Message-ID: <20260828123707.1852437-2-stian@itx.no>
In-Reply-To: <20260828123707.1852437-1-stian@itx.no>
References: <20260828123707.1852437-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A window fill that faults re-enters the kernel through
user_rtt_fill_fixup_common(), which does not pass through etrap.  rtrap
has already set %asi to ASI_AIUP for the fill, and etrap is what would
normally re-establish ASI_AIUS from the TSTATE it synthesizes, so the
kernel carries on with %asi = ASI_AIUP while the primary context has
just been restored to the kernel's.

Every %asi-based user access made from there - put_user(), get_user()
and everything built on them - then translates in the kernel context.
User addresses below the VA hole fault forever, because nothing ever
fills a context-zero translation for them, and the CPU is wedged in
kernel mode: the task survives SIGKILL, sits in state R at 100% CPU,
and takes the machine down once RCU stalls.  Addresses above the hole
fail more quietly, silently aliasing the kernel linear mapping.

Restore the invariant before any user access is attempted.

Fixes: 7cafc0b8bf13 ("sparc64: Fix return from trap window fill crashes.")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://github.com/sparclinux/issues/issues/87
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/urtt_fill.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
index e4cee7be5cd0..5acd27b18b1e 100644
--- a/arch/sparc/kernel/urtt_fill.S
+++ b/arch/sparc/kernel/urtt_fill.S
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asi.h>
 #include <asm/thread_info.h>
 #include <asm/trap_block.h>
 #include <asm/spitfire.h>
@@ -32,6 +33,20 @@ user_rtt_fill_fixup_common:
 		sethi	%hi(KERNBASE), %g1
 		flush	%g1
 
+		/* rtrap set %asi to ASI_AIUP for the window fill, and
+		 * we re-enter the kernel here without passing through
+		 * etrap, which would have re-established ASI_AIUS via
+		 * the TSTATE it synthesizes.  The primary context was
+		 * just restored to the kernel's above, so a leftover
+		 * ASI_AIUP makes every %asi-based user access (put_user,
+		 * get_user) translate in the kernel context: user
+		 * addresses below the VA hole then fault forever
+		 * (nothing ever fills a context-zero translation for
+		 * them), and addresses above it silently alias the
+		 * kernel linear mapping.  Restore the kernel invariant.
+		 */
+		wr	%g0, ASI_AIUS, %asi
+
 		mov	%g4, %l4
 		mov	%g5, %l5
 		brnz,pn	%g3, 1f
-- 
2.43.0

