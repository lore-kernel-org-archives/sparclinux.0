From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 20 Apr 2012 06:32:50 +0000
Subject: Re: [PATCH 1/1] sparc32,leon: add notify_cpu_starting()
Message-Id: <4F910312.3010900@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120420033634.GA13068@zhy> <1334903312-18526-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1334903312-18526-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yong.zhang0@gmail.com
Cc: sam@ravnborg.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net, daniel@gaisler.com, Yong Zhang <yong.zhang@windriver.com>

Hello Yong,
Thank you for the patch, it works. The SMP is fully
functional again for sparc-leon. I just added a "#include<linux/cpu.h>"
to avoid compiler warning.
Please someone in the cc-list, apply.
-- Greetings Konrad

Konrad Eisele wrote:
> From: Yong Zhang<yong.zhang@windriver.com>
>
> Otherwise cpu_active_mask will not set, which lead to other issue.
>
> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
> Signed-off-by: Konrad Eisele<konrad@gaisler.com>
> ---
>   arch/sparc/kernel/leon_smp.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
> index 1210fde..160cac9 100644
> --- a/arch/sparc/kernel/leon_smp.c
> +++ b/arch/sparc/kernel/leon_smp.c
> @@ -23,6 +23,7 @@
>   #include<linux/pm.h>
>   #include<linux/delay.h>
>   #include<linux/gfp.h>
> +#include<linux/cpu.h>
>
>   #include<asm/cacheflush.h>
>   #include<asm/tlbflush.h>
> @@ -78,6 +79,8 @@ void __cpuinit leon_callin(void)
>   	local_flush_tlb_all();
>   	leon_configure_cache_smp();
>
> +	notify_cpu_starting(cpuid);
> +
>   	/* Get our local ticker going. */
>   	smp_setup_percpu_timer();
>

