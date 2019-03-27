From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 27 Mar 2019 10:17:13 +0000
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <87pnqcws2u.fsf@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
 <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
 <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com>
 <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
In-Reply-To: <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alexandre Ghiti <alex@ghiti.fr>, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

Alexandre Ghiti <alex@ghiti.fr> writes:

> On 03/27/2019 09:55 AM, Aneesh Kumar K.V wrote:
>> On 3/27/19 2:14 PM, Alexandre Ghiti wrote:
>>>
>>>
>>> On 03/27/2019 08:01 AM, Aneesh Kumar K.V wrote:
>>>> On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
>

.....

>>
>> This is now
>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>> static inline bool gigantic_page_runtime_supported(void)
>> {
>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>         return false;
>>
>>     return true;
>> }
>>
>>
>> I am wondering whether it should be
>>
>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>> static inline bool gigantic_page_runtime_supported(void)
>> {
>>
>>    if (!IS_ENABLED(CONFIG_CONTIG_ALLOC))
>>         return false;
>
> I don't think this test should happen here, CONFIG_CONTIG_ALLOC only allows
> to allocate gigantic pages, doing that check here would prevent powerpc
> to free boottime gigantic pages when not a guest. Note that this check
> is actually done in set_max_huge_pages.
>
>
>>
>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>         return false;
>
> Maybe I did not understand this check: I understood that, in the case 
> the system
> is virtualized, we do not want it to hand back gigantic pages. Does this 
> check
> test if the system is currently being virtualized ?
> If yes, I think the patch is correct: it prevents freeing gigantic pages 
> when the system
> is virtualized but allows a 'normal' system to free gigantic pages.
>
>
>>

Ok double checked the patch applying the the tree. I got confused by the
removal of that #ifdef. So we now disallow the runtime free by checking
for gigantic_page_runtime_supported() in  __nr_hugepages_store_common.
Now if we allow and if CONFIG_CONTIG_ALLOC is disabled, we still should
allow to free the boot time allocated pages back to buddy.

The patch looks good. You can add for the series

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

-aneesh
