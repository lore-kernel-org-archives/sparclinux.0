From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 02 Mar 2017 05:33:41 +0000
Subject: [PATCH v3 0/4] Zeroing hash tables in allocator
Message-Id: <1488432825-92126-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org

Changes:
v3 -> v2: Added a new patch for adaptive hash table scaling as suggested by
Andi Kleen
v1 -> v2: Reverted NG4memcpy() changes

Pavel Tatashin (4):
  sparc64: NG4 memset 32 bits overflow
  mm: Zeroing hash tables in allocator
  mm: Updated callers to use HASH_ZERO flag
  mm: Adaptive hash table scaling

 arch/sparc/lib/NG4memset.S          |   26 +++++++++++++-------------
 fs/dcache.c                         |   18 ++++--------------
 fs/inode.c                          |   14 ++------------
 fs/namespace.c                      |   10 ++--------
 include/linux/bootmem.h             |    2 ++
 kernel/locking/qspinlock_paravirt.h |    3 ++-
 kernel/pid.c                        |    7 ++-----
 mm/page_alloc.c                     |   31 ++++++++++++++++++++++++++++---
 8 files changed, 55 insertions(+), 56 deletions(-)

