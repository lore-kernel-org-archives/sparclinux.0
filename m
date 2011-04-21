From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Apr 2011 14:19:33 +0000
Subject: [PATCH 0/3] sparc32: boot_cpu_id patches
Message-Id: <4DB03CF5.9060308@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

The LEON patches in this series must be applied after the genirq patches 
[2..7] previously sent.

It adds support for LEON to boot on a CPU other than CPU0 on 
single-processor linux kernels. I have tried to clean up the boot_cpu_id 
initialization and move it to the DATA section and at the same time use 
the value to determine if it is the first CPU booting in the LEON case.

Happy easter everyone,
Daniel

---
 arch/sparc/include/asm/setup.h  |   12 +++++++++
 arch/sparc/kernel/head_32.S     |   51 
+++++++++++++++++++++-----------------
 arch/sparc/kernel/leon_kernel.c |   21 +++++++++-------
 arch/sparc/kernel/leon_smp.c    |    5 +++-
 arch/sparc/kernel/setup_32.c    |    4 +++
 arch/sparc/kernel/smp_32.c      |    2 -
 arch/sparc/kernel/sun4d_irq.c   |    5 +--
 7 files changed, 62 insertions(+), 38 deletions(-)

