From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 27 Apr 2011 13:18:43 +0000
Subject: [PATCH 0/3] sparc32: SMP IPI patches
Message-Id: <4DB817B3.5050205@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Dave,

I have made a new set of IPI patches, this time it includes a patch for 
SUN4M but still missing SUN4D however.

I have tried to use BTFIXUPs and extract some code from the LEON to the 
common smp_32.c as you suggested. I have left the non-spinlock LEON code 
around per-cpu work data as we discussed, I think the same argumentation 
works for sun4m to avoid races when clearing the pending register in the 
interrupt trap handler.

This time I added some IPI IRQ statistics to the genirq 
arch_show_interrupts(),
so the patches must be applied to sparc-next containing genirq patches.

Daniel

 arch/sparc/Kconfig                  |    3 +-
 arch/sparc/include/asm/cpudata_32.h |    5 ++
 arch/sparc/include/asm/leon.h       |    4 +-
 arch/sparc/include/asm/smp_32.h     |   22 +++----
 arch/sparc/kernel/entry.S           |   45 +++++++++++++-
 arch/sparc/kernel/irq_32.c          |   10 +++
 arch/sparc/kernel/leon_smp.c        |  109 
++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/smp_32.c          |   52 +++++++++++++++--
 arch/sparc/kernel/sun4m_smp.c       |   29 +++++++++
 9 files changed, 251 insertions(+), 28 deletions(-)

