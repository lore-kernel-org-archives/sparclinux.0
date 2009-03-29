From: David Miller <davem@davemloft.net>
Date: Sun, 29 Mar 2009 22:44:44 +0000
Subject: Re: [PULL] cpumask updates for sparc
Message-Id: <20090329.154444.177112758.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903161444.41621.rusty@rustcorp.com.au>
In-Reply-To: <200903161444.41621.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rusty@rustcorp.com.au
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, travis@sgi.com

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Mon, 16 Mar 2009 14:44:41 +1030

>   ssh://master.kernel.org/home/ftp/pub/scm/linux/kernel/git/rusty/linux-2.6-cpumask-for-sparc.git master
> 
> Rusty Russell (10):
>       cpumask: Use smp_call_function_many(): sparc64
>       cpumask: arch_send_call_function_ipi_mask: sparc
>       cpumask: Use accessors code: sparc
>       cpumask: Use accessors code.: sparc64
>       cpumask: prepare for iterators to only go to nr_cpu_ids/nr_cpumask_bits.: sparc64
>       cpumask: prepare for iterators to only go to nr_cpu_ids/nr_cpumask_bits.: sparc
>       cpumask: remove cpu_coregroup_map: sparc
>       cpumask: remove the now-obsoleted pcibus_to_cpumask(): sparc
>       cpumask: remove dangerous CPU_MASK_ALL_PTR, &CPU_MASK_ALL.: sparc
>       cpumask: use mm_cpumask() wrapper: sparc

Pulled, thanks a lot Rusty.
