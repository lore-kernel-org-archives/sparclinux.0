Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D944A701;
	Fri, 28 Aug 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920673; cv=none; b=PChTb8iW4vosZzHwpm6J1dilJ5uzIBrfxMHAxluIe/DZV1Ou4T1A3ARsUfmBNKJVpLVxA5ifdPKPU8vmStaFP8VF5OnNTfyR5Nag2Mziijew7f6i/DYTmZvL+/cWJSAIHyE7sKySjt6Ccbjd0hEgNKGra/iQlxocYwjdaWOvSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920673; c=relaxed/simple;
	bh=OmY+8PZlHKkkMXWeh0ben5lXrY6btWYfaFgkAQqKTMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atR6XPVwy0XyLYn6NvPlZ6Cpylhk5WnYOg6xVPxL4fwyJxqcv7GgWWmuTgMeoU97dw8q6BKQ09TeeOYV2LAahxxpIgWlYJ4os2kE0+gb2emL6MEaRbHvzVbhRnO+5vIm9ISirfW5yk2DVP6VSXtoLvnAutwbi1+4i3m5VyRvtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Msat1m7/; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Msat1m7/"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1787920659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8O/Xp9V6094Ri0HZFEnYjkpNf8IyEr6Jqh1UvzCjF4=;
	b=Msat1m7/7vm1lPQRiZGUxDxwMs4lBbDDOeLPN8/+Vef7zKWc8WzTDqZhxFQCQ+ebSHsJYF
	LAjWJqBYhkr0hpq9f2wBpXdmB76ZLgVeClgGeEWvYMCW2xxTlwgm0eOCTjeu1ysculaszI
	0NcEAGFX+j4i39RjszNz1EngoD5VO1U=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 3/3] sparc64: decide the TSB huge-page window fixup before the bank switch
Date: Fri, 28 Aug 2026 14:37:07 +0200
Message-ID: <20260828123707.1852437-4-stian@itx.no>
In-Reply-To: <20260828123707.1852437-1-stian@itx.no>
References: <20260828123707.1852437-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The huge-page path in the TSB miss handler has to route a fault taken
during a register window spill or fill away from hugetlb_setup(), since
a trap stack cannot be built at TL > 1.  That test is made after

	wrpr	%g5, PSTATE_AG | PSTATE_MG, %pstate

(SET_GL(1) on sun4v) has already switched the global register bank.
%g3, holding the fault code, and %g5, holding the PTE, live in the TLB
miss handler's globals and do not survive that switch, so the branch to
winfix_trampoline passes on whatever the new bank happens to contain: a
stale fault code and a garbage fault address.  The task is then killed
with SIGSEGV pointing at an address that was never mapped.

The path predates the fault code being passed at all; it was given one
when winfix_trampoline's %g4 requirement was fixed, and the register it
reads has been the wrong bank's since.

Make the decision before the switch and route to tsb_do_fault, which
re-reads both from the MMU after switching banks, rather than entering
winfix_trampoline with registers that no longer mean anything.

Fixes: 84bd6d8b9c0f ("sparc64: Fix corrupted thread fault code.")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://github.com/sparclinux/issues/issues/87
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/tsb.S | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index eaed39ce8938..a70d5b124a80 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -144,6 +144,26 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	bne,pt		%xcc, 60f
 	 nop
 
+	/* If this fault came from a window spill or fill (TL > 1),
+	 * we cannot build a trap stack and call hugetlb_setup() from
+	 * here.  Route it through tsb_do_fault instead, so that
+	 * do_sparc64_fault() runs and its huge-TSB grow check
+	 * allocates the TSB before the access is replayed.
+	 *
+	 * This must be decided before the register bank switch below:
+	 * %g3 (the fault code) and %g5 (now the PTE) live in the TLB
+	 * miss handler's globals and do not survive it.  Consuming
+	 * them after the switch, as this path used to when it went to
+	 * winfix_trampoline directly, records a stale %g3 as the
+	 * fault code and a stale %g5 as the fault address, and the
+	 * task is then killed with a SIGSEGV at a garbage address.
+	 * tsb_do_fault re-fetches both from the MMU after switching.
+	 */
+	rdpr	%tl, %g7
+	cmp	%g7, 1
+	bgu,pn	%xcc, tsb_do_fault
+	 nop
+
 661:	rdpr		%pstate, %g5
 	wrpr		%g5, PSTATE_AG | PSTATE_MG, %pstate
 	.section	.sun4v_2insn_patch, "ax"
@@ -152,10 +172,6 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	nop
 	.previous
 
-	rdpr	%tl, %g7
-	cmp	%g7, 1
-	bne,pn	%xcc, winfix_trampoline
-	 mov	%g3, %g4
 	ba,pt	%xcc, etrap
 	 rd	%pc, %g7
 	call	hugetlb_setup
-- 
2.43.0

