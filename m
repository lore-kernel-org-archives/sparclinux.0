From: David Miller <davem@davemloft.net>
Date: Fri, 02 May 2014 03:13:07 +0000
Subject: Re: [PATCH 08/10] sparc64: Fix range check in kern_addr_valid().
Message-Id: <20140501.231307.58290953599109676.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175548.327746802251623616.davem@davemloft.net>
In-Reply-To: <20140430.175548.327746802251623616.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 2 May 2014 00:42:25 +0200

> On Wed, Apr 30, 2014 at 05:55:48PM -0400, David Miller wrote:
>> --- a/arch/sparc/include/asm/pgtable_64.h
>> +++ b/arch/sparc/include/asm/pgtable_64.h
>> @@ -916,7 +916,7 @@ static inline bool kern_addr_valid(unsigned long addr)
>>  {
>>  	unsigned long paddr = __pa(addr);
>>  
>> -	if ((paddr >> 41UL) != 0UL)
>> +	if ((paddr >> MAX_PHYS_ADDRESS_BITS) != 0UL)
>>  		return false;
>>  	return test_bit(paddr >> 22, sparc64_valid_addr_bitmap);
> 
> BTW, maybe this other magic constant - 22 - could be replaced as well?
> Is that ILOG2_4MB?

Yep, it is.
