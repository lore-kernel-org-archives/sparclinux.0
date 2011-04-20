From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 07:02:16 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <4DAE84F8.9040901@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>On Tue, Apr 19, 2011 at 06:07:18PM +0200, Daniel Hellstrom wrote:
>  
>
>>Each CPU has a separate set of IRQ controller registers, this
>>patch makes sure that the boot-cpu registers are used instead
>>of CPU0's. Note that there are other parts of the SPARC32/LEON
>>port which does not support booting on other than CPU0 anyway,
>>however this this cleans up the IRQ controller layer in that
>>regard.
>>
>>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>---
>> arch/sparc/include/asm/leon.h   |    1 +
>> arch/sparc/kernel/leon_kernel.c |   14 ++++++++------
>> 2 files changed, 9 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
>>index 31fb2ac..1776f71 100644
>>--- a/arch/sparc/include/asm/leon.h
>>+++ b/arch/sparc/include/asm/leon.h
>>@@ -335,6 +335,7 @@ extern int leon_flush_needed(void);
>> extern void leon_switch_mm(void);
>> extern int srmmu_swprobe_trace;
>> extern int leon3_ticker_irq;
>>+extern int leon3_boot_cpu;
>>    
>>
>
>We already have boot_cpu_id - defiend in smp_32.c.
>Could it be used rather than a leon specific variable?
>
>We would need to define boot_cpu_id also in the non-SMP case
>to do so - but this could also clean up code
>in sun4d_irq.
>  
>
Yes, it might remove a ifdef to the expence of a bigger footprint.

>Note: leon actually set this variable in head_32.S already.
>  
>
I agree that it would be nicer, however I think the SUNs will never be 
booted on CPU1 anyway? Anyways, I think this should go into another 
patch series. I'm very interested in supporting booting on CPU1 for 
LEON, that is really nice in AMP systems where for example RTEMS is 
running on CPU0 and Linux on CPU1. Today RTEMS supports running on 
CPU!=0, so it is not a big issue right now but is not very flexible.

As I state in the comment this patch does not aim to fix everything just 
parts of the IRQ Controller code, there are a lot of other stuff that 
needs to be done in order to support this, not only in Linux the PROM as 
well. I plan to come back later with a patch set for this.

Sam, is that acceptable for now?

Daniel

