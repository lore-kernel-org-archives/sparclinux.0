From: Will Deacon <will@kernel.org>
Date: Tue, 14 Apr 2020 21:40:07 +0000
Subject: [RESEND PATCH 0/4] Rework sparc32 page-table layout
Message-Id: <20200414214011.2699-1-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Matt Fleming <matt@codeblueprint.co.uk>, sparclinux@vger.kernel.org, kernel-team@android.com

Hi all,

This is a reposting of the patch series I sent previously to rework the
sparc32 page-table layout so that 'pmd_t' can be used safely with
READ_ONCE():

https://lore.kernel.org/lkml/20200324104005.11279-1-will@kernel.org

This is blocking the READ_ONCE() rework, which in turn allows us to
bump the minimum GCC version for building the kernel up to 4.8.

Cheers,

Will

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: sparclinux@vger.kernel.org
Cc: kernel-team@android.com

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
2.26.0.110.g2183baf09c-goog
