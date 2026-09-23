Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31347AF4D;
	Wed, 23 Sep 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154291; cv=none; b=UECOBq1bPJ5V4bE6o4En1oVpF3aARCQ1nQ7T33Mr9+YWVqF1NuHxhJchiXFKq6ZQiqpPq2c9Igq5op/z31upeNDOETMGlUBWJ30jogKLKXbQgGBbbUAJQzdlBS+625aVi419IoJnhAEumObPe8QcRiwMa9fFV+VZmvyIE7JKUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154291; c=relaxed/simple;
	bh=BoKdU6V4qS1XlHWnqOcsmrIYtIAntN8UxmKVo12ZFkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2WzH2N5xRW1MGy0t7MqsSyd1efkR0YfXXuBa3VVpd0r4/8BnQDZUHraZRkSUslcPk/GYroN69b0LwiR47VFIBAf+Jvl0QswfQi55dr4VUSm2cFNbGqqgXjYNaK/CUUX5nigFpOv2OIQOdfnl/LUQNzbE9pvRQzSp9/U8Qy4d/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Ox/iyk8F; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Ox/iyk8F"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790154287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rz03Q3LYDjGNSXr9NJduP1jiMxDggB9Dj53CnCIRM7Q=;
	b=Ox/iyk8F9mxpglGbhQx5tk3txQv8TiC7afGUqJxyol8/3sqn9hL3kU7AERsjQHUU87+Hrf
	eHHzT/Pz+Bc08y4di5+10jrHgOm51Ib/TIOquMOmkkCmeonc6xOM3M2U4MVB7NumaXWGFz
	YHj/PiT/HII/FSURrdO+DFdJ8jS5TVE=
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
Subject: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with arch hooks
Date: Wed, 23 Sep 2026 11:04:25 +0200
Message-ID: <20260923090429.2026529-1-stian@itx.no>
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

Two things about the user stack dump do not fit in arch code. The
sampled register window's %l/%i registers, which hold the frame pointer
and return address the unwinder starts from, stay in the register file
until a window spills. The kernel already flushes them wherever it
exposes user stack memory (perf_callchain_user(), ptrace), but the stack
dump has no arch entry point where that could happen. And a 64-bit
sparc stack pointer is biased by 2047, so a dump that starts at the
register value begins 2047 bytes below the frame, and is empty when that
page has never been touched.

Patch 1 therefore adds two hooks in the style of perf_arch_misc_flags(),
both no-ops by default. Patch 2 is the sparc64 implementation and their
user. Patch 3 teaches tools/perf the sparc registers and DWARF unwinding
from the dump. The matching elfutils changes are attached to the
tracking issue:

  https://github.com/sparclinux/issues/issues/99

Tested on an UltraSPARC T4-1 on 7.3-rc4: register values check out
against known contents, --call-graph dwarf unwinds correctly for both
cycles and cpu-clock, as does eu-stackprof, and perf stat/record/record
-g are unchanged. Starting the dump at the stack's actual address
matters in practice: with the dump at the biased register value, 94% of
the user samples of xz -T4 had an empty stack dump; with this series,
none do.

Changes since v2:
- Patch 1: add perf_arch_user_stack_pointer(), so an arch can start the
  dump at the stack's actual address (sashiko review).
- Patch 2: drop %g0 from the uapi, as trap entry does not save it; the
  PC takes its slot, as on mips and loongarch (sashiko review).
- Patch 2: start the dump at %sp + 2047 for a 64-bit stack (sashiko
  review).
- Patch 3: follow both, and comment the max_dwarf_reg adjustment (Ian).
  Drop the memcpy() change to memory_read(), which the unbiased dump
  start makes unnecessary.

v2: https://lore.kernel.org/all/20260922201507.1719668-1-stian@itx.no/
v1: https://lore.kernel.org/all/20260922135653.1622301-1-stian@itx.no/

Stian Halseth (3):
  perf/core: Let an arch prepare and locate the user stack dump
  sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
  perf tools: Support sparc user register samples and dwarf unwinding

 .../features/perf/perf-regs/arch-support.txt  |  2 +-
 .../perf/perf-stackdump/arch-support.txt      |  2 +-
 arch/sparc/Kconfig                            |  2 +
 arch/sparc/include/asm/perf_event.h           |  5 ++
 arch/sparc/include/uapi/asm/perf_regs.h       | 34 +++++++++
 arch/sparc/kernel/Makefile                    |  2 +-
 arch/sparc/kernel/perf_regs.c                 | 74 +++++++++++++++++++
 include/linux/perf_event.h                    | 11 +++
 kernel/events/core.c                          |  2 +
 kernel/events/internal.h                      |  2 +-
 tools/arch/sparc/include/uapi/asm/perf_regs.h | 34 +++++++++
 tools/perf/arch/sparc/include/perf_regs.h     | 18 +++++
 tools/perf/check-headers.sh                   |  1 +
 tools/perf/util/dwarf-regs-arch/Build         |  1 +
 .../util/dwarf-regs-arch/dwarf-regs-sparc.c   | 12 +++
 tools/perf/util/dwarf-regs.c                  |  4 +
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/perf-regs-arch/Build          |  1 +
 .../util/perf-regs-arch/perf_regs_sparc.c     | 67 +++++++++++++++++
 tools/perf/util/perf_regs.c                   | 18 +++++
 tools/perf/util/perf_regs.h                   |  5 ++
 tools/perf/util/unwind-libdw.c                | 37 ++++++++++
 22 files changed, 331 insertions(+), 4 deletions(-)
 create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/sparc/kernel/perf_regs.c
 create mode 100644 tools/arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/sparc/include/perf_regs.h
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_sparc.c

-- 
2.55.0

