From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 16 Dec 2013 04:19:30 +0000
Subject: [PATCH 0/3]  PREEMPT_RT support for Sparc64
Message-Id: <1387166853-10782-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, bigeasy@linutronix.de, Allen Pais <allen.pais@oracle.com>

PREEMPT_RT support for Sparc64. 
I have tested it on UltraSparc T4 (Niagara4).

Allen Pais (3):
  sparc64: use generic rwsem spinlocks rt
  sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
  sparc64: convert ctx_alloc_lock raw_spinlock_t

 arch/sparc/Kconfig                      |    7 +++----
 arch/sparc/include/asm/mmu_64.h         |    2 +-
 arch/sparc/include/asm/mmu_context_64.h |   10 +++++-----
 arch/sparc/kernel/smp_64.c              |    4 ++--
 arch/sparc/mm/init_64.c                 |   14 +++++++-------
 arch/sparc/mm/tsb.c                     |   20 ++++++++++----------
 6 files changed, 28 insertions(+), 29 deletions(-)

-- 
1.7.10.4

