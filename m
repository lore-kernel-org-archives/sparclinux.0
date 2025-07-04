Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BE2D97B7;
	Fri,  4 Jul 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632798; cv=none; b=pbG6Gl+fEGy5fs862g9nqwn6Aos7N066zgNuLmcPg4rHEs7mB9kPdzpqSDWqpRQ1qeOMSinMXNtvkXvvleuPrFKfVm412lOIMIMCdvQtvO+WQP7g8g+ceelq/FIBHQLO5QQQ4Kx5sflUw4q6nCycev1kGtqwTot6Q6DlPEgMXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632798; c=relaxed/simple;
	bh=LikTtaJjGNzZn+9RN96jwnZuX2ntlhHZCY88IkmjooU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnbH4Pgfiy+r74wG9krcezS4PDTsHoMT5XIedU/vy7p4VlrAGYzzhhStLeij6yt4/AlHLZJ0w9xLOqqfsYYSOcAbgpZNJVJ9+POQ3aAcIkWiSxLZie8m69O/F8sejdhMttBU/I9ncI5QbYqa9f3P+08B92p0iXkE882aJ9DIk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kdux1bu9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kdux1bu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751632796; x=1783168796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LikTtaJjGNzZn+9RN96jwnZuX2ntlhHZCY88IkmjooU=;
  b=Kdux1bu9kixMmKuVq5n0r+O8zxJPpKkkACXARDuPakSnHc5sDmqm5dwT
   1227DbyBtAC7sxKqGO/YaX/OR8zLJLjXArJ36nYAyYeA+fNtCYAuRejc6
   1Fkgy1ajpZg+ZrbTU+1AyeTJQlfzVEZ102Z7juhyHSMl2bQOusSN869Ao
   LfLpCxkcR/PDVkVBTkuilgMzcAE6mhPsNkOJCqcOafJn6HohUx5+cviqa
   BlHOyzurBe89KGlXd1TtakKfKygPvaV61PfhEHuA++Gn5Xi7FXAMGmjCn
   Zi6vXXDn/+f3IKkBKJCH0bT+BsCnYCjzgBXceuuaxLea6kfCKUIQVs9Ef
   A==;
X-CSE-ConnectionGUID: f71jAkGwRpWumWVrQ9lNmg==
X-CSE-MsgGUID: Luuyu4SMQtC3WiV4Lj+nOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53834463"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="53834463"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:39:56 -0700
X-CSE-ConnectionGUID: 3YimJf/1Sp6YNWjGDek8Lw==
X-CSE-MsgGUID: NtJOoYdDQfugBLaj+hO45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="158978302"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Jul 2025 05:39:53 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXfhl-0003i7-36;
	Fri, 04 Jul 2025 12:39:49 +0000
Date: Fri, 4 Jul 2025 20:38:54 +0800
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
Subject: Re: [PATCH v3 4/8] char: misc: Add a reentry test case about dynamic
 minor request
Message-ID: <202507042031.3gfceqb3-lkp@intel.com>
References: <20250702-rfc_miscdev-v3-4-d8925de7893d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-rfc_miscdev-v3-4-d8925de7893d@oss.qualcomm.com>

Hi Zijun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 626e89412dfb88766d90d842af4d9ec432d8526f]

url:    https://github.com/intel-lab-lkp/linux/commits/Zijun-Hu/char-misc-Move-drivers-misc-misc_minor_kunit-c-to-drivers-char/20250702-202131
base:   626e89412dfb88766d90d842af4d9ec432d8526f
patch link:    https://lore.kernel.org/r/20250702-rfc_miscdev-v3-4-d8925de7893d%40oss.qualcomm.com
patch subject: [PATCH v3 4/8] char: misc: Add a reentry test case about dynamic minor request
config: powerpc64-randconfig-002-20250704 (https://download.01.org/0day-ci/archive/20250704/202507042031.3gfceqb3-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507042031.3gfceqb3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507042031.3gfceqb3-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: hash_debug_pagealloc_alloc_slots+0x98 (section: .text) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: test_cases+0x60 (section: .data) -> miscdev_test_invalid_input (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: test_cases+0x180 (section: .data) -> miscdev_test_dynamic_reentry (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
