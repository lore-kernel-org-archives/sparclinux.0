From: Petr Mladek <pmladek@suse.com>
Date: Thu, 21 Apr 2016 11:48:41 +0000
Subject: [PATCH v5 0/4] Cleaning printk stuff in NMI context
Message-Id: <1461239325-22779-1-git-send-email-pmladek@suse.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch set generalizes the already existing solution for
printing NMI messages. The main idea comes from Peter Zijlstra.

v5 adds changes suggested by Sergey Senozhatsky. It should not longer
conflict with his async printk patchset.

There are some conflicts with the nmi_backtrace improvements
from Chris Metcalf, see
https://lkml.kernel.org/g/<1459877208-15119-1-git-send-email-cmetcalf@mellanox.com>
Feel free to ask me to resolve them.


Changes against v4:

  + merged 2nd patch into the 1st one to do not break bisection

  + set vprintk_nmi() early in nmi_enter() and set vprintk_default()
    later in nmi_exit() to make sure that all NMI messages are printed
    to the temporary ring buffer

  + used printk_deferred() when flushing the temporary buffers
    on panic in NMI; we do not longer need to touch vprintk_emit()
    and define the ugly macro deferred_console_in_nmi().


Changes against v3:

  + merged all small changes from -mm tree, including commit
    descriptions

  + disabled interrupts when taking the read_lock in __printk_nmi_flush();
    printk_nmi_flush() might be called from any context; reported
    by lockdep

  + never introduce NEED_PRINTK_NMI; in -mm tree was introduced
    in 1st patch and removed in the 4th one

  + flush NMI buffers when the system goes down (new 5th patch);
    addresses Daniel's concerns


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
  printk/nmi: generic solution for safe printk in NMI
  printk/nmi: warn when some message has been lost in NMI context
  printk/nmi: increase the size of NMI buffer and make it configurable
  printk/nmi: flush NMI messages on the system panic

 arch/Kconfig                  |   4 +
 arch/arm/Kconfig              |   1 +
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
 include/linux/printk.h        |  14 ++-
 init/Kconfig                  |  27 +++++
 init/main.c                   |   1 +
 kernel/kexec_core.c           |   1 +
 kernel/panic.c                |   6 +-
 kernel/printk/Makefile        |   1 +
 kernel/printk/internal.h      |  57 +++++++++
 kernel/printk/nmi.c           | 260 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c        |  31 ++---
 lib/nmi_backtrace.c           |  89 +--------------
 26 files changed, 401 insertions(+), 109 deletions(-)
 create mode 100644 kernel/printk/internal.h
 create mode 100644 kernel/printk/nmi.c

-- 
1.8.5.6

