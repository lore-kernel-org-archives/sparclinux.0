From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:17:49 +0000
Subject: [PATCH 0/15] first batch for killing CONFIG_SPARC_LEON
Message-Id: <20120526071749.GA22144@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With this patch-set applied most of the low-level code in the kernel
supports both LEON and SUN.

The only references left are in:
arch/sparc/Kconfig
arch/sparc/kernel/Makefile
arch/sparc/kernel/ioport.c
arch/sparc/kernel/process_32.c
drivers/pci/Makefile
drivers/usb/Kconfig
drivers/usb/host/Kconfig
drivers/usb/host/ehci-hcd.c
drivers/usb/host/uhci-hcd.c

I need to analyse things a bit before attacking the last users,
and wanted to get this batch out for review (and eventually applied).
I expect some variant (like SPARC_LEON_PCI) to continue to
be present - but lets see.

Changes since the [RFC] version:
- used more optimal assembler as suggested by davem
- fix up error message as pointed out by davem
- fix up error message as pointed out by Julian Calaby
- use LEON as default and patch for SUN (which uncovered a bug - good!)
- added several patches...

This version boots on my ss5.
If I build a LEON variant the build fails when it starts to
probe my SCSI drive (I think it was here). This was expected
since ioport is not fixed up yet. Before it would fail much earlier.

Also note that all references to SPARC_LEON is gone in the header files,
so only a minimal set of files are rebuild when you go from non-LEON
to a LEON build.

I have done builds on some configurations for each step - but
my current build-box is slow so I did not cover all.

And I have boot tested the kernel for almost all steps.
So my confidence in the patch-set i good.

	Sam

Sam Ravnborg (15):
      sparc32: string and whitespace cleanup in head_32.S
      sparc32: implement proper LEON support in head_32 (before highmem)
      sparc32: implement proper LEON support in head_32 (after highmem)
      sparc32: introduce sparc32_start_kernel called from head_32.S
      sparc32: add support for run-time patching of leon/sun single instructions
      sparc32: handle leon in irq_32.c
      sparc32: handle leon in cpu.c
      sparc32,leon: clean up leon.h
      sparc32,leon: always include leon_kernel in build
      sparc32,leon: always include leon_kernel + leon_smp in build
      sparc32,leon: fix section mismatch warning
      sparc32: introduce support for run-time patching for all shared assembler code
      sparc32: introduce run-time patching of srmmu access functions
      sparc32: drop LEON hack for ASI_M_MMUREGS
      sparc32: srmmu_probe now knows about leon too

 arch/sparc/include/asm/asmmacro.h  |   22 +++++
 arch/sparc/include/asm/leon.h      |   81 +-------------------
 arch/sparc/include/asm/leon_amba.h |    4 -
 arch/sparc/include/asm/pgtsrmmu.h  |   86 ++-------------------
 arch/sparc/include/asm/psr.h       |    8 ++
 arch/sparc/include/asm/sections.h  |    3 +
 arch/sparc/kernel/Makefile         |    2 +-
 arch/sparc/kernel/cpu.c            |   18 ++--
 arch/sparc/kernel/entry.S          |   10 +-
 arch/sparc/kernel/etrap_32.S       |   18 +++-
 arch/sparc/kernel/head_32.S        |  149 ++++++++++++++++++++++--------------
 arch/sparc/kernel/irq_32.c         |   22 +++---
 arch/sparc/kernel/kernel.h         |    3 +
 arch/sparc/kernel/leon_kernel.c    |    1 +
 arch/sparc/kernel/leon_smp.c       |    8 +--
 arch/sparc/kernel/rtrap_32.S       |   18 +++--
 arch/sparc/kernel/setup_32.c       |   62 ++++++++++++---
 arch/sparc/kernel/trampoline_32.S  |    6 +-
 arch/sparc/kernel/vmlinux.lds.S    |    5 +
 arch/sparc/kernel/wof.S            |   18 +++--
 arch/sparc/kernel/wuf.S            |   27 ++++---
 arch/sparc/mm/Makefile             |    3 +-
 arch/sparc/mm/leon_mm.c            |    2 +-
 arch/sparc/mm/srmmu.c              |   25 +++++-
 arch/sparc/mm/srmmu_access.S       |   82 ++++++++++++++++++++
 26 files changed, 383 insertions(+), 304 deletions(-)
