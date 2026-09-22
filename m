Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB547F787;
	Tue, 22 Sep 2026 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108138; cv=none; b=qZRJX8h1/UqNoPymktLT4G8oqn/njaiFklhLbIKztgfr8Lw3unNft4EpFbZFtcSW3rZ29aCHR/tMK/cMyF1OfsAsYkKyeJLwlS0gtR6E2EfRuLMpLzC29/IwSSRYQ60kmG3I21pn+XegB99TACTb6nkJMPbSZLCB114jOELEfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108138; c=relaxed/simple;
	bh=NLI0n+prMzRh+tfAyXqEWiVCATVhAudCFhUKu5BcrxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhffQYL5/sk7FuN4LtOm8YwmR2wSdtFPkAJvl1kdJCij3QYymgtq1naiKyJfQlE5NqDU7mDQTXTDllo+pkcd6cuYcmzmFbihCn51vCW6yZPc9qEGK+f35b9QdeMOc/V/Rf1b+zUqj2r+9ekMxtRBU0y4w+KMUna4+/C6XIg3Inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=FXbCCn7E; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="FXbCCn7E"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790108129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGM3Svgttye+yoHj2CHDj+6iSFEIryi89MVZNx+shC0=;
	b=FXbCCn7E0r5Qt+AuMm8+PZMDE0zSBWLYBMIDQOzgbzIQF4z06H9pg1NH/RExLyQeo9JAbw
	z5Ei39bw3TzIZFIJ5/Ho8+9o1rimfOLMwjDSG6ifzJrG81cv/lMNRWDQ0TA0Px0w4EUYJb
	pqBW/yuOvOgd43mhGdHznJX/03WzzMI=
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
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-perf-users@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [RFC PATCH v2 0/3] perf: sparc64 user regs and stack dump, with an arch hook
Date: Tue, 22 Sep 2026 22:15:04 +0200
Message-ID: <20260922201507.1719668-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP to sparc64, so
that perf record --call-graph dwarf and elfutils' eu-stackprof work
there.

One piece does not fit in arch code. The user stack dump copies the
stack as it is in memory and assumes the call chain is there. On sparc
it may not be: the sampled register window's %l/%i registers, which
hold the frame pointer and return address the unwinder starts from
(the CFI after `save` defines the CFA in terms of %i6), stay in the
register file until a window spills. The kernel already deals with
this wherever it exposes user stack memory: perf_callchain_user() on
sparc calls flushw_user() before walking the chain, and ptrace does
the same. The stack dump has no arch entry point where that could
happen, and I found no correct sparc-only place:

- flushing in the sparc PMU interrupt handler misses software events
  (cpu-clock, tracepoints), which reach perf_event_overflow() without
  passing through it;
- perf_user_stack_pointer() is private to kernel/events/internal.h;
- perf_reg_abi() is called at the right time but is a query, and a
  flush as a side effect of it would be wrong.

Patch 1 therefore adds a no-op hook in the style of
perf_arch_misc_flags(), perf_arch_prepare_ustack(), called from
perf_prepare_sample() when PERF_SAMPLE_STACK_USER is requested and
user regs exist. Patch 2 is the sparc64 implementation and its user.
Patch 3 teaches tools/perf the sparc registers and DWARF unwinding
from the dump. The matching elfutils changes, which make eu-stackprof
work, are attached to the tracking issue as patches against current
elfutils main:

  https://github.com/sparclinux/issues/issues/99

Tested on an UltraSPARC T4-1 on 7.3-rc4: register values check out
against known contents, --call-graph dwarf unwinds correctly for both
cycles and cpu-clock, eu-stackprof unwinds the same chains, and perf
stat/record/record -g are unchanged.

Changes since v1:
- Patch 2: truncate a 32-bit task's values only for user_mode(regs),
  so kernel-mode PERF_SAMPLE_REGS_INTR registers stay intact
  (sashiko review).
- Patch 2: document that the stack dump starts at the biased %sp.
- Patch 2: mark sparc ok in Documentation/features for perf-regs and
  perf-stackdump (Magnus).
- Patch 3 (tools/perf) added (Magnus).

v1: https://lore.kernel.org/all/20260922135653.1622301-1-stian@itx.no/

Stian Halseth (3):
  perf/core: Let an arch prepare the user stack before it is dumped
  sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
  perf tools: Support sparc user register samples and dwarf unwinding

 .../features/perf/perf-regs/arch-support.txt  |  2 +-
 .../perf/perf-stackdump/arch-support.txt      |  2 +-
 arch/sparc/Kconfig                            |  2 +
 arch/sparc/include/asm/perf_event.h           |  3 +
 arch/sparc/include/uapi/asm/perf_regs.h       | 33 +++++++++
 arch/sparc/kernel/Makefile                    |  2 +-
 arch/sparc/kernel/perf_regs.c                 | 65 +++++++++++++++++
 include/linux/perf_event.h                    |  7 ++
 kernel/events/core.c                          |  2 +
 tools/arch/sparc/include/uapi/asm/perf_regs.h | 33 +++++++++
 tools/perf/arch/sparc/include/perf_regs.h     | 18 +++++
 tools/perf/check-headers.sh                   |  1 +
 tools/perf/util/dwarf-regs-arch/Build         |  1 +
 .../util/dwarf-regs-arch/dwarf-regs-sparc.c   | 12 ++++
 tools/perf/util/dwarf-regs.c                  |  4 ++
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/perf-regs-arch/Build          |  1 +
 .../util/perf-regs-arch/perf_regs_sparc.c     | 69 +++++++++++++++++++
 tools/perf/util/perf_regs.c                   | 18 +++++
 tools/perf/util/perf_regs.h                   |  5 ++
 tools/perf/util/unwind-libdw.c                | 41 ++++++++++-
 21 files changed, 318 insertions(+), 4 deletions(-)
 create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/sparc/kernel/perf_regs.c
 create mode 100644 tools/arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/sparc/include/perf_regs.h
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_sparc.c

-- 
2.55.0

