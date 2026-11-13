Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580879;
	b=DKSZ42yD95XZsMENHvB4J5b3dWCxjUtQ22Dg6UYHJH+OAdbkEUggLVjUYntEEBqYQfHX
	 n6tO9BUcLOYl2Aj1HJ/4fHFAsTDa5R3sCNuRJ1rYUcsHiJRXEbIeisbMx5xfaIGpPbcxH
	 RkVLyYTmvMXsZndJ0WtkW5/BaajgYiNQn8vSQXv7oOE+xAtTkER/0B9leEYW8SmlftCeQ
	 vVCiT6aRtzV5x1odyHsS+dYzVtmG5GxG9GlzMkVh0PVRNrgXaVNwPS3a4bxKn8RK/Vox9
	 vfviqIua5FSS+3AfGw3WBJIJyD2Xkc+G/Q8r1OAK/w8LxsZ2qjXTyMzZ7QwovZz0kVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580879;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bbPfFzPXdVnBQYGKm2T4opS2tBkI0J5gN6MGoRydAzM=;
	b=i4a3ISnyNJH75dWUxUMyhwxj+kOLZIzmTdfPHi4kb9RCPo/CaMcuWSHwzHyuk6baSig+
	 Ar+zfnQkYGR1TNp2sP8g7aCMfHpbhCvQxPOMFKvPM4Wv4iW5mXFSGfXoGUz2zER8Bsw5k
	 YD7nCkP97eKnR4LbQBZZM8sSfcxJuRc2KkIlKxuiHn6JiO/g+Jgd89YIXdMGzZGMbhhaq
	 yv2HbLN4GimPTddXYHwgAIVdofW9n2VJtTslB2KFkGW05lbp9W8zF9joYwADYxe+jFAQb
	 6YgqGZBv06Qu2vWslWMRHHn2uGLRkVMqJmB8IlpUPxtHtO0NwA279vezSGjOpoHDqLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=oinQeWCq;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADF606A32E;
	Fri, 13 Nov 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEADF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=oinQeWCq
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794580876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbPfFzPXdVnBQYGKm2T4opS2tBkI0J5gN6MGoRydAzM=;
	b=oinQeWCqGMkrGNi8LyHOzo4QIHD3kMayX7V15ahFnFbU6nfkbkRus7hnEm6/dsl0q0cava
	a2cwM3zA+YMTfcvbT/j/39c4hgzhrwE3F4tAE8QeXI5yZG+9tt8bxhAoYQ4FzzILjAlsfR
	hj82cmjKpH2EN0snHDr1WR7slfimXyQ=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 3/4] sparc64: kprobes: Resume after a delay slot at the saved next PC
Date: Fri, 13 Nov 2026 15:40:56 +0100
Message-ID: <20261113144057.1697874-4-stian@itx.no>
In-Reply-To: <20261113144057.1697874-1-stian@itx.no>
References: <20261113144057.1697874-1-stian@itx.no>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After single-stepping an instruction that does not branch, execution
resumes at the saved next PC. The probed address plus 8 comes next.
For an instruction in the delay slot of a taken branch the saved next
PC is the branch target. Execution then goes back to the probed
address plus 8. It should continue at the target plus 4.

Use the saved next PC plus 4. For any other instruction that is the
probed address plus 8.

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

