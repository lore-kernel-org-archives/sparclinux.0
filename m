From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 07:46:49 +0000
Subject: Re: [PATCH 04/16] MIPS: use the generic get_user_pages_fast code
Message-Id: <20190625074649.GD30815@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-5-hch@lst.de> <20190621140542.GO19891@ziepe.ca>
In-Reply-To: <20190621140542.GO19891@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:05:42AM -0300, Jason Gunthorpe wrote:
> Today this check is only being done on the get_user_pages_fast() -
> after this patch it is also done for __get_user_pages_fast().
> 
> Which means __get_user_pages_fast is now non-functional on a range of
> MIPS CPUs, but that seems OK as far as I can tell, so:

> However, looks to me like this patch is also a bug fix for this:

Yes.

> > -	pgdp = pgd_offset(mm, addr);
> > -	do {
> > -		pgd_t pgd = *pgdp;
> > -
> > -		next = pgd_addr_end(addr, end);
> > -		if (pgd_none(pgd))
> > -			goto slow;
> > -		if (!gup_pud_range(pgd, addr, next, gup_flags & FOLL_WRITE,
> > -				   pages, &nr))
> 
> This is different too, the core code has a p4d layer, but I see that
> whole thing gets NOP'd by the compiler as mips uses pgtable-nop4d.h -
> right?

Exactly.
