From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 13 Apr 2020 17:04:54 +0000
Subject: Re: [PATCH v2 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-Id: <8d2f8066-98af-4db2-8ffa-f78533a50674@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-2-mike.kravetz@oracle.com>
 <20200410191613.GD3172@xz-x1>
In-Reply-To: <20200410191613.GD3172@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Xu <peterx@redhat.com>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S.Miller" <davem@davemloft.net>

On 4/10/20 12:16 PM, Peter Xu wrote:
> On Wed, Apr 01, 2020 at 11:38:16AM -0700, Mike Kravetz wrote:
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index 2eb6c234d594..81606223494f 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -59,6 +59,8 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>  extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>  				 pte_t *ptep, pte_t pte, unsigned long sz);
>>  #define set_huge_swap_pte_at set_huge_swap_pte_at
>> +bool __init arch_hugetlb_valid_size(unsigned long size);
>> +#define arch_hugetlb_valid_size arch_hugetlb_valid_size
> 
> Sorry for chimming in late.

Thank you for taking a look!

> Since we're working on removing arch-dependent codes after all.. I'm
> thinking whether we can define arch_hugetlb_valid_size() once in the
> common header (e.g. linux/hugetlb.h), then in mm/hugetlb.c:
> 
> bool __init __attribute((weak)) arch_hugetlb_valid_size(unsigned long size)
> {
> 	return size = HPAGE_SIZE;
> }
> 
> We can simply redefine arch_hugetlb_valid_size() in arch specific C
> files where we want to override the default.  Would that be slightly
> cleaner?

I think both the #define X X and weak attribute methods are acceptable.
I went with the #define method only because it was most familiar to me.
Using the weak attribute method does appear to be cleaner.  I'll code it up.

Anyone else have a preference?
-- 
Mike Kravetz
