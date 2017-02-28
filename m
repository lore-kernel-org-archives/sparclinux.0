From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 28 Feb 2017 14:55:43 +0000
Subject: [PATCH v1 0/3] Zeroing hash tables in allocator
Message-Id: <1488293746-965735-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, sparclinux@vger.kernel.org

On large machines hash tables can be many gigabytes in size and it is
inefficient to zero them in a loop without platform specific optimizations.

Using memset() provides a standard platform optimized way to zero the
memory.

Pavel Tatashin (3):
  sparc64: NG4 memset/memcpy 32 bits overflow
  mm: Zeroing hash tables in allocator
  mm: Updated callers to use HASH_ZERO flag

 arch/sparc/lib/NG4memcpy.S          |   71 ++++++++++++++++-------------------
 arch/sparc/lib/NG4memset.S          |   26 ++++++------
 fs/dcache.c                         |   18 ++-------
 fs/inode.c                          |   14 +------
 fs/namespace.c                      |   10 +----
 include/linux/bootmem.h             |    1 +
 kernel/locking/qspinlock_paravirt.h |    3 +-
 kernel/pid.c                        |    7 +--
 mm/page_alloc.c                     |   12 ++++-
 9 files changed, 67 insertions(+), 95 deletions(-)

