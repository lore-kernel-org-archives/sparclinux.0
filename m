Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216822DF719
	for <sparclinux@vger.kernel.org>; Fri,  9 Oct 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540789; cv=none; b=ZPiiywqShRIYbfA2TfnbkL82EeXvMbJ5GwsEceVMJ68rWU1b+gJascEc7DKNKJGoBrgQFifnEGNJyCuXui5mYENFprCUOTYbDnkNfaTvfetOTsllA+91LeGPs/95auzNU8c94hvkTiGLLtKTofp/cbEZWA8PqbWpuPFDL59HF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540789; c=relaxed/simple;
	bh=eaYQmb9ZALluqgib4BZV+eLgGSwA/6ES9/OvsXDVPQU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqQBohv9qjL922cDC0NeHLGyoaAVoqDLj81avj/xrb6IN8bLjt7CxQ+3U6SCjJUKUHrCKL+D6baj4a9ve0NjZsntYUUdhyBVCa9D7IjHGIhCMUX/gmMwYuKh3KU5vO7KMzRBZIzStpANWeutXmAYavx9Om3+7b/Tb/0k6hTleI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Af4xYk97; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Af4xYk97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791540787; x=1823076787;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=eaYQmb9ZALluqgib4BZV+eLgGSwA/6ES9/OvsXDVPQU=;
  b=Af4xYk97cG5AX2PhTiKIOgkcFc0q7cNsXcrR+FfrOFQ0QWtZoV1KV5nP
   dg8km+faCtuCdwCqR4PX56yLuMBhEs2pMwUWICaBK1AR85IUZvESawkVZ
   bD/gTpDzuM/pKEW14i/J2M7i06jhibQFcdb8m84oeMqDNea7qLn/pbse2
   ZF3bSgdGQ1PTjxdjNJ3x081/FUQYtbhyhVb1ehQfkVry3GB9u5C3MHhCR
   mC5yBZQYsLeMSt6emvkV2mBzVH3vaX2IIqgiNsdvfPzBTRv4laaNEhqCe
   E1mygE9LhDmm5P/8gku2oGmKJrFjCFlPbQBcT66Z4iVSvgeE4ipRvc6Vy
   g==;
X-CSE-ConnectionGUID: JjDXe/W4QgaeZCbwJoli0A==
X-CSE-MsgGUID: B5UaLu2PQl268zWWUdIfiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="345878"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="345878"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:13:07 -0700
X-CSE-ConnectionGUID: jlaQHoMiTSm2Ox2HMjOusA==
X-CSE-MsgGUID: HdnIXe07StulL+HQ0YxKtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="223535"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2026 03:13:05 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xF7b5-000000005bY-2qnO;
	Fri, 09 Oct 2026 10:13:03 +0000
Date: Fri, 9 Oct 2026 18:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] sparc64: Define p4d_page() instead of stubbing it to
 NULL
