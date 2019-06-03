From: Christoph Hellwig <hch@lst.de>
Date: Mon, 03 Jun 2019 07:44:21 +0000
Subject: Re: [PATCH 08/16] sparc64: add the missing pgd_page definition
Message-Id: <20190603074421.GB22920@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-9-hch@lst.de> <CAHk-=wj9w5NxTcJsqpvYUiL3OBOH-J3=4-vXcc3GaG_U8H-gJw@mail.gmail.com>
In-Reply-To: <CAHk-=wj9w5NxTcJsqpvYUiL3OBOH-J3=4-vXcc3GaG_U8H-gJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Sat, Jun 01, 2019 at 09:28:54AM -0700, Linus Torvalds wrote:
> Both sparc64 and sh had this pattern, but now that I look at it more
> closely, I think your version is wrong, or at least nonoptimal.

I bet it is.  Then again these symbols are just required for the code
to compile, as neither sparc64 nor sh actually use the particular
variant of huge pages we need it for.  Then again even actually dead
code should better be not too buggy if it isn't just a stub.

> So I thgink this would be better done with
> 
>      #define pgd_page(pgd)    pfn_to_page(pgd_pfn(pgd))
> 
> where that "pgd_pfn()" would need to be a new (but likely very
> trivial) function. That's what we do for pte_pfn().
> 
> IOW, it would likely end up something like
> 
>   #define pgd_to_pfn(pgd) (pgd_val(x) >> PFN_PGD_SHIFT)

True.  I guess it would be best if we could get most if not all
architectures to use common versions of these macros so that we have
the issue settled once.
