From: David Miller <davem@davemloft.net>
Date: Sun, 02 Oct 2016 13:02:12 +0000
Subject: [GIT] Sparc
Message-Id: <20161002.090212.746125237002734416.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix section mismatches in some builds, from Paul Gortmaker.

2) Need to count huge zero page mappings when doing TSB sizing,
   from Mike Kravetz.

3) Fix handing of cpu_possible_mask when nr_cpus module option
   is specified, from Atish Patra.

4) Don't allocate irq stacks until nr_irqs has been processed,
   also from Atish Patra.

The following changes since commit 8ab293e3a1376574e11f9059c09cc0db212546cb:

  Merge branch 'for-4.8-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2016-09-27 16:43:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 2a0100d7beebd2fb2c436852648f75396253e9f8:

  sparc64: Fix non-SMP build. (2016-09-28 20:40:52 -0400)

----------------------------------------------------------------
Atish Patra (2):
      sparc64: Fix cpu_possible_mask if nr_cpus is set
      sparc64: Fix irq stack bootmem allocation.

David S. Miller (1):
      sparc64: Fix non-SMP build.

Mike Kravetz (1):
      sparc64 mm: Fix more TSB sizing issues

Paul Gortmaker (1):
      sparc64: fix section mismatch in find_numa_latencies_for_group

 arch/sparc/include/asm/page_64.h |  1 +
 arch/sparc/include/asm/smp_64.h  |  2 ++
 arch/sparc/kernel/setup_64.c     | 26 ++++++++++++++++++++++++++
 arch/sparc/kernel/smp_64.c       | 14 ++++++++++++++
 arch/sparc/mm/fault_64.c         |  1 +
 arch/sparc/mm/init_64.c          | 22 +++-------------------
 arch/sparc/mm/tlb.c              | 35 +++++++++++++++++++++++++++++++----
 arch/sparc/mm/tsb.c              | 18 ++++++++++++------
 8 files changed, 90 insertions(+), 29 deletions(-)