Message-ID: <202610091839.WCEBCL4p-lkp@intel.com>
References: <20261008191711.223236-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008191711.223236-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.3-rc6]
[also build test ERROR on linus/master next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/sparc64-Define-p4d_page-instead-of-stubbing-it-to-NULL/20261008-121711
base:   v7.3-rc6
patch link:    https://lore.kernel.org/r/20261008191711.223236-1-rosenp%40gmail.com
patch subject: [PATCH v2] sparc64: Define p4d_page() instead of stubbing it to NULL
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20261009/202610091839.WCEBCL4p-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 242243a5814307de825db3428662d67b064e2cbc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610091839.WCEBCL4p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610091839.WCEBCL4p-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmalloc.c:849:10: error: expected expression
     849 |                 return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
         |                        ^
   arch/sparc/include/asm/pgtable_64.h:864:25: note: expanded from macro 'p4d_page'
     864 | #define p4d_page(p4d)                   static inline struct page *p4d_page(p4d_t p4d) { return NULL; }
         |                                         ^
   1 error generated.


vim +849 mm/vmalloc.c

73bdf0a60e607f Linus Torvalds    2008-10-15  816  
48667e7a43c1a1 Christoph Lameter 2008-02-04  817  /*
c0eb315ad9719e Nicholas Piggin   2021-04-29  818   * Walk a vmap address to the struct page it maps. Huge vmap mappings will
c0eb315ad9719e Nicholas Piggin   2021-04-29  819   * return the tail page that corresponds to the base page address, which
c0eb315ad9719e Nicholas Piggin   2021-04-29  820   * matches small vmap mappings.
48667e7a43c1a1 Christoph Lameter 2008-02-04  821   */
add688fbd32158 malc              2014-01-27  822  struct page *vmalloc_to_page(const void *vmalloc_addr)
48667e7a43c1a1 Christoph Lameter 2008-02-04  823  {
48667e7a43c1a1 Christoph Lameter 2008-02-04  824  	unsigned long addr = (unsigned long) vmalloc_addr;
add688fbd32158 malc              2014-01-27  825  	struct page *page = NULL;
48667e7a43c1a1 Christoph Lameter 2008-02-04  826  	pgd_t *pgd = pgd_offset_k(addr);
c2febafc67734a Kiryl Shutsemau   2017-03-09  827  	p4d_t *p4d;
c2febafc67734a Kiryl Shutsemau   2017-03-09  828  	pud_t *pud;
c2febafc67734a Kiryl Shutsemau   2017-03-09  829  	pmd_t *pmd;
c2febafc67734a Kiryl Shutsemau   2017-03-09  830  	pte_t *ptep, pte;
48667e7a43c1a1 Christoph Lameter 2008-02-04  831  
7aa413def76146 Ingo Molnar       2008-06-19  832  	/*
7aa413def76146 Ingo Molnar       2008-06-19  833  	 * XXX we might need to change this if we add VIRTUAL_BUG_ON for
7aa413def76146 Ingo Molnar       2008-06-19  834  	 * architectures that do not vmalloc module space
7aa413def76146 Ingo Molnar       2008-06-19  835  	 */
73bdf0a60e607f Linus Torvalds    2008-10-15  836  	VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
59ea746337c69f Jiri Slaby        2008-06-12  837  
c2febafc67734a Kiryl Shutsemau   2017-03-09  838  	if (pgd_none(*pgd))
c2febafc67734a Kiryl Shutsemau   2017-03-09  839  		return NULL;
c0eb315ad9719e Nicholas Piggin   2021-04-29  840  	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
c0eb315ad9719e Nicholas Piggin   2021-04-29  841  		return NULL; /* XXX: no allowance for huge pgd */
c0eb315ad9719e Nicholas Piggin   2021-04-29  842  	if (WARN_ON_ONCE(pgd_bad(*pgd)))
c0eb315ad9719e Nicholas Piggin   2021-04-29  843  		return NULL;
c0eb315ad9719e Nicholas Piggin   2021-04-29  844  
c2febafc67734a Kiryl Shutsemau   2017-03-09  845  	p4d = p4d_offset(pgd, addr);
c2febafc67734a Kiryl Shutsemau   2017-03-09  846  	if (p4d_none(*p4d))
c2febafc67734a Kiryl Shutsemau   2017-03-09  847  		return NULL;
c0eb315ad9719e Nicholas Piggin   2021-04-29  848  	if (p4d_leaf(*p4d))
c0eb315ad9719e Nicholas Piggin   2021-04-29 @849  		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
c0eb315ad9719e Nicholas Piggin   2021-04-29  850  	if (WARN_ON_ONCE(p4d_bad(*p4d)))
c0eb315ad9719e Nicholas Piggin   2021-04-29  851  		return NULL;
029c54b0959957 Ard Biesheuvel    2017-06-23  852  
c0eb315ad9719e Nicholas Piggin   2021-04-29  853  	pud = pud_offset(p4d, addr);
c0eb315ad9719e Nicholas Piggin   2021-04-29  854  	if (pud_none(*pud))
c0eb315ad9719e Nicholas Piggin   2021-04-29  855  		return NULL;
c0eb315ad9719e Nicholas Piggin   2021-04-29  856  	if (pud_leaf(*pud))
c0eb315ad9719e Nicholas Piggin   2021-04-29  857  		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
c0eb315ad9719e Nicholas Piggin   2021-04-29  858  	if (WARN_ON_ONCE(pud_bad(*pud)))
c2febafc67734a Kiryl Shutsemau   2017-03-09  859  		return NULL;
c0eb315ad9719e Nicholas Piggin   2021-04-29  860  
c2febafc67734a Kiryl Shutsemau   2017-03-09  861  	pmd = pmd_offset(pud, addr);
c0eb315ad9719e Nicholas Piggin   2021-04-29  862  	if (pmd_none(*pmd))
c0eb315ad9719e Nicholas Piggin   2021-04-29  863  		return NULL;
c0eb315ad9719e Nicholas Piggin   2021-04-29  864  	if (pmd_leaf(*pmd))
c0eb315ad9719e Nicholas Piggin   2021-04-29  865  		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
c0eb315ad9719e Nicholas Piggin   2021-04-29  866  	if (WARN_ON_ONCE(pmd_bad(*pmd)))
c2febafc67734a Kiryl Shutsemau   2017-03-09  867  		return NULL;
db64fe02258f15 Nicholas Piggin   2008-10-18  868  
0d1c81edc61e55 Hugh Dickins      2023-06-08  869  	ptep = pte_offset_kernel(pmd, addr);
c33c794828f212 Ryan Roberts      2023-06-12  870  	pte = ptep_get(ptep);
48667e7a43c1a1 Christoph Lameter 2008-02-04  871  	if (pte_present(pte))
add688fbd32158 malc              2014-01-27  872  		page = pte_page(pte);
c0eb315ad9719e Nicholas Piggin   2021-04-29  873  
add688fbd32158 malc              2014-01-27  874  	return page;
48667e7a43c1a1 Christoph Lameter 2008-02-04  875  }
add688fbd32158 malc              2014-01-27  876  EXPORT_SYMBOL(vmalloc_to_page);
48667e7a43c1a1 Christoph Lameter 2008-02-04  877  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
