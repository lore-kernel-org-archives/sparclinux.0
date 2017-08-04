From: David Miller <davem@davemloft.net>
Date: Fri, 04 Aug 2017 17:11:14 +0000
Subject: [GIT] Sparc
Message-Id: <20170804.101114.1963026409463318149.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these Sparc bug fixes:

1) Block interrupts properly across the entire MMU context change
   (both the hw MMU context change and the TSB table change) so
   that we don't get a perf event interrupt in the middle.  From
   Rob Gardner.

2) Be sure to register hugepages early enough, from Nitin Gupta.

3) UltraSPARC-III user copy exception handling would return garbage
   for the copied length in some circumstances.

Thanks!

The following changes since commit cb8c65ccff7f77d0285f1b126c72d37b2572c865:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2017-07-17 15:08:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 0ede1c401332173ab0693121dc6cde04a4dbf131:

  sparc64: Fix exception handling in UltraSPARC-III memcpy. (2017-08-04 09:47:52 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix exception handling in UltraSPARC-III memcpy.

Krzysztof Kozlowski (1):
      sparc: defconfig: Cleanup from old Kconfig options

Nitin Gupta (1):
      sparc64: Register hugepages during arch init

Rob Gardner (1):
      sparc64: Prevent perf from running during super critical sections

Rob Herring (1):
      sbus: Convert to using %pOF instead of full_name

 arch/sparc/configs/sparc32_defconfig    |  4 ----
 arch/sparc/configs/sparc64_defconfig    |  4 ----
 arch/sparc/include/asm/mmu_context_64.h | 14 +++++++++-----
 arch/sparc/kernel/tsb.S                 | 12 ++++++++++++
 arch/sparc/lib/U3memcpy.S               |  4 ++--
 arch/sparc/mm/init_64.c                 | 25 ++++++++++++++++++++++++-
 arch/sparc/power/hibernate.c            |  3 +--
 drivers/sbus/char/display7seg.c         |  4 ++--
 drivers/sbus/char/flash.c               |  4 ++--
 drivers/sbus/char/uctrl.c               |  4 ++--
 10 files changed, 54 insertions(+), 24 deletions(-)
