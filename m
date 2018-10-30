From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 30 Oct 2018 22:18:41 +0000
Subject: [PATCH v2 0/2] kgdb: Fix kgdb_roundup_cpus()
Message-Id: <20181030221843.121254-1-dianders@chromium.org>
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

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (2):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 ------------
 arch/arm64/kernel/kgdb.c   | 12 ------------
 arch/hexagon/kernel/kgdb.c | 32 --------------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  6 +++---
 arch/sh/kernel/kgdb.c      | 12 ------------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-------
 include/linux/kgdb.h       | 22 ++++++++++++++--------
 kernel/debug/debug_core.c  | 38 +++++++++++++++++++++++++++++++++++++-
 11 files changed, 60 insertions(+), 104 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog
