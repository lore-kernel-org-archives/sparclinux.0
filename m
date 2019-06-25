From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 07:41:08 +0000
Subject: Re: [PATCH 01/16] mm: use untagged_addr() for get_user_pages_fast addresses
Message-Id: <20190625074108.GB30815@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-2-hch@lst.de> <20190621133911.GL19891@ziepe.ca>
In-Reply-To: <20190621133911.GL19891@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:39:11AM -0300, Jason Gunthorpe wrote:
> 
> Hmm, this function, and the other, goes on to do:
> 
>         if (unlikely(!access_ok((void __user *)start, len)))
>                 return 0;
> 
> and I thought that access_ok takes in the tagged pointer?
> 
> How about re-order it a bit?

The patch doesn't really work as-as an misses the main
get_user_pages_fast fast path, but I'll add something equivalent.
