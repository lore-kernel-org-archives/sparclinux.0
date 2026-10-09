Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE64E7805;
	Fri,  9 Oct 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569045; cv=none; b=quxs8FGzP+O07WFc0j8zCZ1qowhAxfYiF+W9pmm8EBeUjH8NPdGceS88EzF+F1tE0xm7+4i5EsKsZ0GER3UAdHWa3Scl55715HsPZb8hh+ITIHF/tytBbzgaIF+cMh2Po2QsMqgccaq+qABozglIjt0937K9Ks7vafSax+kPAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569045; c=relaxed/simple;
	bh=pLLgqzoZR6EWP/vVwqZKkOQZPP9/GW3pCZr3LzCyQ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnHhM2jcCkAbc8aHpLvmUxsSne/o6Zv6fAdQ/jfqhSOo/Dazy377Sn6OB/KqVVP/PzFSeb0Lfhi+yoqqewpgAD92OGAvuR7i97Uv49NRUzalP+KPmAqbEO8c4FT88nMYnj/Mujl7jDrhSwg7utPYZOh4OTrdhTMUKJh60QhANaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=BqFk+K2T; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="BqFk+K2T"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791569035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyWM2T+xxpFVXDNaBFMFZftjdMzgAOh6DyV1P/vuk9o=;
	b=BqFk+K2TKT5XCRcVSTkHs1erw68hvWVI4gACGLRj94Xqm79gzNdnp6s8+TQ5iKXZYOdR63
	juGOjzkD8mks962GQAQjxczJYMyA/0HboM3T8NsX8ISvmaY+FRpLVnsHtCoHEzTel4niRm
	mq5KZ4AX9DAFnqeSGRYXJjLlWZXUOZg=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 4/4] sparc64: kprobes: Handle annulled branches
Date: Fri,  9 Oct 2026 20:03:35 +0200
Message-ID: <20261009180336.1315684-5-stian@itx.no>
In-Reply-To: <20261009180336.1315684-1-stian@itx.no>
References: <20261009180336.1315684-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The single-stepped copy of a branch has a break instruction in its
delay slot. An annulled branch that is not taken skips that slot and
runs past the copy, and a taken ba,a or cbcond branches away without
reaching it.

Put a second break instruction after the delay slot, and resume after
the original delay slot when it is hit. Refuse probes on ba,a, fba,a
and cbcond.

Link: https://github.com/sparclinux/issues/issues/110
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/kprobes.h |  3 ++-
 arch/sparc/kernel/kprobes.c      | 43 ++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index 8cc9697846fa1..2f0980da80d3b 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -15,7 +15,7 @@
 
 typedef u32 kprobe_opcode_t;
 
-#define MAX_INSN_SIZE 2
+#define MAX_INSN_SIZE 3
 
 #define kretprobe_blacklist_size 0
 
@@ -25,6 +25,7 @@ void arch_remove_kprobe(struct kprobe *p);
 #define flush_insn_slot(p)		\
 do { 	flushi(&(p)->ainsn.insn[0]);	\
 	flushi(&(p)->ainsn.insn[1]);	\
+	flushi(&(p)->ainsn.insn[2]);	\
 } while (0)
 
 void __kretprobe_trampoline(void);
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

