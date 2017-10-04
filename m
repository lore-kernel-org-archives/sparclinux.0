From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 04 Oct 2017 15:08:59 +0000
Subject: Re: [PATCH v9 08/12] mm: zero reserved and unavailable struct pages
Message-Id: <ee817a40-1160-c24a-5106-f900ad3ebf26@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-9-pasha.tatashin@oracle.com>
 <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
 <691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com>
 <20171004085636.w2rnwf5xxhahzuy7@dhcp22.suse.cz>
 <9198a33d-cd40-dd70-4823-7f70c57ef9a2@oracle.com>
 <20171004125743.fm6mf2artbga76et@dhcp22.suse.cz>
 <d743668c-6b7e-1775-a5b8-d6e997537990@oracle.com>
 <20171004140410.2w2zf2gbutdxunir@dhcp22.suse.cz>
In-Reply-To: <20171004140410.2w2zf2gbutdxunir@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On 10/04/2017 10:04 AM, Michal Hocko wrote:
> On Wed 04-10-17 09:28:55, Pasha Tatashin wrote:
>>
>>> I am not really familiar with the trim_low_memory_range code path. I am
>>> not even sure we have to care about it because nobody should be walking
>>> pfns outside of any zone.
>>
>> According to commit comments first 4K belongs to BIOS, so I think the memory
>> exists but BIOS may or may not report it to Linux. So, reserve it to make
>> sure we never touch it.
> 
> Yes and that memory should be outside of any zones, no?

I am not totally sure, I think some x86 expert could help us here. But, 
in either case this issue can be fixed separately from the rest of the 
series.

> 
>>> I am worried that this patch adds a code which
>>> is not really used and it will just stay that way for ever because
>>> nobody will dare to change it as it is too obscure and not explained
>>> very well.
>>
>> I could explain mine code better. Perhaps add more comments, and explain
>> when it can be removed?
> 
> More explanation would be definitely helpful
> 
>>> trim_low_memory_range is a good example of this. Why do we
>>> even reserve this range from the memory block allocator? The memory
>>> shouldn't be backed by any real memory and thus not in the allocator in
>>> the first place, no?
>>>
>>
>> Since it is not enforced in memblock that everything in reserved list must
>> be part of memory list, we can have it, and we need to make sure kernel does
>> not panic. Otherwise, it is very hard to detect such bugs.
> 
> So, should we report such a memblock reservation API (ab)use to the log?
> Are you actually sure that trim_low_memory_range is doing a sane and
> really needed thing? In other words do we have a zone which contains
> this no-memory backed pfns?
> 

And, this patch reports it already:

+	pr_info("Reserved but unavailable: %lld pages", pgcnt);

I could add a comment above this print call, explain that such memory is 
probably bogus and must be studied/fixed. Also, add that this code can 
be removed once memblock is changed to allow reserve only memory that is 
backed by physical memory i.e. in "memory" list.

Pasha
