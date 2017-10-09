From: Will Deacon <will.deacon@arm.com>
Date: Mon, 09 Oct 2017 18:48:29 +0000
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-Id: <20171009184828.GD30828@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009181433.wevxa447d4g6kdsj@dhcp22.suse.cz>
In-Reply-To: <20171009181433.wevxa447d4g6kdsj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Oct 09, 2017 at 08:14:33PM +0200, Michal Hocko wrote:
> On Mon 09-10-17 13:51:47, Pavel Tatashin wrote:
> > I can go back to that approach, if Michal OK with it. But, that would
> > mean that I would need to touch every single architecture that
> > implements vmemmap_populate(), and also pass flags at least through
> > these functions on every architectures (some have more than one
> > decided by configs).:
> > 
> > vmemmap_populate()
> > vmemmap_populate_basepages()
> > vmemmap_populate_hugepages()
> > vmemmap_pte_populate()
> > __vmemmap_alloc_block_buf()
> > alloc_block_buf()
> > vmemmap_alloc_block()
> > 
> > IMO, while I understand that it looks strange that we must walk page
> > table after creating it, it is a better approach: more enclosed as it
> > effects kasan only, and more universal as it is in common code.
> 
> While I understand that gfp mask approach might look better at first
> sight this is by no means a general purpose API so I would rather be
> pragmatic and have a smaller code footprint than a more general
> interface. Kasan is pretty much a special case and doing a one time
> initialization 2 pass thing is imho acceptable. If this turns out to be
> impractical in future then let's fix it up but right now I would rather
> go a simpler path.

I think the simpler path for arm64 is really to say when we want the memory
zeroing as opposed to exposing pmd_large/pud_large macros. Those are likely
to grow more users too, but are difficult to use correctly as we have things
like contiguous ptes that map to a granule smaller than a pmd.

I proposed an alternative solution to Pavel already, but it could be made
less general purpose by marking the function __meminit and only having it
do anything if KASAN is compiled in.

Will
