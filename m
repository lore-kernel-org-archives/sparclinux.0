From: Peter Zijlstra <peterz@infradead.org>
Date: Sat, 31 Aug 2019 08:55:39 +0000
Subject: Re: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
Message-Id: <20190831085539.GG2369@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: dalias@libc.org, linux-sh@vger.kernel.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linuxarm@huawei.com, jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, mwb@linux.vnet.ibm.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com, will@kernel.org, cai@lca.pw, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, rppt@linux.ibm.com, borntraeger@de.ibm.com, dledford@redhat.com, mingo@redhat.com, jeffrey.t.kirsher@intel.com, benh@kernel.crashing.org, jhogan@kernel.org, nfont@linux.vnet.ibm.com, mattst88@gmail.com, len.brown@intel.com, gor@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org, rth@twiddle.net, axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de, paul.burton@mips.com, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net

On Sat, Aug 31, 2019 at 01:58:16PM +0800, Yunsheng Lin wrote:
> According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
> of proximity domain is optional, as below:
> 
> This optional object is used to describe proximity domain
> associations within a machine. _PXM evaluates to an integer
> that identifies a device as belonging to a Proximity Domain
> defined in the System Resource Affinity Table (SRAT).

That's just words.. what does it actually mean?

> This patch checks node id with the below case before returning
> node_to_cpumask_map[node]:
> 1. if node_id >= nr_node_ids, return cpu_none_mask
> 2. if node_id < 0, return cpu_online_mask
> 3. if node_to_cpumask_map[node_id] is NULL, return cpu_online_mask
> 
> [1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  arch/x86/include/asm/topology.h | 6 ++++++
>  arch/x86/mm/numa.c              | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 4b14d23..f36e9c8 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -69,6 +69,12 @@ extern const struct cpumask *cpumask_of_node(int node);
>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
>  static inline const struct cpumask *cpumask_of_node(int node)
>  {
> +	if (node >= nr_node_ids)
> +		return cpu_none_mask;
> +
> +	if (node < 0 || !node_to_cpumask_map[node])
> +		return cpu_online_mask;
> +
>  	return node_to_cpumask_map[node];
>  }
>  #endif

I _reallly_ hate this. Users are expected to use valid numa ids. Now
we're adding all this checking to all users. Why do we want to do that?

Using '(unsigned)node >= nr_nods_ids' is an error.

> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index e6dad60..5e393d2 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -868,7 +868,7 @@ const struct cpumask *cpumask_of_node(int node)
>  		dump_stack();
>  		return cpu_none_mask;
>  	}
> -	if (node_to_cpumask_map[node] = NULL) {
> +	if (node < 0 || !node_to_cpumask_map[node]) {
>  		printk(KERN_WARNING
>  			"cpumask_of_node(%d): no node_to_cpumask_map!\n",
>  			node);
> -- 
> 2.8.1
> 
