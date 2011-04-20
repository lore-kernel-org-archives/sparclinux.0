From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 20:06:48 +0000
Subject: [PATCH 0/3] sparc32: fix section mismatch warnings + cpu
Message-Id: <20110420200647.GA31101@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Following three patches fix all section mismatch warnings
in the typical sparc32 builds I do.

The easy fix for the section mismatch warnings in cpu.c was
to add a bit of annotation but I took a deeper look at it.
From my analysis there was no reason to call cpu_probe()
each time we bring a new CPU online. So the code
was made similar to sparc64 which only probe once
during startup.

When I was there the show_cpuinfo code was moved from setup_{32,64}.c
to cpu.c where it belongs. This consolidated a few trivial functions.

The consolidation will only pay-off if we make show_cpuinfo the
same for 32 and 64 bit - but I did not do so this time.

The patch-set is run-time tested on a UP sparc32 box.
And build tested on SMP/non-SMP for both sparc32 and sparc64.

The fixes in apc, pmc and time_32 were all trivial mis-annotations.
I am not sure if this fix a potential bug.

	Sam

Patches are made on top of sparc-next as of today (on top of genirq patch)

Sam Ravnborg (3):
      sparc32: fix section mismatch warnings in apc, pmc and time_32
      sparc: consolidate show_cpuinfo in cpu.c
      sparc32: probe for cpu info only during startup

 arch/sparc/include/asm/leon.h       |    1 -
 arch/sparc/include/asm/pgtable_64.h |    3 +
 arch/sparc/include/asm/smp_64.h     |    4 +
 arch/sparc/include/asm/system_64.h  |    4 -
 arch/sparc/kernel/apc.c             |    2 +-
 arch/sparc/kernel/cpu.c             |  139 +++++++++++++++++++++++++++++++++--
 arch/sparc/kernel/devices.c         |    2 -
 arch/sparc/kernel/kernel.h          |    4 +-
 arch/sparc/kernel/leon_smp.c        |    2 -
 arch/sparc/kernel/perf_event.c      |    1 +
 arch/sparc/kernel/pmc.c             |    2 +-
 arch/sparc/kernel/setup_32.c        |   69 -----------------
 arch/sparc/kernel/setup_64.c        |   78 -------------------
 arch/sparc/kernel/sun4d_smp.c       |    2 -
 arch/sparc/kernel/sun4m_smp.c       |    2 -
 arch/sparc/kernel/time_32.c         |    2 +-
 16 files changed, 144 insertions(+), 173 deletions(-)
