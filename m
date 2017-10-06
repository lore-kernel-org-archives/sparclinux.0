From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 06 Oct 2017 11:47:29 +0000
Subject: Re: [PATCH v10 09/10] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <20171006114729.fexwklupkhyxdpt3@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
 <20171005211124.26524-10-pasha.tatashin@oracle.com>
 <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 06-10-17 11:10:14, David Laight wrote:
> From: Pavel Tatashin
> > Sent: 05 October 2017 22:11
> > vmemmap_alloc_block() will no longer zero the block, so zero memory
> > at its call sites for everything except struct pages.  Struct page memory
> > is zero'd by struct page initialization.
> 
> It seems dangerous to change an allocator to stop zeroing memory.
> It is probably saver to add a new function that doesn't zero
> the memory and use that is the places where you don't want it
> to be zeroed.

Not sure what you mean. memblock_virt_alloc_try_nid_raw is a new
function which doesn't zero out...
-- 
Michal Hocko
SUSE Labs
