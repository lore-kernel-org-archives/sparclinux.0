Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338B4248B1;
	Wed,  7 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363253; cv=none; b=d/jcsO3kr9GST9oGEpeVs+eoaN3R6StiTCn9iZvnk5m9COwX9nkC+P9hj2wRCf4ROT9+g3LHF2vf1T9/IRNLtLAA0nzGu5nHRLSMHA2z0ZPBCu9HhXHLgpD7yjNzVgI0FRhRxV3cQhxGKrwdRMbCQ3WYsYdSfYb9e4B7zyM8Le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363253; c=relaxed/simple;
	bh=K79vlzXYWw3CvEgvvmtGGMrJC8UJeWVLj611Jlz92m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvXlppJOWMn02mMp0pjI0MvIBTmgMtSPm+w/RXCVhxouOHu+ZycJaXH60WFNQ3J84xCQQEuxlspZs+ALgUWxUpM6MEdGDSTQ3TGnM4qx8i48fZNZALzGWfvIeHpGfkMpt6mrOV8rIxgan1SPLHipSLXdS2a1kCJyICyKw43bZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Ish0B32k; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Ish0B32k"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791363242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG6WXrhXnKBKpiGA0s+l6Wrv278sqV1lyaa62FnwDQY=;
	b=Ish0B32kRnKResOPqHgYLWJIsuZ+/iafQCBxldQrbjvQRslwuXEcaQELjkCbHomN0F/PYl
	sTG/xhchihVtP5Odc3bRftd0f9WG6wTmvEDb4uRf/33Kx1GcY6dzM4Qk+5L+ut8GctZPAc
	uquIDcu8X2xfZ3t+QCXXAHfF+PVUhCU=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 2/3] sparc64: use the fault address for si_addr on window fixup faults
Date: Wed,  7 Oct 2026 10:53:46 +0200
Message-ID: <20261007085347.256789-3-stian@itx.no>
In-Reply-To: <20261007085347.256789-1-stian@itx.no>
References: <20261007085347.256789-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_fault_siginfo() prefers an address decoded from the instruction at
regs->tpc whenever one could be probed, falling back to the fault time
address only when it could not.

That premise does not hold for a fault taken during a register window
spill or fill.  There the instruction at regs->tpc is the one being
resumed, not the access that faulted, so compute_effective_address()
fabricates an address out of unrelated register contents.  In one
capture it decoded a branch and reported the value it found in %g5 as
si_addr.

Use the fault time address for FAULT_CODE_WINFIXUP.  It may only have
page granularity, but it is the address that actually faulted.

Fixes: 70ffc6ebaead ("sparc64: Fix top-level fault handling bugs.")
Link: https://github.com/sparclinux/issues/issues/87
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/mm/fault_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index e326caf708c60..c37b24f757f43 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -165,6 +165,15 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 
 	if (fault_code & FAULT_CODE_ITLB) {
 		addr = regs->tpc;
+	} else if (fault_code & FAULT_CODE_WINFIXUP) {
+		/* The fault came from a register window spill or fill, so
+		 * the instruction at regs->tpc is the one being resumed,
+		 * not the access that faulted.  Decoding it would fabricate
+		 * an address out of unrelated register contents; the fault
+		 * time provided address is the real one, even if it only
+		 * has page granularity.
+		 */
+		addr = fault_addr;
 	} else {
 		/* If we were able to probe the faulting instruction, use it
 		 * to compute a precise fault address.  Otherwise use the fault
-- 
2.43.0

