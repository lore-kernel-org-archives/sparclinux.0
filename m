From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 09 Apr 2018 17:57:57 +0000
Subject: Re: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
Message-Id: <20180409175757.GA12938@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> -#ifdef __HAVE_ARCH_PTE_SPECIAL
> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>  # define HAVE_PTE_SPECIAL 1
>  #else
>  # define HAVE_PTE_SPECIAL 0

I'd say kill this odd indirection and just use the
CONFIG_ARCH_HAS_PTE_SPECIAL symbol directly.

