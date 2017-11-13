From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 13 Nov 2017 12:00:57 +0000
Subject: Re: linux-next: Tree for Nov 7
Message-Id: <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lgjawgx1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 13-11-17 22:34:50, Michael Ellerman wrote:
> Hi Michal,
> 
> Michal Hocko <mhocko@kernel.org> writes:
> > On Mon 13-11-17 10:20:06, Michal Hocko wrote:
> >> [Cc arm and ppc maintainers]
> >
> > Hmm, it turned out to be a problem on other architectures as well.
> > CCing more maintainers. For your reference, we are talking about
> > http://lkml.kernel.org/r/20171023082608.6167-1-mhocko@kernel.org
> > which has broken architectures which do apply aligning on the mmap
> > address hint without MAP_FIXED applied. See below my proposed way
> > around this issue because I belive that the above patch is quite
> > valuable on its own to be dropped for all archs.
> 
> I don't really like your solution sorry :)  The fact that you've had to
> patch seven arches seems like a red flag.
> 
> I think this is a generic problem with MAP_FIXED, which I've heard
> userspace folks complain about in the past.

The thing is that we canno  change MAP_FIXED behavior as it is carved in
stone

> Currently MAP_FIXED does two things:
>   1. makes addr not a hint but the required address
>   2. blasts any existing mapping
> 
> You want 1) but not 2).

+ fail if there is a clashing range

> So the right solution IMHO would be to add a new mmap flag to request
> that behaviour, ie. a fixed address but iff there is nothing already
> mapped there.
> 
> I don't know the mm code well enough to know if that's hard for some
> reason, but it *seems* like it should be doable.

Yes, I have mentioned that in the previous email but the amount of code
would be even larger. Basically every arch which reimplements
arch_get_unmapped_area would have to special case new MAP_FIXED flag to
do vma lookup. So this was the most simple solution I could come up
with. If there was a general interest for MAP_FIXED_SAFE then we can
introduce it later of course. I would just like the hardening merged
sooner rather than later.
-- 
Michal Hocko
SUSE Labs
