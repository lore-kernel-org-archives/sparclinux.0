From: Bob Breuer <breuerr@mc.net>
Date: Wed, 10 Nov 2004 05:59:34 +0000
Subject: Re: Fix for HyperSPARC DMA errors
Message-Id: <4191AFDE.1090909@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419188A0.3010307@mc.net>
In-Reply-To: <419188A0.3010307@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Should probably test for hypersparc so it doesn't slow down the non-hypersparcs.

BTW, I had tried __flush_page_to_ram as used in iommu_map_dma_area, but that
didn't work.  Might flush_cache_range or something similar work?

David S. Miller wrote:
> On Tue, 9 Nov 2004 21:23:29 -0800
> William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> 
>>Bob, how do you feel about your arch/sparc/mm/iommu.c flush_cache_all()
>>hack? Would you prefer to have that in mainline for the time being, or
>>would you rather wait until you devise a better solution?
> 
> 
> I think even this part of Bob's patch should just go in.
> At worst it will slow things down for people, and it will
> fix real bugs for people.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
