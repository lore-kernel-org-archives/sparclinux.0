From: David Miller <davem@davemloft.net>
Date: Thu, 19 Mar 2015 04:59:15 +0000
Subject: [GIT] Sparc
Message-Id: <20150319.005915.1876746842081223499.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Some command cases of semtimedop() not even handled due to
   miscoded comparison on sparc64.  From Rob Gardner.

2) Due to two bugs, /proc/kcore wan't working properly on sparc.

3) Make sure fatal traps stop all running cpus, from Dave
   Kleikamp.

Please pull, thanks!

The following changes since commit a38ecbbd0be025a6ecbbfd22d2575a5b46317117:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2015-03-01 12:22:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 3c08158e0ef5d6a2d4ae21d9eda218c468bc774f:

  sparc: Fix /proc/kcore (2015-03-18 19:15:28 -0700)

----------------------------------------------------------------
Dave Kleikamp (1):
      sparc64: fatal trap should stop all cpus

David S. Miller (1):
      sparc: Fix /proc/kcore

Ricardo Ribalda (1):
      sparc: io_64.h: Replace io function-link macros

Rickard Strandqvist (2):
      arch: sparc: kernel: traps_64.c: Remove some unused functions
      arch: sparc: kernel: starfire.c: Remove unused function

Rob Gardner (1):
      sparc: semtimedop() unreachable due to comparison error

 arch/sparc/Kconfig                |  3 +++
 arch/sparc/include/asm/io_64.h    | 20 ++++++++++----------
 arch/sparc/include/asm/starfire.h |  1 -
 arch/sparc/kernel/entry.h         |  4 ----
 arch/sparc/kernel/smp_64.c        | 27 ++++++++++++++++++++++++---
 arch/sparc/kernel/starfire.c      |  5 -----
 arch/sparc/kernel/sys_sparc_64.c  |  2 +-
 arch/sparc/kernel/traps_64.c      | 30 ++----------------------------
 arch/sparc/mm/init_64.c           |  2 +-
 9 files changed, 41 insertions(+), 53 deletions(-)
