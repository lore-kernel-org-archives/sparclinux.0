Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C84D8DBE
	for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282719; cv=none; b=ZuOfAXIp2vmDfpWeFZLseBUZbxR6IHe337jVNO+0jTpMOZs2Ay6gfo+2pDNmBd8QXqxs9x85cUooB9dW+dOnPnxA6Qpi/WQghpjG6WmXjgAxGFJEyH9YNyMmnE2z/7LkswKawwSV09dKvFuCgZ6WFJbweH+Tn5hPWEVlQa8Gr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282719; c=relaxed/simple;
	bh=ozjA8KSsMcbFMDharvuoZPgEB9CYnB/D7P0+ThoVcVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv99ctw1xFAZe9OKqXdJ9VbMfveFYYSePXP8ZHXwo9OQioDHhOGUvo/JdW33R+idDkNV84Bxo7/q9SaweOT2Svs3iegrej/I8vKKtWj0W22DcI4/C2DD/wedE1D7Jx4zPJpXA2jF5xoeS0L/0ZojwV7CC03/UzScGuDPiycOFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNXzFI/9; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNXzFI/9"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so24705766b.3
        for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790282716; x=1790887516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFRNBiIrmrhTYxtp/TvLSKPmD2BYNjT7uhVI7i3Srpo=;
        b=jNXzFI/9e4XvB2RizJFi95focR6oF4IngccahLbh5PpNa3erizJpB1vNJP0JBiGtjH
         U5At+CL9ScDbyFBGTyYn+pMpFXqNMhdOdiQQwjDs/9DGhooMYpmSfxYYgzAdYB/wBub7
         SzYC9LQUhJOrg/ZH1/saasHCXg6ehZWbOhjjdnjiWJS8mkzAasucaahSrvmwIYTd6KGN
         idY8AN9/5FZbJEh9o6H5CGmblSr65QPxwEgJUzMzeFDit5aWHJhXL7LoVQA0Eq7DB4Ws
         sx+kXAChvrI5nLFdSKniOAukZi6g8L63yYgqg/NNAikJUzQfGJhiFBCEg4jPYON9tWxc
         E3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282716; x=1790887516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFRNBiIrmrhTYxtp/TvLSKPmD2BYNjT7uhVI7i3Srpo=;
        b=lcuNtMFBkYt2ms18LQICRPF3TddNuPtinFsWxZWCe1U/5zg51DYsLGWdkJzohaRcQ1
         wc6oTUt1cW814PPHz+NQBf8HFFxHBby31VsvS5yiA8v+mAvALsL9Wzz7LI67zgDZ+9z7
         kZ0Rpt2/l9fiRfBM5EELddFOvr2FINdYdNeDNoDLljAXiGnzvh3EEufM+j9U3PbMxLjS
         I6cj9CCiWbMshNtsJbMq+O60Tkd4CYBkU24nZtxBnOCEpskz0bylZLmn84lU6eMFjc8u
         gTpxlyJxqY4Utaur+iyN8PGJlTvLZe3j9RR/0tpOdJt6aAmKwFzGGBABfm10KWfuw0FN
         DAXg==
X-Forwarded-Encrypted: i=1; AKwUvBywNtlPxp5psoeCoX12agXXrlDWzb/nS8yAcqW8JxH+6r3khhWhp+9U4mQZM+IMJaw2W5iLeJi/lm2o@vger.kernel.org
X-Gm-Message-State: AFuF++m8JhHBCpDvcWZmYxDyfb+i3bF7H7KDs+dru3xmkhMAljIscnbQ
	Wj1EDob5z0hr9BQbo0TZ9wJYgzXG1rBiv9io9bhtAIVMT1g/85uhqmsl
