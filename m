Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0936EA93;
	Mon, 12 Oct 2026 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790504; cv=none; b=MqGQhaX1CurZ1Nko6wyH48/OHBC13J8MB93smQwEH7AXggUvex2J1y+E8bp6LgQJ6hhWLMccxRlRwipjK4Y8CKKsLg0WvKlcm8KxNudIunIpe1AmXIVvHHg6PVrrfv6Pz2tB+mjovZZwCdLCb9sgxGVCNSlSWSkNYlJkQ5T5QSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790504; c=relaxed/simple;
	bh=IfIXiTykCz0xjBObFyhrB/LWEMsOLwR04eU+20HNza8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaN8mnXRd36/Pti5Du8raYp4XreXCOtOWKIcIvCEDsiIFP+rLACEMKFAuntm9dZnnIQQCaLMGaWSqsrPXH7r2ElvDW2Lt2foI0V7tNuIJA0QsFisRJiQil7j79IwpWvf0wfqWyUmTyPz7HZv2fbNdB1TG701puOrt8FK2cYnres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPlG8crY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPlG8crY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791790500; x=1823326500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfIXiTykCz0xjBObFyhrB/LWEMsOLwR04eU+20HNza8=;
  b=iPlG8crYIxgqSwAYZoIX91/NdvAJBFVsN6JeKMFWj/h4vdnNZCpdU8l6
   SXg7YTKg/9wutn4aLpiBl2B8UN5xYFbKOfZQJMZ355G4WEArnDxoU2IgQ
   gUPaCwXqU1GCWObvxRJA0z14Lx7ocBeC86d3f7yHjlxAy3aFQPJMq7P0P
   yozEb4X7wbhY9zckXOU/McbjFxnepxGO+hGnnnhhR8c0XOQQL8bce1QSL
   mFb8J9bsz3XaxQJzrd+TqNlR3+RFBNpVTR8QZHJBZTxINSNibdENyCkxl
   VmsdYv0aAsqkXrwXVwnUAkosCqI4SW33+WEQE46n+zsWK3L+wWEwHzuIW
   Q==;
X-CSE-ConnectionGUID: ZhgpIrs5RVahHFRnm/vshg==
X-CSE-MsgGUID: lNzU6kxPQw6iDEmeStIigw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="482462"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="482462"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 00:35:00 -0700
X-CSE-ConnectionGUID: SrlQe+BZR8GU+QavfGSruA==
X-CSE-MsgGUID: EoEqP+0AQYCJnBd5KXT9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1155237"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Oct 2026 00:34:57 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGAYg-00000000B9R-0qsD;
	Mon, 12 Oct 2026 07:34:54 +0000
Date: Mon, 12 Oct 2026 15:34:36 +0800
From: kernel test robot <lkp@intel.com>
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net,
	andreas@gaisler.com, sparclinux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, oleg@redhat.com,
	linmag7@gmail.com
Subject: Re: [PATCH v2 4/6] sparc64: add SPARC64 VII CPU, MMU and SMP support
Message-ID: <202610121549.5ejZQ08o-lkp@intel.com>
References: <20261011195729.981243-5-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011195729.981243-5-linmag7@gmail.com>

Hi Magnus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cee9395acd8043be0644b25c34bfa86623f2b935]

url:    https://github.com/intel-lab-lkp/linux/commits/Magnus-Lindholm/sparc64-return-from-the-generic-clear_page-implementation/20261011-215553
base:   cee9395acd8043be0644b25c34bfa86623f2b935
patch link:    https://lore.kernel.org/r/20261011195729.981243-5-linmag7%40gmail.com
patch subject: [PATCH v2 4/6] sparc64: add SPARC64 VII CPU, MMU and SMP support
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20261012/202610121549.5ejZQ08o-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 51b433b4f56c531c0d95ba15e1a15e06c399d552)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261012/202610121549.5ejZQ08o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610121549.5ejZQ08o-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: fill_in_one_cpu+0x310 (section: .text) -> vii_cpu_topology (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
