Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3703B5DE9;
	Fri,  9 Oct 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569045; cv=none; b=jYiVBakl1AZbLBWaPCo1+3TRfkT7qaMbPal6GkkbatFxswQB1n/Di+jCxgbomufJk7gw66uzqIl3foH0Vu74Pe+NxIWZbyFBKOMtZ/6o6qRF/7bHHqDOQhU29LGU5aJc8Hsw9UnfMU1KzqbQzE7sblWqh9Ol7/7xbpYVphe6f7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569045; c=relaxed/simple;
	bh=7TULG9lK6U4XeHhBQjK7W/ceTkcSJmwKhKVJyGt41no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGGCWiVInhRYfJ/AocoaETK2jQtbVZwbrHOpM1JTSjpKiB20ZGzrORhvOcGzO4mIu6ccrA6DnQG8SYJEeFVysDaa2/0V67Ch88QjLzgsNuaKU8j4Uo/VySTJ+7xKh6mHHsXHFQgl5zgbSiTejiL0F7A6GbgMifR1huv3WW0SAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=TUiELfTu; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="TUiELfTu"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791569035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25qrz+MBMeEFHctM4Gq1jlyM3/vqPwqFRRuDqnMBpI0=;
	b=TUiELfTunGoWmCItMxxBRtf6/lXrbBDSq70cfHr4UkogbCRmSeSYdj60E3MHtFFkPJNWRZ
	rt1VjoOCXrH2/RlSvdTgph6exDETrw+JvNM3vSXvGBQlFbAJiKXAQAHSXydZ9n8viUHaAa
	egD3rx+y0RVzAHzwiGi0QjpcaLGxYwk=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 1/4] sparc64: kprobes: Single-step from an executable instruction slot
Date: Fri,  9 Oct 2026 20:03:32 +0200
Message-ID: <20261009180336.1315684-2-stian@itx.no>
In-Reply-To: <20261009180336.1315684-1-stian@itx.no>
References: <20261009180336.1315684-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobes single-steps the probed instruction from kprobe->ainsn.insn[],
which is part of the kprobe itself and so lives in the linear mapping.
The sun4v linear mapping is not executable, and every probe hit oopses:

  sun4v_insn_access_exception: ADDR[fff800005b0cd66c] CTX[0000] TYPE[0006], going.

Allocate the slot with get_insn_slot(), as other architectures do. It
comes from executable memory in the module area.

Fixes: c4bce90ea2069 ("[SPARC64]: Deal with PTE layout differences in SUN4V.")
Closes: https://github.com/sparclinux/issues/issues/110
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/kprobes.h |  7 +++++--
 arch/sparc/kernel/kprobes.c      | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index aec742cd898f2..8cc9697846fa1 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -11,13 +11,16 @@
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
 
 #define flush_insn_slot(p)		\
 do { 	flushi(&(p)->ainsn.insn[0]);	\
@@ -29,7 +32,7 @@ void __kretprobe_trampoline(void);
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

