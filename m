From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 14 Nov 2017 07:07:48 +0000
Subject: Re: linux-next: Tree for Nov 7
Message-Id: <20171114070748.in5zdc4giqbxowjy@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
 <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
 <c52fa249-9583-18a2-cbac-28abfb23d5a5@oracle.com>
In-Reply-To: <c52fa249-9583-18a2-cbac-28abfb23d5a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 13-11-17 09:35:22, Khalid Aziz wrote:
> On 11/13/2017 09:06 AM, Michal Hocko wrote:
> > OK, so this one should take care of the backward compatibility while
> > still not touching the arch code
> > ---
> > commit 39ff9bf8597e79a032da0954aea1f0d77d137765
> > Author: Michal Hocko <mhocko@suse.com>
> > Date:   Mon Nov 13 17:06:24 2017 +0100
> > 
> >      mm: introduce MAP_FIXED_SAFE
> >      MAP_FIXED is used quite often but it is inherently dangerous because it
> >      unmaps an existing mapping covered by the requested range. While this
> >      might be might be really desidered behavior in many cases there are
> >      others which would rather see a failure than a silent memory corruption.
> >      Introduce a new MAP_FIXED_SAFE flag for mmap to achive this behavior.
> >      It is a MAP_FIXED extension with a single exception that it fails with
> >      ENOMEM if the requested address is already covered by an existing
> >      mapping. We still do rely on get_unmaped_area to handle all the arch
> >      specific MAP_FIXED treatment and check for a conflicting vma after it
> >      returns.
> >      Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > ...... deleted .......
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 680506faceae..aad8d37f0205 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1358,6 +1358,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >   	if (mm->map_count > sysctl_max_map_count)
> >   		return -ENOMEM;
> > +	/* force arch specific MAP_FIXED handling in get_unmapped_area */
> > +	if (flags & MAP_FIXED_SAFE)
> > +		flags |= MAP_FIXED;
> > +
> >   	/* Obtain the address to map to. we verify (or select) it and ensure
> >   	 * that it represents a valid section of the address space.
> >   	 */
> 
> Do you need to move this code above:
> 
>         if (!(flags & MAP_FIXED))
>                 addr = round_hint_to_min(addr);
> 
>         /* Careful about overflows.. */
>         len = PAGE_ALIGN(len);
>         if (!len)
>                 return -ENOMEM;
> 
> Not doing that might mean the hint address will end up being rounded for
> MAP_FIXED_SAFE which would change the behavior from MAP_FIXED.

Yes, I will move it.
-- 
Michal Hocko
SUSE Labs
