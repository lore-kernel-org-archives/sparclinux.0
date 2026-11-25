Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599905;
	b=Ctl8ZCtj2hqk0b2t+kI/J2cE+SyxKPMo2r1uVBQ5ybRjh9gsrekn/lJ5wzkMCrtJt0Fv
	 GKqf0gAtGtg2XU9sQVypoaRG7bhlrZqdQnMJyee98lx63ztY+Gy+iKlbaQ6/O593KlxWb
	 OD/MnFn/+9u5z3Q0zxBkOOjQz+p3veVVI+pUWnvMpTHdZY0arLUumzyL5DEVzZH2NQ6Bi
	 BwGy88UAr2mBlcBXfW7WYVk3b1oZJrlidXkdAP/psTfaGcJSq+xgxEj3R9I96pvbg3BLx
	 TAaMz+m4IMr1h+3pt6PkUVLU2OVBJp2g8nEFaD6UfZr/SvKnU97XGBUQgJFpj7Wc1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599905;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jQf7if7ETsV0Wdj27IdrX22LoOYAHB7sIbcIgGIcj2k=;
	b=oJ6HwGF30DTg35wddeKJM9JC9C4/sAMAg/U6h6hcnjjDWF/jfxMfDwChei0Iq9rLJXDq
	 pj+UCp7J3Nrt40Ep4U5L0hcIgUMOMMkSzap5PIEN4iPhfcl5LRf6tjodn9fuFMrCXWWX0
	 knvxWBDMsNhbcqyiRmamFeVRMacwvH1IprobFagDPWDQmu9GHPkt4B+//5YOcbcviOg/1
	 ErxsuuQERfjFM5RJAsOuZjeho8wIn54zdP4vZzWZZhA/oYjoVZxHlhtwVpDc5g685iiQ9
	 ZirBZ1djnmyfFQVY6tjFdnzmC/j57h2Yb2h5T3F6tyXktVrkxMSX0sgp0eHi1n3nIyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=RYeuYohQ;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AF606A327;
	Wed, 25 Nov 2026 09:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094AF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=RYeuYohQ
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1795599897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jQf7if7ETsV0Wdj27IdrX22LoOYAHB7sIbcIgGIcj2k=;
	b=RYeuYohQEvZP4DPUZ8pm32FSeoTMoHKyw3j2gGZId7H8NAfGIHVBiDijK4JqTzxsq9GP57
	pxlXBWnYhYspMtnuTKM213UwM/NI0zv22F71d1Pvu0PXFv5bTGGUGIBBzlLo3yoaQe1fB7
	QXljHtLjxwuXei9Vx8qae7QmMy1w1WA=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] sparc64: Report the fault address when a user window cannot be saved
Date: Wed, 25 Nov 2026 10:44:46 +0100
Message-ID: <20261125094446.537502-1-stian@itx.no>
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

When the kernel spills a user register window and the store faults,
the window is kept in the thread's window buffer. On the way back to
user space fault_in_user_windows() writes it to the stack. If that
write fails as well, it sends SIGSEGV with force_sig(). The handler
gets SI_KERNEL and si_addr == 0.

When a thread overflows its stack, the first store into the guard page
can be a window spill. If the kernel does that spill, for example
during a system call, the window goes through this path. Stack
overflow handlers compare si_addr with the guard page. With
si_addr == 0 they cannot tell that the stack overflowed. The Rust
runtime then resets the handler, and the process dies with SIGSEGV
instead of reporting the overflow. Rust's
tests/ui/runtime/out-of-stack.rs fails this way:

  ferris[157185]: bad register window fault: SP fff800010f60bf90 (orig_sp fff800010f60b791) TPC fff800010f3a2db0 O7 00000100016039e4

Pass the address of the window to the signal, as stack_unaligned()
does for SIGBUS in the same file. Look up the VMA to choose the
si_code, as process_fpemu_return() does on MIPS. A spill into a
PROT_NONE guard page then reports SEGV_ACCERR, whether the hardware or
the kernel did the spill.

Closes: https://github.com/sparclinux/issues/issues/132
Signed-off-by: Stian Halseth <stian@itx.no>
---
Tested on a T4-1 (sun4v) and a V240 (sun4u) with 7.3.6. A thread
recurses and writes to a pipe at every level, so the kernel spills its
windows. Before, the handler got si_code 128 and si_addr 0. After, it
gets the window address and the same si_code as a spill by the
hardware: SEGV_ACCERR for a PROT_NONE guard, SEGV_MAPERR for an
unmapped hole. out-of-stack.rs passes 10/10 on the T4. A handler that
makes the guard writable and returns also works: the thread continues
and every frame unwinds with the right values.

 arch/sparc/kernel/process_64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index e889da8..dedce75 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -518,6 +518,8 @@ void fault_in_user_windows(struct pt_regs *regs)
 {
 	struct thread_info *t = current_thread_info();
 	unsigned long window;
+	unsigned long sp;
+	int si_code;
 
 	flush_user_windows();
 	window = get_thread_wsaved();
@@ -527,7 +529,7 @@ void fault_in_user_windows(struct pt_regs *regs)
 		do {
 			struct reg_window *rwin = &t->reg_window[window];
 			int winsize = sizeof(struct reg_window);
-			unsigned long sp, orig_sp;
+			unsigned long orig_sp;
 
 			orig_sp = sp = t->rwbuf_stkptrs[window];
 
@@ -557,7 +559,13 @@ void fault_in_user_windows(struct pt_regs *regs)
 
 barf:
 	set_thread_wsaved(window + 1);
-	force_sig(SIGSEGV);
+	mmap_read_lock(current->mm);
+	if (vma_lookup(current->mm, sp))
+		si_code = SEGV_ACCERR;
+	else
+		si_code = SEGV_MAPERR;
+	mmap_read_unlock(current->mm);
+	force_sig_fault(SIGSEGV, si_code, (void __user *) sp);
 }
 
 /* Copy a Sparc thread.  The fork() return value conventions
-- 
2.43.0

