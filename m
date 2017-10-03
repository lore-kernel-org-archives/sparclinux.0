From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 15:34:25 +0000
Subject: Re: [PATCH v9 12/12] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <c028f65a-b4a6-e56d-3a50-5d7ad9af50cb@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-13-pasha.tatashin@oracle.com>
 <20171003131952.aqq377pjug5me6go@dhcp22.suse.cz>
In-Reply-To: <20171003131952.aqq377pjug5me6go@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/03/2017 09:19 AM, Michal Hocko wrote:
> On Wed 20-09-17 16:17:14, Pavel Tatashin wrote:
>> vmemmap_alloc_block() will no longer zero the block, so zero memory
>> at its call sites for everything except struct pages.  Struct page memory
>> is zero'd by struct page initialization.
>>
>> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
>> we will get the performance improvement by zeroing the memory in parallel
>> when struct pages are zeroed.
> 
> Is it possible to merge this patch with http://lkml.kernel.org/r/20170920201714.19817-7-pasha.tatashin@oracle.com

Yes, I will do that. It would also require re-arranging
[PATCH v9 07/12] sparc64: optimized struct page zeroing
optimization to come after this patch.

Pasha
