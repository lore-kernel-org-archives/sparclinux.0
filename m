From: David Miller <davem@davemloft.net>
Date: Mon, 09 Aug 2010 10:28:06 +0000
Subject: [GIT] Sparc
Message-Id: <20100809.032806.226789571.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just some misc sparc64 bits:

1) Add missing ID to sparc64 parport support.

2) Sync sparc64's perf_arch_get_caller_regs() with recent changes.

3) Toss user-copy check code, it never worked properly on sparc for
   whatever reason and just adds warning noise to the logs.

Please pull, thanks a lot!

The following changes since commit 45d7f32c7a43cbb9592886d38190e379e2eb2226:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile (2010-08-08 10:10:11 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      sparc64: Add missing ID to parport probing code.
      sparc64: Fix perf_arch_get_caller_regs().
      sparc: Kill user copy check code.
      sparc64: Update defconfig.

 arch/sparc/Kconfig.debug             |   14 ------
 arch/sparc/configs/sparc64_defconfig |   67 +++++++++++++++++-------------
 arch/sparc/include/asm/parport.h     |    4 ++
 arch/sparc/include/asm/perf_event.h  |   25 +++++++++--
 arch/sparc/include/asm/uaccess_32.h  |   15 -------
 arch/sparc/include/asm/uaccess_64.h  |   23 ++--------
 arch/sparc/kernel/helpers.S          |   75 ----------------------------------
 7 files changed, 68 insertions(+), 155 deletions(-)
