From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 25 Sep 2013 17:44:36 +0000
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-Id: <20130925174436.GA14037@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
 <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
In-Reply-To: <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


* Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:

> On Wed 25 Sep at 09:30:49 +0200 mingo@kernel.org said:
> > >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > >  	info.length = len;
> > > -	info.low_limit = PAGE_SIZE;
> > > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> > >  	info.high_limit = mm->mmap_base;
> > >  	info.align_mask = filp ? get_align_mask() : 0;
> > >  	info.align_offset = pgoff << PAGE_SHIFT;
> > 
> > There appears to be a lot of repetition in these methods - instead of 
> > changing 6 places it would be more future-proof to first factor out the 
> > common bits and then to apply the fix to the shared implementation.
> 
> Besides that existing redundancy in the multiple somewhat similar
> arch_get_unmapped_area_topdown() functions, I was expecting people might
> question the added redundancy of the six instances of:
> 
> 	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

That redundancy would be automatically addressed by my suggestion.

Thanks,

	Ingo
