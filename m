From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 19 Mar 2020 17:00:33 +0000
Subject: Re: [PATCH 2/4] hugetlbfs: move hugepagesz= parsing to arch independent code
Message-Id: <bb1c86b0-5d06-8999-5e3a-f9d20ca46fa1@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-3-mike.kravetz@oracle.com>
 <2ca058dc-47e6-1d08-154b-77d2cbe98e34@c-s.fr>
In-Reply-To: <2ca058dc-47e6-1d08-154b-77d2cbe98e34@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 3/19/20 12:04 AM, Christophe Leroy wrote:
> 
> 
> Le 18/03/2020 à 23:06, Mike Kravetz a écrit :
>> Now that architectures provide arch_hugetlb_valid_size(), parsing
>> of "hugepagesz=" can be done in architecture independent code.
>> Create a single routine to handle hugepagesz= parsing and remove
>> all arch specific routines.  We can also remove the interface
>> hugetlb_bad_size() as this is no longer used outside arch independent
>> code.
>>
>> This also provides consistent behavior of hugetlbfs command line
>> options.  The hugepagesz= option should only be specified once for
>> a specific size, but some architectures allow multiple instances.
>> This appears to be more of an oversight when code was added by some
>> architectures to set up ALL huge pages sizes.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   arch/arm64/mm/hugetlbpage.c   | 15 ---------------
>>   arch/powerpc/mm/hugetlbpage.c | 15 ---------------
>>   arch/riscv/mm/hugetlbpage.c   | 16 ----------------
>>   arch/s390/mm/hugetlbpage.c    | 18 ------------------
>>   arch/sparc/mm/init_64.c       | 22 ----------------------
>>   arch/x86/mm/hugetlbpage.c     | 16 ----------------
>>   include/linux/hugetlb.h       |  1 -
>>   mm/hugetlb.c                  | 24 ++++++++++++++++++------
>>   8 files changed, 18 insertions(+), 109 deletions(-)
>>
> 
> [snip]
> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 2f99359b93af..cd4ec07080fb 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3149,12 +3149,6 @@ static int __init hugetlb_init(void)
>>   }
>>   subsys_initcall(hugetlb_init);
>>   -/* Should be called on processing a hugepagesz=... option */
>> -void __init hugetlb_bad_size(void)
>> -{
>> -    parsed_valid_hugepagesz = false;
>> -}
>> -
>>   void __init hugetlb_add_hstate(unsigned int order)
>>   {
>>       struct hstate *h;
>> @@ -3224,6 +3218,24 @@ static int __init hugetlb_nrpages_setup(char *s)
>>   }
>>   __setup("hugepages=", hugetlb_nrpages_setup);
>>   +static int __init hugepagesz_setup(char *s)
>> +{
>> +    unsigned long long size;
>> +    char *saved_s = s;
>> +
>> +    size = memparse(s, &s);
> 
> You don't use s after that, so you can pass NULL instead of &s and avoid the saved_s

Thanks!

I'll incorporate in v2.

-- 
Mike Kravetz
