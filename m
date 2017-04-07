From: David Miller <davem@davemloft.net>
Date: Fri, 07 Apr 2017 21:21:34 +0000
Subject: [GIT] Sparc
Message-Id: <20170407.142134.1030477210102341254.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Several fixes here, mostly having to due with either build errors or
memory corruptions depending upon whether you have THP enabled or not.

Please pull, thanks a lot!

The following changes since commit ad0376eb1483bd9880770b346f6592aece669e4c:

  Merge tag 'edac_for_4.11_2' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp (2017-03-27 11:09:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 86e1066fe2af51dce4351c2357223e0d902dfc7a:

  sparc: remove unused wp_works_ok macro (2017-04-06 12:03:30 -0700)

----------------------------------------------------------------
Babu Moger (1):
      arch/sparc: Avoid DCTI Couples

Guenter Roeck (1):
      sparc32: Export vac_cache_size to fix build error

Mathias Krause (1):
      sparc: remove unused wp_works_ok macro

Nitin Gupta (3):
      sparc64: Fix size check in huge_pte_alloc
      sparc64: Add support for 2G hugepages
      sparc64: Fix memory corruption when THP is enabled

Tom Hromatka (1):
      sparc64: Fix kernel panic due to erroneous #ifdef surrounding pmd_write()

bob picco (1):
      sparc64: kern_addr_valid regression

 arch/sparc/include/asm/page_64.h      |  3 ++-
 arch/sparc/include/asm/pgtable_64.h   | 15 ++++++++-------
 arch/sparc/include/asm/processor_32.h |  6 ------
 arch/sparc/include/asm/processor_64.h |  4 ----
 arch/sparc/kernel/head_64.S           |  4 ++++
 arch/sparc/kernel/misctrap.S          |  1 +
 arch/sparc/kernel/rtrap_64.S          |  1 +
 arch/sparc/kernel/spiterrs.S          |  1 +
 arch/sparc/kernel/sun4v_tlb_miss.S    |  1 +
 arch/sparc/kernel/urtt_fill.S         |  1 +
 arch/sparc/kernel/winfixup.S          |  2 ++
 arch/sparc/lib/NG2memcpy.S            |  4 ++++
 arch/sparc/lib/NG4memcpy.S            |  1 +
 arch/sparc/lib/NG4memset.S            |  1 +
 arch/sparc/lib/NGmemcpy.S             |  1 +
 arch/sparc/mm/hugetlbpage.c           |  9 ++++++++-
 arch/sparc/mm/init_64.c               |  6 +++++-
 arch/sparc/mm/srmmu.c                 |  1 +
 arch/sparc/mm/tlb.c                   |  6 +++---
 arch/sparc/mm/tsb.c                   |  4 ++--
 20 files changed, 47 insertions(+), 25 deletions(-)
