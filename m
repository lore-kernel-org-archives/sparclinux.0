From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 03 Jun 2019 15:16:08 +0000
Subject: Re: [PATCH 01/16] uaccess: add untagged_addr definition for other arches
Message-Id: <431c7395-2327-2f7c-cc8f-b01412b74e10@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de>
 <20190601074959.14036-2-hch@lst.de>
In-Reply-To: <20190601074959.14036-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Andrey Konovalov <andreyknvl@google.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>

On 6/1/19 1:49 AM, Christoph Hellwig wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> To allow arm64 syscalls to accept tagged pointers from userspace, we must
> untag them when they are passed to the kernel. Since untagging is done in
> generic parts of the kernel, the untagged_addr macro needs to be defined
> for all architectures.
> 
> Define it as a noop for architectures other than arm64.

Could you reword above sentence? We are already starting off with
untagged_addr() not being no-op for arm64 and sparc64. It will expand
further potentially. So something more along the lines of "Define it as
noop for architectures that do not support memory tagging". The first
paragraph in the log can also be rewritten to be not specific to arm64.

--
Khalid

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0e8834ac32b7..949d43e9c0b6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
>  
> +#ifndef untagged_addr
> +#define untagged_addr(addr) (addr)
> +#endif
> +
>  #ifndef __pa_symbol
>  #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
>  #endif
> 
