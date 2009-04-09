From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 21:29:23 +0000
Subject: Re: [PATCH 12/12]: sparc64: Use new dynamic per-cpu allocator.
Message-Id: <20090409.142923.252620650.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408.223758.81953207.davem@davemloft.net>
	<49DDE07C.8050101@kernel.org>
In-Reply-To: <49DDE07C.8050101@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Thu, 09 Apr 2009 04:48:12 -0700

> 
> David Miller wrote:
>>  void __init setup_per_cpu_areas(void)
>>  {
>> -	unsigned long size, i, nr_possible_cpus = num_possible_cpus();
>> -	char *ptr;
>> +	size_t dyn_size, static_size = __per_cpu_end - __per_cpu_start;
>> +	static struct vm_struct vm;
>> +	unsigned long delta, cpu;
>> +	size_t pcpu_unit_size;
>> +	size_t ptrs_size;
>> +
>> +	pcpur_size = PFN_ALIGN(static_size + PERCPU_MODULE_RESERVE +
>> +			       PERCPU_DYNAMIC_RESERVE);
>> +	dyn_size = pcpur_size - static_size - PERCPU_MODULE_RESERVE;
> 
> Isn't it better to use embedding allocator for !NUMA cases (one less
> TLB entry usage for each CPU)?

Heck, the embedding case would probably be optimal for Niagara NUMA
systems too.

On Niagara systems all of the "possible" cpu numbers are linear and in
order.  No holes, gaps, or other stuff like this.  So just allocating
big TLB mapping chunks and chopping them up to the individual cpus is
the best scheme possible.

Indeed, these are the kinds of things I plan to experiment with.
