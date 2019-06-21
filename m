From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Fri, 21 Jun 2019 13:45:31 +0000
Subject: Re: [PATCH 03/16] mm: lift the x86_32 PAE version of gup_get_pte to common code
Message-Id: <20190621134531.GN19891@ziepe.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-4-hch@lst.de>
In-Reply-To: <20190611144102.8848-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:49PM +0200, Christoph Hellwig wrote:
> The split low/high access is the only non-READ_ONCE version of
> gup_get_pte that did show up in the various arch implemenations.
> Lift it to common code and drop the ifdef based arch override.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/include/asm/pgtable-3level.h | 47 ------------------------
>  arch/x86/kvm/mmu.c                    |  2 +-
>  mm/Kconfig                            |  3 ++
>  mm/gup.c                              | 51 ++++++++++++++++++++++++---
>  5 files changed, 52 insertions(+), 52 deletions(-)

Yep, the sh and mips conversions look right too.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f0c76ba47695..fe51f104a9e0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -762,6 +762,9 @@ config GUP_BENCHMARK
>  
>  	  See tools/testing/selftests/vm/gup_benchmark.c
>
> +config GUP_GET_PTE_LOW_HIGH
> +	bool
> +

The config name seems a bit out of place though, should it be prefixed
with GENERIC_ or ARCH_?

Jason
