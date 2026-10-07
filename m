Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03472427A04;
	Wed,  7 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363252; cv=none; b=Y/44fTLbET4rIQkavtPSKrkZhKcsEy2hDIkrfhDoxmQQLMQdXsECsAuHUROW1xX8ysv8z3eRcRT/0tcZx4tRpvnq0m0vsl5ICaU5pVe7txCKVLtnHCoPak30G3f1PjySaG9jFTnHQb6rDeGDrP0i49gsDXXuNBoWsAUBP7ZSF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363252; c=relaxed/simple;
	bh=zfERSpnojm261i93w2JipzQrJ+fFEiKH45+LgKmSavA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQNIrD8p6+SBbd1mHlpoTjIiS1L5ltQIEEkj+ybMVaq9LBCo+EV64iNmQh4lf7CkK/Go/o05W1fBd8PeGqpoeYTq7+6eUkPkJ20kobjTOMMWeGl0F8pqkd7M0afrk7zbjxJ+UkXeLHS9NBKSMpyr83aKorqzUm/ejp/9cmEGlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Ipiq5YLD; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Ipiq5YLD"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791363242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6E7xqjxQbrQo7h9CnPBA/7cYBgFZTDsTNwiPGWkNrg=;
	b=Ipiq5YLDkZSRWGl+6FM7xfRrqFi3du4eL/z/8Y7UVdG1MiE4z2Mftiv6yrCF63QufGMNfH
	yd7xQ1fwucHVIK00WpdVuF57jKazrmp9yQIFRLGR1A8iDmZcZrZ8y8Er949BEGujbDk+Z8
	yWrhHv7TQ5PEYJ9lWdCrT5JToHLECF0=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 1/3] sparc64: restore %asi in user_rtt_fill_fixup_common
Date: Wed,  7 Oct 2026 10:53:45 +0200
Message-ID: <20261007085347.256789-2-stian@itx.no>
In-Reply-To: <20261007085347.256789-1-stian@itx.no>
References: <20261007085347.256789-1-stian@itx.no>
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
v2: reword the comment as suggested by Andreas: state the restored
invariant first, phrase it as why the write is needed, and leave the
failure-mode details to the commit message.  No code change.

 arch/sparc/kernel/urtt_fill.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
index e4cee7be5cd02..1ec67df9b59e3 100644
--- a/arch/sparc/kernel/urtt_fill.S
+++ b/arch/sparc/kernel/urtt_fill.S
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asi.h>
 #include <asm/thread_info.h>
 #include <asm/trap_block.h>
 #include <asm/spitfire.h>
@@ -32,6 +33,15 @@ user_rtt_fill_fixup_common:
 		sethi	%hi(KERNBASE), %g1
 		flush	%g1
 
+		/* Restore the kernel's ASI_AIUS invariant, which etrap
+		 * would have re-established had we passed through it.
+		 * rtrap set %asi to ASI_AIUP for the window fill, and
+		 * the primary context is now the kernel's, so a leftover
+		 * ASI_AIUP would make %asi-based user accesses (put_user,
+		 * get_user) translate in the kernel context.
+		 */
+		wr	%g0, ASI_AIUS, %asi
+
 		mov	%g4, %l4
 		mov	%g5, %l5
 		brnz,pn	%g3, 1f
-- 
2.43.0

