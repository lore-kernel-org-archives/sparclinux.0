From: Yan Burman <burman.yan@gmail.com>
Date: Fri, 24 Nov 2006 19:02:53 +0000
Subject: Re: [PATCH 2.6.19-rc6] sparc: replace kmalloc+memset with kzalloc
Message-Id: <456741DD.6060103@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4566DF0A.3050803@gmail.com> <45672D00.8060903@s5r6.in-berlin.de>
In-Reply-To: <45672D00.8060903@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

Stefan Richter wrote:
> Yan Burman wrote:
> ...
>   
>> --- linux-2.6.19-rc5_orig/arch/sparc/kernel/sun4d_irq.c	2006-11-09 12:16:21.000000000 +0200
>> +++ linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/sun4d_irq.c	2006-11-11 22:44:04.000000000 +0200
>> @@ -545,8 +545,7 @@ void __init sun4d_init_sbi_irq(void)
>>  	nsbi = 0;
>>  	for_each_sbus(sbus)
>>  		nsbi++;
>> -	sbus_actions = (struct sbus_action *)kmalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
>> -	memset (sbus_actions, 0, (nsbi * 8 * 4 * sizeof(struct sbus_action)));
>> +	sbus_actions = kzalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
>>  	for_each_sbus(sbus) {
>>  #ifdef CONFIG_SMP	
>>  		extern unsigned char boot_cpu_id;
>>     
>
> I'm not sure about this ^ hunk, but...
>
>   
>> diff -rubp linux-2.6.19-rc5_orig/arch/sparc/mm/io-unit.c linux-2.6.19-rc5_kzalloc/arch/sparc/mm/io-unit.c
>> --- linux-2.6.19-rc5_orig/arch/sparc/mm/io-unit.c	2006-11-09 12:16:21.000000000 +0200
>> +++ linux-2.6.19-rc5_kzalloc/arch/sparc/mm/io-unit.c	2006-11-11 22:44:04.000000000 +0200
>> @@ -41,9 +41,8 @@ iounit_init(int sbi_node, int io_node, s
>>  	struct linux_prom_registers iommu_promregs[PROMREG_MAX];
>>  	struct resource r;
>>  
>> -	iounit = kmalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
>> +	iounit = kzalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
>>  
>> -	memset(iounit, 0, sizeof(*iounit));
>>  	iounit->limit[0] = IOUNIT_BMAP1_START;
>>  	iounit->limit[1] = IOUNIT_BMAP2_START;
>>  	iounit->limit[2] = IOUNIT_BMAPM_START;
>>     
>
> ...in this ^, the old code and your update don't check for NULL return.
>   

Both of this parts are done at early stages, so it is probably:
a) Impossible to recover from failure
b) If you run out of memory at this stage, you are probably in very big 
trouble anyway

I could modify it to check and panic if the check fails.
Would that be better?

