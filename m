From: kbuild test robot <lkp@intel.com>
Date: Tue, 30 Aug 2016 22:51:57 +0000
Subject: Re: [PATCH] sparc64 mm: Fix more TSB sizing issues
Message-Id: <201608310635.bSVf0cLr%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
List-Id: <sparclinux.vger.kernel.org>
References: <1472592502-16007-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1472592502-16007-1-git-send-email-mike.kravetz@oracle.com>
To: sparclinux@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

[auto build test ERROR on sparc/master]
[also build test ERROR on v4.8-rc4 next-20160825]
[cannot apply to sparc-next/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Mike-Kravetz/sparc64-mm-Fix-more-TSB-sizing-issues/20160831-054025
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   arch/sparc/mm/tsb.c: In function 'init_new_context':
>> arch/sparc/mm/tsb.c:504:4: error: 'saved_thp_pte_count' undeclared (first use in this function)
       saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
       ^
   arch/sparc/mm/tsb.c:504:4: note: each undeclared identifier is reported only once for each function it appears in
>> arch/sparc/mm/tsb.c:504:27: error: 'HPAGE_SIZE' undeclared (first use in this function)
       saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
                              ^

vim +/saved_thp_pte_count +504 arch/sparc/mm/tsb.c

   498			mm->context.tsb_block[i].tsb = NULL;
   499	
   500		/* If this is fork, inherit the parent's TSB size.  We would
   501		 * grow it to that size on the first page fault anyways.
   502		 */
   503		tsb_grow(mm, MM_TSB_BASE, get_mm_rss(mm) -
 > 504			 saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
   505	
   506	#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
   507		if (unlikely(saved_hugetlb_pte_count + saved_thp_pte_count))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--yrj/dFKFPuw6o+aM
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--yrj/dFKFPuw6o+aM--
