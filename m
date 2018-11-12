From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 12 Nov 2018 18:26:54 +0000
Subject: [PATCH v4 0/4] kgdb: Fix kgdb_roundup_cpus()
Message-Id: <20181112182659.245726-1-dianders@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v4:
- Removed smp_mb() calls.
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Don't round up a CPU that failed rounding up before new for v3.
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c          | 10 ++----
 arch/arm/kernel/kgdb.c          | 12 -------
 arch/arm64/kernel/kgdb.c        | 12 -------
 arch/hexagon/kernel/kgdb.c      | 32 -------------------
 arch/mips/kernel/kgdb.c         |  9 +-----
 arch/powerpc/kernel/kgdb.c      |  6 ++--
 arch/sh/kernel/kgdb.c           | 12 -------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 ++----
 include/linux/kgdb.h            | 22 ++++++++-----
 kernel/debug/debug_core.c       | 56 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -----
 14 files changed, 89 insertions(+), 112 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
