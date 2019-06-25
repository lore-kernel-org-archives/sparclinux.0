From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 07:56:50 +0000
Subject: Re: [PATCH 11/16] mm: consolidate the get_user_pages* implementations
Message-Id: <20190625075650.GF30815@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-12-hch@lst.de> <20190621144131.GQ19891@ziepe.ca>
In-Reply-To: <20190621144131.GQ19891@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:41:31AM -0300, Jason Gunthorpe wrote:
> >  static bool gup_fast_permitted(unsigned long start, unsigned long end)
> >  {
> > -	return true;
> > +	return IS_ENABLED(CONFIG_HAVE_FAST_GUP) ? true : false;
> 
> The ?: is needed with IS_ENABLED?

It shouldn't, I'll fix it up.

> I'd suggest to revise this block a tiny bit:
> 
> -#ifndef gup_fast_permitted
> +#if !IS_ENABLED(CONFIG_HAVE_FAST_GUP) || !defined(gup_fast_permitted)
>  /*
>   * Check if it's allowed to use __get_user_pages_fast() for the range, or
>   * we need to fall back to the slow version:
>   */
> -bool gup_fast_permitted(unsigned long start, int nr_pages)
> +static bool gup_fast_permitted(unsigned long start, int nr_pages)
>  {
> 
> Just in case some future arch code mismatches the header and kconfig..

IS_ENABLED outside a function doesn't really make sense.  But I'll
just life the IS_ENABLED(CONFIG_HAVE_FAST_GUP) checks into the two
callers.
