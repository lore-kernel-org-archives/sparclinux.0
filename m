From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 03 Dec 2018 16:28:16 +0000
Subject: Re: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
Message-Id: <20181203162816.GA26700@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
 <20181203161052.GA4244@ravnborg.org>
In-Reply-To: <20181203161052.GA4244@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, Dec 03, 2018 at 05:10:52PM +0100, Sam Ravnborg wrote:
> Hi Mike.
> 
> On Mon, Dec 03, 2018 at 05:47:12PM +0200, Mike Rapoport wrote:
> > Rather than use the memblock_alloc_base that returns a physical address and
> > then convert this address to the virtual one, use appropriate memblock
> > function that returns a virtual address.
> > 
> > There is a small functional change in the allocation of then NODE_DATA().
> > Instead of panicing if the local allocation failed, the non-local
> > allocation attempt will be made.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/sh/mm/init.c | 18 +++++-------------
> >  arch/sh/mm/numa.c |  5 ++---
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index c8c13c77..3576b5f 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
> >  void __init allocate_pgdat(unsigned int nid)
> >  {
> >  	unsigned long start_pfn, end_pfn;
> > -#ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	unsigned long phys;
> > -#endif
> >  
> >  	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >  
> >  #ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	phys = __memblock_alloc_base(sizeof(struct pglist_data),
> > -				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
> > -	/* Retry with all of system memory */
> > -	if (!phys)
> > -		phys = __memblock_alloc_base(sizeof(struct pglist_data),
> > -					SMP_CACHE_BYTES, memblock_end_of_DRAM());
> > -	if (!phys)
> > +	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
> > +				sizeof(struct pglist_data),
> > +				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> > +				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > +	if (!NODE_DATA(nid))
> >  		panic("Can't allocate pgdat for node %d\n", nid);
> > -
> > -	NODE_DATA(nid) = __va(phys);
> > -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
> The new code will always assign NODE_DATA(nid), where the old
> code only assigned NODE_DATA(nid) in the good case.
> I dunno if this is an issue, just noticed the difference and
> wanted to point it out.

If the allocation fails the NODE_DATA(nid) remains zero anyway and there is
a panic() call. So I think there is no actual functional change here.

> 	Sam
> 

-- 
Sincerely yours,
Mike.
