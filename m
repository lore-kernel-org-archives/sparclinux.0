From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 06 Jan 2004 05:24:10 +0000
Subject: Re: [SPARC32] Fix BUG-on-swapout
Message-Id: <20040106052410.GA13478@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040106040805.GA13026@foobazco.org>
In-Reply-To: <20040106040805.GA13026@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 05, 2004 at 11:55:44PM -0500, Pete Zaitcev wrote:

> > -extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
> > +extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
> 
> Seems that the first one can be just removed altogether,
> since you're on it.

Yes, you're right.  I'll nuke it in my next go-round with mm.  Thanks.

> > +	KM_PTE2,
> 
> Is this needed for anything?

Not at the moment.  It is used on other arches for HIGHPTE however.
Thus far I've not dreamed up a sane way to implement that, but a fresh
batch of srmmu mushrooms just came in so I'm optimistic. :-)

The options I've considered:

Uncache-in-place.  We can't do large mappings, which wastes memory and
blows TLB locality to hell.

Uncache-in-place for user pagetables, allocate the kernel pagetables
from an uncached block as we do now.  This effectively requires user
pagetables in highmem, which not all boxes have.

Abuse the zone allocator to force pagetable allocations to come from
preassigned regions which are either small-mapped (kernel pte) or
unmapped (HIGHPTE for user pagetables).  Uncache these in place.
Incredibly evil, needlessly complex, and you can still run out.

The 2.2 way.

Leave it the way it is and put in a less fragmentation-happy
allocator.  Sorry, no HIGHPTE.

Please drop your ideas in the suggestion box.  Thanks.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
