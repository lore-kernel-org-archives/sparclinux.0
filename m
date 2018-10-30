From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 30 Oct 2018 11:56:28 +0000
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep splats w/ kgdb
Message-Id: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <20181029180707.207546-1-dianders@chromium.org>
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, catalin.marinas@arm.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, mhocko@suse.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, marex@denx.de, sfr@canb.auug.org.au, ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org, linux@armlinux.org.uk, pombredanne@nexb.com, tony@atomide.com, mingo@redhat.com, joel@jms.id.au, linux-serial@vger.kernel.org, rolf.evers.fischer@aptiv.com, jhogan@kernel.org, asierra@xes-inc.com, linux-snps-arc@lists.i

On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> Looking back, this is pretty much two series squashed that could be
> treated indepdently.  The first is a serial series and the second is a
> kgdb series.

Indeed.

I couldn't work out the link between the first 5 patches and the last 2
until I read this...

Is anything in the 01->05 patch set even related to kgdb? From the stack
traces it looks to me like the lock dep warning would trigger for any
sysrq. I think separating into two threads for v2 would be sensible.


Daniel.


> 
> For all serial patches I'd expect them to go through the tty tree once
> they've been reviewed.
> 
> If folks are OK w/ the 'smp' patch it probably should go in some core
> kernel tree.  The kgdb patch won't work without it, though, so to land
> that we'd need coordination between the folks landing that and the
> folks landing the 'smp' patch.
> 
> 
> Douglas Anderson (7):
>   serial: qcom_geni_serial: Finish supporting sysrq
>   serial: core: Allow processing sysrq at port unlock time
>   serial: qcom_geni_serial: Process sysrq at port unlock time
>   serial: core: Include console.h from serial_core.h
>   serial: 8250: Process sysrq at port unlock time
>   smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
>   kgdb: Remove irq flags and local_irq_enable/disable from roundup
> 
>  arch/arc/kernel/kgdb.c                      |  4 +--
>  arch/arm/kernel/kgdb.c                      |  4 +--
>  arch/arm64/kernel/kgdb.c                    |  4 +--
>  arch/hexagon/kernel/kgdb.c                  | 11 ++----
>  arch/mips/kernel/kgdb.c                     |  4 +--
>  arch/powerpc/kernel/kgdb.c                  |  2 +-
>  arch/sh/kernel/kgdb.c                       |  4 +--
>  arch/sparc/kernel/smp_64.c                  |  2 +-
>  arch/x86/kernel/kgdb.c                      |  9 ++---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
>  drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
>  drivers/tty/serial/8250/8250_omap.c         |  6 +++-
>  drivers/tty/serial/8250/8250_port.c         |  8 ++---
>  drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
>  include/linux/kgdb.h                        |  9 ++---
>  include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
>  kernel/debug/debug_core.c                   |  2 +-
>  kernel/smp.c                                |  4 ++-
>  18 files changed, 80 insertions(+), 53 deletions(-)
> 
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
