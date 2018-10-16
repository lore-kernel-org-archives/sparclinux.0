From: David Miller <davem@davemloft.net>
Date: Tue, 16 Oct 2018 02:39:45 +0000
Subject: [GIT] Sparc
Message-Id: <20181015.193945.304905055642913000.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Revert the %pOF change, it causes regressions.

2) Wire up io_pgetevents().

3) Fix perf events on single-PCR sparc64 cpus.

4) Do proper perf event throttling like arm and x86.

Please pull, thanks a lot!

The following changes since commit 0854ba5ff5c938307cd783e996b62c83f1ce923b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2018-10-08 16:25:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to a06ecbfe784ceb22e56ae3cd75fe77138e7cfa0b:

  Revert "sparc: Convert to using %pOFn instead of device_node.name" (2018-10-15 18:32:54 -0700)

----------------------------------------------------------------
David S. Miller (6):
      sparc: Wire up io_pgetevents system call.
      sparc: Fix single-pcr perf event counter management.
      sparc: Throttle perf events properly.
      sparc64: Make proc_id signed.
      sparc64: Set %l4 properly on trap return after handling signals.
      Revert "sparc: Convert to using %pOFn instead of device_node.name"

Kees Cook (1):
      sunvdc: Remove VLA usage

 arch/sparc/include/asm/cpudata_64.h  |  2 +-
 arch/sparc/include/uapi/asm/unistd.h |  3 ++-
 arch/sparc/kernel/auxio_64.c         |  4 ++--
 arch/sparc/kernel/perf_event.c       | 26 ++++++++++++++++++++++----
 arch/sparc/kernel/power.c            |  4 ++--
 arch/sparc/kernel/prom_32.c          | 26 +++++++++++++-------------
 arch/sparc/kernel/prom_64.c          | 68 ++++++++++++++++++++++++++++++++++----------------------------------
 arch/sparc/kernel/rtrap_64.S         |  3 ++-
 arch/sparc/kernel/systbls_32.S       |  2 +-
 arch/sparc/kernel/systbls_64.S       |  4 ++--
 drivers/block/sunvdc.c               | 14 ++++++++++----
 11 files changed, 91 insertions(+), 65 deletions(-)
