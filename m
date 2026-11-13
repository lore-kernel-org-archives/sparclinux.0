Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580879;
	b=DqSC531VJg+VGTO+8A7WHM6AHO4NYV39+xcRfCAhFtqLtD/jFUOzibresxVHqLwe3AFH
	 GY2kabrPBfRqROlqnSijcaLGKQkabTYBmQz5BdiFwJ/6jgrmsyOIKui5kl+yApwSMCS2e
	 FrcDTh6N0aF+0mWl/+KEDHgcyTt2RBnPrTydaO79aI5c0T4IKL8T1ah/ludEHOMnmMy7+
	 HD3BiqfWXlOV9caAvPx7BVSweGmajiOVN3sxTeR260Ka1mtiH4uYPQ9sdtK66eiseB7TL
	 qT0rRPjXRI3IttGOfqjNaOBuaX9HqaUS3gmLIB7lwvBK080qrL0BDvtNRdWd6eh8Fnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580879;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YkNWVwW1/XPiB+NZFpQOG8PrZ8FpJ1mKSzeBpPs45Oo=;
	b=WkjObR1Q5KoWRJMeVm2vGDG7hRSNppVc0F9hp+cbLGGDEA8xOj76bPGOtGPFJivAw4rM
	 50gI1rhMINjpQuh+HOGiuw8mj4I+NPN6dLP+oq8d5C/F9QO+F7lJ19SGnAksHCwBT6Drr
	 Dj3VRckUY6rvMi+JW9fz/XOElDeU6X1Z8U+QLdjRkopY6AiDivHBJsT/vObzM/u4YMxdi
	 Rf4yMbB0WTeaa9/mPRcTOAvNaW2fFB8ipLXpAy2zuuFTMLopvy3qKw7ZLQu5ojmfnE0V6
	 bxyff/gQMl3yOEPsITPijvAnqwnsFyns0kMpGJ294RECh/lzeQFvO8/fCvGJ3vYvJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=da2O+VHs;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0B606A332;
	Fri, 13 Nov 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC0B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=da2O+VHs
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794580876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YkNWVwW1/XPiB+NZFpQOG8PrZ8FpJ1mKSzeBpPs45Oo=;
	b=da2O+VHsg9+fNSNXZT9aSQJrhsPjjYADDsebMcpXTv0UMeXsOaHujEu/FV7+2QzDYe5sTv
	bAQJ8ywirLL1+JyOkGpCWtHN60L1M1cc0gBSDI8JxBPfu16ABppI266YPZZmouQwSNnypS
	qVjVZfGwIKxBALRCSRxQnOjMchkoVqs=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 0/4] sparc64: kprobes: Make kprobes work on sun4v
Date: Fri, 13 Nov 2026 15:40:53 +0100
Message-ID: <20261113144057.1697874-1-stian@itx.no>
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

Any kprobe hit on a sun4v machine oopses. The probed instruction is
single-stepped from memory that is not executable there. Patch 1
moves the copy into an instruction slot from get_insn_slot(), as other
architectures do.

Once probes work, three older single-step bugs show up. A taken BPr or
FP branch resumes at the wrong address (patch 2). So does a probe on a
delay slot instruction (patch 3). An annulled branch can skip the
break instruction after the copy (patch 4). Patch 2 overlaps Danish
Khateeb's relbranch_fixup() fix from September. Whichever is applied
first, the other is a small rebase.

Tested on a SPARC T7-1 and T4-1 (sun4v) and a Sun Fire V240 (sun4u):
entry and return probes, probes on all 50 instructions of
__task_pid_nr_ns at once while checking getppid(), ps and /proc, probes
on the SPARC AES routines during AF_ALG encryption (sun4v), and
refusal of ba,a. Without the series the first probe hit oopses on
sun4v. A probe on a taken brnz oopses on sun4u as well.

v2: make flush_insn_slot() a no-op in patch 1 (Masami). The slot is
flushed in arch_prepare_kprobe() when it is written. A killed probe
has a NULL slot pointer. init_aggr_kprobe() flushed through it.
Patch 4 no longer touches the macro. Rebased onto 7.4-rc3. Build
tested on the T7-1.
v1: https://lore.kernel.org/all/20261009180336.1315684-1-stian@itx.no/

Stian Halseth (4):
  sparc64: kprobes: Single-step from an executable instruction slot
  sparc64: kprobes: Fix up register and FP branches after single-step
  sparc64: kprobes: Resume after a delay slot at the saved next PC
  sparc64: kprobes: Handle annulled branches

 arch/sparc/include/asm/kprobes.h | 14 +++----
 arch/sparc/kernel/kprobes.c      | 69 +++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 17 deletions(-)


base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.43.0

