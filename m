From: David Miller <davem@davemloft.net>
Date: Fri, 29 Oct 2010 03:46:04 +0000
Subject: [GIT] Sparc
Message-Id: <20101028.204604.226766493.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Some left over signal fixes from Al, please some build
fixups for LEON and other configurations from Namhyung
Kim.

Please pull, thanks!

The following changes since commit b18cae4224bde7e5a332c19bc99247b2098ea232:

  Merge branch 'for-next' of git://android.git.kernel.org/kernel/tegra (2010-10-25 18:42:06 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Al Viro (1):
      sparc: keep calling do_signal() as long as pending signals remain

Daniel Hellstrom (1):
      sparc: Fixed random SPARC/LEON SMP CPU Stuck problem.

David S. Miller (1):
      sparc32: Fix unaligned stack handling on trap return.

Namhyung Kim (4):
      sparc: don't #include asm/system.h in asm/jump_label.h
      sparc32: remove CONFIG_HAVE_PERF_EVENTS option
      sparc32: fix build failure on CONFIG_SPARC_LEON
      kbuild: add ARCH=sparc32 target

 Makefile                            |    3 ++
 arch/sparc/Kconfig                  |    3 --
 arch/sparc/include/asm/jump_label.h |    1 -
 arch/sparc/kernel/irq_32.c          |    4 +-
 arch/sparc/kernel/leon_smp.c        |    4 +-
 arch/sparc/kernel/rtrap_32.S        |    6 ++--
 arch/sparc/kernel/rtrap_64.S        |   36 ++--------------------------------
 arch/sparc/mm/fault_32.c            |   12 +++++++++++
 8 files changed, 25 insertions(+), 44 deletions(-)
