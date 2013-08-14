From: Arpit Goel <B44344@freescale.com>
Date: Wed, 14 Aug 2013 07:15:53 +0000
Subject: [PATCH v2 0/2] Make PPC macro spin_event_timeout() architecture independent
Message-Id: <1376463835-13040-1-git-send-email-B44344@freescale.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch-set moves USECS_PER_JIFFY to architecture timex.h from architecture
specific C files. Patch-set further uses this to make PPC macro
spin_event_timeout() architecture independent. This change enables drivers to
use spin_event_timeout() even in non-PowerPC based SoC's.

This patchset has been compiled for ARM, PowerPC and x86.

Patch[1/2] : Moves USECS_PER_JIFFY to architecture specific timex.h files from
	     architecture specific C files.

Patch[2/2] : Converts PPC macro spin_event_timeout() in architecture independent
	     macro.

Changes in v2:
	Patch[1/2] Adds USEC_PER_JIFFY to linux/timex.h
	Patch[2/2] uses usecs_to_jiffies for conversion

Arpit Goel (2):
  Make USECS_PER_JIFFY available for generic use
  Convert PowerPC macro spin_event_timeout() to architecture independent
    macro

 arch/arm/include/asm/timex.h      |  2 ++
 arch/arm/kernel/time.c            |  3 ---
 arch/m32r/include/asm/timex.h     |  2 ++
 arch/m32r/kernel/time.c           |  3 ---
 arch/m68k/hp300/time.c            |  4 +---
 arch/m68k/include/asm/timex.h     |  2 ++
 arch/s390/include/asm/timex.h     |  2 ++
 arch/s390/kernel/time.c           |  2 --
 arch/sparc/include/asm/timex_32.h |  2 ++
 arch/sparc/include/asm/timex_64.h |  2 ++
 arch/sparc/kernel/pcic.c          |  1 -
 include/linux/delay.h             | 40 +++++++++++++++++++++++++++++++++++++++
 include/linux/timex.h             |  5 +++++
 13 files changed, 58 insertions(+), 12 deletions(-)

-- 
1.8.1.4


