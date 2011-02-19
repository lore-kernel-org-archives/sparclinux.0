From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 Feb 2011 15:44:56 +0000
Subject: [RFC] sparc32 genirq support v2
Message-Id: <20110219154456.GA6908@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Changes since v1 posting:
- My sun4m box is now working with the new patchset
- Introduced use of mask/unmask
- Introduced use of handle_level_irq
- sun4d is now converted (ready for review)
- Several bugfixes


There is still some TODO's:

sun4m:
     There is no replacement for smp_rotate that always scheduled
     next CPU as interrupt target upon an interrupt

sun4d:
     The original implmentation of enable/disable had:

          if (irq < NR_IRQS)
               return;

     The new implmentation does not distingush between SBUS and cpu
     interrupts.
     I am no sure what is right here. I assume we need to do
     something for the cpu interrupts.

leon:
    Not converted yet - I hope the Gaisler team will look into this!

We need these TODO's addressed before we can apply the patches.
Or at least the conversion patch.

The diffstat say that we add much more code than we delete.
But the reality is now that bad.
Some code has been expanded to increase readability.
And additiona comments has been added.

The end result is IMO more readable. But Now I have also spent
some hours getting familiar with the code.

	Sam

Sam Ravnborg (4):
      sparc32: introduce sparc_irq_config
      sparc32: introduce build_device_irq
      sparc32,sun4m: percpu and global register definitions moved to irq.h
      sparc32: genirq support

 arch/sparc/Kconfig                 |    5 +-
 arch/sparc/include/asm/floppy_32.h |   41 +--
 arch/sparc/include/asm/irq_32.h    |    8 +-
 arch/sparc/include/asm/system_32.h |    5 +
 arch/sparc/kernel/Makefile         |    4 +
 arch/sparc/kernel/irq.h            |   86 ++----
 arch/sparc/kernel/irq_32.c         |  509 ++++++++++++++++++++++++--------
 arch/sparc/kernel/kernel.h         |    7 +-
 arch/sparc/kernel/leon_kernel.c    |    2 +-
 arch/sparc/kernel/of_device_32.c   |   59 ++++-
 arch/sparc/kernel/pcic.c           |   42 +++
 arch/sparc/kernel/sun4c_irq.c      |  146 ++++------
 arch/sparc/kernel/sun4d_irq.c      |  575 +++++++++++++++++++++---------------
 arch/sparc/kernel/sun4m_irq.c      |  204 +++++++-------
 arch/sparc/kernel/sun4m_smp.c      |   16 +-
 arch/sparc/kernel/time_32.c        |    2 +-
 16 files changed, 1046 insertions(+), 665 deletions(-)

