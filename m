From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Fri, 21 Jun 2019 14:43:51 +0000
Subject: Re: switch the remaining architectures to use generic GUP v3
Message-Id: <20190621144351.GR19891@ziepe.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
In-Reply-To: <20190611144102.8848-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:46PM +0200, Christoph Hellwig wrote:
> Hi Linus and maintainers,
> 
> below is a series to switch mips, sh and sparc64 to use the generic
> GUP code so that we only have one codebase to touch for further
> improvements to this code.  I don't have hardware for any of these
> architectures, and generally no clue about their page table
> management, so handle with care.

I like this series, ther are alot of people talking about work for GUP
and this will make any of that so much easier to do.

Jason
