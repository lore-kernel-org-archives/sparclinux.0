From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 19:23:33 +0000
Subject: [RFC] sparc32 genirq support
Message-Id: <20110213192333.GA25042@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have over the weekend tried to port sparc32 to support genirq.
This is based on an old patch by David Miller.

I have concentrated on sum4m - as this is HW I have.
Status is that booting hangs in calibrate_delay() which
gives us a good hint that the timer interrupt is not working.

I have tried to debug it but ran out of ideas for now.

Note: Please do not look at sun4c + sun4d - code
is only included if someone wanted to build it.

Also - I have not looked at leon.


The diffstat looks promising:
 arch/sparc/Kconfig                 |    5 +-
 arch/sparc/include/asm/irq_32.h    |    8 +-
 arch/sparc/include/asm/system_32.h |    5 -
 arch/sparc/kernel/Makefile         |    4 -
 arch/sparc/kernel/irq.h            |   70 +++---
 arch/sparc/kernel/irq_32.c         |  502 ++++++++++--------------------------
 arch/sparc/kernel/leon_kernel.c    |    2 +-
 arch/sparc/kernel/of_device_32.c   |   59 +----
 arch/sparc/kernel/pcic.c           |   42 ---
 arch/sparc/kernel/sun4c_irq.c      |  139 ++++++----
 arch/sparc/kernel/sun4d_irq.c      |  453 +++++++++++++-------------------
 arch/sparc/kernel/sun4m_irq.c      |  193 +++++++-------
 arch/sparc/kernel/sun4m_smp.c      |    2 +-
 arch/sparc/kernel/time_32.c        |    2 +-
 14 files changed, 546 insertions(+), 940 deletions(-)

The first three patches are preparational patches:

      sparc32: introduce sparc_irq_config
      sparc32: introduce build_device_irq
      sparc32,sun4m: made a few structs global

Theey need a fresh-up of the changelog - otherwise I consider
these OK.

The last patch is the actual conversion. And by nature it
is rather big (and not easy to read either).

handler_irq() in irq_32.c is a rough copy of the sparc64 variant.
But I may have missed something obvious.

In pcic.c I deleted some enable/disable functions.
I simply fail to see how they were used before - but it is
likely that I need to re-introduce these again.

For now my problem is that my timer interrupt never seems
to trigger thus causing the hang in calibrate_delay()

Any input is appreciated - especially the setup of
the genirq stuff etc.

	Sam
