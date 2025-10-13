Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660F261B75;
	Sat, 18 Oct 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808953; cv=none; b=LjkG6didrAGpCticdew/eb6dsGm4eD1CA6exjwnjZbDNFC/5dH8+BLIhBIQM81Bm07h1ll6Yrv8odIXQ+ZWTGJdpzlseb5AeKSwxopi+hcH8wpl2Ykv9eLznb3RW/lQNvK54GgkmRiJEIFL5DcMMQW+O/lKRRy7x9hEnolAGsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808953; c=relaxed/simple;
	bh=FH7kWsdToQ9dkDy3wa31Jvf5NV2Cp2hhNe4IzS9w3/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulUDSLodVZtLmtjZqiycdzo6Uc5ydQENUhJXh9YhG3MPOI/t7b0CBv1utxBZYMLY/qHZUCk5TmGC4i2T0MZfLHEhWq/Mi/0O+I4IV9YLyVCyz0/Jj3Unr7rYtSRR/hcAZMexiL9rsK7dJFBYrjRcrHt5R35Qx7vd9KPyky7tl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2Yr+rPg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2Yr+rPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808951; x=1792344951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FH7kWsdToQ9dkDy3wa31Jvf5NV2Cp2hhNe4IzS9w3/M=;
  b=R2Yr+rPgJ1E/ZA2Orxt9rYbBjwI4QMeOUp6ULIXrqrzXk2t7KTacTPox
   6R0vxSy4JaXxKxyvnCyzBKm7wYkKolG7pKLmNFbyfyre4qV61s4gf4qIi
   RPFFobivpnmJeGtEzKNLEkyU0f1jcNHktodUgayWVpo0BP91IDNhnlfUc
   66Ohua7/ybodQ1wqPns7x5n7wE2hRxouZmN4f0wDZrqRms8xYF3rlqvpJ
   ze201Z7Yw8v1R6QBOoZz6aXWbKaheVuboBG6YBqapPQajZxrZOheSvpBa
   HBLQJ+XWOX9MUml4OS4cy6QCVW4G4VrlfnLLr0qTftpHr2AROr7tkltVy
   w==;
X-CSE-ConnectionGUID: 5XIDNclFQXC6oKHvoWZ9jA==
X-CSE-MsgGUID: YsHSleeZQ5iqoRfA2M45yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62029445"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="62029445"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:51 -0700
X-CSE-ConnectionGUID: YFbJk/fUSPu1cRR9Tql/CA==
X-CSE-MsgGUID: 2rIfw+45QYOkc89a/JO41g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188073036"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:50 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v8PbI-000000002vp-2A6B;
	Mon, 13 Oct 2025 23:57:00 +0300
Date: Mon, 13 Oct 2025 23:57:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>, Jens Axboe <axboe@kernel.dk>,
	linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] sparc: floppy: Replace deprecated strcpy with
 strscpy in sun_floppy_init
Message-ID: <aO1nnGiISsk9dNt2@smile.fi.intel.com>
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
 <20250922210408.1723452-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922210408.1723452-3-thorsten.blum@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 22, 2025 at 11:03:52PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> No functional changes intended.

Is this the only one place in floppy (arch) code?

The change itself LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


