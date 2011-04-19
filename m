From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 16:06:12 +0000
Subject: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <4DADB2F4.6070402@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Dave,

All the changes in this patch set [1..7] must be applied on top
of Sam genirq patch. The are all LEON specific.

They add:
 * mask/unmask spinlock protection
 * Support for LEON Extended IRQ controller
 * Use new genirq layer for per-cpu Timer ISR (cleanup)
 * other cleanups
 * add support for CPU affinity

Daniel Hellstrom

 arch/sparc/include/asm/leon.h   |   37 +----
 arch/sparc/kernel/entry.S       |   16 --
 arch/sparc/kernel/leon_kernel.c |  318 
++++++++++++++++++++++++---------------
 arch/sparc/kernel/leon_smp.c    |   12 +-
 4 files changed, 207 insertions(+), 176 deletions(-)

