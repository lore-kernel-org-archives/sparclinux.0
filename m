From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 16:13:13 +0000
Subject: Re: [v6 14/15] mm: optimize early system hash allocations
Message-Id: <8da9321c-769c-3319-8c02-3c91d86b221e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-15-git-send-email-pasha.tatashin@oracle.com>
 <20170811130541.GM30811@dhcp22.suse.cz>
In-Reply-To: <20170811130541.GM30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> Clients can call alloc_large_system_hash() with flag: HASH_ZERO to specify
>> that memory that was allocated for system hash needs to be zeroed,
>> otherwise the memory does not need to be zeroed, and client will initialize
>> it.
>>
>> If memory does not need to be zero'd, call the new
>> memblock_virt_alloc_raw() interface, and thus improve the boot performance.
>>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> OK, but as mentioned in the previous patch add memblock_virt_alloc_raw
> in this patch.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Ok I will merge them.

Thank you,
Pasha
