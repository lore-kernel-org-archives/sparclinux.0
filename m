From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 18 Jan 2017 00:14:34 +0000
Subject: Re: [PATCH v4 4/4] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <decf9145-5414-33fc-cf15-e4dc4f7ceae5@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1483999591.git.khalid.aziz@oracle.com>
 <cover.1483999591.git.khalid.aziz@oracle.com>
 <0c08eb00e5a9735d7d0bcbeaadeacaa761011aab.1483999591.git.khalid.aziz@oracle.com>
 <20170116.233924.374841184595409216.davem@davemloft.net>
In-Reply-To: <20170116.233924.374841184595409216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: corbet@lwn.net, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, mike.kravetz@oracle.com, akpm@linux-foundation.org, mingo@kernel.org, kirill.shutemov@linux.intel.com, adam.buchbinder@gmail.com, hughd@google.com, minchan@kernel.org, keescook@chromium.org, chris.hyser@oracle.com, atish.patra@oracle.com, cmetcalf@mellanox.com, atomlin@redhat.com, jslaby@suse.cz, joe@perches.com, paul.gortmaker@windriver.com, mhocko@suse.com, lstoakes@gmail.com, jack@suse.cz, dave.hansen@linux.intel.com, vbabka@suse.cz, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, khalid@gonehiking.org

On 01/16/2017 09:39 PM, David Miller wrote:
> From: Khalid Aziz <khalid.aziz@oracle.com>
> Date: Wed, 11 Jan 2017 09:12:54 -0700
>
>> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
>> index 8a6982d..68b03bf 100644
>> --- a/arch/sparc/kernel/mdesc.c
>> +++ b/arch/sparc/kernel/mdesc.c
>> @@ -20,6 +20,7 @@
>>  #include <asm/uaccess.h>
>>  #include <asm/oplib.h>
>>  #include <asm/smp.h>
>> +#include <asm/adi.h>
>>
>>  /* Unlike the OBP device tree, the machine description is a full-on
>>   * DAG.  An arbitrary number of ARCs are possible from one
>> @@ -1104,5 +1105,8 @@ void __init sun4v_mdesc_init(void)
>>
>>  	cur_mdesc = hp;
>>
>> +#ifdef CONFIG_SPARC64
>
> mdesc.c is only built on sparc64, this ifdef is superfluous.

Good point. I will fix it.

>
>> +/* Update the state of MCDPER register in current task's mm context before
>> + * dup so the dup'd task will inherit flags in this register correctly.
>> + * Current task may have updated flags since it started running.
>> + */
>> +int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>> +{
>> +	if (adi_capable() && src->mm) {
>> +		register unsigned long tmp_mcdper;
>> +
>> +		__asm__ __volatile__(
>> +			".word 0x83438000\n\t"	/* rd %mcdper, %g1 */
>> +			"mov %%g1, %0\n\t"
>> +			: "=r" (tmp_mcdper)
>> +			:
>> +			: "g1");
>> +		src->mm->context.mcdper = tmp_mcdper;
>
> I don't like the idea of duplicating 'mm' state using the task struct
> copy.  Why do not the MM handling interfaces handle this properly?
>
> Maybe it means you've abstracted the ADI register handling in the
> wrong place.  Maybe it's a thread property which is "pushed" from
> the MM context.

I see what you are saying. This code updates mm->context.mcdper for the 
source thread with the current state of MCDPER since MCDPER can be 
changed by a userspace process any time. When userspace changes MCDPER, 
it is not saved into mm->context.mcdper until a context switch happens. 
This means during the timeslice for a thread, its mm->context.mcdper may 
not reflect the current value of MCDPER. Updating it ensures dup_mm() 
will copy the real current value of MCDPER into the newly forked thread. 
arch_dup_mmap() looks like a more appropriate place to do this. Do you 
agree?

Thanks,
Khalid

