From: David Miller <davem@davemloft.net>
Date: Wed, 17 Oct 2012 05:05:24 +0000
Subject: [GIT] Sparc
Message-Id: <20121017.010524.778858011941892565.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two sparc64 perf bug fixes and add a sysrq facility so I can diagnose
these kinds of problems more quickly in the future.

Please pull, thanks a lot.

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to e793d8c6740f8fe704fa216e95685f4d92c4c4b9:

  sparc64: Fix bit twiddling in sparc_pmu_enable_event(). (2012-10-16 13:05:25 -0700)

----------------------------------------------------------------
David S. Miller (3):
      sparc64: Like x86 we should check current->mm during perf backtrace generation.
      sparc64: Add global PMU register dumping via sysrq.
      sparc64: Fix bit twiddling in sparc_pmu_enable_event().

 Documentation/sysrq.txt         |   1 +
 arch/sparc/include/asm/ptrace.h |  13 +++++++-
 arch/sparc/include/asm/smp_64.h |   2 ++
 arch/sparc/kernel/perf_event.c  |  15 +++++----
 arch/sparc/kernel/process_64.c  | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 arch/sparc/kernel/smp_64.c      |  11 +++++++
 arch/sparc/mm/ultra.S           |  64 ++++++++++++++++++++++++++++++++++--
 drivers/tty/sysrq.c             |   1 +
 8 files changed, 198 insertions(+), 29 deletions(-)