X-Gm-Gg: AYBFou2vh9b2FmYw5w3n+dHpehQub5VB/rdmr+2kBSFGwLii8C+jcQqYmaR6WsfRrvD
	w+/HL2vgasgcFKI5un0ZNfdfRGGxJ86jq7Hc2qrmXfeAy1znw/Dgp//n6AEe6n3qnly9etEt+04
	fp7dGX2jYaCYtKXA/82irUvst6r9ncJromwp4JddgP1pKLBgmovwOtePLQvXNZul0/UuCCisBmQ
	hv4m2UAmP79hTfYwsFScUMDmjSuyXw0qq2n0+fWL9x/nzJMT5uuD6xYA1kWzDTYyLQxueodxxa3
	+bTxOZrHxVtF/vYDu68ltP32M6ALeMBSG1dPQDbsPTCMeQ3hz68Za+6Bqm4vsUo0uJPW1f+xIrd
	VgLd0s9IJF0ZAKF7nFu99a8tpwX+msmM+QnOZoRrHunYXDBzjD4DA3IQFnvfn1EdgRl62Gc3a/6
	v0Bzxx1mDNql8fFeZNBZy6hx6e5yukZooVGnoOoLc/ZfOkoXOlFYs3GuJTw98PY4D+vcdOwLWH0
	vtnitLuzRDdMUgo4x35w641fnDJY0myiGb7G+CoRGFIz22ZNA8=
X-Received: by 2002:a17:907:7b8a:b0:c29:3d59:706b with SMTP id a640c23a62f3a-c2ac5510506mr293618566b.44.1790282715500;
        Thu, 24 Sep 2026 13:45:15 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae77ff064sm12193666b.48.2026.09.24.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:45:15 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH] sparc32: capture SuperSPARC data store error state
Date: Thu, 24 Sep 2026 22:44:38 +0200
Message-ID: <20260924204503.870873-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SuperSPARC reports a failed buffered write with trap 0x2b. The store
has retired by then, while the processor disables the store buffer and
retains its entries for inspection.

MFSR is cleared when read. SAVE_ALL may spill a user window and read
MFSR while checking that spill, so capture MFAR and MFSR first. Keep
them in the trap window's output registers, which SAVE_ALL preserves.

Build pt_regs and set PSR.ET before entering C. The reporter can then
inspect the frozen store buffer and, when present, the MXCC registers
without running C or printk with traps disabled. Use the saved trap PSR
for CPU identification, then continue through the existing bad-trap path.

This is diagnostic support, not error recovery: the handler neither
retries the failed store nor re-enables the store buffer.

This follows SuperSPARC Family User's Manual sections 9.12.3.6, MFSR
Timing and Operation, 10.6.5, Data Store Errors, 10.7, Store Buffer
Diagnostic and Control Interfaces, 12.8.2, Data Store Error Trap,
16.5.4, MXCC Status Register, 16.5.6, MXCC MBus Port Register, and
16.8.4, MXCC Error Register.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
Applies and builds standalone on v7.3-rc1; cross-built with the SPARCstation
20 configuration, no new warnings.

sparc32 does not boot on current mainline without the prerequisite series
below, so this cannot be exercised on real hardware without them:

  sparc32: relocatable kernel / phys_base + Viking fixes
    https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t
  sparc32: replace sp_banks with memblock (v3)
    https://lore.kernel.org/sparclinux/20260901214611.60560-1-linmag7@gmail.com/
  sparc32: SuperSPARC SMP synchronization fixes (v2)
    https://lore.kernel.org/sparclinux/20260917075842.784996-1-linmag7@gmail.com/

This and "sparc32: emulate UDIV/SDIV on illegal_instruction" both insert
code immediately after do_hw_interrupt() in arch/sparc/kernel/traps_32.c.
They are independent, adjacent insertions, no shared functionality, but
whichever is applied second needs a trivial context rebase.

 arch/sparc/include/asm/mxcc.h   | 36 +++++++++++++++++++
 arch/sparc/include/asm/viking.h | 41 ++++++++++++++++++++++
 arch/sparc/kernel/entry.S       | 28 +++++++++++++++
 arch/sparc/kernel/entry.h       |  2 ++
 arch/sparc/kernel/traps_32.c    | 61 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/ttable_32.S   |  8 ++---
 6 files changed, 172 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/mxcc.h b/arch/sparc/include/asm/mxcc.h
index bd6339dcf693..bbfeab004e3e 100644
--- a/arch/sparc/include/asm/mxcc.h
+++ b/arch/sparc/include/asm/mxcc.h
@@ -126,6 +126,42 @@ static inline unsigned long mxcc_get_creg(void)
 	return mxcc_control;
 }
 
