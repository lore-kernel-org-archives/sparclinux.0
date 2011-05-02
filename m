From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 02 May 2011 10:07:49 +0000
Subject: [PATCH 0/4 v2] sparc32: SMP IPI patches
Message-Id: <4DBE8275.5060604@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Dave,

I have made a new set of IPI patches, this time it includes patches for 
all SPARC32 architectures. It looks to me as if sun4d does not have a 
pending soft-IRQ register, so I handle it as a normal hard IRQ.

I'm not sure if I should add a STBAR/memory barrier or a spinlock to the 
sun4d implementation of smp4d_ipi_{single,mask_one,resched}. I'm a bit 
worried that the memory write happens after the IPI is generated to the 
other CPUs. Also, I'm not sure that IRQ14 is the best choice for IPI, 
the best is probably of put it on a separate IRQ but I don't know if 
there are free IRQs.

I hope that someone could try SMP on sun4m and sun4d with these patches.

Thanks,
Daniel

---

 arch/sparc/Kconfig                  |    3 +-
 arch/sparc/include/asm/cpudata_32.h |    5 ++
 arch/sparc/include/asm/leon.h       |    4 +-
 arch/sparc/include/asm/smp_32.h     |   22 +++----
 arch/sparc/kernel/entry.S           |   45 +++++++++++++-
 arch/sparc/kernel/irq.h             |    6 ++
 arch/sparc/kernel/irq_32.c          |   10 +++
 arch/sparc/kernel/leon_smp.c        |  109 
++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/smp_32.c          |   52 +++++++++++++++--
 arch/sparc/kernel/sun4d_irq.c       |    9 +++
 arch/sparc/kernel/sun4d_smp.c       |   79 +++++++++++++++++++++++++
 arch/sparc/kernel/sun4m_smp.c       |   29 +++++++++
 12 files changed, 345 insertions(+), 28 deletions(-)

