From: Tejun Heo <tj@kernel.org>
Date: Thu, 09 Apr 2009 11:48:12 +0000
Subject: Re: [PATCH 12/12]: sparc64: Use new dynamic per-cpu allocator.
Message-Id: <49DDE07C.8050101@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408.223758.81953207.davem@davemloft.net>
In-Reply-To: <20090408.223758.81953207.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

The percpu part looks good to me.  Just one question below.

David Miller wrote:
>  void __init setup_per_cpu_areas(void)
>  {
> -	unsigned long size, i, nr_possible_cpus = num_possible_cpus();
> -	char *ptr;
> +	size_t dyn_size, static_size = __per_cpu_end - __per_cpu_start;
> +	static struct vm_struct vm;
> +	unsigned long delta, cpu;
> +	size_t pcpu_unit_size;
> +	size_t ptrs_size;
> +
> +	pcpur_size = PFN_ALIGN(static_size + PERCPU_MODULE_RESERVE +
> +			       PERCPU_DYNAMIC_RESERVE);
> +	dyn_size = pcpur_size - static_size - PERCPU_MODULE_RESERVE;

Isn't it better to use embedding allocator for !NUMA cases (one less
TLB entry usage for each CPU)?

Thanks.

-- 
tejun