+static inline void mxcc_get_64bit_reg(unsigned long reg,
+				      unsigned long *high,
+				      unsigned long *low)
+{
+	unsigned long reg_high, reg_low;
+
+	__asm__ __volatile__("ldda [%2] %3, %%g2\n\t"
+			     "or %%g0, %%g2, %0\n\t"
+			     "or %%g0, %%g3, %1\n\t"
+			     : "=&r" (reg_high), "=&r" (reg_low)
+			     : "r" (reg), "i" (ASI_M_MXCC)
+			     : "g2", "g3");
+	*high = reg_high;
+	*low = reg_low;
+}
+
+static inline void mxcc_get_sreg(unsigned long *high, unsigned long *low)
+{
+	mxcc_get_64bit_reg(MXCC_SREG, high, low);
+}
+
+static inline void mxcc_get_ereg(unsigned long *high, unsigned long *low)
+{
+	mxcc_get_64bit_reg(MXCC_EREG, high, low);
+}
+
+static inline unsigned long mxcc_get_preg(void)
+{
+	unsigned long mxcc_port;
+
+	__asm__ __volatile__("lda [%1] %2, %0\n\t"
+			     : "=r" (mxcc_port)
+			     : "r" (MXCC_PREG), "i" (ASI_M_MXCC));
+	return mxcc_port;
+}
+
 static inline void mxcc_set_creg(unsigned long mxcc_control)
 {
 	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
diff --git a/arch/sparc/include/asm/viking.h b/arch/sparc/include/asm/viking.h
index bbb714de43c4..c6ee82fa1c82 100644
--- a/arch/sparc/include/asm/viking.h
+++ b/arch/sparc/include/asm/viking.h
@@ -98,6 +98,11 @@
 #define VIKING_TCENABLE     0x00010000   /* Enable table-walks to be cached */
 #define VIKING_DPENABLE     0x00040000   /* Enable the data prefetcher */
 
+#define ASI_M_VIKING_STOREBUF_TAG	0x30
+#define ASI_M_VIKING_STOREBUF_DATA	0x31
+#define ASI_M_VIKING_STOREBUF_CTRL	0x32
+#define VIKING_STOREBUF_ENTRIES		8
+
 /*
  * GNU/Viking Breakpoint Action Register fields.
  */
@@ -162,6 +167,42 @@ static inline unsigned long viking_get_bpreg(void)
 	return regval;
 }
 
