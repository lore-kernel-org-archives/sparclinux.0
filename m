From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 06 Oct 2017 06:49:32 +0000
Subject: Re: [PATCH] mm: deferred_init_memmap improvements
Message-Id: <071d574f-1d8c-5be9-ec92-6227db01bbd3@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171004152902.17300-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171004152902.17300-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/04/2017 08:59 PM, Pavel Tatashin wrote:
> This patch fixes another existing issue on systems that have holes in
> zones i.e CONFIG_HOLES_IN_ZONE is defined.
> 
> In for_each_mem_pfn_range() we have code like this:
> 
> if (!pfn_valid_within(pfn)
> 	goto free_range;
> 
> Note: 'page' is not set to NULL and is not incremented but 'pfn' advances.

page is initialized to NULL at the beginning of the function.
PFN advances but we dont proceed unless pfn_valid_within(pfn)
holds true which basically should have checked with arch call
back if the PFN is valid in presence of memory holes as well.
Is not this correct ?

> Thus means if deferred struct pages are enabled on systems with these kind
> of holes, linux would get memory corruptions. I have fixed this issue by
> defining a new macro that performs all the necessary operations when we
> free the current set of pages.

If we bail out in case PFN is not valid, then how corruption
can happen ?

