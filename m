From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 04 Oct 2017 08:48:16 +0000
Subject: Re: [PATCH v9 03/12] mm: deferred_init_memmap improvements
Message-Id: <20171004084816.ljyw2gdf5gmgtm7z@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-4-pasha.tatashin@oracle.com>
 <20171003125754.2kuqzkstywg7axhd@dhcp22.suse.cz>
 <fc4ef789-d9a8-5dab-6508-f0fe8751b462@oracle.com>
 <d81baa49-b796-7130-4ace-0f14ed59be46@oracle.com>
In-Reply-To: <d81baa49-b796-7130-4ace-0f14ed59be46@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue 03-10-17 12:01:08, Pasha Tatashin wrote:
> Hi Michal,
> 
> Are you OK, if I replace DEFERRED_FREE() macro with a function like this:
> 
> /*
>  * Helper for deferred_init_range, free the given range, and reset the
>  * counters
>  */
> static inline unsigned long __def_free(unsigned long *nr_free,
>                                        unsigned long *free_base_pfn,
>                                        struct page **page)
> {
>         unsigned long nr = *nr_free;
> 
>         deferred_free_range(*free_base_pfn, nr);
>         *free_base_pfn = 0;
>         *nr_free = 0;
>         *page = NULL;
> 
>         return nr;
> }
> 
> Since it is inline, and we operate with non-volatile counters, compiler will
> be smart enough to remove all the unnecessary de-references. As a plus, we
> won't be adding any new branches, and the code is still going to stay
> compact.

OK. It is a bit clunky but we are holding too much state there. I
haven't checked whether that can be simplified but this can be always
done later.
-- 
Michal Hocko
SUSE Labs
