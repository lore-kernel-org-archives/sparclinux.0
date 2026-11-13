Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580879;
	b=4MUIpVxWs2DkdyJuMp/hPkyOZIGZe9dbnPsLKITcH9Wuefdw/E6bEbLUcMfr68kU3xC1
	 4pf01Bj3qX7uq7bkv28Jidv2Pe/PPqvAKKXLH/8RK5bOxjttI7CQUhP5Ok5edW0TNBiAD
	 MUafBYPBL5EHK9Y0YhMEDSKUIxSygpuUFTRWU8v9EbK5RNrLwexFgszxrZW2MuQ7nMytU
	 FDpAbe5U3lpNRHGwgCDgWIVU8KinOVrR2YFl8cWHXgPhgaem7pLyqUchf8dWz8g0Z0sQU
	 sGwky4b1bKUmRgS/aZ5dm9/r3VzgwmWzy0vrTjnej1itPonNrMecpXbSo03tnmpJZjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580879;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MK09vO0rnmUeAUjM58FfiC402nZHsIADcNUr3sKyHbU=;
	b=RFWFyCjTedNkeh25jDB9Umr9/y9zOrttOXj/AzP/vfNXlzRJEPkJS5Hps4qdx04Qg0Wg
	 WRWZuDnVDAnfn76VIQe7tz2G0N8tIUHmY9MIh0KXU/q5zRskpD0+ZaTjB9Q9N1DWrrWoj
	 Em4l3TuLrlN1RXxsCjXJP/Dpxi2htxqoHMx0dU7rPMc/z5l/XE9S9iPKqpaHg7jb2TK2i
	 CFkIRFE0zXzpY0hhUTWiwesVuHzyAUltZ000x+C3N/Bk/AeUzOBv/eTphBIineMJPZ6vN
	 LoKUcvzmdoe4tgmuGdcwZdzMtsU6UvulZR6Ccj9a/a0e6OfjppFA5nTfFotJqPRBiJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=CQcE3BFe;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF5606A330;
	Fri, 13 Nov 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEAF5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=CQcE3BFe
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794580877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MK09vO0rnmUeAUjM58FfiC402nZHsIADcNUr3sKyHbU=;
	b=CQcE3BFefo7GqenU55A84TmWPDHRR+xdGIR/3Bm//ovRUKH0acZ1oRX+LJ6hh04XKDSnus
	5SpGHHJwRH2rK9nk/+szCqOgzOVwCj0QerbXyZKY4hCQacwPt172t7EvA+VsKYG1OPrklZ
	kyLOvhneiAZeQ0qhWFSsINO0mKFUO+k=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 4/4] sparc64: kprobes: Handle annulled branches
Date: Fri, 13 Nov 2026 15:40:57 +0100
Message-ID: <20261113144057.1697874-5-stian@itx.no>
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

The single-stepped copy of a branch has a break instruction in its
delay slot. An annulled branch that is not taken skips that slot and
runs past the copy. A taken ba,a or cbcond branches away without
reaching it.

Put a second break instruction after the delay slot. When it is hit,
resume after the original delay slot. Refuse probes on ba,a, fba,a
and cbcond.

Link: https://github.com/sparclinux/issues/issues/110
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/kprobes.h |  2 +-
 arch/sparc/kernel/kprobes.c      | 43 ++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index d14206c063e25..e15fd84c88681 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -15,7 +15,7 @@
 
 typedef u32 kprobe_opcode_t;
 
-#define MAX_INSN_SIZE 2
+#define MAX_INSN_SIZE 3
 
 #define kretprobe_blacklist_size 0
 
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 327d83188a978..dc1180d4c2338 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -21,7 +21,8 @@
  *
  * In the kprobe->ainsn.insn[] array we store the original
  * instruction at index zero and a break instruction at
- * index one.
+ * index one, and another at index two for a branch that
+ * annuls its delay slot.
  *
  * When we hit a kprobe we:
  * - Run the pre-handler
@@ -47,11 +48,34 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
+/* cbcond has no delay slot and ba,a annuls it, so when taken the
+ * single-stepped copy branches away without reaching a break instruction.
+ */
+static bool __kprobes kprobe_insn_rejected(u32 insn)
+{
+	if (insn & 0xc0000000)
+		return false;
+
+	switch ((insn >> 22) & 0x7) {
+	case 1:		/* BPcc */
+	case 2:		/* Bicc */
+	case 5:		/* FBPfcc */
+	case 6:		/* FBfcc */
+		return (insn & 0x3e000000) == 0x30000000;
+	case 3:		/* BPr, cbcond */
+		return insn & 0x10000000;
+	}
+	return false;
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	if ((unsigned long) p->addr & 0x3UL)
 		return -EILSEQ;
 
+	if (kprobe_insn_rejected(*p->addr))
+		return -EINVAL;
+
 	p->ainsn.insn = get_insn_slot();
 	if (!p->ainsn.insn)
 		return -ENOMEM;
@@ -62,6 +86,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
 	flushi(&p->ainsn.insn[1]);
 
+	p->ainsn.insn[2] = BREAKPOINT_INSTRUCTION_2;
+	flushi(&p->ainsn.insn[2]);
+
 	p->opcode = *p->addr;
 	return 0;
 }
@@ -295,12 +322,18 @@ static void __kprobes resume_execution(struct kprobe *p,
 {
 	u32 insn = p->ainsn.insn[0];
 
-	regs->tnpc = relbranch_fixup(insn, p, regs, kcb);
+	if (regs->tpc == (unsigned long) &p->ainsn.insn[2]) {
+		/* An untaken branch annulled its delay slot. */
+		regs->tpc = kcb->kprobe_orig_tnpc + 0x4UL;
+		regs->tnpc = kcb->kprobe_orig_tnpc + 0x8UL;
+	} else {
+		regs->tnpc = relbranch_fixup(insn, p, regs, kcb);
 
-	/* This assignment must occur after relbranch_fixup() */
-	regs->tpc = kcb->kprobe_orig_tnpc;
+		/* This assignment must occur after relbranch_fixup() */
+		regs->tpc = kcb->kprobe_orig_tnpc;
 
-	retpc_fixup(regs, insn, (unsigned long) p->addr);
+		retpc_fixup(regs, insn, (unsigned long) p->addr);
+	}
 
 	regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
 			kcb->kprobe_orig_tstate_pil);
-- 
2.43.0

