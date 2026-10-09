Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5044E4323;
	Fri,  9 Oct 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569045; cv=none; b=qnk1x0JuojQcsVgas4dIZ6Y4qWwMaImywPUO3tn7oW2k7s3i5SuFqsQKUm/kRa7vvr1jvtS+Y5v6CKHouQE+b4eqQ1LfJSzSpRqNHFuOVnMP7QkDLoju/Kic4oecyhkSW0dtX8xdzshr6IGZEWjecD0p/MIBD9V+8+ikGzKJ66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569045; c=relaxed/simple;
	bh=zF4eawWVHXbX/4hxfZYhuDugnjeCgP822sX/plN6R8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ5naUmwlpsLcHtdrYwskwTPGnI7Vzg12uRQZ1PV62u+P49skSjWK7DblUp/idd6cYwTBZXhwgkiWTwp04QLc0mcLSfTD/RIVk2cjZwbW+f8YgFveh/wC63xNymf2nFZG4M+BAqroJy8hAQIjk8VGShuBigQucLzXV/PNUuTMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Vd/7LIVw; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Vd/7LIVw"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791569035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1Tmk8hKir8hCNQtLO+SolipxeNQ9+JCzf7F9gQQ7qg=;
	b=Vd/7LIVw0GawC7MuLX1qNNd4/iMCyBUmOtggccoNjmK3i8zBMK1JJotDP0N6LzS+oNzSrl
	3dYtYsthpX78aZ3ojVXl7bkkM+sEBc75UpoA+j6Cfag9QXk9xwNtpmppvJLbD3sxhaCYF3
	II15MrUGyWtyj+BlhdSoOxXw3XP10FA=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 3/4] sparc64: kprobes: Resume after a delay slot at the saved next PC
Date: Fri,  9 Oct 2026 20:03:34 +0200
Message-ID: <20261009180336.1315684-4-stian@itx.no>
In-Reply-To: <20261009180336.1315684-1-stian@itx.no>
References: <20261009180336.1315684-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After single-stepping an instruction that does not branch, execution
resumes at the saved next PC, followed by the probed address plus 8.
For an instruction in the delay slot of a taken branch the saved next
PC is the branch target, so after the target execution goes back to
the probed address plus 8 instead of continuing at the target plus 4.

Use the saved next PC plus 4, which equals the probed address plus 8
for any other instruction.

Link: https://github.com/sparclinux/issues/issues/110
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/kprobes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 38e6d9b51a207..327d83188a978 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -211,13 +211,14 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
  * 
  */
 static unsigned long __kprobes relbranch_fixup(u32 insn, struct kprobe *p,
-					       struct pt_regs *regs)
+					       struct pt_regs *regs,
+					       struct kprobe_ctlblk *kcb)
 {
 	unsigned long real_pc = (unsigned long) p->addr;
 
 	/* Branch not taken, no mods necessary.  */
 	if (regs->tnpc == regs->tpc + 0x4UL)
-		return real_pc + 0x8UL;
+		return kcb->kprobe_orig_tnpc + 0x4UL;
 
 	/* The cases are call and the branches BPcc, Bicc, BPr, FBPfcc
 	 * and FBfcc.
@@ -294,7 +295,7 @@ static void __kprobes resume_execution(struct kprobe *p,
 {
 	u32 insn = p->ainsn.insn[0];
 
-	regs->tnpc = relbranch_fixup(insn, p, regs);
+	regs->tnpc = relbranch_fixup(insn, p, regs, kcb);
 
 	/* This assignment must occur after relbranch_fixup() */
 	regs->tpc = kcb->kprobe_orig_tnpc;
-- 
2.43.0

