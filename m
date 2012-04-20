From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 20 Apr 2012 08:13:58 +0000
Subject: Re: [PATCH] sparc32,leon: add notify_cpu_starting()
Message-Id: <4F9117F6.4030808@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120420.030607.1891260321280604674.davem@davemloft.net> <1334907995-6971-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1334907995-6971-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Eisele <konrad@gaisler.com>
Cc: davem@davemloft.net, yong.zhang0@gmail.com, sam@ravnborg.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, daniel@gaisler.com

On 04/20/2012 01:16 PM, Konrad Eisele wrote:

> Otherwise cpu_active_mask will not set, which lead to other issue.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>


Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Looks like I missed sparc32 while fixing up the other architectures.
(https://lkml.org/lkml/2012/3/22/132)

Regards,
Srivatsa S. Bhat

> ---
>  arch/sparc/kernel/leon_smp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
> index 6173f4d..356dfc4 100644
> --- a/arch/sparc/kernel/leon_smp.c
> +++ b/arch/sparc/kernel/leon_smp.c
> @@ -79,6 +79,8 @@ void __cpuinit leon_callin(void)
>  	local_flush_tlb_all();
>  	leon_configure_cache_smp();
> 
> +	notify_cpu_starting(cpuid);
> +
>  	/* Get our local ticker going. */
>  	register_percpu_ce(cpuid);
> 

