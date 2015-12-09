From: Petr Mladek <pmladek@suse.com>
Date: Wed, 09 Dec 2015 13:21:01 +0000
Subject: [PATCH v3 0/4] Cleaning printk stuff in NMI context
Message-Id: <1449667265-17525-1-git-send-email-pmladek@suse.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch set generalizes the already existing solution for
printing NMI messages. The main idea comes from Peter Zijlstra.

Changes against v2:

  + fixed compilation problems reported by 0-day build robot

  + MN10300 and Xtensa architectures will get handled separately

  + dropped the patch that printed NMI messages directly when Oops
    in progress; it made the solution less reliable

  + made the size of the buffer configurable; use real numbers
    instead of PAGE_SIZE


Changes against v1:

  + rebased on top of 4.4-rc2; there the old implementation was
    moved to lib/nmi_backtrace.c and used also on arm; I hope that
    I got the arm side correctly; I was not able to test on arm :-(

  + defined HAVE_NMI on arm for !CPU_V7M instead of !CPU_V7;
    handle_fiq_as_nmi() is called from entry-armv.S that
    is compiled when !CPU_V7M

  + defined HAVE_NMI also on mips; it calls nmi_enter() and
    seems to have real NMIs (or am I wrong?)

  + serialized backtraces when printing directly
    (oops_in_progress)


Petr Mladek (4):
  printk/nmi: Generic solution for safe printk in NMI
  printk/nmi: Use IRQ work only when ready
  printk/nmi: Warn when some message has been lost in NMI context
  printk/nmi: Increase the size of NMI buffer and make it configurable

 arch/Kconfig                  |   7 ++
 arch/arm/Kconfig              |   2 +
 arch/arm/kernel/smp.c         |   2 +
 arch/avr32/Kconfig            |   1 +
 arch/blackfin/Kconfig         |   1 +
 arch/cris/Kconfig             |   1 +
 arch/mips/Kconfig             |   1 +
 arch/powerpc/Kconfig          |   1 +
 arch/s390/Kconfig             |   1 +
 arch/sh/Kconfig               |   1 +
 arch/sparc/Kconfig            |   1 +
 arch/tile/Kconfig             |   1 +
 arch/x86/Kconfig              |   1 +
 arch/x86/kernel/apic/hw_nmi.c |   1 -
 include/linux/hardirq.h       |   2 +
 include/linux/percpu.h        |   3 -
 include/linux/printk.h        |  12 ++-
 init/Kconfig                  |  27 ++++++
 init/main.c                   |   1 +
 kernel/printk/Makefile        |   1 +
 kernel/printk/nmi.c           | 218 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c        |  29 +++---
 kernel/printk/printk.h        |  55 +++++++++++
 lib/nmi_backtrace.c           |  89 +----------------
 24 files changed, 352 insertions(+), 107 deletions(-)
 create mode 100644 kernel/printk/nmi.c
 create mode 100644 kernel/printk/printk.h

-- 
1.8.5.6

