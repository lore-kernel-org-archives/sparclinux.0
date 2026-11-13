Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580880;
	b=Whd9Fzp9QwCZkp20b094Lf+ufq7xL9HxC+SdlvT796pa5Hs0yy+oJprQWwH0SSAP1kmL
	 hAU9dwH7xKb60EqX/f+cOckIggjRCAPHn16Blkewj56Y4ItYZhl5axAk+P3j6CZZyWSfF
	 uUusUE8a5b0P4q+L5E4fMBxuQmUT6C2lVzEbyYzp861qR9iD/QpmZZImOqTi3N+mjYB6o
	 A8KFJSud+35KEnmg/NMJcb6TvX9TSZF7mzkUCXwqdfu8bGdUrcMQ+9EbX2Zoa6hkKslxP
	 mI00HGdAFVx8JtOVcZuButpQ8C8cOsFEBotKCVbWINqFCGtA2zs4IO/XQjUvSpPulLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580880;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HL92zgKYod996hm0k6p0C5Jm4SP3ok+isLPK4hYR488=;
	b=Lre6I+MAmzWNVGyT8ksyb6iIHFahzIRXj1GRAz/kzuI2Bixp1w23IiwSaXVtzdf82Oh+
	 Q8/JWa5Ay5c6Go+2NTBb6v80wehPkEviqxjljtH1jO4NxTf45CYESfElkPoLgy5Aii/z5
	 eyWh7NzNVew6PjPegtesn48J3wfY6z83XAEgGqcX38NkxUVhQi24JNYApgEYkTuaIej/6
	 S7dLXnyFvIil5QA5AI9+LrMNGKjBx9tYIk4f1ZkcuosQlUPCHZZYbK9vos0rA/zqOUCaD
	 GOr1GbOyCJNIw0xyg+8wIZu9ti/dHiQq860qsnaVvWJ9+eNRbuvj0YJ9wO3a7hNmrAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=N0EYVdhO;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB18606A331;
	Fri, 13 Nov 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB18606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=N0EYVdhO
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794580876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HL92zgKYod996hm0k6p0C5Jm4SP3ok+isLPK4hYR488=;
	b=N0EYVdhOJY8nfDd06mabt3fLEBv1HUQp1RsL48uHqkNjlSdEgmv4kLZ37xipIh/Zu2lWnF
	XuNI0eMaK8QxQMwkU4eIyTyjMxqN0gtHoGpSry6PRAHGH8uWXcDSiPUCCSowvP6sDWc5fU
	IQcozouQUGPsE0Ue4fGwrW7nZkGz7O4=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 1/4] sparc64: kprobes: Single-step from an executable instruction slot
Date: Fri, 13 Nov 2026 15:40:54 +0100
Message-ID: <20261113144057.1697874-2-stian@itx.no>
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

kprobes single-steps the probed instruction from kprobe->ainsn.insn[].
The array is embedded in struct kprobe, in the linear mapping. The
sun4v linear mapping is not executable. Every probe hit oopses:

  sun4v_insn_access_exception: ADDR[fff800005b0cd66c] CTX[0000] TYPE[0006], going.

Allocate the copy with get_insn_slot(), as other architectures do. The
slot comes from executable memory in the module area.

flush_insn_slot() flushed the embedded copy after init_aggr_kprobe()
had copied it into the aggregator. The aggregator now shares the slot
by pointer. arch_prepare_kprobe() flushes the slot when it writes it.
Make the macro a no-op, like x86 and arm64.

Fixes: c4bce90ea2069 ("[SPARC64]: Deal with PTE layout differences in SUN4V.")
Closes: https://github.com/sparclinux/issues/issues/110
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/kprobes.h | 12 ++++++------
 arch/sparc/kernel/kprobes.c      | 12 ++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index aec742cd898f2..d14206c063e25 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -11,25 +11,25 @@
 #include <linux/types.h>
 #include <linux/percpu.h>
 
+#define __ARCH_WANT_KPROBES_INSN_SLOT
+
 typedef u32 kprobe_opcode_t;
 
 #define MAX_INSN_SIZE 2
 
 #define kretprobe_blacklist_size 0
 
-#define arch_remove_kprobe(p)	do {} while (0)
+struct kprobe;
+void arch_remove_kprobe(struct kprobe *p);
 
-#define flush_insn_slot(p)		\
-do { 	flushi(&(p)->ainsn.insn[0]);	\
-	flushi(&(p)->ainsn.insn[1]);	\
-} while (0)
+#define flush_insn_slot(p)	do { } while (0)
 
 void __kretprobe_trampoline(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
-	kprobe_opcode_t insn[MAX_INSN_SIZE];
+	kprobe_opcode_t *insn;
 };
 
 struct prev_kprobe {
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 191bbaca99212..608efda8cb948 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -52,6 +52,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if ((unsigned long) p->addr & 0x3UL)
 		return -EILSEQ;
 
+	p->ainsn.insn = get_insn_slot();
+	if (!p->ainsn.insn)
+		return -ENOMEM;
+
 	p->ainsn.insn[0] = *p->addr;
 	flushi(&p->ainsn.insn[0]);
 
@@ -62,6 +66,14 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
+void __kprobes arch_remove_kprobe(struct kprobe *p)
+{
+	if (p->ainsn.insn) {
+		free_insn_slot(p->ainsn.insn, 0);
+		p->ainsn.insn = NULL;
+	}
+}
+
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
-- 
2.43.0

