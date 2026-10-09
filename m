Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43C3E316D;
	Fri,  9 Oct 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569044; cv=none; b=Ollwxz2IQ21xmhuQnx7cb5y0zgW89QGkQ/y0qAFnV2XVW2pNP6CotUG0vpeCHU2Yr0IYQhsR92+Ebf/NZAAzNB32abmiUHSwxW7jxRrFJC+3pVEBKyBFllMAKuq4VLkQhIDfr+ZFzXkEHCBcSa+fF+OaNv7ZeIYsKO3cFZuT+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569044; c=relaxed/simple;
	bh=ckFG8C7Hxd8qNC8aBrpJU0CQYB2mofqQQ2Sr8xC2UHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCgO4Ur78K9HKpUcm8XGYbEH1j85Yxh0CDYStShlgc8y+I0EIZqjZeMwgU5aaFkm8Ww/pILYM+t+rNN62z3rR43NDa4eRC6xKC2b2XsVzABX4CMCdPGP+HWmBP3sC9XpHkYDkYIhptzKp6AkzuSeZhcFiNhB2E3kpgLbqMdEESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=k5iJTwlv; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="k5iJTwlv"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791569035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y87J6BBuR24u9MRCoszjpGO+5foEMCzLYaJH2bQGIg=;
	b=k5iJTwlvrLqaTYabeEB3hgNsMRmrY8C9kQEuhyczVjEe/0m5brI54YGt6vwvx55IBc8sgV
	9nfn9Zf9idxCyW21J2Vjjw9HAWFJt8Aq+ScggWw3E1Okx7jjnspnx74QcJ9XteBf2FDTUI
	D2W3qd65VhYW3aNM47hZEPw652cvJnE=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 2/4] sparc64: kprobes: Fix up register and FP branches after single-step
Date: Fri,  9 Oct 2026 20:03:33 +0200
Message-ID: <20261009180336.1315684-3-stian@itx.no>
In-Reply-To: <20261009180336.1315684-1-stian@itx.no>
References: <20261009180336.1315684-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

relbranch_fixup() moves the target of a PC-relative branch from the
single-step slot back to the probed instruction, but it only knows
call, Bicc and BPcc. A taken BPr (brz, brnz, ...) or FBPfcc/FBfcc is
taken for an absolute jump, and execution resumes at the target
relative to the slot:

  Unable to handle kernel paging request at virtual address 000000000fffff98
  TPC: <0xfffff98>

Treat them like the other PC-relative branches.

Link: https://github.com/sparclinux/issues/issues/110
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/kprobes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 608efda8cb948..38e6d9b51a207 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -219,12 +219,15 @@ static unsigned long __kprobes relbranch_fixup(u32 insn, struct kprobe *p,
 	if (regs->tnpc == regs->tpc + 0x4UL)
 		return real_pc + 0x8UL;
 
-	/* The three cases are call, branch w/prediction,
-	 * and traditional branch.
+	/* The cases are call and the branches BPcc, Bicc, BPr, FBPfcc
+	 * and FBfcc.
 	 */
 	if ((insn & 0xc0000000) == 0x40000000 ||
 	    (insn & 0xc1c00000) == 0x00400000 ||
-	    (insn & 0xc1c00000) == 0x00800000) {
+	    (insn & 0xc1c00000) == 0x00800000 ||
+	    (insn & 0xc1c00000) == 0x00c00000 ||
+	    (insn & 0xc1c00000) == 0x01400000 ||
+	    (insn & 0xc1c00000) == 0x01800000) {
 		unsigned long ainsn_addr;
 
 		ainsn_addr = (unsigned long) &p->ainsn.insn[0];
-- 
2.43.0

