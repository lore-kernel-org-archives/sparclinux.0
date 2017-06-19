From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Mon, 19 Jun 2017 17:08:47 +0000
Subject: [PATCH 0/3] Suppressing version generation failed warnings in sparc
Message-Id: <1497892130-875525-1-git-send-email-nagarathnam.muthusamy@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Compiling the sparc build of upstream kernel generates lots of warnings
regarding version generation failure for functions defined in assembly files.
This can be easily suppressed by adding those function prototypes to
asm/asm-prototypes.h as in powerpc architecture. The following series of patches
aims to clean the following warnings.

WARNING: EXPORT symbol "atomic_add" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "xor_niagara_4" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic_sub_return" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic64_sub" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "xor_vis_3" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "atomic_xor" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "sun4v_niagara2_getperf" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic64_fetch_xor" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic_fetch_xor" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "__bzero" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "atomic64_fetch_and" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "raw_copy_to_user" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "__flushw_user" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "sun4v_niagara2_setperf" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "__arch_hweight64" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "__ffs" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "prom_root_node" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "csum_partial_copy_nocheck" [vmlinux] version generation
failed, symbol will not be versioned.
WARNING: EXPORT symbol "memcpy" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "atomic_fetch_or" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "xor_vis_4" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "__arch_hweight32" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "ffs" [vmlinux] version generation failed, symbol will not be
versioned.
WARNING: EXPORT symbol "atomic_and" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "xor_niagara_3" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic64_and" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "real_hard_smp_processor_id" [vmlinux] version generation
failed, symbol will not be versioned.
WARNING: EXPORT symbol "clear_user_page" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "memmove" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "raw_copy_from_user" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic64_add_return" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "__memscan_generic" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic_sub" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "__memscan_zero" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic64_add" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "strncmp" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "atomic64_fetch_sub" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "xor_vis_5" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "ip_fast_csum" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "test_and_change_bit" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "__arch_hweight8" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "strlen" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "xor_niagara_2" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic64_fetch_or" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic64_or" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "atomic_fetch_sub" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic_fetch_add" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "clear_bit" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "sun4v_mach_set_watchdog" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "set_bit" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "__csum_partial_copy_from_user" [vmlinux] version generation
failed, symbol will not be versioned.
WARNING: EXPORT symbol "memset" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "__csum_partial_copy_to_user" [vmlinux] version generation
failed, symbol will not be versioned.
WARNING: EXPORT symbol "atomic64_fetch_add" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "change_bit" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "__clear_user" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic64_sub_return" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "__arch_hweight16" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "tlb_type" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "VISenter" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "test_and_set_bit" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "xor_niagara_5" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "_clear_page" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "xor_vis_2" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "atomic64_xor" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "test_and_clear_bit" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "atomic_fetch_and" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "copy_user_page" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "sun4v_chip_type" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "raw_copy_in_user" [vmlinux] version generation failed, symbol
will not be versioned.
WARNING: EXPORT symbol "memcmp" [vmlinux] version generation failed, symbol will not
be versioned.
WARNING: EXPORT symbol "atomic_add_return" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "atomic_or" [vmlinux] version generation failed, symbol will
not be versioned.
WARNING: EXPORT symbol "atomic64_dec_if_positive" [vmlinux] version generation
failed, symbol will not be versioned.
WARNING: EXPORT symbol "sun4v_niagara_setperf" [vmlinux] version generation failed,
symbol will not be versioned.
WARNING: EXPORT symbol "sun4v_niagara_getperf" [vmlinux] version generation failed,
symbol will not be versioned.

With the fix, all these warnings will be removed during compilation.

Nagarathnam Muthusamy (3):
  Adding asm-prototypes.h for genksyms to generate crc
  sed regex in Makefile.build requires line break between exported
    symbols
  Adding the type of exported symbols

 arch/sparc/include/asm/asm-prototypes.h |   24 +++++++++++++++++
 arch/sparc/lib/atomic_64.S              |   44 ++++++++++++++++++------------
 arch/sparc/lib/checksum_64.S            |    1 +
 arch/sparc/lib/csum_copy.S              |    1 +
 arch/sparc/lib/memscan_64.S             |    2 +
 arch/sparc/lib/memset.S                 |    1 +
 6 files changed, 55 insertions(+), 18 deletions(-)
 create mode 100644 arch/sparc/include/asm/asm-prototypes.h

