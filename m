Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69801337B81
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327348; cv=none; b=Z/sxj/AQVRmlCHqJN0Pt1b18V94LDjHYscMNpBFhdZ57JTR8vBQO60L3aN7QmBq6xz8dvKeoOVloCfmEruktjCnlrwXEy1crfUIPjWclc3ElAXsWq/aydvMcYRKrSO8R9dOcqTy9vOp8kdgFz8Yj9uBvziFEcl+dhkrSmSkpU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327348; c=relaxed/simple;
	bh=1YYc3sMFUbCbbn19wgr7YV3/l+3KgfXUec6TQy1or+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZCTFo8hjtRrjCylcwgnAlVAS1rTTWy5YpaOwx/Z4DmxCpM0/AKQ45nY/vTL5beC5YZhMNJsSza/IKvkFupYivfsJzg95Enw9RvymeUxlTb6G558ohf4svigCS5pVSmSo7dEO8EjGDlQGmCToh/uRI9Ne9NikCXI/42bq1INpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=qw3vM1dc; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=f/YiOkjO; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="qw3vM1dc";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="f/YiOkjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788327342; x=1788932142;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=teV4sx8uLoW3jHOdd+YcF3stnTGkkGnzM5IGThhf40c=;
	b=qw3vM1dcFUcNzTFwuJHPewwXMxkzIjppWQJuYqKMy/imtpa7rLbZpQC5xiYbKpyJMJi5I/a8VyWo9
	 czuKYKAdF7oqL8a7Q/ztg2F0IniRDueE9GgrvUwUExzYq7LfY5Nzj8I/fhhKApcoEn5tOJ4XlrsQNO
	 Eve7K3qiLFGg46n+WuCPwYnslyBUDFENYJSitV8B3Z3Ud55I3H+hEBLRl6eU4+FJ3i+oh3xqKC2TpW
	 42R2FfRjwSv2dr34JRAuKculWZSZAdOZtTuTpH3WnP3GpWJtI+cNKk0+jkW2m+mI//4mqtWrzuE/nl
	 iSjN+JEe5eyq37gT66RyJU8wH4jBAIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788327342; x=1788932142;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=teV4sx8uLoW3jHOdd+YcF3stnTGkkGnzM5IGThhf40c=;
	b=f/YiOkjO6nWwiBj8N7L1HMQaEaUAd52u3v6kFKc0cMi+ylMHAFXZCdRf+Iq/0pgBvk91LgxbcBxaN
	 qvb6FZjAw==
X-HalOne-ID: 219fc36e-a690-11f1-a0c3-6b8d581b3111
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:5cc:91fa:7f53:a32a])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 219fc36e-a690-11f1-a0c3-6b8d581b3111;
	Wed, 02 Sep 2026 05:35:42 +0000 (UTC)
Date: Wed, 2 Sep 2026 07:35:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com,
	linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v3 0/6] sparc32: replace sp_banks with memblock
Message-ID: <20260902053540.GB338380@ravnborg.org>
References: <20260901214611.60560-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901214611.60560-1-linmag7@gmail.com>

Hi Magnus.
On Tue, Sep 01, 2026 at 11:45:44PM +0200, Magnus Lindholm wrote:
> Replace the sparc32-private sp_banks memory description with memblock.
> 
> The first two patches convert the SRMMU consumers that already run after
> bootmem_init() has populated memblock. The third patch moves memblock
> population to prom_meminit() and applies the mem= limit there. Patch 4
> removes an unused address bitmap before patch 5 moves the early memory
> setup into setup_32.c. Patch 6 removes the now-unused sp_banks array.
> 
> This work is based on an earlier eight-patch series by Sam Ravnborg.
> Patch 2 directly carries over Sam's memblock sizing conversion. The series
> has otherwise been substantially reorganized and reworked for the current
> kernel. It retains the sparc32 mem= command-line option by using
> memblock_enforce_memory_limit() and uses memblock's exclusive range-end
> semantics throughout.
> 
> The series applies on top of the sparc32 phys_base and Viking fixes.
> setup_memory() preserves relocated-kernel handling by removing RAM below
> the physical address to which PAGE_OFFSET maps.
> 
> Link: https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t
> 
> The v1 series was boot tested on a Sun SPARCstation 20 with dual
> SuperSPARC-II CPUs (SM71).
> The v2 series was boot tested on a Sun SPARCstation 20 with dual
> ROSS HyperSPARC (RT626) CPUs.
> The v3 series was cross-compiled with the SPARCstation 20 and LEON
> configurations as well as boot tested on a Sun SPARCstation 20
> with dual ROSS HyperSPARC (RT626) CPUs.
> 
> Changes in v3:
> - Add Sam's Reviewed-by tag to patch 4.
> - Initialize max_pfn in patch 5 and use it as the highmem zone limit.
> - Use PHYS_PFN() instead of open-coded PAGE_SHIFT conversions in patch 5.
> - Remove the obsolete highstart_pfn and highend_pfn declarations.
> - Use the generic max_low_pfn declaration from linux/memblock.h.
> - Document removal of the duplicate private HIGHMEM summary.
> 
> Changes in v2:
> - Add Sam's Reviewed-by tags to patches 1-3 and 6. Patch 6 is the
>   unchanged source change from patch 5 in v1, renumbered by the new patch.
> - Drop the unused sparc_valid_addr_bitmap in a preparation patch.
> - Use for_each_mem_pfn_range() and the standard max_low_pfn variable in
>   the early memory setup. This tightens LEON's _pfn_valid() upper bound
>   from all memory to the lowmem limit, with no functional change because
>   LEON does not use highmem.


The full series looks good now, thanks for picking this up and adressing
my review feedback.
For anyone looking at sparc32 code this is now much more standard
and you managed to remove ~250 lines of old code.

It is now ready for Andreas to take a look.

	Sam
