From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 20 Apr 2020 22:53:26 +0000
Subject: Re: [PATCH v3 0/4] Clean up hugetlb boot command line processing
Message-Id: <CADYN=9JbXi=rvBAvhwPh8aFu2ne4Hbu4T+PW3NP3Rv2is+x77w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <5E312000-05D8-4C5D-A7C0-DDDE1842CB0E@lca.pw>
 <4c36c6ce-3774-78fa-abc4-b7346bf24348@oracle.com>
 <CADYN=9+=tCDmddTYGY44onvrzbg7yrbacMDSxd4hhD+=b=Yeiw@mail.gmail.com>
 <86333853-0648-393f-db96-d581ee114d2b@oracle.com>
In-Reply-To: <86333853-0648-393f-db96-d581ee114d2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Qian Cai <cai@lca.pw>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Nitesh Narayan Lal <nitesh@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S.Miller" <davem@davemloft.net>

On Mon, 20 Apr 2020 at 23:43, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/20/20 1:29 PM, Anders Roxell wrote:
> > On Mon, 20 Apr 2020 at 20:23, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> On 4/20/20 8:34 AM, Qian Cai wrote:
> >>>
> >>> Reverted this series fixed many undefined behaviors on arm64 with the config,
> >> While rearranging the code (patch 3 in series), I made the incorrect
> >> assumption that CONT_XXX_SIZE = (1UL << CONT_XXX_SHIFT).  However,
> >> this is not the case.  Does the following patch fix these issues?
> >>
> >> From b75cb4a0852e208bee8c4eb347dc076fcaa88859 Mon Sep 17 00:00:00 2001
> >> From: Mike Kravetz <mike.kravetz@oracle.com>
> >> Date: Mon, 20 Apr 2020 10:41:18 -0700
> >> Subject: [PATCH] arm64/hugetlb: fix hugetlb initialization
> >>
> >> When calling hugetlb_add_hstate() to initialize a new hugetlb size,
> >> be sure to use correct huge pages size order.
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> ---
> >>  arch/arm64/mm/hugetlbpage.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >> index 9ca840527296..a02411a1f19a 100644
> >> --- a/arch/arm64/mm/hugetlbpage.c
> >> +++ b/arch/arm64/mm/hugetlbpage.c
> >> @@ -453,11 +453,11 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
> >>  static int __init hugetlbpage_init(void)
> >>  {
> >>  #ifdef CONFIG_ARM64_4K_PAGES
> >> -       hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> >> +       hugetlb_add_hstate(ilog2(PUD_SIZE) - PAGE_SHIFT);
> >>  #endif
> >> -       hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT);
> >> -       hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> >> -       hugetlb_add_hstate(CONT_PTE_SHIFT - PAGE_SHIFT);
> >> +       hugetlb_add_hstate(ilog2(CONT_PMD_SIZE) - PAGE_SHIFT);
> >> +       hugetlb_add_hstate(ilog2(PMD_SIZE) - PAGE_SHIFT);
> >> +       hugetlb_add_hstate(ilog2(CONT_PTE_SIZE) - PAGE_SHIFT);
> >>
> >>         return 0;
> >>  }
> >
> > I build this for an arm64 kernel and ran it in qemu and it worked.
>
> Thanks for testing Anders!
>
> Will, here is an updated version of the patch based on your suggestion.
> I added the () for emphasis but that may just be noise for some.  Also,
> the naming differences and values for CONT_PTE may make some people
> look twice.  Not sure if being consistent here helps?
>
> I have only built this.  No testing.
>
> From daf833ab6b806ecc0816d84d45dcbacc052a7eec Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 20 Apr 2020 13:56:15 -0700
> Subject: [PATCH] arm64/hugetlb: fix hugetlb initialization
>
> When calling hugetlb_add_hstate() to initialize a new hugetlb size,
> be sure to use correct huge pages size order.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

I tested this patch on qemu-aarch64.

Cheers,
Anders

> ---
>  arch/arm64/mm/hugetlbpage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 9ca840527296..bed6dc7c4276 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -455,9 +455,9 @@ static int __init hugetlbpage_init(void)
>  #ifdef CONFIG_ARM64_4K_PAGES
>         hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>  #endif
> -       hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT);
> +       hugetlb_add_hstate((CONT_PMD_SHIFT + PMD_SHIFT) - PAGE_SHIFT);
>         hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> -       hugetlb_add_hstate(CONT_PTE_SHIFT - PAGE_SHIFT);
> +       hugetlb_add_hstate((CONT_PTE_SHIFT + PAGE_SHIFT) - PAGE_SHIFT);
>
>         return 0;
>  }
> --
> 2.25.2
>
