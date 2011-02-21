From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 21 Feb 2011 09:30:55 +0000
Subject: Re: [RFC/PATCH 0/5] sparc32 genirq support
Message-Id: <4D6230CF.5010209@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110220203757.GA12981@merkur.ravnborg.org>
In-Reply-To: <20110220203757.GA12981@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>Convert sparc32 to use genirq.
>
>Changes since v2:
>- avoid moving function in sun4d_irq to make diff more readable (Josip Rodin)
>- added patch that fixes build with floppy or LEON enabled
>  I broke that during my cleanup.
>  This is 1/5 - and should be applied to -next soon.
>- converted leon to genirq
>  It was straight forward. I identified some dead code in leon_kernel
>  but I did not clean it up (stuff that reference eirq).
>  
>
Somehow only parts of the Extended IRQ Controller patch was submitted 
when LEON was included the first time. We distribute the rest of the 
patch on our homepage, however since it is not clean and you are 
cleaning up the IRQ code I have been waiting with it.

The extended IRQ controller is basically one extra level of IRQs, when 
the EIRQ (1..14) is taken the ISR looks what IRQ actually caused the IRQ 
(16..31) and calls that handler.

Thanks,
Daniel

>- converted pcic to genirq
>  I had missed this during the last rounds. I had also missed
>  that we either used sun4m_irq OR pcic irq support.
>  Note: I assume the handle_level_irq is the right handler for pcic too.
>
>The TODO list contains only two items now:
>- What to do with the smp4m_irq_rotate(cpu) functionality?
>  Can we just ignore it as we have a maximum of 4 CPUs
>- Are the sun4d mask/unmask implementation buggy with respect
>  to cpu interrupts?
>  I do not know the sun4d platform - and has no HW to test on (yet at least)
>
>
>I feel quite confident with most of the code-changes.
>The sun4d stuff is where I am most unsafe.
>If anyone can test it on real HW it would be great!
>
>I will try to setup QEMU during the next week or two
>to see if this can help me in more testing.
>
>	Sam
>
>Sam Ravnborg (5):
>      sparc32: fix build with leon or floppy enabled
>      sparc32: introduce sparc_irq_config
>      sparc32: introduce build_device_irq
>      sparc32,sun4m: percpu and global register definitions moved to irq.h
>      sparc32: genirq support
>
> arch/sparc/Kconfig                 |    5 +-
> arch/sparc/include/asm/floppy_32.h |   41 ++-
> arch/sparc/include/asm/irq_32.h    |    8 +-
> arch/sparc/include/asm/leon.h      |    3 -
> arch/sparc/include/asm/system_32.h |    5 -
> arch/sparc/kernel/Makefile         |    4 -
> arch/sparc/kernel/irq.h            |   86 ++++--
> arch/sparc/kernel/irq_32.c         |  504 ++++++++--------------------------
> arch/sparc/kernel/kernel.h         |    9 +-
> arch/sparc/kernel/leon_kernel.c    |   62 ++++-
> arch/sparc/kernel/leon_smp.c       |   20 +-
> arch/sparc/kernel/of_device_32.c   |   59 +----
> arch/sparc/kernel/pcic.c           |   82 ++++--
> arch/sparc/kernel/sun4c_irq.c      |  146 ++++++----
> arch/sparc/kernel/sun4d_irq.c      |  522 +++++++++++++++---------------------
> arch/sparc/kernel/sun4m_irq.c      |  204 +++++++-------
> arch/sparc/kernel/sun4m_smp.c      |   16 +-
> arch/sparc/kernel/time_32.c        |    2 +-
> 18 files changed, 748 insertions(+), 1030 deletions(-)
>
>
>  
>

