From: David Miller <davem@davemloft.net>
Date: Sat, 18 Nov 2017 03:15:16 +0000
Subject: [GIT] Sparc
Message-Id: <20171118.121516.877252352119345490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Add missing cmpxchg64() for 32-bit sparc.

2) Timer conversions from Allen Pais and Kees Cook.

3) vDSO support, from Nagarathnam Muthusamy.

4) Fix sparc64 huge page table walks based upon bug report by Al Viro,
   from Nitin Gupta.

5) Optimized fls() for T4 and above, from Vijay Kumar.

Please pull, thanks a lot!

The following changes since commit 9cd6681cb1169e815c41af0265165dd1b872f228:

  Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2017-09-27 12:22:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 70f3c8b7c2e7ebcdde8354da004872e7c9184e97:

  sparc64: Fix page table walk for PUD hugepages (2017-11-15 14:37:43 +0900)

----------------------------------------------------------------
Allen Pais (1):
      sparc64: Convert timers to user timer_setup()

Corentin Labbe (2):
      sparc: time: Remove unneeded linux/miscdevice.h include
      sbus: char: Move D7S_MINOR to include/linux/miscdevice.h

David S. Miller (2):
      sparc32: Add cmpxchg64().
      Merge branch 'sparc64-optimized-fls'

Elena Reshetova (1):
      sparc64: convert mdesc_handle.refcnt from atomic_t to refcount_t

Guenter Roeck (1):
      sparc64: mmu_context: Add missing include files

Kees Cook (1):
      sparc/led: Convert timers to use timer_setup()

Nagarathnam Muthusamy (1):
      vDSO for sparc

Nitin Gupta (1):
      sparc64: Fix page table walk for PUD hugepages

Vijay Kumar (5):
      sparc64: Define SPARC default fls function
      sparc64: Define SPARC default __fls function
      sparc64: SPARC optimized fls function
      sparc64: SPARC optimized __fls function
      sparc64: Use sparc optimized fls and __fls for T4 and above

 arch/sparc/Kbuild                       |   1 +
 arch/sparc/Kconfig                      |   2 +
 arch/sparc/Makefile                     |   4 ++
 arch/sparc/include/asm/bitops_64.h      |   5 +-
 arch/sparc/include/asm/clocksource.h    |  17 +++++
 arch/sparc/include/asm/cmpxchg_32.h     |   3 +
 arch/sparc/include/asm/elf_64.h         |  14 ++++
 arch/sparc/include/asm/mmu_64.h         |   1 +
 arch/sparc/include/asm/mmu_context_64.h |   2 +
 arch/sparc/include/asm/processor_64.h   |   8 +++
 arch/sparc/include/asm/tsb.h            |   2 +-
 arch/sparc/include/asm/vdso.h           |  24 +++++++
 arch/sparc/include/asm/vvar.h           |  74 ++++++++++++++++++++
 arch/sparc/include/uapi/asm/auxvec.h    |   4 ++
 arch/sparc/kernel/Makefile              |   1 +
 arch/sparc/kernel/head_64.S             |   2 +
 arch/sparc/kernel/led.c                 |  16 +++--
 arch/sparc/kernel/mdesc.c               |  17 ++---
 arch/sparc/kernel/time_64.c             |  12 +++-
 arch/sparc/kernel/vdso.c                |  70 +++++++++++++++++++
 arch/sparc/kernel/viohs.c               |   6 +-
 arch/sparc/lib/Makefile                 |   3 +
 arch/sparc/lib/NG4fls.S                 |  30 +++++++++
 arch/sparc/lib/NG4patch.S               |   9 +++
 arch/sparc/lib/atomic32.c               |  14 ++++
 arch/sparc/lib/fls.S                    |  67 +++++++++++++++++++
 arch/sparc/lib/fls64.S                  |  61 +++++++++++++++++
 arch/sparc/vdso/.gitignore              |   3 +
 arch/sparc/vdso/Makefile                | 149 +++++++++++++++++++++++++++++++++++++++++
 arch/sparc/vdso/vclock_gettime.c        | 264 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/vdso/vdso-layout.lds.S       | 104 ++++++++++++++++++++++++++++
 arch/sparc/vdso/vdso-note.S             |  12 ++++
 arch/sparc/vdso/vdso.lds.S              |  25 +++++++
 arch/sparc/vdso/vdso2c.c                | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/vdso/vdso2c.h                | 143 +++++++++++++++++++++++++++++++++++++++
 arch/sparc/vdso/vdso32/.gitignore       |   1 +
 arch/sparc/vdso/vdso32/vclock_gettime.c |  26 +++++++
 arch/sparc/vdso/vdso32/vdso-note.S      |  12 ++++
 arch/sparc/vdso/vdso32/vdso32.lds.S     |  24 +++++++
 arch/sparc/vdso/vma.c                   | 268 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/sbus/char/display7seg.c         |   1 -
 include/linux/miscdevice.h              |   1 +
 42 files changed, 1711 insertions(+), 25 deletions(-)
 create mode 100644 arch/sparc/include/asm/clocksource.h
 create mode 100644 arch/sparc/include/asm/vdso.h
 create mode 100644 arch/sparc/include/asm/vvar.h
 create mode 100644 arch/sparc/kernel/vdso.c
 create mode 100644 arch/sparc/lib/NG4fls.S
 create mode 100644 arch/sparc/lib/fls.S
 create mode 100644 arch/sparc/lib/fls64.S
 create mode 100644 arch/sparc/vdso/.gitignore
 create mode 100644 arch/sparc/vdso/Makefile
 create mode 100644 arch/sparc/vdso/vclock_gettime.c
 create mode 100644 arch/sparc/vdso/vdso-layout.lds.S
 create mode 100644 arch/sparc/vdso/vdso-note.S
 create mode 100644 arch/sparc/vdso/vdso.lds.S
 create mode 100644 arch/sparc/vdso/vdso2c.c
 create mode 100644 arch/sparc/vdso/vdso2c.h
 create mode 100644 arch/sparc/vdso/vdso32/.gitignore
 create mode 100644 arch/sparc/vdso/vdso32/vclock_gettime.c
 create mode 100644 arch/sparc/vdso/vdso32/vdso-note.S
 create mode 100644 arch/sparc/vdso/vdso32/vdso32.lds.S
 create mode 100644 arch/sparc/vdso/vma.c
