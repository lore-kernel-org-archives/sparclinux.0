Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40D29AAFD;
	Fri,  4 Jul 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622519; cv=none; b=lD3l2a8i8GC8hkShio7ePYASZnf4Xv+I4My39k2z1+a8xa+Yb0weQothN86T4y4XDAY0qb99w60QRsUaY7yM+z9Dine012TghN5hUiP61IScPNM+mnrp0P5Mz8Bl1INDcYmEBd5qAqtnbp8I+tJCkvKOPgs9FW6xzhJDXRGywTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622519; c=relaxed/simple;
	bh=am0YjSLq6opId+8jb8XluWaS3QEulOIJcT1B2pYF464=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsIV7JHSmRkv4oZBVjSKAzUwNzR/25xzfsaj0WczmvhFsyw3l62JybKaL0Nh4xnNg7dOL56mnjmZVbrHJpozTEEuYq5Uyw0Lmet4e45sVbfWNn4pzAoNkNvyDWiNpU+UJYIUZ/+h0p7L7jqXzsZbAmbr9AEnTSfASGXm/8lAdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lv9KvEEg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lv9KvEEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751622519; x=1783158519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=am0YjSLq6opId+8jb8XluWaS3QEulOIJcT1B2pYF464=;
  b=Lv9KvEEgviuLQTffuh2sdu4r7G80QCJWf5ZavNjSg/IBBAGMedAHvfmQ
   xUjmHryiHpyHQT5AgBCBThdNjW3WP5YrH9os2ctmmDOtjmSzYMHBxtLtr
   0JLptc6a2YjDsp+/N+ccW5nsPVR4ZxbE0sUBrIQwqt55dsCjNZ+qSWG65
   xRvenl1HKO3NJuz40n0r56Y1E7GYU7AjNLiX2sLALKpd9dSajs3hp2Vtm
   9x7YPXOzWQ/z0QMM75L4j5J/IWw/bWIYi0cd+lDv6UHIwcp9JLUTk/exa
   1DVjDIXOOy5dEmvsGuOjvVhKswd6ob7zihcV1NrIYpRgS8dNhcf+8agNR
   Q==;
X-CSE-ConnectionGUID: lrf5lB4FTcCmPRpyM3mMMg==
X-CSE-MsgGUID: 30SNgoBNR1KOUkHAqeHKgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65408516"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="65408516"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 02:48:38 -0700
X-CSE-ConnectionGUID: kSKs1kAUT6+aKYAMcPG3Kg==
X-CSE-MsgGUID: qMilI+FFQwqrwSpxQFY3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154016435"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Jul 2025 02:48:35 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXd20-0003ZL-1Q;
	Fri, 04 Jul 2025 09:48:32 +0000
Date: Fri, 4 Jul 2025 17:48:01 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Message-ID: <202507041717.ZONOYCp2-lkp@intel.com>
References: <20250702-rfc_miscdev-v3-2-d8925de7893d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-rfc_miscdev-v3-2-d8925de7893d@oss.qualcomm.com>

Hi Zijun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 626e89412dfb88766d90d842af4d9ec432d8526f]

url:    https://github.com/intel-lab-lkp/linux/commits/Zijun-Hu/char-misc-Move-drivers-misc-misc_minor_kunit-c-to-drivers-char/20250702-202131
base:   626e89412dfb88766d90d842af4d9ec432d8526f
patch link:    https://lore.kernel.org/r/20250702-rfc_miscdev-v3-2-d8925de7893d%40oss.qualcomm.com
patch subject: [PATCH v3 2/8] char: misc: Adapt and add test cases for simple minor space division
config: powerpc64-randconfig-002-20250704 (https://download.01.org/0day-ci/archive/20250704/202507041717.ZONOYCp2-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041717.ZONOYCp2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041717.ZONOYCp2-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: hash_debug_pagealloc_alloc_slots+0x98 (section: .text) -> memblock_alloc_try_nid (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: test_cases+0x60 (section: .data) -> miscdev_test_invalid_input (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
