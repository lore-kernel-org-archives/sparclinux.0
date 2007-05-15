From: Christoph Lameter <clameter@sgi.com>
Date: Tue, 15 May 2007 23:45:22 +0000
Subject: Re: slab hang on boot
Message-Id: <Pine.LNX.4.64.0705151642530.3886@schroedinger.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705142133190.17204@math>
 <20070514.151148.45744375.davem@davemloft.net>
 <Pine.LNX.4.64.0705141642350.13606@schroedinger.engr.sgi.com>
 <20070515163321.744e2388.akpm@linux-foundation.org>
In-Reply-To: <20070515163321.744e2388.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mroos@linux.ee, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 May 2007, Andrew Morton wrote:

> On Mon, 14 May 2007 16:46:17 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > @@ -86,6 +87,9 @@ static inline int kmalloc_index(int size
> >  	 */
> >  	WARN_ON_ONCE(size = 0);
> >  
> > +	if (size >= (1UL << KMALLOC_SHIFT_HIGH))
> > +		return -1;
> > +
> 
> I don't quite understand why we did this.  The subsequent logic in
> kmalloc_index() should return -1 for this `size' anyway.  If it doesn't,
> it's bust, isn't it?

KMALLOC_SHIFT_HIGH is not a constant but may be less than 25.

> Also, afaict kmalloc_slab() will totally mishandle the -1 return value and
> will return a garbage kmem_cache*, via
> 
>         return &kmalloc_caches[index];

It does an

if (index < 0)

before getting to that statement.
 
> Could you double-check it all please?

It was already checked.


 
