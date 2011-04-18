From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 18 Apr 2011 21:22:48 +0000
Subject: [PATCH 0/3 v4] sparc32: genirq support
Message-Id: <20110418212248.GA13576@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I consider the patchset to add genirq support to sparc32
ready to be applied to sparc-next.

I do so despite less testing than what I had planned.

Chris Newport has kindly donated his Sparc Server 1000 to me.
But my attempts to get latest linux running on the box has so far failed.
The box runs Solaris - so HW is OK.

I have also purchased a Sparc Station IPX - but again has my
attempts to get a kernel operational failed.

So testing has concentrated on sun4m + leon based machines.

Changes in v4:
- include shutdown support (from Daniel Hellstrom)
- protect irq_alloc, irq_link operation with a spinloc (partly from Daniel Hellstrom)
- renamed the handlers to level/edge (partly from Daniel Hellstrom)
- introduced the generic show_interrupt() (based on the sparc64 variant)
- one rename has been split out in a separate patch
- A third patch is included that makes the init code more readable
  in irq_32.c. It fooled me - so some cleanup was required.


The diff is not easy to read. I could have jumped high and low
to make it a bit easier to read but I just dropped doing so.
A proper review require both old and new codebase at the same time.

Any comments are as always appreciated!

	Sam


Sam Ravnborg (3):
      sparc32,sun4d: rename sbus_tid to board_to_cpu in irq support
      sparc32: cleanup code for irq init
      sparc32: genirq support
 

 arch/sparc/Kconfig                 |    6 +-
 arch/sparc/include/asm/floppy_32.h |   40 ++-
 arch/sparc/include/asm/irq_32.h    |    6 +-
 arch/sparc/include/asm/pcic.h      |   10 +-
 arch/sparc/include/asm/system_32.h |    5 -
 arch/sparc/kernel/Makefile         |    4 -
 arch/sparc/kernel/irq.h            |   45 ++--
 arch/sparc/kernel/irq_32.c         |  503 ++++++++----------------------------
 arch/sparc/kernel/kernel.h         |    1 +
 arch/sparc/kernel/leon_kernel.c    |   70 ++++-
 arch/sparc/kernel/pcic.c           |   83 ++++--
 arch/sparc/kernel/sun4c_irq.c      |  150 +++++++-----
 arch/sparc/kernel/sun4d_irq.c      |  480 ++++++++++++----------------------
 arch/sparc/kernel/sun4m_irq.c      |  179 +++++++------
 arch/sparc/kernel/sun4m_smp.c      |   16 +-
 15 files changed, 652 insertions(+), 946 deletions(-)
