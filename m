From: David Miller <davem@davemloft.net>
Date: Tue, 20 Apr 2010 08:49:08 +0000
Subject: [GIT]: Sparc
Message-Id: <20100420.014908.46443175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes.

Including a IRQ tracing trap return blunder I've been tracking
down for 2 weeks :-)

Thanks!

The following changes since commit 13bd8e4673d527a9e48f41956b11d391e7c2cfe0:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../anholt/drm-intel

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (5):
      sparc64: Allocate sufficient stack space in ftrace stubs.
      sparc64: Run NMIs on the hardirq stack.
      sparc64: Fix PREEMPT_ACTIVE value.
      sparc64: Use correct pt_regs in decode_access_size() error paths.
      sparc64: Fix hardirq tracing in trap return path.

Frederic Weisbecker (1):
      sparc: Fix forgotten kmemleak headers inclusion

 arch/sparc/include/asm/thread_info_64.h |    2 +-
 arch/sparc/kernel/irq_64.c              |   20 ++------------------
 arch/sparc/kernel/kstack.h              |   19 +++++++++++++++++++
 arch/sparc/kernel/nmi.c                 |    7 +++++++
 arch/sparc/kernel/rtrap_64.S            |   12 +++++++++++-
 arch/sparc/kernel/unaligned_64.c        |    6 +++---
 arch/sparc/lib/mcount.S                 |    8 ++++----
 7 files changed, 47 insertions(+), 27 deletions(-)
