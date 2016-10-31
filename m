From: David Miller <davem@davemloft.net>
Date: Mon, 31 Oct 2016 01:04:26 +0000
Subject: [GIT] Sparc
Message-Id: <20161030.210426.1467743348902484606.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Several sparc64 bug fixes here:

1) Make the user copy routines on sparc64 return a properly accurate
   residual length when an exception occurs.

2) We can get enormous kernel TLB range flush requests from vmalloc
   unmaps, so handle these more gracefully by doing full flushes
   instead of going page-by-page.

3) Cope properly with negative branch offsets in sparc jump-label
   support, from James Clarke.

4) Some old-style decl GCC warning fixups from Tobias Klauser.

Please pull, thanks a lot!

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to a74ad5e660a9ee1d071665e7e8ad822784a2dc7f:

  sparc64: Handle extremely large kernel TLB range flushes more gracefully. (2016-10-27 09:11:05 -0700)

----------------------------------------------------------------
Atish Patra (1):
      sparc64: Setup a scheduling domain for highest level cache.

David S. Miller (16):
      sparc64: Delete __ret_efault.
      sparc64: Prepare to move to more saner user copy exception handling.
      sparc64: Convert copy_in_user to accurate exception reporting.
      sparc64: Convert GENcopy_{from,to}_user to accurate exception reporting.
      sparc64: Convert U1copy_{from,to}_user to accurate exception reporting.
      sparc64: Convert NG4copy_{from,to}_user to accurate exception reporting.
      sparc64: Convert NGcopy_{from,to}_user to accurate exception reporting.
      sparc64: Convert NG2copy_{from,to}_user to accurate exception reporting.
      sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.
      sparc64: Delete now unused user copy assembler helpers.
      sparc64: Delete now unused user copy fixup functions.
      sparc64: Fix illegal relative branches in hypervisor patched TLB code.
      sparc64: Handle extremely large kernel TSB range flushes sanely.
      sparc64: Fix instruction count in comment for __hypervisor_flush_tlb_pending.
      sparc64: Fix illegal relative branches in hypervisor patched TLB cross-call code.
      sparc64: Handle extremely large kernel TLB range flushes more gracefully.

James Clarke (1):
      sparc: Handle negative offsets in arch_jump_label_transform

Tobias Klauser (2):
      sparc64: Fix old style declaration GCC warnings
      sparc32: Fix old style declaration GCC warnings

 arch/sparc/include/asm/cpudata_64.h  |   5 +-
 arch/sparc/include/asm/spinlock_32.h |   2 +-
 arch/sparc/include/asm/spinlock_64.h |  12 +--
 arch/sparc/include/asm/topology_64.h |   8 +-
 arch/sparc/include/asm/uaccess_64.h  |  28 +------
 arch/sparc/kernel/head_64.S          |  37 ---------
 arch/sparc/kernel/jump_label.c       |  23 ++++--
 arch/sparc/kernel/mdesc.c            |  46 ++++++-----
 arch/sparc/kernel/smp_64.c           |   8 ++
 arch/sparc/lib/GENcopy_from_user.S   |   4 +-
 arch/sparc/lib/GENcopy_to_user.S     |   4 +-
 arch/sparc/lib/GENmemcpy.S           |  48 ++++++++----
 arch/sparc/lib/Makefile              |   2 +-
 arch/sparc/lib/NG2copy_from_user.S   |   8 +-
 arch/sparc/lib/NG2copy_to_user.S     |   8 +-
 arch/sparc/lib/NG2memcpy.S           | 228 +++++++++++++++++++++++++++++++++--------------------
 arch/sparc/lib/NG4copy_from_user.S   |   8 +-
 arch/sparc/lib/NG4copy_to_user.S     |   8 +-
 arch/sparc/lib/NG4memcpy.S           | 294 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 arch/sparc/lib/NGcopy_from_user.S    |   4 +-
 arch/sparc/lib/NGcopy_to_user.S      |   4 +-
 arch/sparc/lib/NGmemcpy.S            | 233 ++++++++++++++++++++++++++++++++++++------------------
 arch/sparc/lib/U1copy_from_user.S    |   8 +-
 arch/sparc/lib/U1copy_to_user.S      |   8 +-
 arch/sparc/lib/U1memcpy.S            | 345 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 arch/sparc/lib/U3copy_from_user.S    |   8 +-
 arch/sparc/lib/U3copy_to_user.S      |   8 +-
 arch/sparc/lib/U3memcpy.S            | 227 ++++++++++++++++++++++++++++++++++++-----------------
 arch/sparc/lib/copy_in_user.S        |  35 ++++++---
 arch/sparc/lib/user_fixup.c          |  71 -----------------
 arch/sparc/mm/tsb.c                  |  17 ++++
 arch/sparc/mm/ultra.S                | 374 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 32 files changed, 1400 insertions(+), 723 deletions(-)
 delete mode 100644 arch/sparc/lib/user_fixup.c
