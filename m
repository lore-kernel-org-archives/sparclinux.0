From: David Miller <davem@davemloft.net>
Date: Fri, 24 Oct 2014 17:32:49 +0000
Subject: [GIT] Sparc
Message-Id: <20141024.133249.71272218161411159.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two bug fixes:

1) Fix boots with gcc-4.9 compiled sparc64 kernels.

2) Add missing __get_user_pages_fast() on sparc64 to fix hangs
   on futexes used in transparent hugepage areas.

   It's really idiotic to have a weak symbolled fallback that just
   returns zero, and causes this kind of bug.  There should be no
   backup implementation and the link should fail if the architecture
   fails to provide __get_user_pages_fast() and supports transparent
   hugepages.

Thanks.

The following changes since commit 61ed53deb1c6a4386d8710dbbfcee8779c381931:

  Merge tag 'ntb-3.18' of git://github.com/jonmason/ntb (2014-10-19 12:58:22 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 06090e8ed89ea2113a236befb41f71d51f100e60:

  sparc64: Implement __get_user_pages_fast(). (2014-10-24 09:59:02 -0700)

----------------------------------------------------------------
David S. Miller (2):
      sparc64: Fix register corruption in top-most kernel stack frame during boot.
      sparc64: Implement __get_user_pages_fast().

 arch/sparc/include/asm/oplib_64.h |  3 ++-
 arch/sparc/include/asm/setup.h    |  2 ++
 arch/sparc/kernel/entry.h         |  3 ---
 arch/sparc/kernel/head_64.S       | 40 ++++------------------------------------
 arch/sparc/kernel/hvtramp.S       |  1 -
 arch/sparc/kernel/setup_64.c      | 28 ++++++++++++++++++++--------
 arch/sparc/kernel/trampoline_64.S | 12 +++++++-----
 arch/sparc/mm/gup.c               | 30 ++++++++++++++++++++++++++++++
 arch/sparc/prom/cif.S             |  5 ++---
 arch/sparc/prom/init_64.c         |  6 +++---
 arch/sparc/prom/p1275.c           |  2 --
 11 files changed, 70 insertions(+), 62 deletions(-)
