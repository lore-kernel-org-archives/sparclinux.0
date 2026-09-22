Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0871E33F8A6;
	Tue, 22 Sep 2026 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085442; cv=none; b=qAmHzLJPq9NfCkv5IGYfz2Dr20TjOzuKqBm5SaLJc7zFnCI1zHm6n8uRhZ3yVlMd63x8BEKCMH/3pJ6Z6oSDEneDNPsu4Ef2szS5m4FUU0n9zeam+7zqQaOjyeGq3ON4UilZTZgfe64VmlDtJOMiJD1E/cJez+Cy07vSchCAQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085442; c=relaxed/simple;
	bh=JRkVcFJx9uOc1Hon8yrh8Nji+MYY69yyyqffNjsZ1RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPqgCHuw032sVtLXjArUMWhhrF7eHsaskxJ3whQWPqMA4cBkAbd1jgE79MHAQs5GX3o+o2lQNRFab3k2akK4cZwZEvzOWKy3uGYE4bYCCSYK/zZ2fHC1mNGTLOgN4Su9NkCuKnD0X3+mFcpRNBoV9hzB01E9yS4d7uBoNS53aSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=kYRDlbL0; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="kYRDlbL0"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790085432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GuPHvJTYZvTdgKz9vIDG9FGLeh87f+u1FBmVEw6sV1U=;
	b=kYRDlbL0rQ5AWtliQ6LRO+tlzzMK5rgkvTByVgvgKJXkupkUQrNplNLNQQmdubFUlVlfl+
	Ldtiz/ds3XukZrqPwOHvxbrUzpdTd2w9tC2O2Rx9ZqoczMhEWdKZbPeVrko/JgGW1SWHo3
	Sz0mM9oMFGB9EIPmNRCjJLALOWD1x/s=
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [RFC PATCH 0/2] perf: user stack dump on sparc64 needs an arch hook
Date: Tue, 22 Sep 2026 15:56:51 +0200
Message-ID: <20260922135653.1622301-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am adding HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP to sparc64, so
that perf record --call-graph dwarf and elfutils' eu-stackprof work
there. The sparc side (patch 2) is straightforward and follows parisc.
One thing does not fit in arch code, and I would like to get the shape
of that agreed before sending the rest.

The user stack dump copies the stack as it is in memory and assumes the
call chain is there. On sparc it may not be: the sampled register
window's %l/%i registers, which hold the frame pointer and return
address the unwinder starts from (the CFI after `save` defines the CFA
in terms of %i6), stay in the register file until a window spills. The
kernel already deals with this wherever it exposes user stack memory:
perf_callchain_user() on sparc calls flushw_user() before walking the
chain, and ptrace does the same. The stack dump has no arch entry
point where that could happen.

I looked for a sparc-only way and did not find a correct one:

- flushing in the sparc PMU interrupt handler misses software events
  (cpu-clock, tracepoints), which reach perf_event_overflow() without
  passing through it;
- perf_user_stack_pointer() is private to kernel/events/internal.h, so
  the arch cannot override it;
- perf_reg_abi() is called at the right time but is a query, and a
  flush as a side effect of it would be wrong.

So patch 1 adds a no-op hook in the style of perf_arch_misc_flags():
perf_arch_prepare_ustack(), called from perf_prepare_sample() when
PERF_SAMPLE_STACK_USER is requested and user regs exist. Patch 2 is the
sparc64 implementation and its user. Happy to take a different name or
placement.

Tested on an UltraSPARC T4-1 on 7.3-rc4 with a perf tool taught the
sparc registers (that patch, and the matching elfutils backend, follow
once the hook is settled): register values check out against known
contents, and --call-graph dwarf unwinds correctly for both cycles and
cpu-clock. perf stat/record/record -g are unchanged.

Link: https://github.com/sparclinux/issues/issues/99

Stian Halseth (2):
  perf/core: Let an arch prepare the user stack before it is dumped
  sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER

 arch/sparc/Kconfig                      |  2 +
 arch/sparc/include/asm/perf_event.h     |  3 ++
 arch/sparc/include/uapi/asm/perf_regs.h | 33 +++++++++++++
 arch/sparc/kernel/Makefile              |  2 +-
 arch/sparc/kernel/perf_regs.c           | 65 +++++++++++++++++++++++++
 include/linux/perf_event.h              |  7 +++
 kernel/events/core.c                    |  2 +
 7 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/sparc/kernel/perf_regs.c

--
2.55.0
