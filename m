From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2012 09:34:43 +0000
Subject: Re: [PATCH 8/12] arch/sparc: remove references to cpu_*_map.
Message-Id: <4F3B7963.9080505@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1329281884.6232.rusty@rustcorp.com.au>
In-Reply-To: <1329281884.6232.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venki@google.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On 02/15/2012 10:28 AM, Rusty Russell wrote:

> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> This has been obsolescent for a while; time for the final push.
> 
> Also get rid of obsolescent first_cpu().
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/kernel/leon_kernel.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -104,11 +104,11 @@ static int irq_choose_cpu(const struct c
>  {
>  	cpumask_t mask;
>  
> -	cpus_and(mask, cpu_online_map, *affinity);
> -	if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
> +	cpumask_and(&mask, cpu_online_mask, affinity);
> +	if (cpumask_equal(&mask, cpu_online_mask) || cpus_empty(mask))


You could even change that cpus_empty() to cpumask_empty(&mask)...
Either way, it is fine..

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

