From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Fri, 21 Jun 2019 13:40:21 +0000
Subject: Re: [PATCH 02/16] mm: simplify gup_fast_permitted
Message-Id: <20190621134021.GM19891@ziepe.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-3-hch@lst.de>
In-Reply-To: <20190611144102.8848-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:48PM +0200, Christoph Hellwig wrote:
> Pass in the already calculated end value instead of recomputing it, and
> leave the end > start check in the callers instead of duplicating them
> in the arch code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/include/asm/pgtable.h   |  8 +-------
>  arch/x86/include/asm/pgtable_64.h |  8 +-------
>  mm/gup.c                          | 17 +++++++----------
>  3 files changed, 9 insertions(+), 24 deletions(-)

Much cleaner

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
