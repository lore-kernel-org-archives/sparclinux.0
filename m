From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 15:29:16 +0000
Subject: Re: [PATCH v9 08/12] mm: zero reserved and unavailable struct pages
Message-Id: <691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-9-pasha.tatashin@oracle.com>
 <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
In-Reply-To: <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/03/2017 09:18 AM, Michal Hocko wrote:
> On Wed 20-09-17 16:17:10, Pavel Tatashin wrote:
>> Some memory is reserved but unavailable: not present in memblock.memory
>> (because not backed by physical pages), but present in memblock.reserved.
>> Such memory has backing struct pages, but they are not initialized by going
>> through __init_single_page().
> 
> Could you be more specific where is such a memory reserved?
> 

I know of one example: trim_low_memory_range() unconditionally reserves 
from pfn 0, but e820__memblock_setup() might provide the exiting memory 
from pfn 1 (i.e. KVM).

But, there could be more based on this comment from linux/page-flags.h:

  19  * PG_reserved is set for special pages, which can never be swapped 
out. Some
  20  * of them might not even exist (eg empty_bad_page)...

Pasha
