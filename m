From: David Miller <davem@davemloft.net>
Date: Thu, 24 Mar 2016 19:22:52 +0000
Subject: Re: [Patch V2 2/2] sparc64 changes
Message-Id: <20160324.152252.1708061349012846009.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 17:41:08 -0500

> +	/* Check for a huge/THP page */
> +	paddr = pmd_is_huge(pte, vaddr, verbose);
> +	if (paddr)
> +		goto out;
 ...
> +	paddr = pte_to_pa(pte);
> +	paddr = paddr | (vaddr & ~PAGE_MASK);

This handles transparent huge pages installed at the PMD level, but I don't
see that it handles huge PTEs properly, which are encoded at the PTE level.
