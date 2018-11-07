From: Douglas Anderson <dianders@chromium.org>
Date: Wed, 07 Nov 2018 01:00:24 +0000
Subject: [PATCH v3 0/4] kgdb: Fix kgdb_roundup_cpus()
Message-Id: <20181107010028.184543-1-dianders@chromium.org>
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

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Patch #3 and #4 are new.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c     | 10 ++-----
 arch/arm/kernel/kgdb.c     | 12 ---------
 arch/arm64/kernel/kgdb.c   | 12 ---------
 arch/hexagon/kernel/kgdb.c | 32 ----------------------
 arch/mips/kernel/kgdb.c    |  9 +------
 arch/powerpc/kernel/kgdb.c |  6 ++---
 arch/sh/kernel/kgdb.c      | 12 ---------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-----
 include/linux/kgdb.h       | 22 +++++++++------
 kernel/debug/debug_core.c  | 55 +++++++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h  |  1 +
 kernel/debug/kdb/kdb_bt.c  | 11 +++++++-
 13 files changed, 88 insertions(+), 105 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