+static inline unsigned long viking_get_storebuf_control(void)
+{
+	unsigned long control;
+
+	__asm__ __volatile__("lda [%%g0] %1, %0\n\t"
+			     : "=r" (control)
+			     : "i" (ASI_M_VIKING_STOREBUF_CTRL));
+	return control;
+}
+
+static inline void
+viking_get_storebuf_entry(unsigned int entry, unsigned long *tag_high,
+			  unsigned long *tag_low, unsigned long *data_high,
+			  unsigned long *data_low)
+{
+	unsigned long address = (entry & 7) << 3;
+	unsigned long th, tl, dh, dl;
+
+	__asm__ __volatile__("ldda [%4] %5, %%g2\n\t"
+			     "or %%g0, %%g2, %0\n\t"
+			     "or %%g0, %%g3, %1\n\t"
+			     "ldda [%4] %6, %%g2\n\t"
+			     "or %%g0, %%g2, %2\n\t"
+			     "or %%g0, %%g3, %3\n\t"
+			     : "=&r" (th), "=&r" (tl), "=&r" (dh),
+			       "=&r" (dl)
+			     : "r" (address),
+			       "i" (ASI_M_VIKING_STOREBUF_TAG),
+			       "i" (ASI_M_VIKING_STOREBUF_DATA)
+			     : "g2", "g3");
+	*tag_high = th;
+	*tag_low = tl;
+	*data_high = dh;
+	*data_low = dl;
+}
+
 static inline void viking_get_dcache_ptag(int set, int block,
 					      unsigned long *data)
 {
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..0f07ec9082e7 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -22,6 +22,7 @@
 #include <asm/psr.h>
 #include <asm/vaddrs.h>
 #include <asm/page.h>
+#include <asm/pgtsrmmu.h>
 #include <asm/winmacro.h>
 #include <asm/signal.h>
 #include <asm/obio.h>
@@ -205,6 +206,33 @@ bad_trap_handler:
 	 mov	%l7, %o1		! trap number
 
 	RESTORE_ALL
+
+	.align	4
+	.globl	data_store_error
+data_store_error:
+	/* SAVE_ALL preserves the trap window's output registers. */
+	mov	SRMMU_FAULT_ADDR, %l5
+	LEON_PI(lda	[%l5] ASI_LEON_MMUREGS, %o1)	! read MFAR first
+	SUN_PI_(lda	[%l5] ASI_M_MMUREGS, %o1)	! read MFAR first
+
+	mov	SRMMU_FAULT_STATUS, %l5
+	LEON_PI(lda	[%l5] ASI_LEON_MMUREGS, %o2)	! read MFSR last
+	SUN_PI_(lda	[%l5] ASI_M_MMUREGS, %o2)	! read MFSR last
+
+	SAVE_ALL
+
+	wr	%l0, PSR_ET, %psr
+	WRITE_PAUSE
+
+	add	%sp, STACKFRAME_SZ, %o0	! pt_regs
+	call	do_data_store_error
+	 nop
+
+	add	%sp, STACKFRAME_SZ, %o0	! pt_regs
+	call	do_hw_interrupt
+	 mov	0x2b, %o1
+
+	RESTORE_ALL
 	
 /* For now all IRQ's not registered get sent here. handler_irq() will
  * see if a routine is registered to handle this interrupt and if not
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index c746c0fd5d6b..b421705ab418 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -12,6 +12,8 @@ void handler_irq(int irq, struct pt_regs *regs);
 #ifdef CONFIG_SPARC32
 /* traps */
 void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
+void do_data_store_error(struct pt_regs *regs, unsigned long mfar,
+			 unsigned long mfsr);
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
                             unsigned long npc, unsigned long psr);
 
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index bb149f6cc34b..b0aa4974d9cc 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -25,6 +25,9 @@
 #include <asm/ptrace.h>
 #include <asm/oplib.h>
 #include <asm/page.h>
+#include <asm/mbus.h>
+#include <asm/mxcc.h>
+#include <asm/viking.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
 
@@ -105,6 +108,64 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 			       (void __user *)regs->pc, type - 0x80);
 }
 
