From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 15:15:54 +0000
Subject: Re: [PATCH v9 03/12] mm: deferred_init_memmap improvements
Message-Id: <fc4ef789-d9a8-5dab-6508-f0fe8751b462@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-4-pasha.tatashin@oracle.com>
 <20171003125754.2kuqzkstywg7axhd@dhcp22.suse.cz>
In-Reply-To: <20171003125754.2kuqzkstywg7axhd@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Michal,

> 
> Please be explicit that this is possible only because we discard
> memblock data later after 3010f876500f ("mm: discard memblock data
> later"). Also be more explicit how the new code works.

OK

> 
> I like how the resulting code is more compact and smaller.

That was the goal :)

> for_each_free_mem_range also looks more appropriate but I really detest
> the DEFERRED_FREE thingy. Maybe we can handle all that in a single goto
> section. I know this is not an art but manipulating variables from
> macros is more error prone and much more ugly IMHO.

Sure, I can re-arrange to have a goto place. Function won't be as small, 
and if compiler is not smart enough we might end up with having more 
branches than what my current code has.

> 
> please do not use macros. Btw. this deserves its own fix. I suspect that
> no CONFIG_HOLES_IN_ZONE arch enables DEFERRED_STRUCT_PAGE_INIT but
> purely from the review point of view it should be its own patch.

Sure, I will submit this patch separately from the rest of the project. 
In my opinion DEFERRED_STRUCT_PAGE_INIT is the way of the future, so we 
should make sure it is working with as many configs as possible.

Thank you,
Pasha
