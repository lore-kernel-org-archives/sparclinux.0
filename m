From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 15:58:46 +0000
Subject: Re: [v6 07/15] mm: defining memblock_virt_alloc_try_nid_raw
Message-Id: <545b7230-2c09-d2f9-f26a-05ef395c36d4@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-8-git-send-email-pasha.tatashin@oracle.com>
 <20170811123953.GI30811@dhcp22.suse.cz>
In-Reply-To: <20170811123953.GI30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/11/2017 08:39 AM, Michal Hocko wrote:
> On Mon 07-08-17 16:38:41, Pavel Tatashin wrote:
>> A new variant of memblock_virt_alloc_* allocations:
>> memblock_virt_alloc_try_nid_raw()
>>      - Does not zero the allocated memory
>>      - Does not panic if request cannot be satisfied
> 
> OK, this looks good but I would not introduce memblock_virt_alloc_raw
> here because we do not have any users. Please move that to "mm: optimize
> early system hash allocations" which actually uses the API. It would be
> easier to review it that way.
> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> other than that
> Acked-by: Michal Hocko <mhocko@suse.com>

Sure, I could do this, but as I understood from earlier Dave Miller's 
comments, we should do one logical change at a time. Hence, introduce 
API in one patch use it in another. So, this is how I tried to organize 
this patch set. Is this assumption incorrect?
