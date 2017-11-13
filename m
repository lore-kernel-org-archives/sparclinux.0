From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 13 Nov 2017 15:59:14 +0000
Subject: Re: linux-next: Tree for Nov 7
Message-Id: <20171113155914.5uwmycui4qdwsbw3@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154811.GM12318@n2100.armlinux.org.uk>
In-Reply-To: <20171113154811.GM12318@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 13-11-17 15:48:13, Russell King - ARM Linux wrote:
> On Mon, Nov 13, 2017 at 04:16:41PM +0100, Michal Hocko wrote:
> > On Mon 13-11-17 13:00:57, Michal Hocko wrote:
> > [...]
> > > Yes, I have mentioned that in the previous email but the amount of code
> > > would be even larger. Basically every arch which reimplements
> > > arch_get_unmapped_area would have to special case new MAP_FIXED flag to
> > > do vma lookup.
> > 
> > It turned out that this might be much more easier than I thought after
> > all. It seems we can really handle that in the common code. This would
> > mean that we are exposing a new functionality to the userspace though.
> > Myabe this would be useful on its own though. Just a quick draft (not
> > even compile tested) whether this makes sense in general. I would be
> > worried about unexpected behavior when somebody set other bit without a
> > good reason and we might fail with ENOMEM for such a call now.
> > 
> > Elf loader would then use MAP_FIXED_SAFE rather than MAP_FIXED.
> > ---
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> > index 3b26cc62dadb..d021c21f9b01 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -31,6 +31,9 @@
> >  #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
> >  #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
> >  
> > +#define MAP_KEEP_MAPPING 0x2000000
> > +#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */
> 
> A few things...
> 
> 1. Does this need to be exposed to userland?

As I've written in another email, exposing the flag this way would be
really dangerous wrt. backward compatibility. So we would either need some
translation or make it a flag on its own and touch the arch specific
code which I really wanted to prevent from.

Whether this is something useful for the userspace is a separate
question which I should bring up to linux-api for a wider audience to
discuss.

So I guess this goes down to whether we want/need something like
MAP_FIXED_SAFE or opt out the specific hardening code for arches that
cannot make unaligned mappings for the requested address.

> 2. Can it end up in include/uapi/asm-generic/mman*.h ?
> 3. The definition of MAP_FIXED_SAFE should really have parens around it.

Of course. I thought I did...

> > @@ -1365,6 +1365,13 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  	if (offset_in_page(addr))
> >  		return addr;
> >  
> > +	if ((flags & MAP_FIXED_SAFE) = MAP_FIXED_SAFE) {
> 
> I'm surprised this doesn't warn - since this effectively expands to:
> 
> 	flags & MAP_FIXED | MAP_KEEP_MAPPING
> 
> hence why MAP_FIXED_SAFE needs parens.

It sure does.

Thanks!
-- 
Michal Hocko
SUSE Labs
