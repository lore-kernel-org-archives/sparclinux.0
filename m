Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62134344D96;
	Mon, 26 Jan 2026 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445843; cv=none; b=gWvQ7ii+nLiWG23GvM3QCZmsaNvI7mt1TMzONirTTlMciDHlKloFhgnQnUQ2qum9G33EG0arc3dn4+F/7y2Gd20QSfyGEgf1ugu2nd5Gk3cKJJhg3I5aNI6/V7D14frWQlQemca9yezTrfdtDNsVSqMK1GZw14lp1woFlUfi3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445843; c=relaxed/simple;
	bh=wZQk++9yuqlfFhY/0I2paflX6b6WMIJiWwQ1VqhZhSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsZq8FX9pUbKWW5dk2sJQoCX528OgBdj0QCyI4Vd0Q5Jj7SexFHa61gESizOtmH/uOJqpF7yqXUY7XbdhoXV7zmCzXXZ/sncIG2xfyqN1FrDjmxdwkEwk6dWbfdsGCsRwEirb3OCqYxbiD18Hz8Jfsjuy354EngvTXXa7gXpA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=DjvNKV/g reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="DjvNKV/g"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0DrX3Yhxz1DDdl;
	Mon, 26 Jan 2026 17:43:56 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0DrW6JCqz1DDdQ;
	Mon, 26 Jan 2026 17:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769445836;
	bh=Ob/iC1ur7MSlGgIdF0+GsDmd0qN+yAOvABh/TKEKuj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DjvNKV/gqTscogXOIshAElNDyJ+25nQnf+gVrLIwchsbqSMhmXHWpYegt9bQHdes4
	 WoHR4/Fo/HtMVIGGEWCAlUNVsszqoqHYOZA0kh7oQPEHTStE/YEcN7Dh3OgygQg+VA
	 8hZ+15PWyWc4lOlqlaX7q4+QzV8dkxTGcCgJ/Xi4pqfxbwSWGWaoIQAkaDB6cB6tbC
	 HS1YWEWW8mlDA4sC0udODxfkAc03uLvCH/kHLus1Sansxu/U3Ubv6aaNw51syUpDXf
	 Dtzka/6It6DqmZusRcrTcbRzcW+20X9VChigjwZrPuLMMk7rKW3Wi3WMGAFxEszdzK
	 AdIjSnhMOlz1g==
Message-ID: <494e98fe-0fa6-416c-b136-9c444c03f769@gaisler.com>
Date: Mon, 26 Jan 2026 17:43:55 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/sparc: fix unused variable warning
To: alexs@kernel.org, "David S. Miller" <davem@davemloft.net>,
 "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260107104145.51416-1-alexs@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260107104145.51416-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-07 11:41, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
>    arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>    arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set but not used [-Wunused-but-set-variable]
>      361 |         unsigned short hv_pgsz_idx;
>          |                        ^~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>

Did the kernel test robot also suggest a "Closes:" line as well? If so,
please also add that.

> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Cc: Matthew Wilcox  <willy@infradead.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Mike Rapoport  <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: David S. Miller <davem@davemloft.net>
> ---

It's helpful if you put changes between versions in between --- lines 
here.

>  arch/sparc/mm/init_64.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..ba19d23d4040 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -358,30 +358,24 @@ static void __init pud_huge_patch(void)
>  bool __init arch_hugetlb_valid_size(unsigned long size)
>  {
>  	unsigned int hugepage_shift = ilog2(size);
> -	unsigned short hv_pgsz_idx;
>  	unsigned int hv_pgsz_mask;
>  
>  	switch (hugepage_shift) {
>  	case HPAGE_16GB_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_16GB;
>  		pud_huge_patch();
>  		break;
>  	case HPAGE_2GB_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
>  		break;
>  	case HPAGE_256MB_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_256MB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_256MB;
>  		break;
>  	case HPAGE_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_4MB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_4MB;
>  		break;
>  	case HPAGE_64K_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_64K;
> -		hv_pgsz_idx = HV_PGSZ_IDX_64K;
>  		break;
>  	default:
>  		hv_pgsz_mask = 0;

Other than the potentially missing Closes: line, LGTM.

Thanks,
Andreas

