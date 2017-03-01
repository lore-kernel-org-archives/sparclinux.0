From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 01 Mar 2017 00:14:40 +0000
Subject: [PATCH v2 0/3] Zeroing hash tables in allocator
Message-Id: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, sparclinux@vger.kernel.org

Changes:
v1 -> v2: Reverted NG4memcpy() changes

On large machines hash tables can be many gigabytes in size and it is
inefficient to zero them in a loop without platform specific optimizations.

Using memset() provides a standard platform optimized way to zero the
memory.

Pavel Tatashin (3):
  sparc64: NG4 memset 32 bits overflow
  mm: Zeroing hash tables in allocator
  mm: Updated callers to use HASH_ZERO flag

 arch/sparc/lib/NG4memset.S          |   26 +++++++++++++-------------
 fs/dcache.c                         |   18 ++++--------------
 fs/inode.c                          |   14 ++------------
 fs/namespace.c                      |   10 ++--------
 include/linux/bootmem.h             |    1 +
 kernel/locking/qspinlock_paravirt.h |    3 ++-
 kernel/pid.c                        |    7 ++-----
 mm/page_alloc.c                     |   12 +++++++++---
 8 files changed, 35 insertions(+), 56 deletions(-)

