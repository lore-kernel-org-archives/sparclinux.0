From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Thu, 10 Aug 2017 14:41:41 +0000
Subject: Re: [PATCH v7 7/9] mm: Add address parameter to arch_validate_prot()
Message-Id: <2e97b439-dd71-8997-4824-15f2b1f53787@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1502219353.git.khalid.aziz@oracle.com>
 <43c120f0cbbebd1398997b9521013ced664e5053.1502219353.git.khalid.aziz@oracle.com>
 <87tw1flftz.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tw1flftz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: bsingharora@gmail.com, dja@axtens.net, tglx@linutronix.de, mgorman@suse.de, aarcange@redhat.com, kirill.shutemov@linux.intel.com, heiko.carstens@de.ibm.com, ak@linux.intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 08/10/2017 07:20 AM, Michael Ellerman wrote:
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> A protection flag may not be valid across entire address space and
>> hence arch_validate_prot() might need the address a protection bit is
>> being set on to ensure it is a valid protection flag. For example, sparc
>> processors support memory corruption detection (as part of ADI feature)
>> flag on memory addresses mapped on to physical RAM but not on PFN mapped
>> pages or addresses mapped on to devices. This patch adds address to the
>> parameters being passed to arch_validate_prot() so protection bits can
>> be validated in the relevant context.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Cc: Khalid Aziz <khalid@gonehiking.org>
>> ---
>> v7:
>> 	- new patch
>>
>>   arch/powerpc/include/asm/mman.h | 2 +-
>>   arch/powerpc/kernel/syscalls.c  | 2 +-
>>   include/linux/mman.h            | 2 +-
>>   mm/mprotect.c                   | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
>> index 30922f699341..bc74074304a2 100644
>> --- a/arch/powerpc/include/asm/mman.h
>> +++ b/arch/powerpc/include/asm/mman.h
>> @@ -40,7 +40,7 @@ static inline bool arch_validate_prot(unsigned long prot)
>>   		return false;
>>   	return true;
>>   }
>> -#define arch_validate_prot(prot) arch_validate_prot(prot)
>> +#define arch_validate_prot(prot, addr) arch_validate_prot(prot)
> 
> This can be simpler, as just:
> 
> #define arch_validate_prot arch_validate_prot
> 

Hi Michael,

Thanks for reviewing!

My patch expands parameter list for arch_validate_prot() from one to two 
parameters. Existing powerpc version of arch_validate_prot() is written 
with one parameter. If I use the above #define, compilation fails with:

mm/mprotect.c: In function ‘do_mprotect_pkey’:
mm/mprotect.c:399: error: too many arguments to function 
‘arch_validate_prot’

Another way to solve it would be to add the new addr parameter to 
powerpc version of arch_validate_prot() but I chose the less disruptive 
solution of tackling it through #define and expanded the existing 
#define to include the new parameter. Make sense?

Thanks,
Khalid
