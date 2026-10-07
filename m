Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351A42E41B;
	Wed,  7 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363253; cv=none; b=sNQlgJ8J2f4/TqjN5fN1mJCPrUKaDJu0NcEin5whasv1wGqMwHUFEloBfRCT4gWAwG0JR/OTV/ZwaijVn1cTeyLwLRJ0Ou8B3mO5o8EUMguJjevUxsr3eLv8Ujd5xrJczUzeuAorU0iBZtGNscp1V1kPBp4liAcA5CVvKsqk6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363253; c=relaxed/simple;
	bh=9N8YsyBjc5Dpas5T8dSqhwxe8Iu83TwFsdK8gqFU3Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI4a9ojDUSQPVBMNMCsq3iSl+GomRg9wqtDZKRpFFJ0pmBnlYmg2BALDLJTc/idJv+n2B6aIb4BRlXA4eNYbFxARmB3dSKCeLdRWSEW9CfvYtXwtQIBUF6ff3ZMaL5HADvT3/z+JCEBJHi0BUNOO5FOAItZE5LjOL/w9AfZPR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=BqAYmDrw; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="BqAYmDrw"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791363243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7VfUAbEXsatpZTaJpjh7Upcyr3t0cxAu6YGTe5bvbQ=;
	b=BqAYmDrwIFivxOZ0bic/hIoN3IsQdXjDPjk6WdiSqjlakWVnHpllhyI++VFMiN41Ncl/9E
	irVYIR6flYjvgFVMYn222o+7rqTeF7wuHveBs2C8mizUm4KhmNnXOPWVw8yvQxrTzfvpH2
	1gkBfbHzejG9TzJI2mFTFf83dQu/ees=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 3/3] sparc64: decide the TSB huge-page window fixup before the bank switch
Date: Wed,  7 Oct 2026 10:53:47 +0200
Message-ID: <20261007085347.256789-4-stian@itx.no>
In-Reply-To: <20261007085347.256789-1-stian@itx.no>
References: <20261007085347.256789-1-stian@itx.no>
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
index eaed39ce8938c..a70d5b124a803 100644
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

