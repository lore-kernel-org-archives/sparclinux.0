From: David Miller <davem@davemloft.net>
Date: Sun, 03 Mar 2013 06:41:35 +0000
Subject: Re: [PATCH]sparc32: Fix lost pte_present() state while mprotect() system call
Message-Id: <20130303.014135.1820903343472159760.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1123991361539147@web6h.yandex.ru>
In-Reply-To: <1123991361539147@web6h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 25 Feb 2013 17:05:18 +0400

> Should we account none pages in pte_present instead of above like this?
> 
> static inline int srmmu_pte_present(pte_t pte)
> { return ((pte_val(pte) & SRMMU_ET_MASK) = SRMMU_ET_PTE) ||
>           ((pte_val(pte) & SRMMU_PAGE_NONE) = SRMMU_PAGE_NONE); }

No, I don't think that is what we should do.

Instead, we should use the SRMMU_NOREAD bit to encode SRMMU_PAGE_NONE
pte's.  Then you make SRMMU_PAGE_NONE set SRMMU_ET_PTE but also
SRMMU_NOREAD.

Then you'll need no changes at all to srmmu_pte_present() or
SRMMU_CHG_MASK.
