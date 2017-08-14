From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 Aug 2017 13:51:12 +0000
Subject: Re: [v6 05/15] mm: don't accessed uninitialized struct pages
Message-Id: <e339a33c-d16b-91bd-5df0-18f5ec03d52b@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
 <20170811093746.GF30811@dhcp22.suse.cz>
 <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
 <20170814114755.GI19063@dhcp22.suse.cz>
In-Reply-To: <20170814114755.GI19063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> mem_init()
>>   free_all_bootmem()
>>    free_low_memory_core_early()
>>     for_each_reserved_mem_region()
>>      reserve_bootmem_region()
>>       init_reserved_page() <- if this is deferred reserved page
>>        __init_single_pfn()
>>         __init_single_page()
>>
>> So, currently, we are using the value of page->flags to figure out if this
>> page has been initialized while being part of deferred page, but this is not
>> going to work for this project, as we do not zero the memory that is backing
>> the struct pages, and size the value of page->flags can be anything.
> 
> True, this is the initialization part I've missed in one of the previous
> patches already. Would it be possible to only iterate over !reserved
> memory blocks instead? Now that we discard all the metadata later it
> should be quite easy to do for_each_memblock_type, no?

Hi Michal,

Clever suggestion to add a new iterator to go through unreserved 
existing memory, I do not think there is this iterator available, so it 
would need to be implemented, using similar approach to what I have done 
with a call back.

However, there is a different reason, why I took this current approach.

Daniel Jordan is working on a ktask support:
https://lkml.org/lkml/2017/7/14/666

He and I discussed on how to multi-thread struct pages initialization 
within memory nodes using ktasks. Having this callback interface makes 
that multi-threading quiet easy, improving the boot performance further, 
with his prototype we saw x4-6 improvements (using 4-8 threads per 
node). Reducing the total time it takes to initialize all struct pages 
on machines with terabytes of memory to less than one second.

Pasha
