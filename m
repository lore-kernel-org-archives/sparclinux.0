From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 07 Oct 2020 12:36:54 +0000
Subject: Re: [PATCH 2/2] sparc: Check VMA range in sparc_validate_prot()
Message-Id: <20201007123654.GB11433@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
 <20201007073932.865218-2-jannh@google.com>
In-Reply-To: <20201007073932.865218-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

> +++ b/arch/sparc/include/asm/mman.h
> @@ -60,31 +60,41 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr,
>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>  		return 0;
>  	if (prot & PROT_ADI) {
> +		struct vm_area_struct *vma, *next;
> +

I'd split all the ADI logic into a separate, preferable out of line
helper.

> +			/* reached the end of the range without errors? */
> +			if (addr+len <= vma->vm_end)

missing whitespaces around the arithmetic operator.
