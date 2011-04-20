From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 07:34:25 +0000
Subject: Re: [PATCH 7/7] sparc32,leon: implement genirq CPU affinity
Message-Id: <4DAE8C81.4050203@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-7-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-7-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Hellstrom wrote:

> Sam Ravnborg wrote:
>
>> On Tue, Apr 19, 2011 at 06:07:19PM +0200, Daniel Hellstrom wrote:
>>  
>>
>>> A simple implementation of CPU affinity, the first CPU in
>>> the affinity CPU mask always takes the IRQ.
>>>
>>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>> ---
>>> arch/sparc/kernel/leon_kernel.c |   66 
>>> +++++++++++++++++++++++++++++++++------
>>> 1 files changed, 56 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/sparc/kernel/leon_kernel.c 
>>> b/arch/sparc/kernel/leon_kernel.c
>>> index 26acc75..e12f4e8 100644
>>> --- a/arch/sparc/kernel/leon_kernel.c
>>> +++ b/arch/sparc/kernel/leon_kernel.c
>>> @@ -100,25 +100,68 @@ static inline unsigned long 
>>> get_irqmask(unsigned int irq)
>>>     return mask;
>>> }
>>>
>>> +#ifdef CONFIG_SMP
>>> +static int irq_choose_cpu(const struct cpumask *affinity)
>>> +{
>>> +    cpumask_t mask;
>>> +
>>> +    cpus_and(mask, cpu_online_map, *affinity);
>>> +    if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
>>> +        return leon3_boot_cpu;
>>> +    else
>>> +        return first_cpu(mask);
>>> +}
>>> +
>>> +int leon_set_affinity(struct irq_data *data, const struct cpumask 
>>> *dest,
>>> +              bool force)
>>> +{
>>> +    unsigned long mask, oldmask, flags;
>>> +    int oldcpu, newcpu;
>>> +
>>> +    mask = (unsigned long)data->chip_data;
>>> +    oldcpu = irq_choose_cpu(data->affinity);
>>> +    newcpu = irq_choose_cpu(dest);
>>> +
>>> +    if (oldcpu = newcpu)
>>> +        goto out;
>>> +
>>> +    /* unmask on old CPU first before enabling on the selected CPU */
>>> +    spin_lock_irqsave(&leon_irq_lock, flags);
>>> +    oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(oldcpu));
>>> +    LEON3_BYPASS_STORE_PA(LEON_IMASK(oldcpu), (oldmask & ~mask));
>>> +    oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(newcpu));
>>> +    LEON3_BYPASS_STORE_PA(LEON_IMASK(newcpu), (oldmask | mask));
>>> +    spin_unlock_irqrestore(&leon_irq_lock, flags);
>>> +out:
>>> +    return IRQ_SET_MASK_OK;
>>> +}
>>> +#else
>>> +#define irq_choose_cpu(affinity) leon3_boot_cpu
>>> +#endif
>>>   
>>
>>
>> We could always define the leon_set_affinity() function
>> to avoid ifdeffery in irq_chip definition.
>>  
>>
> Yes, that is what sparc64 does.
>
>> The expense is that we define this function in both the
>> UP and SMP case - it is NOT called by the generic irq
>> layer in the UP case.
>>  
>>
> Yes, it would increase the footprint to remove one ifdef. I could add 
> a "#define leon_set_affinity NULL" in the already present ifdef above 
> to avoid the extra ifdef in chip declaration?

Due to compiler optimizations the function is reduced to two 
instructions anyway, I go with your and the sparc64 way. I will resend 
the patch with your acked-by line as well.

00000034 <leon_set_affinity>:
  34:   81 c3 e0 08     retl
  38:   90 10 20 00     clr  %o0

Thanks,
Daniel
