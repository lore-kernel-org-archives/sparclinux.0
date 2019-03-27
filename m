From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 27 Mar 2019 08:56:05 +0000
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
 <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
In-Reply-To: <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alexandre Ghiti <alex@ghiti.fr>, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On 3/27/19 2:14 PM, Alexandre Ghiti wrote:
> 
> 
> On 03/27/2019 08:01 AM, Aneesh Kumar K.V wrote:
>> On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
>>> On systems without CONTIG_ALLOC activated but that support gigantic 
>>> pages,
>>> boottime reserved gigantic pages can not be freed at all. This patch
>>> simply enables the possibility to hand back those pages to memory
>>> allocator.
>>>
>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h 
>>> b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>>> index ec2a55a553c7..7013284f0f1b 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>>> @@ -36,8 +36,8 @@ static inline int hstate_get_psize(struct hstate 
>>> *hstate)
>>>       }
>>>   }
>>>   -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>>> -static inline bool gigantic_page_supported(void)
>>> +#define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>>> +static inline bool gigantic_page_runtime_supported(void)
>>>   {
>>>       /*
>>>        * We used gigantic page reservation with hypervisor assist in 
>>> some case.
>>> @@ -49,7 +49,6 @@ static inline bool gigantic_page_supported(void)
>>>         return true;
>>>   }
>>> -#endif
>>>     /* hugepd entry valid bit */
>>>   #define HUGEPD_VAL_BITS        (0x8000000000000000UL)
>>
>> Is that correct when CONTIG_ALLOC is not enabled? I guess we want
>>
>> gigantic_page_runtime_supported to return false when CONTIG_ALLOC is 
>> not enabled on all architectures and on POWER when it is enabled we 
>> want it to be conditional as it is now.
>>
>> -aneesh
>>
> 
> CONFIG_ARCH_HAS_GIGANTIC_PAGE is set by default when an architecture 
> supports gigantic
> pages: on its own, it allows to allocate boottime gigantic pages AND to 
> free them at runtime
> (this is the goal of this series), but not to allocate runtime gigantic 
> pages.
> If CONTIG_ALLOC is set, it allows in addition to allocate runtime 
> gigantic pages.
> 
> I re-introduced the runtime checks because we can't know at compile time 
> if powerpc can
> or not support gigantic pages.
> 
> So for all architectures, gigantic_page_runtime_supported only depends on
> CONFIG_ARCH_HAS_GIGANTIC_PAGE enabled or not. The possibility to 
> allocate runtime
> gigantic pages is dealt with after those runtime checks.
> 

you removed that #ifdef in the patch above. ie we had
#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
static inline bool gigantic_page_supported(void)
{
	/*
	 * We used gigantic page reservation with hypervisor assist in some case.
	 * We cannot use runtime allocation of gigantic pages in those platforms
	 * This is hash translation mode LPARs.
	 */
	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
		return false;

	return true;
}
#endif


This is now
#define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
static inline bool gigantic_page_runtime_supported(void)
{
if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
		return false;

	return true;
}


I am wondering whether it should be

#define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
static inline bool gigantic_page_runtime_supported(void)
{

    if (!IS_ENABLED(CONFIG_CONTIG_ALLOC))
		return false;

if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
		return false;

	return true;
}

or add that #ifdef back.

> By the way, I forgot to ask you why you think that if an arch cannot 
> allocate runtime gigantic
> pages, it should not be able to free boottime gigantic pages ?
> 

on virtualized platforms like powervm which use a paravirtualized page 
table update mechanism (we dont' have two level table). The ability to 
map a page huge depends on how hypervisor allocated the guest ram. 
Hypervisor also allocates the guest specific page table of a specific 
size depending on how many pages are going to be mapped by what page size.

on POWER we indicate possible guest real address that can be mapped via 
hugepage (in this case 16G) using a device tree node 
(ibm,expected#pages) . It is expected that we will map these pages only 
as 16G pages. Hence we cannot free them back to the buddy where it could 
get mapped via 64K page size.

-aneesh
