From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 24 Mar 2014 18:19:44 +0000
Subject: Re: Generic idle causes boot hang on T1000
Message-Id: <alpine.LSU.2.11.1403241827570.1319@nerf08.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.11.1403232347380.23553@nerf08.vanv.qr>
In-Reply-To: <alpine.LSU.2.11.1403232347380.23553@nerf08.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Monday 2014-03-24 17:53, David Miller wrote:
>diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
>index 32a280e..d7b4967 100644
>--- a/arch/sparc/kernel/process_64.c
>+++ b/arch/sparc/kernel/process_64.c
>@@ -58,9 +58,12 @@ void arch_cpu_idle(void)
> {
> 	if (tlb_type != hypervisor) {
> 		touch_nmi_watchdog();
>+		local_irq_enable();
> 	} else {
> 		unsigned long pstate;
> 
>+		local_irq_enable();
>+
>                 /* The sun4v sleeping code requires that we have PSTATE.IE cleared over
>                  * the cpu sleep hypervisor call.
>                  */
>@@ -82,7 +85,6 @@ void arch_cpu_idle(void)
> 			: "=&r" (pstate)
> 			: "i" (PSTATE_IE));
> 	}
>-	local_irq_enable();
> }
> 
> #ifdef CONFIG_HOTPLUG_CPU

With this patch, the boot succeeds.
