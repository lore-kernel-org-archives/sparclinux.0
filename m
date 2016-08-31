From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 31 Aug 2016 03:27:46 +0000
Subject: Re: [PATCH] sparc64 mm: Fix more TSB sizing issues
Message-Id: <75bce2ed-8ae8-d207-e426-ee105e9b2910@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201608310635.bSVf0cLr%fengguang.wu@intel.com>
In-Reply-To: <201608310635.bSVf0cLr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Nitin Gupta <nitin.m.gupta@oracle.com>

On 08/30/2016 03:51 PM, kbuild test robot wrote:
> Hi Mike,
> 
> [auto build test ERROR on sparc/master]
> [also build test ERROR on v4.8-rc4 next-20160825]
> [cannot apply to sparc-next/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]

Ugh!  I'll send a V2 patch with the non-hugepage/non-thp build error fixed.
I'd really like to fix this without adding another #ifdef to the routine.

-- 
Mike Kravetz

> 
> url:    https://github.com/0day-ci/linux/commits/Mike-Kravetz/sparc64-mm-Fix-more-TSB-sizing-issues/20160831-054025
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
> config: sparc64-allnoconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sparc/mm/tsb.c: In function 'init_new_context':
>>> arch/sparc/mm/tsb.c:504:4: error: 'saved_thp_pte_count' undeclared (first use in this function)
>        saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
>        ^
>    arch/sparc/mm/tsb.c:504:4: note: each undeclared identifier is reported only once for each function it appears in
>>> arch/sparc/mm/tsb.c:504:27: error: 'HPAGE_SIZE' undeclared (first use in this function)
>        saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
>                               ^
> 
> vim +/saved_thp_pte_count +504 arch/sparc/mm/tsb.c
> 
>    498			mm->context.tsb_block[i].tsb = NULL;
>    499	
>    500		/* If this is fork, inherit the parent's TSB size.  We would
>    501		 * grow it to that size on the first page fault anyways.
>    502		 */
>    503		tsb_grow(mm, MM_TSB_BASE, get_mm_rss(mm) -
>  > 504			 saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
>    505	
>    506	#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
>    507		if (unlikely(saved_hugetlb_pte_count + saved_thp_pte_count))
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
