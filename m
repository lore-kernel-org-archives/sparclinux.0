From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jul 2014 22:52:07 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <20140728.155207.310355957128025086.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 15:19:21 +0200

Again, please format your subject line properly, the subsystem prefix
here could be "sunsab: ".

> Handling of a BREAK on a serial line is currently broken in the sunsab serial
> driver. Due to this defect, it is not possible to break to the firmware prompt
> or trigger a Magic SysRq on these machines (which would be quite useful for
> debugging kernel problems on headless machines).
> 
> This problem is caused by the fact that the count of characters to be processed
> might be 0 when a BREAK interrupt is triggered. The code in the driver contains
> a loop that processes the pending characters - with count set to 0 no processing
> takes place at all. Unfortunately, the call of uart_handle_break() is contained
> inside this loop and therefore skipped completely.
> 
> This patch moves the check for BREAK status in front of the loop and executes it
> only when count = 0, i.e. when it would not be done inside the loop.
> 
> With this patch, Magic SysRq works again. However, there seems to be another
> problem that causes an Oops when a register dump is requested by SysRq. This
> is caused when perf_event_print_debug() is called from sysrq_handle_showregs()
> in drivers/tty/sysrq.c. This patch provides no solution for this problem; my
> workaround was to eliminate the call to perf_event_print_debug() in
> sysrq_handle_showregs(). This problem was observed on a SunBlade 2000 with an
> UltraSPARC III Cu CPU and might be specific to this CPU model (the UltraSPARC III
> is the first CPU to support perf_event.).
> 
> The patch was originally developed against a 3.13 backport kernel from Debian.
> Both the patch against 3.13 and a recent 3.16-rc6 are included below. Please note
> that I could only test the 3.13 version as I do not have access to the affected
> machine anymore.

Please provide a proper "Singed-off-by: " as per Documentation/SubmittingPatches.

> +       if(count = 0) {

Space between "if" and "(".

> +               if(unlikely(stat->sreg.isr1 & SAB82532_ISR1_BRK)) {

Likewise.
