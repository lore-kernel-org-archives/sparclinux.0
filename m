Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DC421234;
	Wed,  7 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363253; cv=none; b=lO7saQmydb+mwqtjhgQh9YwJ9mxl9czlpEPnn3KmsV2UDdvkyh6axPU3vBpjC6SEBwDeRn/EobSswoZss0SMonEdtkxJyEc0zERs4Pkgg0hQZiyKAMCMIyspjjAfj7zsW9tA0grJR8cu4d2ah4teJOkri1ZsJ5TGdXNJnrA2DFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363253; c=relaxed/simple;
	bh=3ShNl2lMu1cmq20FgjMQHVbcTfnOO76ge4bOi1UA09I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAvUPJI5hAcGwOk6tgWB5mlo83yqSe4h9Kt3cxbeq1cwR0uAhk+cyvz0MuIs+qS/29LFvEymffZcYUG3LcKQjoyIDznor7azA7ojG8/6wH0s7rgKGa3VaTNBFRtHekYf1wfap3FShzKkAHuxGrbfHjDiySfxikzuiEq8Cz0n4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=A/9ZBDLl; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="A/9ZBDLl"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791363242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=84hpmUIjn+sU9RD/ARErhaz9x/FcagOmgq7UoC0RwqU=;
	b=A/9ZBDLlYtDr3vhyGCqcz4QOgxPr9IqwwaVmk+v/FpVBqftMyHqHa3x0Tt1/zD9sOnCxAZ
	dXO2xVUv+e9CiqIzhQkiEF1kKX4p2SgHLBFes6qOLsaWYoLvtO2x/nMtJFA8Vv8zKkg9PE
	jBWBc7IhllRNi6fqefM8h5N1gPr28ys=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 0/3] sparc64: fix a window fill fixup lockup and two fault bugs
Date: Wed,  7 Oct 2026 10:53:44 +0200
Message-ID: <20261007085347.256789-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A register window fill that faults is mishandled in three ways on
sparc64.  The first wedges the CPU in kernel mode and takes the machine
with it; the other two corrupt what the kernel reports about the fault,
and were found while chasing the first.

1/3 is the lockup.  user_rtt_fill_fixup_common() re-enters the kernel
without passing through etrap, so %asi is left as the ASI_AIUP that
rtrap set for the fill while the primary context has been restored to
the kernel's.  Every subsequent %asi-based user access then translates
in the kernel context, and a user address below the VA hole can never be
resolved: the fault repeats forever, the task survives SIGKILL, and RCU
eventually reports the CPU stalled.

The reproducer in the v1 cover letter moves %sp onto a page, flushes the
register windows, mprotects that page PROT_NONE and takes a signal, so
the fill on the signal return path faults.  It needs no unusual
configuration and wedges a stock kernel in a few seconds; mind where you
run it, as the machine needs a hard reset afterwards.  On a fixed kernel
it prints PASS and exits.

2/3 and 3/3 came out of that investigation.  do_fault_siginfo() decodes
the instruction at regs->tpc to compute si_addr, which is not the
faulting access when the fault came from a spill or fill; in one capture
it decoded a branch and reported the contents of %g5.  And the huge-page
path in the TSB miss handler tested TL after switching the global
register bank, so it consumed a fault code and a PTE that no longer
existed and killed the task with SIGSEGV at an address that had never
been mapped.  That one needs CONFIG_TRANSPARENT_HUGEPAGE and only
appears under load.

1/3 is reproduced and fixed on an UltraSPARC T4-1 (sun4v, Niagara4) and
on a Sun Fire V240 (sun4u, UltraSPARC-IIIi), which between them cover
both forms of the global register bank switch, SET_GL and the
PSTATE_AG|PSTATE_MG write.  2/3 and 3/3 are tested on the T4-1, where
with all three applied a Go toolchain build now completes five times
running with THP enabled, having previously died within a minute.

Link: https://github.com/sparclinux/issues/issues/87

v2:
  - 1/3: reword the comment above the %asi write as suggested by
    Andreas: state the restored invariant first, phrase it as why the
    write is needed, and leave the failure-mode details to the commit
    message.  No code change.
  - 2/3, 3/3: unchanged.

v1: https://lore.kernel.org/all/20260828123707.1852437-1-stian@itx.no/

Stian Halseth (3):
  sparc64: restore %asi in user_rtt_fill_fixup_common
  sparc64: use the fault address for si_addr on window fixup faults
  sparc64: decide the TSB huge-page window fixup before the bank switch

 arch/sparc/kernel/tsb.S       | 24 ++++++++++++++++++++----
 arch/sparc/kernel/urtt_fill.S | 10 ++++++++++
 arch/sparc/mm/fault_64.c      |  9 +++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.43.0

