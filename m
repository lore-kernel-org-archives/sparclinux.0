From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:34 +0000
Subject: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <20201218184347.2180772-1-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

The sun4m and sun4d based SPARC machines was very popular in the
90'ties and was then replaced by the more powerful sparc64
class of machines.
Today there is only Gentoo that to my best knowledge supports
sparc32 and people have moved on to more capable HW.

Cobham Gaisler have variants of the LEON processer that
runs sparc32 - and they are in production today.

With this patchset I propose to sunset sun4m and sun4d and move
focus to a more streamlined support for LEON.

One downside is that qemu supports sun4m - and we may loose
some testing possibilities when sun4m is dropped. qemu supports
LEON to some degree - I have not yet tried it out.

Andreas from Gaisler have indicated that they may be more active
upstream on sparc32 - and this will only be easier with a kernel
where the legacy stuff is dropped.

I decided to divide up the patches to make it possible to review
the set as some of the patches touches assembler and these parts
could use some extra eyes if we move forward with this.

For now it builds with the configurations I have tried.

Looking forward for feedback if sunsetting is a good idea or not.

	Sam

Sam Ravnborg (13):
      sparc32: Drop sun4m/sun4d support from head_32.S
      sparc32: Drop floppy support
      sparc32: Drop sun4m specific led driver
      sparc32: Drop auxio support
      sparc32: Drop run-time patching of ipi trap
      sparc32: Drop patching of interrupt vector
      sparc32: Drop sun4m/sun4d specific irq handling
      sparc32: Drop sun4d/sun4m smp support
      sparc32: Drop pcic support
      sparc32: Drop mbus support
      sparc32: Drop unused mmu models
      sparc32: drop check for sparc_model
      sparc32: drop use of sparc_config

Note: I dunno why git does not see floppy_64.h=>floppy.h as a rename??

 arch/sparc/Kconfig                  |  16 +-
 arch/sparc/include/asm/auxio_32.h   |  73 +---
 arch/sparc/include/asm/cpu_type.h   |  18 -
 arch/sparc/include/asm/elf_32.h     |   2 -
 arch/sparc/include/asm/floppy.h     | 786 ++++++++++++++++++++++++++++++++-
 arch/sparc/include/asm/floppy_32.h  | 393 -----------------
 arch/sparc/include/asm/floppy_64.h  | 779 ---------------------------------
 arch/sparc/include/asm/io_32.h      |   4 +-
 arch/sparc/include/asm/irq_32.h     |   1 -
 arch/sparc/include/asm/mbus.h       |  97 -----
 arch/sparc/include/asm/mxcc.h       | 138 ------
 arch/sparc/include/asm/pcic.h       | 130 ------
 arch/sparc/include/asm/pgtable_32.h |  24 -
 arch/sparc/include/asm/ross.h       | 192 --------
 arch/sparc/include/asm/swift.h      | 107 -----
 arch/sparc/include/asm/timer_32.h   |   1 +
 arch/sparc/include/asm/tsunami.h    |  65 ---
 arch/sparc/include/asm/viking.h     | 255 -----------
 arch/sparc/kernel/Makefile          |   8 +-
 arch/sparc/kernel/apc.c             |  14 -
 arch/sparc/kernel/auxio_32.c        | 140 ------
 arch/sparc/kernel/cpu.c             |   1 -
 arch/sparc/kernel/devices.c         |  10 +-
 arch/sparc/kernel/entry.S           | 354 +--------------
 arch/sparc/kernel/head_32.S         | 190 +-------
 arch/sparc/kernel/ioport.c          |   6 +-
 arch/sparc/kernel/irq.h             |  35 +-
 arch/sparc/kernel/irq_32.c          | 127 +-----
 arch/sparc/kernel/kernel.h          |  28 --
 arch/sparc/kernel/led.c             | 146 -------
 arch/sparc/kernel/leon_kernel.c     |  43 +-
 arch/sparc/kernel/leon_pmc.c        |  14 +-
 arch/sparc/kernel/leon_smp.c        |   3 -
 arch/sparc/kernel/of_device_32.c    |   4 +-
 arch/sparc/kernel/pcic.c            | 841 ------------------------------------
 arch/sparc/kernel/pmc.c             |  10 -
 arch/sparc/kernel/process_32.c      |  10 -
 arch/sparc/kernel/setup_32.c        |  80 +---
 arch/sparc/kernel/smp_32.c          | 102 +----
 arch/sparc/kernel/sun4d_irq.c       | 519 ----------------------
 arch/sparc/kernel/sun4d_smp.c       | 413 ------------------
 arch/sparc/kernel/sun4m_irq.c       | 240 ----------
 arch/sparc/kernel/sun4m_smp.c       | 273 ------------
 arch/sparc/kernel/time_32.c         | 114 +++--
 arch/sparc/kernel/ttable_32.S       |   9 +-
 arch/sparc/mm/Makefile              |   1 -
 arch/sparc/mm/hypersparc.S          | 414 ------------------
 arch/sparc/mm/io-unit.c             |   3 -
 arch/sparc/mm/iommu.c               |  49 +--
 arch/sparc/mm/mm_32.h               |   1 -
 arch/sparc/mm/srmmu.c               | 834 +----------------------------------
 arch/sparc/mm/swift.S               | 256 -----------
 arch/sparc/mm/tsunami.S             | 132 ------
 arch/sparc/mm/viking.S              | 284 ------------
 arch/sparc/prom/misc_32.c           |   2 -
 55 files changed, 905 insertions(+), 7886 deletions(-)
