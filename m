From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 29 Oct 2018 18:07:00 +0000
Subject: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep splats w/ kgdb
Message-Id: <20181029180707.207546-1-dianders@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Douglas Anderson <dianders@chromium.org>, nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, catalin.marinas@arm.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, mhocko@suse.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, marex@denx.de, sfr@canb.auug.org.au, ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org, linux@armlinux.org.uk, pombredanne@nexb.com, tony@atomide.com, mingo@redhat.com, joel@jms.id.au, linux-serial@vger.kernel.org, rolf.evers.fischer@aptiv.com, jhogan@kernel.org, asierra@xes-inc.com, linux-snps-arc@lists.infradead.org, dan.carpenter@oracle.com, ying.huang@intel.com

I started out this series trying to make sysrq work over the serial
console on qcom_geni_serial, then fell into a rat's nest.

To solve the deadlock I faced when enabling sysrq I tried to borrow
code from '8250_port.c' which avoided grabbing the port lock in
console_write().  ...but since these days I try to run with lockdep on
all the time, I found it caused an annoying lockdep splat (which I
also reproduced on my rk3399 board).  ...so I instead changed my
qcom_geni_serial solution to borrow code from 'msm_serial.c'

I wasn't super happy with the solution in 'msm_serial.c' though.  I
don't like releasing the spinlock there.  Not only is it ugly but it
means we are unlocking / re-locking _all the time_ even though sysrq
characters are rare.  ...so I came up with what I think is a better
solution and then implemented it for qcom_geni_serial.

Since I had a good way to test 8250-based UARTs, I also fixed that
driver to use my new method.  When doing so, I ran into a missing
msm_serial.c at all, so I didn't switch that (or all other serial
drivers for that matter) to the new method.

After fixing all the above issues, I found the next lockdep splat in
kgdb and I think I've worked around it in a good-enough way, but I'm
much less confident about this.  Hopefully folks can take a look at
it.

In general, patches earlier in this series should be "less
controversial" and hopefully can land even if people don't like
patches later in the series.  ;-)

Looking back, this is pretty much two series squashed that could be
treated indepdently.  The first is a serial series and the second is a
kgdb series.

For all serial patches I'd expect them to go through the tty tree once
they've been reviewed.

If folks are OK w/ the 'smp' patch it probably should go in some core
kernel tree.  The kgdb patch won't work without it, though, so to land
that we'd need coordination between the folks landing that and the
folks landing the 'smp' patch.


Douglas Anderson (7):
  serial: qcom_geni_serial: Finish supporting sysrq
  serial: core: Allow processing sysrq at port unlock time
  serial: qcom_geni_serial: Process sysrq at port unlock time
  serial: core: Include console.h from serial_core.h
  serial: 8250: Process sysrq at port unlock time
  smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
  kgdb: Remove irq flags and local_irq_enable/disable from roundup

 arch/arc/kernel/kgdb.c                      |  4 +--
 arch/arm/kernel/kgdb.c                      |  4 +--
 arch/arm64/kernel/kgdb.c                    |  4 +--
 arch/hexagon/kernel/kgdb.c                  | 11 ++----
 arch/mips/kernel/kgdb.c                     |  4 +--
 arch/powerpc/kernel/kgdb.c                  |  2 +-
 arch/sh/kernel/kgdb.c                       |  4 +--
 arch/sparc/kernel/smp_64.c                  |  2 +-
 arch/x86/kernel/kgdb.c                      |  9 ++---
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
 drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
 drivers/tty/serial/8250/8250_omap.c         |  6 +++-
 drivers/tty/serial/8250/8250_port.c         |  8 ++---
 drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
 include/linux/kgdb.h                        |  9 ++---
 include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
 kernel/debug/debug_core.c                   |  2 +-
 kernel/smp.c                                |  4 ++-
 18 files changed, 80 insertions(+), 53 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog
