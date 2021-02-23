From: David Miller <davem@davemloft.net>
Date: Tue, 23 Feb 2021 21:21:26 +0000
Subject: [GIT] Sparc
Message-Id: <20210223.132126.1594995051384966189.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: torvalds@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


A host of mall cleanups and adjustments that have accumulated while
I was away, nothing major.

Please pull, thanks a lot!

The following changes since commit dd0d718152e4c65b173070d48ea9dfc06894c3e5:

  Merge tag 'spi-fix-v5.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel=
/git/broonie/spi (2020-06-22 09:49:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git=20

for you to fetch changes up to 356184fb6d67770d7788f316226be810a430937b:

  sparc: make xchg() into a statement expression (2021-02-18 16:40:22 -0800)

----------------------------------------------------------------
Al Viro (1):
      sparc32: fix a user-triggerable oops in clear_user()

Alexander A. Klimov (1):
      arch/sparc: Replace HTTP links with HTTPS ones

Andreas Larsson (2):
      sparc32: Limit memblock allocation to low memory
      sparc32: Preserve clone syscall flags argument for restarts due to si=
gnals

Ben Hutchings (1):
      sparc32: signal: Fix stack trampoline for RT signals

Christoph Hellwig (1):
      sparc64: switch defconfig from the legacy ide driver to libata

Corentin Labbe (2):
      sparc: piggyback: handle invalid image
      sparc: sparc64_defconfig: add necessary configs for qemu

David S. Miller (1):
      Merge branch 'sparc32-srmmu-improve-type-safety-of-__nocache_fix'

Gustavo A. R. Silva (2):
      sparc64: viohs: Use struct_size() helper
      sparc: Use fallthrough pseudo-keyword

Jing Xiangfeng (1):
      sbus: char: Remove meaningless jump label out_free

Kaixu Xia (1):
      sparc32: Fix comparing pointer to 0 coccicheck warning

Khalid Aziz (1):
      sparc64: Use arch_validate_flags() to validate ADI flag

Matthew Wilcox (Oracle) (1):
      sparc: Fix handling of page table constructor failure

Mike Rapoport (2):
      sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_map=
pings()
      sparc32: srmmu: improve type safety of __nocache_fix()

Peter Collingbourne (1):
      sparc: remove SA_STATIC_ALLOC macro definition

Qinglang Miao (1):
      sparc: use for_each_child_of_node() macro

Randy Dunlap (4):
      SPARC: backoff.h: delete a duplicated word
      sparc64: only select COMPAT_BINFMT_ELF if BINFMT_ELF is set
      sparc: fix led.c driver when PROC_FS is not enabled
      sparc: make xchg() into a statement expression

Tiezhu Yang (1):
      sparc: Replace test_ti_thread_flag() with test_tsk_thread_flag()

Uwe Kleine-K=F6nig (3):
      tty: vcc: Drop impossible to hit WARN_ON
      tty: vcc: Drop unnecessary if block
      tty: hvcs: Drop unnecessary if block

 arch/sparc/Kconfig                   |  4 ++--
 arch/sparc/boot/piggyback.c          |  4 ++++
 arch/sparc/configs/sparc64_defconfig | 11 ++++++++---
 arch/sparc/include/asm/backoff.h     |  2 +-
 arch/sparc/include/asm/cmpxchg_32.h  |  2 +-
 arch/sparc/include/asm/mman.h        | 54 +++++++++++++++++++++++++++++---=
----------------------
 arch/sparc/include/asm/pgtsrmmu.h    |  2 +-
 arch/sparc/include/asm/signal.h      | 12 ------------
 arch/sparc/kernel/auxio_64.c         |  1 -
 arch/sparc/kernel/central.c          |  2 +-
 arch/sparc/kernel/entry.S            |  8 +++-----
 arch/sparc/kernel/kgdb_32.c          |  2 +-
 arch/sparc/kernel/kgdb_64.c          |  2 +-
 arch/sparc/kernel/led.c              |  2 ++
 arch/sparc/kernel/pci.c              |  3 +--
 arch/sparc/kernel/pcr.c              |  2 +-
 arch/sparc/kernel/process_32.c       |  2 +-
 arch/sparc/kernel/prom_32.c          |  2 +-
 arch/sparc/kernel/rtrap_32.S         |  2 +-
 arch/sparc/kernel/signal32.c         |  4 ++--
 arch/sparc/kernel/signal_32.c        |  8 ++++----
 arch/sparc/kernel/signal_64.c        |  4 ++--
 arch/sparc/kernel/viohs.c            |  6 ++----
 arch/sparc/lib/memset.S              |  1 +
 arch/sparc/math-emu/math_32.c        |  8 ++++----
 arch/sparc/mm/init_32.c              |  3 +++
 arch/sparc/mm/init_64.c              |  2 +-
 arch/sparc/mm/srmmu.c                | 20 ++++++++++----------
 drivers/sbus/char/display7seg.c      |  4 +---
 drivers/tty/hvc/hvcs.c               |  3 ---
 drivers/tty/vcc.c                    | 10 ++--------
 31 files changed, 91 insertions(+), 101 deletions(-)
