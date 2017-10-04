From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 04 Oct 2017 12:57:43 +0000
Subject: Re: [PATCH v9 08/12] mm: zero reserved and unavailable struct pages
Message-Id: <20171004125743.fm6mf2artbga76et@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-9-pasha.tatashin@oracle.com>
 <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
 <691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com>
 <20171004085636.w2rnwf5xxhahzuy7@dhcp22.suse.cz>
 <9198a33d-cd40-dd70-4823-7f70c57ef9a2@oracle.com>
In-Reply-To: <9198a33d-cd40-dd70-4823-7f70c57ef9a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 04-10-17 08:40:11, Pasha Tatashin wrote:
> > > > Could you be more specific where is such a memory reserved?
> > > > 
> > > 
> > > I know of one example: trim_low_memory_range() unconditionally reserves from
> > > pfn 0, but e820__memblock_setup() might provide the exiting memory from pfn
> > > 1 (i.e. KVM).
> > 
> > Then just initialize struct pages for that mapping rigth there where a
> > special API is used.
> > 
> > > But, there could be more based on this comment from linux/page-flags.h:
> > > 
> > >   19  * PG_reserved is set for special pages, which can never be swapped out.
> > > Some
> > >   20  * of them might not even exist (eg empty_bad_page)...
> > 
> > I have no idea wht empty_bad_page is but a quick grep shows that this is
> > never used. I might be wrong here but if somebody is reserving a memory
> > in a special way then we should handle the initialization right there.
> > E.g. create an API for special memblock reservations.
> > 
> 
> Hi Michal,
> 
> The reservations happen before struct pages are allocated and mapped. So, it
> is not always possible to do it at call sites.

OK, I didn't realize that.
 
> Previously, I have solved this problem like this:
> 
> https://patchwork.kernel.org/patch/9886163
> 
> But, I was not too happy with that approach, so I replaced it with the
> current approach as it is more generic, and solves similar issues if they
> happen in other places. Also, the comment in page-flags got me scared that
> there are probably other places perhaps on other architectures that can have
> the similar issue.

I believe the comment is just stale. I have looked into empty_bad_page
and it is just a relict. I plan to post a patch soon.

> In addition, I did not like my solution, I was simply shrinking the low
> reservation from:
> [0 - reserve_low) to [min_pfn - reserve_low), but if min_pfn > reserve_low
> can we skip low reservation entirely? I was not sure.
> 
> The current approach notifies us if there are such pages, and we can
> fix/remove them in the future without crashing kernel in the meantime.

I am not really familiar with the trim_low_memory_range code path. I am
not even sure we have to care about it because nobody should be walking
pfns outside of any zone. I am worried that this patch adds a code which
is not really used and it will just stay that way for ever because
nobody will dare to change it as it is too obscure and not explained
very well. trim_low_memory_range is a good example of this. Why do we
even reserve this range from the memory block allocator? The memory
shouldn't be backed by any real memory and thus not in the allocator in
the first place, no?
-- 
Michal Hocko
SUSE Labs
