From: Will Deacon <will.deacon@arm.com>
Date: Mon, 09 Oct 2017 17:13:37 +0000
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-Id: <20171009171337.GE30085@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
In-Reply-To: <20171003144845.GD4931@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 03, 2017 at 03:48:46PM +0100, Mark Rutland wrote:
> On Wed, Sep 20, 2017 at 04:17:11PM -0400, Pavel Tatashin wrote:
> > During early boot, kasan uses vmemmap_populate() to establish its shadow
> > memory. But, that interface is intended for struct pages use.
> > 
> > Because of the current project, vmemmap won't be zeroed during allocation,
> > but kasan expects that memory to be zeroed. We are adding a new
> > kasan_map_populate() function to resolve this difference.
> 
> Thanks for putting this together.
> 
> I've given this a spin on arm64, and can confirm that it works.
> 
> Given that this involes redundant walking of page tables, I still think
> it'd be preferable to have some common *_populate() helper that took a
> gfp argument, but I guess it's not the end of the world.
> 
> I'll leave it to Will and Catalin to say whether they're happy with the
> page table walking and the new p{u,m}d_large() helpers added to arm64.

To be honest, it just looks completely backwards to me; we're walking the
page tables we created earlier on so that we can figure out what needs to
be zeroed for KASAN. We already had that information before, hence my
preference to allow propagation of GFP_FLAGs to vmemmap_alloc_block when
it's needed. I know that's not popular for some reason, but is walking the
page tables really better?

Will
