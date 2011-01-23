From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 21:39:40 +0000
Subject: [RFC PATCH 0/7] sparc32: cleanup irq + smp files
Message-Id: <20110123213940.GA15063@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am slowly working towards the goal of migrating
sparc32 to genirq.
PArt of the job is to understand the current code-base.
While reading the code I was constantly distracted
by all the minor issues in these.

So I cooked up a few patches to clean up the files.

In general I did like this:
- Manually identified headers that was not needed
- Added comments from an old patch from davem
- Read through the file and fixed all the obvious stuff
- Ran checkpatch on each file and fixed what I considered relevant

The files does not pass checkpatch with no warnings - this
was not my goal.
But the readability has increased which is good.

The patchset is based on top of sparc-next and does not
include changes previously posted that updates sparc64
irq support.
I will rebase if/when these patches are applied to sparc-next.

The RFC patchset is sent out so people can comment on them.

Note: I could have split it up much further but I did
not see much gain in this. The current patchset looks
quite review-able to me.

Some of the files has gained several additional comments.
These are all from an old patch I got from davem.

The patch "sparc32: remove tick14.c" is the same as was sent
out yesterday.

	Sam

Sam Ravnborg (7):
      sparc32: remove tick14.c
      sparc32: add irq + smp declarations to headers
      sparc32,sun4c: irq file cleanup
      sparc32,sun4m: irq, smp files cleanup
      sparc32,sun4d: irq, smp files cleanup
      sparc32,sun4d: drop unused code in sun4d_distribute_irqs()
      sparc32,sun4d: add comment in empty statement in sun4d_request_irq()

 arch/sparc/include/asm/mmu_32.h |    3 +
 arch/sparc/include/asm/smp_32.h |    6 +
 arch/sparc/kernel/Makefile      |    1 -
 arch/sparc/kernel/irq_32.c      |    6 +-
 arch/sparc/kernel/kernel.h      |   47 ++++++++
 arch/sparc/kernel/setup_32.c    |   19 ++--
 arch/sparc/kernel/sun4c_irq.c   |   81 ++++++++-------
 arch/sparc/kernel/sun4d_irq.c   |  227 +++++++++++++++++---------------------
 arch/sparc/kernel/sun4d_smp.c   |  176 +++++++++++-------------------
 arch/sparc/kernel/sun4m_irq.c   |  182 ++++++++++++++++---------------
 arch/sparc/kernel/sun4m_smp.c   |   91 ++++------------
 arch/sparc/kernel/tick14.c      |   39 -------
 arch/sparc/prom/misc_32.c       |    4 -
 13 files changed, 394 insertions(+), 488 deletions(-)
