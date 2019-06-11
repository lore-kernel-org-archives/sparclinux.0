From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 11 Jun 2019 19:35:57 +0000
Subject: Re: [PATCH 10/16] mm: rename CONFIG_HAVE_GENERIC_GUP to CONFIG_HAVE_FAST_GUP
Message-Id: <98e75b14-89f4-91b4-e836-2fdff188535b@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-11-hch@lst.de>
In-Reply-To: <20190611144102.8848-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 6/11/19 8:40 AM, Christoph Hellwig wrote:
> We only support the generic GUP now, so rename the config option to
> be more clear, and always use the mm/Kconfig definition of the
> symbol and select it from the arch Kconfigs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig     | 5 +----
>  arch/arm64/Kconfig   | 4 +---
>  arch/mips/Kconfig    | 2 +-
>  arch/powerpc/Kconfig | 2 +-
>  arch/s390/Kconfig    | 2 +-
>  arch/sh/Kconfig      | 2 +-
>  arch/sparc/Kconfig   | 2 +-
>  arch/x86/Kconfig     | 4 +---
>  mm/Kconfig           | 2 +-
>  mm/gup.c             | 4 ++--
>  10 files changed, 11 insertions(+), 18 deletions(-)
> 

Looks good.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
