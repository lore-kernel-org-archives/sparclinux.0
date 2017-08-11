From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 19:00:47 +0000
Subject: Re: [v6 04/15] mm: discard memblock data later
Message-Id: <42a04441-47ad-2fa0-ca3c-784c717213f7@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
In-Reply-To: <20170811093249.GE30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Michal,

This suggestion won't work, because there are arches without memblock 
support: tile, sh...

So, I would still need to have:

#ifdef CONFIG_MEMBLOCK in page_alloc, or define memblock_discard() stubs 
in nobootmem headfile. In either case it would become messier than what 
it is right now.

Pasha

> I have just one nit below
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> [...]
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 2cb25fe4452c..bf14aea6ab70 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -285,31 +285,27 @@ static void __init_memblock memblock_remove_region(struct memblock_type *type, u
>>   }
>>   
>>   #ifdef CONFIG_ARCH_DISCARD_MEMBLOCK
> 
> pull this ifdef inside memblock_discard and you do not have an another
> one in page_alloc_init_late
> 
> [...]
>> +/**
>> + * Discard memory and reserved arrays if they were allocated
>> + */
>> +void __init memblock_discard(void)
>>   {
> 
> here
> 
>> -	if (memblock.memory.regions = memblock_memory_init_regions)
>> -		return 0;
>> +	phys_addr_t addr, size;
>>   
>> -	*addr = __pa(memblock.memory.regions);
>> +	if (memblock.reserved.regions != memblock_reserved_init_regions) {
>> +		addr = __pa(memblock.reserved.regions);
>> +		size = PAGE_ALIGN(sizeof(struct memblock_region) *
>> +				  memblock.reserved.max);
>> +		__memblock_free_late(addr, size);
>> +	}
>>   
>> -	return PAGE_ALIGN(sizeof(struct memblock_region) *
>> -			  memblock.memory.max);
>> +	if (memblock.memory.regions = memblock_memory_init_regions) {
>> +		addr = __pa(memblock.memory.regions);
>> +		size = PAGE_ALIGN(sizeof(struct memblock_region) *
>> +				  memblock.memory.max);
>> +		__memblock_free_late(addr, size);
>> +	}
>>   }
>> -
>>   #endif
