From: Will Deacon <will@kernel.org>
Date: Tue, 24 Mar 2020 10:40:01 +0000
Subject: [PATCH 0/4] Rework sparc32 page-table layout
Message-Id: <20200324104005.11279-1-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Matt Fleming <matt@codeblueprint.co.uk>, sparclinux@vger.kernel.org

Hi folks,

This series of patches reworks the sparc32 page-table layout so that
'pmd_t' no longer embeds an array of 16 physical pointers, which means
that we can finally enforce atomicity for accesses made using READ_ONCE():

  https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org

I've tested this with QEMU by booting Debian Etch. Please take a look!

Cheers,

Will

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: sparclinux@vger.kernel.org

--->8

Will Deacon (4):
  sparc32: mm: Fix argument checking in __srmmu_get_nocache()
  sparc32: mm: Restructure sparc32 MMU page-table layout
  sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
  sparc32: mm: Reduce allocation size for PMD and PTE tables

 arch/sparc/include/asm/page_32.h    | 12 ++--
 arch/sparc/include/asm/pgalloc_32.h | 11 ++--
 arch/sparc/include/asm/pgtable_32.h | 40 +++++++-----
 arch/sparc/include/asm/pgtsrmmu.h   | 36 +----------
 arch/sparc/include/asm/viking.h     |  5 +-
 arch/sparc/kernel/head_32.S         |  8 +--
 arch/sparc/mm/hypersparc.S          |  3 +-
 arch/sparc/mm/srmmu.c               | 95 ++++++++++-------------------
 arch/sparc/mm/viking.S              |  5 +-
 9 files changed, 85 insertions(+), 130 deletions(-)

-- 
2.20.1
