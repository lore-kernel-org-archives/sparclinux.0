From: David Miller <davem@davemloft.net>
Date: Wed, 14 May 2008 01:19:48 +0000
Subject: [GIT]: Sparc
Message-Id: <20080513.181948.168654633.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This has:

1) The mremap() validation fix that you noticed go to
   stable :-)

2) An edge case for the LMB library, and another change to
   make it's debugging facilities more useful.

3) Make sparc64 use a TS_RESTORE_SIGMASK just like x86 does.

Please pull, thanks a lot!

The following changes since commit c714a534d85576af21b06be605ca55cb2fb887ee:
  Linus Torvalds (1):
        Make 'cond_resched()' nullification depend on PREEMPT_BKL

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      sparc: Fix mremap address range validation.
      lmb: Fix inconsistent alignment of size argument.
      lmb: Make lmb debugging more useful.
      sparc64: Use a TS_RESTORE_SIGMASK

 arch/sparc/kernel/sys_sparc.c     |   48 ++++---------------------------------
 arch/sparc64/kernel/rtrap.S       |    6 ++--
 arch/sparc64/kernel/signal.c      |   21 ++++++++-------
 arch/sparc64/kernel/signal32.c    |   13 ++++-----
 arch/sparc64/kernel/sys_sparc.c   |   36 +++------------------------
 arch/sparc64/kernel/sys_sparc32.c |   33 +-----------------------
 include/asm-sparc/mman.h          |    5 +--
 include/asm-sparc64/mman.h        |    5 +--
 include/asm-sparc64/thread_info.h |   28 ++++++++++++++++++---
 lib/lmb.c                         |   45 +++++++++++++++++++++++-----------
 10 files changed, 89 insertions(+), 151 deletions(-)
