From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Apr 2012 16:06:28 +0000
Subject: [PATCH 0/2] generic clockevent support for sparc32
Message-Id: <20120406160628.GA17240@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

We have now support for generic clock events ready for sparc32.
The initial work was done by Tkhai and Konrad contributed the Leon support.

I have attributed Konrad with a "Tested-by:" - but not a Signed-off-by:.
I did not find a good way to attributer that he wrote the leon stuff.
But it is documented in the changelog description.

I consider the patchset ready for sparc-next - in the hope
that it may see a little more testing until next merge window.

The patch-set is too huge - but as this touches several
platforms I saw no easy way to further split it up :-(

Please apply.

	Sam


Sam Ravnborg:
	sparc32: rename sparc_irq_config to sparc_config

Tkhai Kirill <tkhai@yandex.ru>
	sparc32: generic clockevent support

 arch/sparc/kernel/irq.h               |   19 ++
 arch/sparc/kernel/leon_kernel.c       |   49 +++++++
 arch/sparc/kernel/pcic.c              |   48 ++++---
 arch/sparc/kernel/sun4c_irq.c         |   11 +
 arch/sparc/kernel/sun4d_irq.c         |   18 ++
 arch/sparc/kernel/sun4m_irq.c         |   22 ++-
 arch/sparc/kernel/time_32.c           |  216 +++++++++++++++++++++++++++-------
 b/arch/sparc/Kconfig                  |    7 -
 b/arch/sparc/include/asm/cpudata_32.h |    1
 b/arch/sparc/include/asm/leon.h       |    2
 b/arch/sparc/include/asm/timer_32.h   |   29 ++++
 b/arch/sparc/include/asm/timex_32.h   |    1
 b/arch/sparc/kernel/irq.h             |    6
 b/arch/sparc/kernel/irq_32.c          |    2
 b/arch/sparc/kernel/kernel.h          |    2
 b/arch/sparc/kernel/leon_kernel.c     |    4
 b/arch/sparc/kernel/leon_smp.c        |   34 -----
 b/arch/sparc/kernel/of_device_32.c    |    4
 b/arch/sparc/kernel/pcic.c            |    2
 b/arch/sparc/kernel/smp_32.c          |   21 ---
 b/arch/sparc/kernel/sun4c_irq.c       |    4
 b/arch/sparc/kernel/sun4d_irq.c       |    4
 b/arch/sparc/kernel/sun4d_smp.c       |   34 +----
 b/arch/sparc/kernel/sun4m_irq.c       |    4
 b/arch/sparc/kernel/sun4m_smp.c       |   38 ++---
 b/arch/sparc/kernel/time_32.c         |    3
 26 files changed, 378 insertions(+), 207 deletions(-)
