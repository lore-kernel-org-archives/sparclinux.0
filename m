From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 20:33:30 +0000
Subject: sparc: fix a few sparse warnings
Message-Id: <20081207203330.GA27505@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave et al.

I spent a few hours fixing some trivial sparse warnings.
I spent some time trying to find a good way to fix
the floppy related warnings from irq_32.c but gave up.

The best solution would be to move the interrupt
handler to floppy_32.h (as we do with sparc64) so
we keep the dependencies local.
And if we do this maybe we should just rewrite it to C
anyway. But that requires some sparc assembler knowledge,
and the real gain is minimal so I dropped it.

The patches add more lines than they remove - mostly
because this is about adding proper extern decalarations
for several functions.

I decided to go for a common entry.h file.
Because I hope there will be more shared stuff in there
over time.
And the same argument applies for kernel.h.

There are 138 warnings to go in kernel/ and many of these
are simple to fix. But they are for another day.

	Sam

Sam Ravnborg (5):
      sparc: fix sparse warning in kernel/pmc.c
      sparc: fix trivial style issues in kernel/pmc.c
      sparc: fix sparse warnings in traps_32.c
      sparc: add include guards to kernel.h
      sparc: fix sparse warnings in irq_32.c

 arch/sparc/include/asm/irq_32.h |    1 +
 arch/sparc/kernel/entry.h       |   39 ++++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/irq_32.c      |    7 ++++---
 arch/sparc/kernel/kernel.h      |   23 +++++++++++++++++++++++
 arch/sparc/kernel/muldiv.c      |    5 ++---
 arch/sparc/kernel/pmc.c         |   18 +++++++++---------
 arch/sparc/kernel/sun4d_irq.c   |    2 +-
 arch/sparc/kernel/traps_32.c    |   34 +++-------------------------------
 8 files changed, 81 insertions(+), 48 deletions(-)

