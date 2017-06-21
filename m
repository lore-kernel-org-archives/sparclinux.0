From: David Miller <davem@davemloft.net>
Date: Wed, 21 Jun 2017 01:21:23 +0000
Subject: Re: [PATCH 0/4] sparc64: Add 16GB hugepage support
Message-Id: <20170620.212123.1341170611627457785.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1498005968.git.nitin.m.gupta@oracle.com>
In-Reply-To: <cover.1498005968.git.nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 20 Jun 2017 18:05:53 -0700

> Patch 1/4: Core changes needed to add 16G hugepage support: To map a
>   single 16G hugepage, two PUD entries are used. Each PUD entry maps
>   8G portion of a 16G page. This page table encoding scheme is same as
>   that used for hugepages at PMD level (8M, 256M and 2G pages) where
>   each PMD entry points successively to 8M regions within a page.  No
>   page table entries below the PUD level are allocated for 16G
>   hugepage since those are not required.
> 
>   TSB entries for a 16G page are created at every 4M boundary since
>   the HUGE_TSB is used for these pages which is configured with page
>   size of 4M.  When walking page tables (on a TSB miss), bits [32:22]
>   are transferred from vaddr to PUD to resolve addresses at 4M
>   boundary. The resolved address mapping is then stored in HUGE_TSB.

Ok this is a new feature.

> Patch 2/4: get_user_pages() etc. are used for direct IO. These
>   functions were not aware of hugepages at the PUD level and would try
>   to continue walking page tables beyond the PUD level. Since 16G
>   hugepages have page tables allocated till PUD level only, these
>   accesses would result in invalid access. This patch adds the case
>   for PUD huge pages to these functions.
> 
> Patch 3/4: Fixes a bug in gup_huge_pmd() which caused wrong page
>   within a hugepage to be considered as the head page. gup_huge_pud()
>   already has this fix.

These are bug fixes that appear to be relevant for mainline right?

Please submit these two separately.

> Patch 4/4: Patch 1 added the case of PUD entry being huge in page
>   table walk and alloc functions. This new case further increased
>   nesting in these functions and made them harder to follow. This
>   patch flattens these functions for better readability.

Ok, this is a cleanup and can go along with the new feature patch #1.

So submit the two bug fixes against 'sparc' GIT, then when I next
merge 'sparc' into 'sparc-next', you can submit #1 and #4.

THanks.
