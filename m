From: David Miller <davem@davemloft.net>
Date: Wed, 19 May 2010 19:50:21 +0000
Subject: [GIT] Sparc
Message-Id: <20100519.125021.51256632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a few small things, and explicitly set ARCH_SLAB_MINALIGN like we
always should have.

Please pull, thanks!

The following changes since commit 024a6b95181f2df6090975c8a293499d24bf8b28:
  Linus Torvalds (1):
        Merge branch 'davinci-for-linus' of git://git.kernel.org/.../khilman/linux-davinci

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc64: Show stack backtrace from show_regs() just like other platforms.
      sparc64: Fix stack dumping and tracing when function graph is enabled.
      sparc: Define ARCH_SLAB_MINALIGN

Jan Blunck (1):
      drivers/sbus/char/flash.c: flash_read should update ppos instead of file->f_pos

 arch/sparc/include/asm/cache.h |    2 ++
 arch/sparc/kernel/perf_event.c |   14 ++++++++++++++
 arch/sparc/kernel/process_64.c |    1 +
 arch/sparc/kernel/stacktrace.c |   23 ++++++++++++++++++++++-
 arch/sparc/kernel/traps_64.c   |   14 ++++++++++++++
 drivers/sbus/char/flash.c      |    6 +++---
 6 files changed, 56 insertions(+), 4 deletions(-)
