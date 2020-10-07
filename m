From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 07 Oct 2020 12:35:44 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <20201007123544.GA11433@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, Dave Kleikamp <shaggy@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Wed, Oct 07, 2020 at 09:39:31AM +0200, Jann Horn wrote:
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 078608ec2e92..b1fabb97d138 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -43,7 +43,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
>  {
>  	long ret = -EINVAL;
>  
> -	if (!arch_validate_prot(prot, addr))
> +	if (!arch_validate_prot(prot, addr, len))

This call isn't under mmap lock.  I also find it rather weird as the
generic code only calls arch_validate_prot from mprotect, only powerpc
also calls it from mmap.

This seems to go back to commit ef3d3246a0d0
("powerpc/mm: Add Strong Access Ordering support")
