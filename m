From: Douglas Anderson <dianders@chromium.org>
Date: Wed, 05 Dec 2018 03:38:24 +0000
Subject: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
Message-Id: <20181205033828.6156-1-dianders@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org, Huang Ying <ying.huang@intel.com>, linux-mips@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Repost of v6 adds CC's and also tags already received.

Changes in v6:
- Moved smp_call_function_single_async() error check to patch 3.

Changes in v5:
- Add a comment about get_irq_regs().
- get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
- for_each_cpu() => for_each_online_cpu()
- Error check smp_call_function_single_async()

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

 arch/arc/kernel/kgdb.c          | 10 +----
 arch/arm/kernel/kgdb.c          | 12 ------
 arch/arm64/kernel/kgdb.c        | 12 ------
 arch/hexagon/kernel/kgdb.c      | 32 ----------------
 arch/mips/kernel/kgdb.c         |  9 +----
 arch/powerpc/kernel/kgdb.c      |  6 +--
 arch/sh/kernel/kgdb.c           | 12 ------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 +----
 include/linux/kgdb.h            | 22 +++++++----
 kernel/debug/debug_core.c       | 65 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 +++++-
 kernel/debug/kdb/kdb_debugger.c |  7 ----
 14 files changed, 98 insertions(+), 112 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog
