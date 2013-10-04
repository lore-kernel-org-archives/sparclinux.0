From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Fri, 04 Oct 2013 02:16:48 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <524E2510.8080301@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10/03/2013 07:07 PM, Gurudas Pai wrote:
> On 09/30/2013 09:31 AM, David Miller wrote:
>> This is a respin of the original page_offset and 64-bit page
>> table changes with some minor changes and a bug fix:
>>
>> 1) Bob's ACKs for the first 6 patches added.
>>
>> 2) Don't use "UL" postfix for shift counts, there is code that
>>     wants those to be "int", particularly printfs in mm/mm_init.c
>>     that use the "%d" format specifier for SECTIONS_SHIFT.
>>
>> 3) Adjust VA_HOLE defines to match what the new 3-level page
>>     tables can actually provide.
>>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> -- 
> On a t4-1 machine with 64gb RAM , run following testcase as
>
> ./a.out 10000
>
> And run echo 1000000 > /proc/sys/vm/nr_hugepages couple of times. 
> Machine becomes unusuable.
> This includes "fix generic hugetlb pte check return type." patch as 
> well.Oom killers and then lockups.
> Will try wothout patches very soon.
Same issue without 47-bit patches.
thanks,
-Guru


