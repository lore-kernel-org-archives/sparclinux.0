From: David Miller <davem@davemloft.net>
Date: Mon, 21 Mar 2011 02:51:59 +0000
Subject: [GIT] Sparc
Message-Id: <20110320.195159.71120857.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Flesh out some missing OF layer interfaces to fix allmodconfig
   build.

2) Hook up new system calls.

Please pull, thanks a lot!

The following changes since commit a44f99c7efdb88fa41128065c9a9445c19894e34:

  Merge branch 'trivial' of git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild-2.6 (2011-03-20 18:14:55 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      sparc: Provide NO_IRQ definition.
      sparc: Implement of_address_to_resource().
      sparc: Implement of_iomap().
      sparc: Add {open_by,name_to}_handle_at and clock_adjtime syscalls.

 arch/sparc/include/asm/irq_32.h      |    3 +++
 arch/sparc/include/asm/irq_64.h      |    2 ++
 arch/sparc/include/asm/unistd.h      |    5 ++++-
 arch/sparc/kernel/of_device_common.c |   27 +++++++++++++++++++++++++++
 arch/sparc/kernel/systbls_32.S       |    2 +-
 arch/sparc/kernel/systbls_64.S       |    4 ++--
 6 files changed, 39 insertions(+), 4 deletions(-)
