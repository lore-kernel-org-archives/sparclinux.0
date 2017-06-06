From: jane.chu@oracle.com
Date: Tue, 06 Jun 2017 03:03:28 +0000
Subject: Re: [PATCH v2] arch/sparc: support NR_CPUS = 4096
Message-Id: <6255d34e-499d-db38-ec86-8930828684de@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496702911-717442-1-git-send-email-jane.chu@oracle.com>
 <20170605.205739.2124313705421284534.davem@davemloft.net>
In-Reply-To: <20170605.205739.2124313705421284534.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tglx@linutronix.de, atish.patra@oracle.com, Liam.Howlett@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "JANE.CHU" <jane.chu@oracle.com>

On 06/05/2017 05:57 PM, David Miller wrote:

> From: Jane Chu <jane.chu@oracle.com>
> Date: Mon,  5 Jun 2017 16:48:31 -0600
>
>> Linux SPARC64 limits NR_CPUS to 4064 because init_cpu_send_mondo_info()
>> only allocates a single page for NR_CPUS mondo entries. Thus we cannot
>> use all 4096 CPUs on some SPARC platforms.
>>
>> To fix, allocate (2^order) pages where order is set according to the size
>> of cpu_list for possible cpus. Since cpu_list_pa and cpu_mondo_block_pa
>> are not used in asm code, there are no imm13 offsets from the base PA
>> that will break because they can only reach one page.
>>
>> Orabug: 25505750
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
>> Reviewed-by: Atish Patra <atish.patra@oracle.com>
>> ---
>>   arch/sparc/Kconfig         |    4 ++--
>>   arch/sparc/kernel/irq_64.c |   16 ++++++++++++----
>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 58243b0..4399be7 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -192,9 +192,9 @@ config NR_CPUS
>>   	int "Maximum number of CPUs"
>>   	depends on SMP
>>   	range 2 32 if SPARC32
>> -	range 2 1024 if SPARC64
>> +	range 2 4096 if SPARC64
>>   	default 32 if SPARC32
>> -	default 64 if SPARC64
>> +	default 4096 if SPARC64
>>   
>>   source kernel/Kconfig.hz
>>   
>> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
>> index 4d0248a..cc8f6c3 100644
>> --- a/arch/sparc/kernel/irq_64.c
>> +++ b/arch/sparc/kernel/irq_64.c
>> @@ -1034,17 +1034,25 @@ static void __init init_cpu_send_mondo_info(struct trap_per_cpu *tb)
>>   {
>>   #ifdef CONFIG_SMP
>>   	unsigned long page;
>> +	void *mondo;
>>   
>> -	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > (PAGE_SIZE - 64));
>> +	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > PAGE_SIZE);
>> +
>> +	/* Make sure mondo block is 64byte aligned */
>> +	mondo = kzalloc(64, GFP_KERNEL);
>> +	if (!mondo) {
>> +		prom_printf("SUN4V: Error, cannot allocate mondo block.\n");
>> +		prom_halt();
>> +	}
>> +	tb->cpu_mondo_block_pa = __pa(mondo);
> Hmmm, you said that this has to be 64 byte aligned right?  We might have
> to do something in order to insure that, as kmalloc() only guarantees
> ARCH_KMALLOC_MINALIGN which I think is 8 on sparc.
Yes.
>
> I suppose this would work:
>
> 	mondo = kzalloc(64 + 63, GFP_KERNEL);
>
> and then 64-byte align that pointer.

On sun4v sparc,  it looks like kzalloc(64, GFP_KERNEL)  ends up allocating
from kmalloc_caches[6] - a 64-byte kmem-cache allocated by
kmem_cache_init() with SLAB_HWCACHE_ALIGN flag set, so it's in 
l3-cache-line-size
alignment, i.e. 64byte.  I printed out the 'mondo' pa and verified that.

thanks!
-jane


