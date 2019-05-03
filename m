From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 03 May 2019 13:47:19 +0000
Subject: Re: [PATCH 2/3] s390: remove ARCH_SELECT_MEMORY_MODEL
Message-Id: <20190503134719.GB5602@osiris>
List-Id: <sparclinux.vger.kernel.org>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
 <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:56:16PM +0300, Mike Rapoport wrote:
> The only reason s390 has ARCH_SELECT_MEMORY_MODEL option in
> arch/s390/Kconfig is an ancient compile error with allnoconfig which was
> fixed by commit 97195d6b411f ("[S390] fix sparsemem related compile error
> with allnoconfig on s390") by adding the ARCH_SELECT_MEMORY_MODEL option.
> 
> Since then a lot have changed and now allnoconfig builds just fine without
> ARCH_SELECT_MEMORY_MODEL, so it can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
