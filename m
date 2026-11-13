Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580879;
	b=3ozDeTSEt8GNlPKg0RgMUUr0S1DztB21tpus72lA61niJPWIP4ORKIlem9NiJFIA37XH
	 7AJfKrVnUkAdiFkZfDLw/f3ZK+z6yGc7MXVPan9lobRqrCjCcsDl13xuaB3YEZqSntnfl
	 TFTj9TsKUq2XqHJ2kBSOkRcmbIfNyyoAQflY4oVVFwU6cOR1jVCPj5qgleVm7baZCUtHH
	 RSe6HQi2Vj0xTh+rcUKO+i8Di2od5WPVx6S2x8LJenGuT5c7Fqvr0e2j8JttLQoGz3WRM
	 HEaAAbjGTrHro5vOBwdXTmpYr/ps0Ar8b2Z8dHsoQjccl06U+0ap6egFYZJQOF8W+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580879;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tOun4bI8iVL+2iLm1oG+MIyBhqrSN/6XblHtAXPcUaU=;
	b=iTIyXN7O5Z4NTyphGtvH1bmDYFltDe8trNU3wkLV9H9wMSVy+u1mk+AI6a+HsaWqh/NZ
	 8eGyzrnrZsOqz74lE8hEKRpu72ov7hrfBF8BkuDnT1tC76OfQEbpL3wz2RtNUGGJX6ZmT
	 oewz2JaOlfI3A+LOnvSMeHLffomJqMnGFTRbMwe6yqg93l9w7Qu9LPX6ub6A2+3NnY2Yc
	 UnKHi+s28AdbKBY1fsMKn3q5ABRDeCEqHrTSvXzFMaPmb/AB6mzeidUyIQ51OF8d7v8KJ
	 EcZ5omwariZ8Jn2mSVhTs9pcHBEI+0UvV6M7MnEsSa++dyVRU8XbtVD1Tz1qJxdjksQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=Sv9MqbiA;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F7606A323;
	Fri, 13 Nov 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=Sv9MqbiA
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794580876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOun4bI8iVL+2iLm1oG+MIyBhqrSN/6XblHtAXPcUaU=;
	b=Sv9MqbiALUhKfQvOwuum41rQrkkJ/jh+zWI3G2jhg+Suffahsf9eiM4yVnkek+eEyp5iiI
	zd3YLBDXxa9D7+cJn2f7mDYnt1R+y+8n/A3MgkhCf7kj1q3LMaQ76F6EX43JwtsD90NQSX
	mMuTq8OREmmlisS62NnSuzFqgDCDNX0=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 2/4] sparc64: kprobes: Fix up register and FP branches after single-step
Date: Fri, 13 Nov 2026 15:40:55 +0100
Message-ID: <20261113144057.1697874-3-stian@itx.no>
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

relbranch_fixup() moves the target of a PC-relative branch from the
single-step slot back to the probed instruction. It only knows call,
Bicc and BPcc. A taken BPr (brz, brnz, ...) or FBPfcc/FBfcc is left
alone. Execution resumes at the target relative to the slot:

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

