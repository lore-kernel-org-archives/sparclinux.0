From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Apr 2014 07:54:26 +0000
Subject: [PATCH 0/4] sparc32: introduce asm-generic
Message-Id: <20140426075426.GA21467@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Inspired by Michal Simek <monstr@monstr.eu> this patch-set
introduces asm-generic/io.h for sparc32.

As the diff-stat tells this was a nice code-reduction.

The changes are done on top of the previous sent sparse warning cleanup.
But I do not expect any difficult conflicts if applied alone.

leon_pci + pcic are touched because they had local
and identical implementations of functiones that are
static inline in asm-generic/io.h

leon_pci_grpci1 + leon_pci_grpci2 are touched becuse they
used a sparc spacific implmentation of swab32.
They have just been changed to use the global variant.

I also looked at sparc64 - but there were to many
sparc64 assembler implementations of the io
functons - and the generic io.h did not support this mix.

The last patch kills a few defines in io.h for sbus.
I assume they were introduced before the functions
were all shifted over to __iomem style pointers.
The same could be done for sparc64 - but then
there were even more of the same so I left
this for another time.

The patch-set has been build tested only.
My attempts to test this using qemu have failed as
the qemu version I have errors out.
And my fedora box are mssing some libs to build
qemu from source :-(

	Sam

Sam Ravnborg (4):
      sparc: move page_to_phys to page.h
      sparc32: replace flip_dword() with swab32()
      sparc32: introduce asm-generic/io.h
      sparc32: clean up io_32.h

 arch/sparc/include/asm/io_32.h      | 287 ++++++------------------------------
 arch/sparc/include/asm/io_64.h      |   1 -
 arch/sparc/include/asm/page.h       |   3 +
 arch/sparc/kernel/leon_pci.c        |  79 ----------
 arch/sparc/kernel/leon_pci_grpci1.c |   4 +-
 arch/sparc/kernel/leon_pci_grpci2.c |   4 +-
 arch/sparc/kernel/pcic.c            |  80 +---------
 arch/sparc/lib/Makefile             |   2 +-
 8 files changed, 57 insertions(+), 403 deletions(-)
