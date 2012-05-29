From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2012 08:14:58 +0000
Subject: Re: [PATCH 08/10] SPARC: smp: remove call to ipi_call_lock_irq()/ipi_call_unlock_irq()
Message-Id: <20120529.041458.1686171726483755640.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
	<1338275765-3217-9-git-send-email-yong.zhang0@gmail.com>
	<4FC48272.9040904@linux.vnet.ibm.com>
In-Reply-To: <4FC48272.9040904@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: yong.zhang0@gmail.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com, nikunj@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, axboe@kernel.dk, mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Tue, 29 May 2012 13:31:54 +0530

> On 05/29/2012 12:46 PM, Yong Zhang wrote:
> 
>> From: Yong Zhang <yong.zhang@windriver.com>
>> 
>> 1) call_function.lock used in smp_call_function_many() is just to protect
>>    call_function.queue and &data->refs, cpu_online_mask is outside of the
>>    lock. And it's not necessary to protect cpu_online_mask,
>>    because data->cpumask is pre-calculate and even if a cpu is brougt up
>>    when calling arch_send_call_function_ipi_mask(), it's harmless because
>>    validation test in generic_smp_call_function_interrupt() will take care
>>    of it.
>> 
>> 2) For cpu down issue, stop_machine() will guarantee that no concurrent
>>    smp_call_fuction() is processing.
>> 
>> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> ---
>>  arch/sparc/kernel/smp_64.c |    6 ++----
>>  1 files changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
>> index f591598..60e745c 100644
>> --- a/arch/sparc/kernel/smp_64.c
>> +++ b/arch/sparc/kernel/smp_64.c
>> @@ -124,9 +124,9 @@ void __cpuinit smp_callin(void)
>>  	while (!cpumask_test_cpu(cpuid, &smp_commenced_mask))
>>  		rmb();
>> 
>> -	ipi_call_lock_irq();
>> +	local_irq_disable();
> 
> 
> This looks odd. IRQs must not have been enabled at this point.
> Just remove the call to local_irq_enable() that is found a few lines above
> this line and then you won't have to add this call to local_irq_disable().

Agreed.
