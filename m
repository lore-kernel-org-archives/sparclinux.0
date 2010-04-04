From: David Miller <davem@davemloft.net>
Date: Sun, 04 Apr 2010 08:15:17 +0000
Subject: [GIT] Sparc
Message-Id: <20100404.011517.182704987.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc fixes.

Thanks a lot!

The following changes since commit 5e11611a5d22252f3f9c169a3c9377eac0c32033:
  Linus Torvalds (1):
        Merge master.kernel.org:/home/rmk/linux-2.6-arm

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Ben Hutchings (1):
      sparc64: Fix array size reported by vmemmap_populate()

David S. Miller (5):
      sparc: Fix regset register window handling.
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/
      sparc64: Update defconfig.
      sparc64: Implement perf_arch_fetch_caller_regs
      sunxvr500: Ignore secondary output PCI devices.

Julia Lawall (1):
      drivers/serial/sunsu.c: Correct use after free

 arch/sparc/configs/sparc64_defconfig |   28 +++++++-----
 arch/sparc/kernel/helpers.S          |   75 ++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/ptrace_32.c        |    4 ++
 arch/sparc/kernel/ptrace_64.c        |    4 ++
 arch/sparc/mm/init_64.c              |    2 +-
 drivers/serial/sunsu.c               |    4 +-
 drivers/video/sunxvr500.c            |   24 ++++++++---
 7 files changed, 120 insertions(+), 21 deletions(-)
