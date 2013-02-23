From: David Miller <davem@davemloft.net>
Date: Sat, 23 Feb 2013 23:54:27 +0000
Subject: Re: [PATCH]sparc32: Fix lost pte_present() state while mprotect() system call
Message-Id: <20130223.185427.2174957191074957136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1123991361539147@web6h.yandex.ru>
In-Reply-To: <1123991361539147@web6h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 22 Feb 2013 17:19:07 +0400

> If pte is present before change_pte_range() works on it, the state will be
> lost after it. pte_modify() zeroes every 0xff bit including SRMMU_ET_MASK
> while it adds new protection. I receive the stack after this (on a slightly
> modified kernel):
> 
> BUG: Bad page map in process SC_EXE  pte:059d8cfc pmd:00069e01
> addr:52d44000 vm_flags:00100070 anon_vma:be6ef3cc mapping:(null) index:52d44
> 8009e8d0 : zap_pte_range+0x120/0x3bc
> 8009ed3c : unmap_page_range+0x1d0/0x230
> 8009ee80 : unmap_vmas+0xe4/0x160
> 800a5a74 : exit_mmap+0xbc/0x218
> 8003ed24 : mmput+0x2c/0x100
> 80044190 : exit_mm+0x108/0x148
> 800447a0 : do_exit+0x158/0x350
> 80044a08 : do_group_exit+0x38/0xb8
> 80044a94 : sys_exit_group+0xc/0x1c
> 8001232c : syscall_is_too_hard+0x38/0x44
> 7fd5a7c4 : 0x7fd5a7c4
> 
> So, add SRMMU_ET_MASK to SRMMU_CHG_MASK.
> 
> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
 ...
> -#define SRMMU_CHG_MASK    (0xffffff00 | SRMMU_REF | SRMMU_DIRTY)
> +#define SRMMU_CHG_MASK    (0xffffff00 | SRMMU_REF | SRMMU_DIRTY | SRMMU_ET_MASK)

I don't think this is correct, the state is not lost, it must be
contained fully in the pgprot_t protections we are changing to.

What if we are trying to change the protections from PAGE_COPY (which
has the valid bit set) to PAGE_NONE (which lacks the valid bit)?  That
no longer works after your change, as we'll leave the valid bit set.

In fact, I think the bug you triggered is exactly this situation, and
your patch therefore breaks PAGE_NONE completely.

Present and Valid are two seperate pieces of state, so the bug might
really be that the SRMMU code tries to handle them as one.  And your
trace seems to confirm this, actually.  PROT_NONE can be for a present
page, but it must have the valid bit cleared.
