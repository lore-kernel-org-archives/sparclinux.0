Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA41EA7D2;
	Sat, 18 Oct 2025 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816335; cv=none; b=XcTOV+w6M7AkHZiazcjqhRgFv71RzpdyGCE2UOnR5rfyPOq9JrGeM+E/q2CjM+EjAPDdobKuoVsTrZHiB7K87CjT7n1KdYMAdAesd+FtC0VJK4+ExY6aqOh0in/p4TebzLZYjTNfTvLfYN4RTOqY6dh8vk6D9cpvtBHkdw77rX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816335; c=relaxed/simple;
	bh=dRgPhXbTYBGx2ER9ENOAL7OHytDME0q/959WH7mhaUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gbgkYiADcSAxGeQa7HIaGx/7eIBCZBySr1CuH5yHu3x16tzLhankNHqTzJtK3bRppN/gowUK00AUbgCZl8DqcdMS+fAmY4syl8krbNyy8DExAHBVpxaqENGAs9bsssdKLTWWIFUGfmL+T/cGET07ydmAilnx5T2pFhX3CIUsmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdApy55k; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdApy55k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816333; x=1792352333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dRgPhXbTYBGx2ER9ENOAL7OHytDME0q/959WH7mhaUc=;
  b=bdApy55koKhdTXIK1H8UPDHyENu3zGilHl5PNPghhQJWSsXQq0lauKS+
   ynkETAb/qezBwoUYXfSiDyFndwSDdS8jAT/2vMLZAk5efMBlbU0D6kImz
   PacMMIeS1Cxt+X1iJCARTORhsks9YzKZf2FdCKhg8QTOSK4Pw6RMCZwZB
   Wm3QMCEY/qiXxPwHWcTSon2AKwf0+hTEYeVrbGjLjPefJ56edRM8+BBbS
   S04AJ8G61YwYxngcarvJ0Ar7xCaDUA5tR9j5smW9Dz3C1xn4Zj1qIw3Cz
   kW2zCjhDVlHvN2rRN5SuLqUdjIRnYl7FIGvUet3KHzQic3IPXH6rj1qKG
   g==;
X-CSE-ConnectionGUID: Evt9i1zySoWoPLZINDDvlA==
X-CSE-MsgGUID: eZ7SI3GgRV6Y0APMSBN30A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63144954"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63144954"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:38:52 -0700
X-CSE-ConnectionGUID: 5VD2tXH3Tz+X1c52sDcN7g==
X-CSE-MsgGUID: HQD4fIA/R6eloRTFyTUddw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="213610114"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:38:50 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAClM-00000000xfn-0GtY;
	Sat, 18 Oct 2025 22:38:48 +0300
Date: Sat, 18 Oct 2025 22:38:47 +0300
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
Message-ID: <aPPsx9cHwkF8MC1l@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


