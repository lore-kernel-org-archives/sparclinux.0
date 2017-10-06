From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 06 Oct 2017 12:11:42 +0000
Subject: RE: [PATCH v10 09/10] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <063D6719AE5E284EB5DD2968C1650D6DD008BB4D@AcuExch.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
 <20171005211124.26524-10-pasha.tatashin@oracle.com>
 <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
 <20171006114729.fexwklupkhyxdpt3@dhcp22.suse.cz>
In-Reply-To: <20171006114729.fexwklupkhyxdpt3@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Michal Hocko
> Sent: 06 October 2017 12:47
> On Fri 06-10-17 11:10:14, David Laight wrote:
> > From: Pavel Tatashin
> > > Sent: 05 October 2017 22:11
> > > vmemmap_alloc_block() will no longer zero the block, so zero memory
> > > at its call sites for everything except struct pages.  Struct page memory
> > > is zero'd by struct page initialization.
> >
> > It seems dangerous to change an allocator to stop zeroing memory.
> > It is probably saver to add a new function that doesn't zero
> > the memory and use that is the places where you don't want it
> > to be zeroed.
> 
> Not sure what you mean. memblock_virt_alloc_try_nid_raw is a new
> function which doesn't zero out...

You should probably leave vmemap_alloc_block() zeroing the memory
so that existing alls don't have to be changed - apart from the
ones you are explicitly optimising.

	David
