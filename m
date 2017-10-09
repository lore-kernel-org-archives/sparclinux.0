From: Will Deacon <will.deacon@arm.com>
Date: Mon, 09 Oct 2017 18:48:34 +0000
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-Id: <20171009184834.GE30828@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
 <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
In-Reply-To: <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Oct 09, 2017 at 02:42:32PM -0400, Pavel Tatashin wrote:
> Hi Will,
> 
> In addition to what Michal wrote:
> 
> > As an interim step, why not introduce something like
> > vmemmap_alloc_block_flags and make the page-table walking opt-out for
> > architectures that don't want it? Then we can just pass __GFP_ZERO from
> > our vmemmap_populate where necessary and other architectures can do the
> > page-table walking dance if they prefer.
> 
> I do not see the benefit, implementing this approach means that we
> would need to implement two table walks instead of one: one for x86,
> another for ARM, as these two architectures support kasan. Also, this
> would become a requirement for any future architecture that want to
> add kasan support to add this page table walk implementation.

We have two table walks even with your patch series applied afaict: one in
our definition of vmemmap_populate (arch/arm64/mm/mmu.c) and this one
in the core code.

> >> IMO, while I understand that it looks strange that we must walk page
> >> table after creating it, it is a better approach: more enclosed as it
> >> effects kasan only, and more universal as it is in common code.
> >
> > I don't buy the more universal aspect, but I appreciate it's subjective.
> > Frankly, I'd just sooner not have core code walking early page tables if
> > it can be avoided, and it doesn't look hard to avoid it in this case.
> > The fact that you're having to add pmd_large and pud_large, which are
> > otherwise unused in mm/, is an indication that this isn't quite right imo.
> 
>  28 +#define pmd_large(pmd)         pmd_sect(pmd)
>  29 +#define pud_large(pud)         pud_sect(pud)
> 
> it is just naming difference, ARM64 calls them pmd_sect, common mm and
> other arches call them
> pmd_large/pud_large. Even the ARM has these defines in
> 
> arm/include/asm/pgtable-3level.h
> arm/include/asm/pgtable-2level.h

My worry is that these are actually highly arch-specific, but will likely
grow more users in mm/ that assume things for all architectures that aren't
necessarily valid.

Will
