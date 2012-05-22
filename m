From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2012 20:06:37 +0000
Subject: [RFC PATCH 0/5] first batch of leon adaptions
Message-Id: <20120522200637.GA9804@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I wanted feedback on the changes in head_32.S and
decided to send out what I considered ready for now.

This set does not yet include the run-time patching
as discussed the other day.
I decided to postpone this until next batch as I have
not prepared any users of it yet.

But again - main point here is feedback
on the head_32.S changes as I do not feel too
familiar with SPARC assembler just yet.

At least it boots on my ss5 box :-)

I am btw. utterly confused by the handling of
secondary cpus for leon.
For some reason there is a direct call to
leon_smp_cpu_startup: in trampoline_32.S.

But sun4m does not need such a trick.

	Sam

Sam Ravnborg (5):
      sparc32: whitespace cleanup in head_32.S
      sparc32: implement proper LEON support in head_32 (before highmem)
      sparc32: implement proper LEON support in head_32 (after highmem)
      sparc32: handle leon in cpu.c
      sparc32: handle leon in irq_32.c

 arch/sparc/include/asm/psr.h |    6 +++
 arch/sparc/kernel/cpu.c      |   18 ++++----
 arch/sparc/kernel/head_32.S  |   96 ++++++++++++++++++++++++++++++++----------
 arch/sparc/kernel/irq_32.c   |   22 +++++----
 4 files changed, 100 insertions(+), 42 deletions(-)
