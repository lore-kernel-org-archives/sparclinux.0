From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Apr 2011 07:53:31 +0000
Subject: Re: [PATCH] sparc32,leon: SMP power down implementation
Message-Id: <4DB679FB.5010309@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303804097-488-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303804097-488-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Hellstrom wrote:

>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>---
> arch/sparc/kernel/process_32.c |   12 ++++++++++--
> 1 files changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
>index 1752929..c8cc461 100644
>--- a/arch/sparc/kernel/process_32.c
>+++ b/arch/sparc/kernel/process_32.c
>@@ -128,8 +128,16 @@ void cpu_idle(void)
>         set_thread_flag(TIF_POLLING_NRFLAG);
> 	/* endless idle loop with no priority at all */
> 	while(1) {
>-		while (!need_resched())
>-			cpu_relax();
>+#ifdef CONFIG_SPARC_LEON
>+		if (pm_idle) {
>+			while (!need_resched())
>+				(*pm_idle)();
>+		} else
>+#endif
>+		{
>+			while (!need_resched())
>+				cpu_relax();
>+		}
>  
>

I have made this CONFIG_SPARC_LEON because I'm not sure if other SMP 
SPARC32 supports the pmc idle. One can see from row 109 above that in 
single-processor pmc_idle() is called in the same mannor, however no for 
SMP... perhaps it is a meaning with that? I don't want to break 
anything, if you think is shuold not be ifdeffed I will remove it and 
repost.

Daniel
