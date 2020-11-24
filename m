From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 24 Nov 2020 15:44:15 +0000
Subject: Re: [PATCH] sparc64: Use arch_validate_flags() to validate ADI flag
Message-Id: <ab73559b-c8bf-dd8d-c959-72049dafe8fa@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201023175611.12819-1-khalid.aziz@oracle.com>
 <20201120180119.GM24344@gaia>
In-Reply-To: <20201120180119.GM24344@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: jannh@google.com, hch@infradead.org, davem@davemloft.net, akpm@linux-foundation.org, anthony.yznaga@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 11/20/20 11:01 AM, Catalin Marinas wrote:
> Hi Khalid,
> 
> On Fri, Oct 23, 2020 at 11:56:11AM -0600, Khalid Aziz wrote:
>> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
>> index f94532f25db1..274217e7ed70 100644
>> --- a/arch/sparc/include/asm/mman.h
>> +++ b/arch/sparc/include/asm/mman.h
>> @@ -57,35 +57,39 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>>   {
>>   	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>>   		return 0;
>> -	if (prot & PROT_ADI) {
>> -		if (!adi_capable())
>> -			return 0;
>> +	return 1;
>> +}
> 
> We kept the equivalent of !adi_capable() check in the arm64
> arch_validate_prot() and left arch_validate_flags() more relaxed. I.e.
> you can pass PROT_MTE to mmap() even if the hardware doesn't support
> MTE. This is in line with the pre-MTE ABI where unknown mmap() flags
> would be ignored while mprotect() would reject them. This discrepancy
> isn't nice but we decided to preserve the pre-MTE mmap ABI behaviour.
> Anyway, it's up to you if you want to change the sparc behaviour, I
> don't think it matters in practice.

Hi Catalin,

Thanks for taking a look at this patch. I felt mmap() silently accepting 
PROT_ADI but not really enabling protection can be dangerous since it 
leads the end user to be under false impression that they have protected 
the memory. I chose to treat PROT_ADI as a known flag and provide a 
definite feedback to user whether it can be honored or not.

> 
> I think with this patch, arch_validate_prot() no longer needs the 'addr'
> argument. Maybe you can submit an additional patch to remove them (not
> urgent, the compiler should get rid of them).

Yes, 'addr' is an unused argument now. On the other hand, I suspect with 
additional protections being implemented in hardware for memory regions, 
sooner or later someone will see a need to validate protection bits in 
the context of memory region it is being applied to. Address is not 
going to be enough information though and we are most likely going to 
need size of the memory region being operated upon as well. That means 
this code is likely to need a patch to add the size argument. So it is 
reasonable to remove 'addr' for now and reintroduce a more complete 
version with size as well later in a patch when the need comes up.

> 
>>   
>> -		if (addr) {
>> -			struct vm_area_struct *vma;
>> +#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
>> +/* arch_validate_flags() - Ensure combination of flags is valid for a
>> + *	VMA.
>> + */
>> +static inline bool arch_validate_flags(unsigned long vm_flags)
>> +{
>> +	/* If ADI is being enabled on this VMA, check for ADI
>> +	 * capability on the platform and ensure VMA is suitable
>> +	 * for ADI
>> +	 */
>> +	if (vm_flags & VM_SPARC_ADI) {
>> +		if (!adi_capable())
>> +			return false;
>>   
>> -			vma = find_vma(current->mm, addr);
>> -			if (vma) {
>> -				/* ADI can not be enabled on PFN
>> -				 * mapped pages
>> -				 */
>> -				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> -					return 0;
>> +		/* ADI can not be enabled on PFN mapped pages */
>> +		if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> +			return false;
>>   
>> -				/* Mergeable pages can become unmergeable
>> -				 * if ADI is enabled on them even if they
>> -				 * have identical data on them. This can be
>> -				 * because ADI enabled pages with identical
>> -				 * data may still not have identical ADI
>> -				 * tags on them. Disallow ADI on mergeable
>> -				 * pages.
>> -				 */
>> -				if (vma->vm_flags & VM_MERGEABLE)
>> -					return 0;
>> -			}
>> -		}
>> +		/* Mergeable pages can become unmergeable
>> +		 * if ADI is enabled on them even if they
>> +		 * have identical data on them. This can be
>> +		 * because ADI enabled pages with identical
>> +		 * data may still not have identical ADI
>> +		 * tags on them. Disallow ADI on mergeable
>> +		 * pages.
>> +		 */
>> +		if (vm_flags & VM_MERGEABLE)
>> +			return false;
> 
> Ah, you added a check to the madvise(MADV_MERGEABLE) path to ignore the
> flag if VM_SPARC_ADI. On arm64 we intercept memcmp_pages() but we have a
> PG_arch_2 flag to mark a page as containing tags. Either way should
> work.
> 
> FWIW, if you are happy with the mmap() rejecting PROT_ADI on
> !adi_capable() hardware:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Thanks!

--
Khalid