+static bool cpu_is_viking(unsigned long psr, unsigned long mcr)
+{
+	unsigned int psr_impl = (psr >> 28) & 0xf;
+	unsigned int psr_vers = (psr >> 24) & 0xf;
+	unsigned int mcr_impl = (mcr >> 28) & 0xf;
+	unsigned int mcr_vers = (mcr >> 24) & 0xf;
+
+	return psr_impl == MBUS_VIKING &&
+	       (psr_vers == 0 ||
+		(psr_vers == 1 && mcr_impl == 0 && mcr_vers == 0));
+}
+
+void do_data_store_error(struct pt_regs *regs, unsigned long mfar,
+			 unsigned long mfsr)
+{
+	unsigned long tag_high[VIKING_STOREBUF_ENTRIES];
+	unsigned long tag_low[VIKING_STOREBUF_ENTRIES];
+	unsigned long data_high[VIKING_STOREBUF_ENTRIES];
+	unsigned long data_low[VIKING_STOREBUF_ENTRIES];
+	unsigned long mxcc_status_high = 0, mxcc_status_low = 0;
+	unsigned long mxcc_error_high = 0, mxcc_error_low = 0;
+	unsigned long mxcc_port = 0, storebuf_control;
+	unsigned long mcr = srmmu_get_mmureg();
+	unsigned long psr = regs->psr;
+	bool has_mxcc;
+	int i;
+
+	if (!cpu_is_viking(psr, mcr)) {
+		pr_emerg("Data Store Error: CPU%d PSR=%08lx MCR=%08lx MFAR=%08lx MFSR=%08lx\n",
+			 raw_smp_processor_id(), psr, mcr, mfar, mfsr);
+		return;
+	}
+
+	storebuf_control = viking_get_storebuf_control();
+	for (i = 0; i < VIKING_STOREBUF_ENTRIES; i++)
+		viking_get_storebuf_entry(i, &tag_high[i], &tag_low[i],
+					  &data_high[i], &data_low[i]);
+
+	has_mxcc = !(mcr & VIKING_MMODE);
+	if (has_mxcc) {
+		mxcc_get_sreg(&mxcc_status_high, &mxcc_status_low);
+		mxcc_get_ereg(&mxcc_error_high, &mxcc_error_low);
+		mxcc_port = mxcc_get_preg();
+	}
+
+	pr_emerg("Viking Data Store Error: CPU%d PSR=%08lx MCR=%08lx MFAR=%08lx MFSR=%08lx SBCTRL=%08lx\n",
+		 raw_smp_processor_id(), psr, mcr, mfar, mfsr,
+		 storebuf_control);
+	if (has_mxcc)
+		pr_emerg("MXCC: CCSR=%08lx:%08lx CCER=%08lx:%08lx PREG=%08lx\n",
+			 mxcc_status_high, mxcc_status_low,
+			 mxcc_error_high, mxcc_error_low, mxcc_port);
+
+	for (i = 0; i < VIKING_STOREBUF_ENTRIES; i++)
+		pr_emerg("Viking SB%d: TAG=%08lx:%08lx DATA=%08lx:%08lx\n",
+			 i, tag_high[i], tag_low[i], data_high[i], data_low[i]);
+}
+
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
diff --git a/arch/sparc/kernel/ttable_32.S b/arch/sparc/kernel/ttable_32.S
index e79fd786fbbb..ec6c885ddd33 100644
--- a/arch/sparc/kernel/ttable_32.S
+++ b/arch/sparc/kernel/ttable_32.S
@@ -56,7 +56,7 @@ t_bad26:BAD_TRAP(0x26) BAD_TRAP(0x27)
 t_cpexc:TRAP_ENTRY(0x28, do_cp_exception)   /* Co-Processor Exception        */
 t_dacce:SRMMU_DFAULT                        /* Data Access Error             */
 t_hwdz:	TRAP_ENTRY(0x2a, do_hw_divzero)     /* Division by zero, you lose... */
-t_dserr:BAD_TRAP(0x2b)                      /* Data Store Error              */
+t_dserr:TRAP_ENTRY(0x2b, data_store_error)  /* Data Store Error              */
 t_daccm:BAD_TRAP(0x2c)                      /* Data Access MMU-Miss          */
 t_bad2d:BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
 t_bad32:BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
@@ -158,7 +158,7 @@ trapbase_cpu1:
 	TRAP_ENTRY(0x28, do_cp_exception)
 	SRMMU_DFAULT
 	TRAP_ENTRY(0x2a, do_hw_divzero)
-	BAD_TRAP(0x2b)
+	TRAP_ENTRY(0x2b, data_store_error)
 	BAD_TRAP(0x2c)
 	BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
 	BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
@@ -257,7 +257,7 @@ trapbase_cpu2:
 	TRAP_ENTRY(0x28, do_cp_exception)
 	SRMMU_DFAULT
 	TRAP_ENTRY(0x2a, do_hw_divzero)
-	BAD_TRAP(0x2b)
+	TRAP_ENTRY(0x2b, data_store_error)
 	BAD_TRAP(0x2c)
 	BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
 	BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
@@ -357,7 +357,7 @@ trapbase_cpu3:
 	TRAP_ENTRY(0x28, do_cp_exception)
 	SRMMU_DFAULT
 	TRAP_ENTRY(0x2a, do_hw_divzero)
-	BAD_TRAP(0x2b) BAD_TRAP(0x2c)
+	TRAP_ENTRY(0x2b, data_store_error) BAD_TRAP(0x2c)
 	BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
 	BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
 	BAD_TRAP(0x37) BAD_TRAP(0x38) BAD_TRAP(0x39) BAD_TRAP(0x3a) BAD_TRAP(0x3b)

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

