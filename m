From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 09 Apr 2018 13:57:06 +0000
Subject: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Message-Id: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
per architecture header files. This doesn't allow to make other
configuration dependent on it.

This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
setting it automatically when architectures was already setting it in
header file.

There is no functional change introduced by this series.

Laurent Dufour (3):
  mm: introduce ARCH_HAS_PTE_SPECIAL
  mm: replace __HAVE_ARCH_PTE_SPECIAL
  mm: remove __HAVE_ARCH_PTE_SPECIAL

 Documentation/features/vm/pte_special/arch-support.txt | 2 +-
 arch/arc/Kconfig                                       | 1 +
 arch/arc/include/asm/pgtable.h                         | 2 --
 arch/arm/Kconfig                                       | 1 +
 arch/arm/include/asm/pgtable-3level.h                  | 1 -
 arch/arm64/Kconfig                                     | 1 +
 arch/arm64/include/asm/pgtable.h                       | 2 --
 arch/powerpc/Kconfig                                   | 1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h           | 3 ---
 arch/powerpc/include/asm/pte-common.h                  | 3 ---
 arch/riscv/Kconfig                                     | 1 +
 arch/s390/Kconfig                                      | 1 +
 arch/s390/include/asm/pgtable.h                        | 1 -
 arch/sh/Kconfig                                        | 1 +
 arch/sh/include/asm/pgtable.h                          | 2 --
 arch/sparc/Kconfig                                     | 1 +
 arch/sparc/include/asm/pgtable_64.h                    | 3 ---
 arch/x86/Kconfig                                       | 1 +
 arch/x86/include/asm/pgtable_types.h                   | 1 -
 include/linux/pfn_t.h                                  | 4 ++--
 mm/Kconfig                                             | 3 +++
 mm/gup.c                                               | 4 ++--
 mm/memory.c                                            | 2 +-
 23 files changed, 18 insertions(+), 24 deletions(-)

-- 
2.7.4

