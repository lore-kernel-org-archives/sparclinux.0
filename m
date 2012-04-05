From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 05 Apr 2012 06:55:21 +0000
Subject: Re: sparc - generic clock event support
Message-Id: <4F7D41D9.7060703@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404200704.GA16958@merkur.ravnborg.org>
In-Reply-To: <20120404200704.GA16958@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> I have now finised revising the patch to
> provide support for generic clock event support
> on sparc32.
>
> The main focus has been to extend the core functionality
> (within sparc32) to allow us to share a lot of code between
> leon and the other platfroms.
>
> I have in this process updated a few bits here and there.
> The patch set is build tested for leon, and
> runtime tested on my ss5 (sun4m).

I'll test it today on Leon.
-- Konrad

>
> I know this is easter - but this is what allows me to work
> on this stuff... But anyway - any feedback would be good.
> I hope to see this hit sparc-next.git soon so we can have
> it included in next merge window.
>
> The diffstat tells us this is a relatively huge patch:
>   arch/sparc/kernel/irq.h               |   19 ++
>   arch/sparc/kernel/leon_kernel.c       |   49 +++++++
>   arch/sparc/kernel/pcic.c              |   48 ++++---
>   arch/sparc/kernel/sun4c_irq.c         |   11 +
>   arch/sparc/kernel/sun4d_irq.c         |   18 ++
>   arch/sparc/kernel/sun4m_irq.c         |   22 ++-
>   arch/sparc/kernel/time_32.c           |  216 +++++++++++++++++++++++++++-------
>   b/arch/sparc/Kconfig                  |    7 -
>   b/arch/sparc/include/asm/cpudata_32.h |    1
>   b/arch/sparc/include/asm/leon.h       |    2
>   b/arch/sparc/include/asm/timer_32.h   |   29 ++++
>   b/arch/sparc/include/asm/timex_32.h   |    1
>   b/arch/sparc/kernel/irq.h             |    6
>   b/arch/sparc/kernel/irq_32.c          |    2
>   b/arch/sparc/kernel/kernel.h          |    2
>   b/arch/sparc/kernel/leon_kernel.c     |    4
>   b/arch/sparc/kernel/leon_smp.c        |   34 -----
>   b/arch/sparc/kernel/of_device_32.c    |    4
>   b/arch/sparc/kernel/pcic.c            |    2
>   b/arch/sparc/kernel/smp_32.c          |   21 ---
>   b/arch/sparc/kernel/sun4c_irq.c       |    4
>   b/arch/sparc/kernel/sun4d_irq.c       |    4
>   b/arch/sparc/kernel/sun4d_smp.c       |   34 +----
>   b/arch/sparc/kernel/sun4m_irq.c       |    4
>   b/arch/sparc/kernel/sun4m_smp.c       |   38 ++---
>   b/arch/sparc/kernel/time_32.c         |    3
>   26 files changed, 378 insertions(+), 207 deletions(-)
>
> But I could not see any easy way to split this up in smaller bits.
>
> There are only two patches:
>
>      sparc32: rename sparc_irq_config to sparc_config
>      sparc32: generic clockevent support
>
> They will follow this mail.
>
> Note that the second patch is a collaborative effort by
> Kirill, Konrad and me.
>
> I found no better way to attribute that than
> what is included in the patch description.
> Adding Konrad's "Signed-off" would be wrong as
> the patch did not pass through him.
>
> 	Sam
>
>

