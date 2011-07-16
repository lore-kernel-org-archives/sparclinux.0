From: David Miller <davem@davemloft.net>
Date: Sat, 16 Jul 2011 17:48:19 +0000
Subject: [GIT] Sparc
Message-Id: <20110716.104819.855316771212871477.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull, to get these Sparc bug fixes.

Thanks!

The following changes since commit 1765a367a3b5d5e9692949b0c5ec933eff2c0701:

  Merge branch 'gpio/merge' of git://git.secretlab.ca/git/linux-2.6 (2011-07-15 18:03:30 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Matthias Rosenfelder (1):
      sparc32,leon: Added __init declaration to leon_flush_needed()

Steven Rostedt (1):
      sparc/irqs: Do not trace arch_local_{*,irq_*} functions

Will Simoneau (1):
      sparc: sun4m SMP: fix wrong shift instruction in IPI handler

 arch/sparc/include/asm/irqflags_32.h |    8 ++++----
 arch/sparc/include/asm/irqflags_64.h |   14 +++++++-------
 arch/sparc/kernel/entry.S            |    2 +-
 arch/sparc/mm/leon_mm.c              |    2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)
