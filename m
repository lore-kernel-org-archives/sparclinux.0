From: Babu Moger <babu.moger@oracle.com>
Date: Sat, 20 May 2017 00:16:54 +0000
Subject: [PATCH v2 0/7] Enable queued rwlock and queued spinlock for SPARC
Message-Id: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This series of patches enables queued rwlock and queued spinlock support
for SPARC. These features were introduced some time ago in upstream.
Here are some of the earlier discussions.
https://lwn.net/Articles/572765/
https://lwn.net/Articles/582200/
https://lwn.net/Articles/561775/
https://lwn.net/Articles/590243/

Tests: Ran AIM7 benchmark to verify the performance on various workloads.
https://github.com/davidlohr/areaim. Same benchmark was used when this
feature was introduced and enabled on x86. Here are the test results.

Kernel				4.11.0-rc6     4.11.0-rc6 + 	Change
				baseline	queued locks
			      (Avg No.of jobs) (Avg No.of jobs)
Workload
High systime 10-100 user	 17290.48	 17295.18	+0.02
High systime 200-1000 users	109814.95	110248.87	+0.39
High systime 1200-2000 users	107912.40	127923.16	+18.54

Disk IO 10-100 users		168910.16	158834.17	-5.96
Disk IO 200-1000 users		242781.74	281285.80	+15.85
Disk IO 1200-2000 users		228518.23	218421.23	-4.41

Disk IO 10-100 users		183933.77	207928.67	+13.04
Disk IO 200-1000 users		491981.56	500162.33	+1.66
Disk IO 1200-2000 users		463395.66	467312.70	+0.84

fserver 10-100 users		254177.53	270283.08	+6.33
fserver IO 200-1000 users	269017.35	324812.2	+20.74
fserver IO 1200-2000 users	229538.87	284713.77	+24.03

Disk I/O results are little bit in negative territory. But majority of the 
performance changes are in positive and it is significant in some cases.

Changes:
v1->v2:
Addressed the comments from David Miller.
1. Added CPU_BIG_ENDIAN for all SPARC
2. Removed #ifndef __LINUX_SPINLOCK_TYPES_H guard from spinlock_types.h
3. Removed check for CONFIG_QUEUED_RWLOCKS in SPARC64 as it is the 
   default definition for SPARC64 now. Cleaned-up the previous arch_read_xxx
   and arch_write_xxx definitions as it is defined now in qrwlock.h.
4. Removed check for CONFIG_QUEUED_SPINLOCKS in SPARC64 as it is the default
   definition now for SPARC64 now. Cleaned-up the previous arch_spin_xxx
   definitions as it is defined in qspinlock.h. 

v1: Initial version

Babu Moger (7):
  kernel/locking: Fix compile error with qrwlock.c
  arch/sparc: Remove the check #ifndef __LINUX_SPINLOCK_TYPES_H
  arch/sparc: Define config parameter CPU_BIG_ENDIAN
  arch/sparc: Introduce cmpxchg_u8 SPARC
  arch/sparc: Enable queued rwlocks for SPARC
  arch/sparc: Introduce xchg16 for SPARC
  arch/sparc: Enable queued spinlock support for SPARC

 arch/sparc/Kconfig                      |    6 +
 arch/sparc/include/asm/cmpxchg_64.h     |   76 ++++++++++--
 arch/sparc/include/asm/qrwlock.h        |    7 +
 arch/sparc/include/asm/qspinlock.h      |    7 +
 arch/sparc/include/asm/spinlock_64.h    |  208 +------------------------------
 arch/sparc/include/asm/spinlock_types.h |   12 ++-
 include/asm-generic/qrwlock_types.h     |    6 +-
 kernel/locking/qrwlock.c                |    1 +
 8 files changed, 101 insertions(+), 222 deletions(-)
 create mode 100644 arch/sparc/include/asm/qrwlock.h
 create mode 100644 arch/sparc/include/asm/qspinlock.h

