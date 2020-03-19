From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 19 Mar 2020 02:42:56 +0000
Subject: Re: [PATCH 4/4] hugetlbfs: clean up command line processing
Message-Id: <7196b6b5-53df-9898-471a-ae481395e97c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-5-mike.kravetz@oracle.com>
 <1820045d-0bf2-9a86-226d-e9c4d5928749@infradead.org>
In-Reply-To: <1820045d-0bf2-9a86-226d-e9c4d5928749@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 3/18/20 5:20 PM, Randy Dunlap wrote:
> Hi Mike,
> 
> On 3/18/20 3:06 PM, Mike Kravetz wrote:
>> With all hugetlb page processing done in a single file clean up code.
>> - Make code match desired semantics
>>   - Update documentation with semantics
>> - Make all warnings and errors messages start with 'HugeTLB:'.
>> - Consistently name command line parsing routines.
>> - Add comments to code
>>   - Describe some of the subtle interactions
>>   - Describe semantics of command line arguments
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  Documentation/admin-guide/mm/hugetlbpage.rst | 26 +++++++
>>  mm/hugetlb.c                                 | 78 +++++++++++++++-----
>>  2 files changed, 87 insertions(+), 17 deletions(-)
> 
> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index cc85b4f156ca..2b9bf01db2b6 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
> 
>> @@ -3214,8 +3238,15 @@ static int __init hugetlb_nrpages_setup(char *s)
>>  
>>  	return 1;
>>  }
>> -__setup("hugepages=", hugetlb_nrpages_setup);
>> +__setup("hugepages=", hugepages_setup);
>>  
>> +/*
>> + * hugepagesz command line processing
>> + * A specific huge page size can only be specified once with hugepagesz.
>> + * hugepagesz is followed by hugepages on the commnad line.  The global
> 
> typo:                                            command

Thanks

> 
>> + * variable 'parsed_valid_hugepagesz' is used to determine if prior
>> + * hugepagesz argument was valid.
>> + */
>>  static int __init hugepagesz_setup(char *s)
>>  {
>>  	unsigned long long size;
> 
> 
> Does any of this need to be updated?  (from Documentation/admin-guide/kernel-parameters.txt)
> 
> 	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
> 			On x86-64 and powerpc, this option can be specified
> 			multiple times interleaved with hugepages= to reserve
> 			huge pages of different sizes. Valid pages sizes on
> 			x86-64 are 2M (when the CPU supports "pse") and 1G
> 			(when the CPU supports the "pdpe1gb" cpuinfo flag).
> 

No functional changes should be expected/seen as a result of these patches.
So the documentation here is basically OK.  However, it is out of date as
more architectures are supported.  In addition, the statement "this option
can be specified multiple times interleaved with hugepages= to reserve
huge pages of different sizes." may need a little clarification.  As mentioned
elsewhere,  hugepagesz= can only be specified once per huge page size.

I'll make some updates in v2.
-- 
Mike Kravetz
