Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41980378811
	for <sparclinux@vger.kernel.org>; Fri,  6 Feb 2026 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374400; cv=none; b=kXSwCrMX5Tc6KyGKiEU5iB9W2O2lZhydR1LwAjAMqsh6zrDPZ8E+AK7F39p/bIBaW6y7QRhdt5WR83cU7KTbEeUa7Z/TbKR/UJXkMabPKUsb4bsN3EY0sgexkJ4RbRmrPAriILqFiEqh8E7ZqNKKIIqtaDWxVmWi7yyIaGxVZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374400; c=relaxed/simple;
	bh=Cvp9pUnW3ZWnlgWQPP/mvGJEj9mN+44UG3hmH1uuiXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOnjjB9PjPaeOtlGoQN0bt9xRrBpNHTNrC57xXD4eRrEc72N+EgF3n/cMkFM1DPq+xm5wZaA4+7Kwy2S3D2Wi2qT4OeGEq8AQcZqMAw8wEFaIcTMrd/YX0XGcjwNZQWjiZm4Q1+HjgoyUVv8iRyoxeHZ6b6nXlv5gkHmcv/a538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kvSdVbYS reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kvSdVbYS"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f6rFV3s1jz1DR2j;
	Fri,  6 Feb 2026 11:39:58 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f6rFV1Prqz1DR2d;
	Fri,  6 Feb 2026 11:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770374398;
	bh=dpfxOay5dibMntX0t77YmMv7fnFLgoXNnp90xgozs/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kvSdVbYS/bET3WMLjm08Q7NhgMSJ4ZSZrCXun1u5mpOkbCS7vT2MFYZON/LQlKpH9
	 1fqMh+qp8H6Uts7+OcvEMk3Khu1KBZ4/+YhJMeiFn9JTKsT1nCdTkYDKF4VWaQ0TGx
	 vUxgHx5nYSLTscF/ZcM/3zeHHxx/yfGIO++PIEbcwCcvoHBBHQ8wv2jkBFtvBWPdKJ
	 kS0+ydd4PWQMzb/KvshtlwwiVN6g8CJMBh3xImECJFO7JTVE+yu7J8SGLF0leecvWb
	 RTqTjCelaKWIdHElLiaU+Fdp9lQzdSGt4LqFOdDmyhzcTALXfhy/wosy7SkIn9Krq0
	 XHq3555ms3Yng==
Message-ID: <0f79f2da-dc1b-455a-97b2-7c57270ff1aa@gaisler.com>
Date: Fri, 6 Feb 2026 11:39:57 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc64: fix unused variable warning
To: alexs@kernel.org
Cc: kernel test robot <lkp@intel.com>, sparclinux@vger.kernel.org,
 Nitin Gupta <nitin.m.gupta@oracle.com>,
 "David S . Miller" <davem@davemloft.net>
References: <20260205133911.31598-1-alexs@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260205133911.31598-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-05 14:39, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
>    arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>    arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx'
>      set but not used [-Wunused-but-set-variable]
>      361 |         unsigned short hv_pgsz_idx;
>          |                        ^~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: sparclinux@vger.kernel.org
> CC: Nitin Gupta <nitin.m.gupta@oracle.com>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
> v2->v3:
>   Change subject prefix: arch/sparc -> sparc64.
>   Clean up unnecessary CCs.
> 
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

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


