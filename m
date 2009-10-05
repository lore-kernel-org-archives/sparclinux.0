From: David Miller <davem@davemloft.net>
Date: Mon, 05 Oct 2009 09:02:10 +0000
Subject: [GIT]: Sparc
Message-Id: <20091005.020210.175814860.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Lots of perf improvements, all cache and hw events on supported
   chips are there.

   And with a little bit more work I'll be able to enable both
   counters at once instead of one at a time like it is now.

2) Use asm-generic/hardirq.h, from Christoph Hellwig with help
   from Andrew Morton.

3) Build fix after poll.h removal of sched.h from Stephen Rothwell.

Please pull, thanks a lot!

The following changes since commit 0d9df2515dbceb67d343c0f10fd3ff218380d524:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../sam/kbuild-fixes

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Christoph Hellwig (1):
      sparc32: convert to asm-generic/hardirq.h

David S. Miller (10):
      sparc: Support HW cache events.
      sparc: Support all ultra3 and ultra4 derivatives.
      sparc: Add Niagara2 HW cache event support.
      sparc: Niagara1 perf event support.
      sparc64: Add initial perf event conflict resolution and checks.
      sparc64: Increase vmalloc size to fix percpu regressions.
      sparc64: Add a basic conflict engine in preparation for multi-counter support.
      sparc64: Minor coding style fixups in perf code.
      sparc64: Fix comment typo in perf_event.c
      sparc64: Cache per-cpu %pcr register value in perf code.

Stephen Rothwell (1):
      sparc: using HZ needs an include of linux/param.h

 arch/sparc/include/asm/hardirq_32.h |   12 +-
 arch/sparc/include/asm/irq_32.h     |    4 +-
 arch/sparc/include/asm/pgtable_64.h |    4 +-
 arch/sparc/kernel/ktlb.S            |    8 +-
 arch/sparc/kernel/perf_event.c      |  577 ++++++++++++++++++++++++++++++++---
 arch/sparc/oprofile/init.c          |    1 +
 6 files changed, 547 insertions(+), 59 deletions(-)
