Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5438E8A7
	for <sparclinux@vger.kernel.org>; Fri,  9 Oct 2026 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579083; cv=none; b=APbA8oM9BbHiUgnACOlZQRQEaAYi4Cecihv7Ej5mf5gyPX8x2rhgQv8TEFx6u0onL/AvMi8PClZhkZ929fChnqrl7/DDeMR8kjiEECyUzaUCJVhyhQ6VSsQ+zab9hmGKhbWgrGXsNRzPa26RLG1Br5kESYy40fjf8SJqoWuRgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579083; c=relaxed/simple;
	bh=DEQJeKh1aKUCl9c7JFzNmCfkldEKd85L6h1ZihvpBOc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrY5urBwOG3bShE6CI+X2uCsiCNOMhbOQyP96Tql6ETssOH1QHkpsEWLLswHdb3in6wYNzKU4YcPphy00R457EtCGw3e/P9BG/AzZRrtm74rx6vl2aek5lA97ruQkbmomX6m2sOQHwwezFM+eypoDh71g5+vQ1Zv0ufdnXogDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTG4lPr1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTG4lPr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791579082; x=1823115082;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=DEQJeKh1aKUCl9c7JFzNmCfkldEKd85L6h1ZihvpBOc=;
  b=bTG4lPr1H/YtBS9xpHE6edRnd8OPVlxsQuwANvBtszqb/YHTNHOtDXNb
   nzQYWoGKK7faOT6tIR8vXaj2G5ZV/8iFJ2szavxQ7es1vsu5ucd9avhv2
   smT92PfcyfOd5hgPya269zkXW3FgDjLlIea8TeRcsZN7r+lVhZGzvM0s/
   aYi1zPFTOWtPqO00bY5TXzvYSvutMqTk8Vpe8sESPH+n1djA3s/Do6kvj
   YL8m2m7ZoQNNJWM4q/skT9jSL6u+xjw3rt9fVl8zpu5fmqxGASw/5tiBb
   Bd0zKVPKK3tjwPbelJTP8xv7fXmQvY6kIonCatQZCqCX1K/7EnGH8f/Wj
   g==;
X-CSE-ConnectionGUID: GHsY8zIxQFSVrwHCxm50+w==
X-CSE-MsgGUID: AQshz2N6T5+OspVg/CRSxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="481899"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="481899"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:51:21 -0700
X-CSE-ConnectionGUID: idQ0WEPkSwmdJNKLT5LT4w==
X-CSE-MsgGUID: xeD5zO60QbaVUT6txIt1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="588918"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Oct 2026 13:51:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFHYk-000000006BI-1uWw;
	Fri, 09 Oct 2026 20:51:18 +0000
Date: Sat, 10 Oct 2026 04:51:03 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] sparc64: Define p4d_page() instead of stubbing it to
 NULL
Message-ID: <202610100432.gMvyFk85-lkp@intel.com>
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
config: sparc-randconfig-1000-20261010 (https://download.01.org/0day-ci/archive/20261010/202610100432.gMvyFk85-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100432.gMvyFk85-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100432.gMvyFk85-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/pgtable.h:5,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:31,
                    from mm/vmalloc.c:12:
   mm/vmalloc.c: In function 'vmalloc_to_page':
>> arch/sparc/include/asm/pgtable_64.h:864:25: error: expected expression before 'static'
    #define p4d_page(p4d)   static inline struct page *p4d_page(p4d_t p4d) { return NULL; }
                            ^~~~~~
   mm/vmalloc.c:849:10: note: in expansion of macro 'p4d_page'
      return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
             ^~~~~~~~


vim +/static +864 arch/sparc/include/asm/pgtable_64.h

   862	
   863	/* only used by the stubbed out hugetlb gup code, should never be called */
 > 864	#define p4d_page(p4d)			static inline struct page *p4d_page(p4d_t p4d) { return NULL; }
   865	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
