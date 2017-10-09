From: Will Deacon <will.deacon@arm.com>
Date: Mon, 09 Oct 2017 18:22:17 +0000
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-Id: <20171009182217.GC30828@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
In-Reply-To: <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Pavel,

On Mon, Oct 09, 2017 at 01:51:47PM -0400, Pavel Tatashin wrote:
> I can go back to that approach, if Michal OK with it. But, that would
> mean that I would need to touch every single architecture that
> implements vmemmap_populate(), and also pass flags at least through
> these functions on every architectures (some have more than one
> decided by configs).:
> 
> vmemmap_populate()
> vmemmap_populate_basepages()
> vmemmap_populate_hugepages()
> vmemmap_pte_populate()
> __vmemmap_alloc_block_buf()
> alloc_block_buf()
> vmemmap_alloc_block()

As an interim step, why not introduce something like
vmemmap_alloc_block_flags and make the page-table walking opt-out for
architectures that don't want it? Then we can just pass __GFP_ZERO from
our vmemmap_populate where necessary and other architectures can do the
page-table walking dance if they prefer.

> IMO, while I understand that it looks strange that we must walk page
> table after creating it, it is a better approach: more enclosed as it
> effects kasan only, and more universal as it is in common code.

I don't buy the more universal aspect, but I appreciate it's subjective.
Frankly, I'd just sooner not have core code walking early page tables if
it can be avoided, and it doesn't look hard to avoid it in this case.
The fact that you're having to add pmd_large and pud_large, which are
otherwise unused in mm/, is an indication that this isn't quite right imo.

Will
