From: David Miller <davem@davemloft.net>
Date: Thu, 14 Feb 2013 20:14:45 +0000
Subject: [GIT] Sparc
Message-Id: <20130214.151445.2165581579573329189.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


A couple small fixes for sparc including some THP brown-paper-bag
material:

1) During the merging of all the THP support for various architectures,
   sparc missed adding a HAVE_ARCH_TRANSPARENT_HUGEPAGE to it's Kconfig,
   oops.

2) Sparc needs to be mindful of hugepages in get_user_pages_fast().

3) Fix memory leak in SBUS probe, from Cong Ding.

4) The sunvdc virtual disk client driver has a test of the bitmask of
   vdisk server supported operations which was off by one bit.

Please pull, thanks a lot!

The following changes since commit 9a9284153d965a57edc7162a8e57c14c97f3a935:

  Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux (2013-01-20 20:55:49 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to f4d9605434c0fd4cc8639bf25cfc043418c52362:

  sunvdc: Fix off-by-one in generic_request(). (2013-02-14 11:49:01 -0800)

----------------------------------------------------------------
Cong Ding (1):
      sparc: kernel/sbus.c: fix memory leakage

David S. Miller (3):
      sparc64: Add missing HAVE_ARCH_TRANSPARENT_HUGEPAGE.
      sparc64: Fix get_user_pages_fast() wrt. THP.
      sunvdc: Fix off-by-one in generic_request().

 arch/sparc/Kconfig                  |  1 +
 arch/sparc/include/asm/pgtable_64.h | 14 ++++++--------
 arch/sparc/kernel/sbus.c            |  6 +++---
 arch/sparc/mm/gup.c                 | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/block/sunvdc.c              |  2 +-
 5 files changed, 68 insertions(+), 14 deletions(-)
