From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Fri, 21 Jun 2019 15:54:15 +0000
Subject: Re: [PATCH 01/16] mm: use untagged_addr() for get_user_pages_fast addresses
Message-Id: <20190621155415.GU19891@ziepe.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-2-hch@lst.de>
 <20190621133911.GL19891@ziepe.ca>
 <9a4e1485-4683-92b0-3d26-73f26896d646@oracle.com>
In-Reply-To: <9a4e1485-4683-92b0-3d26-73f26896d646@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:35:11AM -0600, Khalid Aziz wrote:
> On 6/21/19 7:39 AM, Jason Gunthorpe wrote:
> > On Tue, Jun 11, 2019 at 04:40:47PM +0200, Christoph Hellwig wrote:
> >> This will allow sparc64 to override its ADI tags for
> >> get_user_pages and get_user_pages_fast.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>  mm/gup.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/gup.c b/mm/gup.c
> >> index ddde097cf9e4..6bb521db67ec 100644
> >> +++ b/mm/gup.c
> >> @@ -2146,7 +2146,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >>  	unsigned long flags;
> >>  	int nr = 0;
> >>  
> >> -	start &= PAGE_MASK;
> >> +	start = untagged_addr(start) & PAGE_MASK;
> >>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> >>  	end = start + len;
> > 
> > Hmm, this function, and the other, goes on to do:
> > 
> >         if (unlikely(!access_ok((void __user *)start, len)))
> >                 return 0;
> > 
> > and I thought that access_ok takes in the tagged pointer?
> > 
> > How about re-order it a bit?
> 
> access_ok() can handle tagged or untagged pointers. It just strips the
> tag bits from the top bits. Current order doesn't really matter from
> functionality point of view. There might be minor gain in delaying
> untagging in __get_user_pages_fast() but I could go either way.

I understand the current ARM and SPARC implementations don't do much
with the tags, but it feels like a really big assumption for the core
code that all future uses of tags will be fine to have them stripped
out of 'void __user *' pointers. IMHO that is something we should not
be doing in the core kernel..

Jason
