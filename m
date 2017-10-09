From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 09 Oct 2017 18:59:09 +0000
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-Id: <CAOAebxs5s3DKV8f+Zw+LFVB98PE6cs=RwcOH8qEiU_MPLM9RvQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
 <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
 <20171009184834.GE30828@arm.com>
In-Reply-To: <20171009184834.GE30828@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Will,

> We have two table walks even with your patch series applied afaict: one in
> our definition of vmemmap_populate (arch/arm64/mm/mmu.c) and this one
> in the core code.

I meant to say implementing two new page table walkers, not at runtime.

> My worry is that these are actually highly arch-specific, but will likely
> grow more users in mm/ that assume things for all architectures that aren't
> necessarily valid.

I see, how about moving new kasan_map_populate() implementation into
arch dependent code:

arch/x86/mm/kasan_init_64.c
arch/arm64/mm/kasan_init.c

This way we won't need to add pmd_large()/pud_large() macros for arm64?

Pavel
