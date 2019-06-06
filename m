From: Christoph Hellwig <hch@lst.de>
Date: Thu, 06 Jun 2019 06:20:18 +0000
Subject: Re: [PATCH 12/16] mm: consolidate the get_user_pages* implementations
Message-Id: <20190606062018.GA26745@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-13-hch@lst.de> <b0b73eae-6d79-b621-ce4e-997ccfbf4446@nvidia.com>
In-Reply-To: <b0b73eae-6d79-b621-ce4e-997ccfbf4446@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 11:01:17PM -0700, John Hubbard wrote:
> I started reviewing this one patch, and it's kind of messy figuring out 
> if the code motion preserves everything because of
> all the consolidation from other places, plus having to move things in
> and out of the ifdef blocks.  So I figured I'd check and see if this is
> going to make it past RFC status soon, and if it's going before or after
> Ira's recent RFC ("RDMA/FS DAX truncate proposal").

I don't like the huge moves either, but I can't really think of any
better way to do it.  Proposals welcome, though.
