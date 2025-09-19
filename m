Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DF1A2392;
	Fri, 19 Sep 2025 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304867; cv=none; b=aHraKH4FZ06NBxBsYFZjwldj7iJVeoMu7bti1ryhe8iN/Top0D9j18yWaQUgW0lRoAolmeGvOV0ptBah5O+yHOI+MzqLKGR7tqOEkdBSAA71xek5FZ2r6utCJ9eFy7s8N6LVGmmdNEQhhlyjfY7FsHnt8gJ8Wn4nX0MXVHJfZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304867; c=relaxed/simple;
	bh=MUFjOV3PcpeLweev66g/OKPf8Yvs4EgD6Y1CbHDoFeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFtb89ojUDA4nK1ESBgP/H0zk6BZkiBtj5WGyQTLWQVAZ7hQ50v2xAmXbr4ZiXUC1GoLP29tyECUs3HbFoQRuYsp220KJg4oVXjCquaY/KCZMCFZX++0E5VKA/e+jQewIBSY+mKOXGqC5ILWW0995hiV10c2hj8VUM6IYndzDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZIS3uKJI reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZIS3uKJI"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0g21RmNz1DHVd;
	Fri, 19 Sep 2025 20:01:02 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0g140wXz1DDgW;
	Fri, 19 Sep 2025 20:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758304862;
	bh=Adb/v4+SNCxBIaVZ6ZeOTykCjGWPianFwYeUtXI4LRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZIS3uKJI8pcvOwnlHZWZLwNyxJUL2pKfViap/o8bnNRKK5OzcE2wFnmf4g289ZqfS
	 4hzHqoljJmMJ9Ml+pVwwB3tPVp0hBqVrgzYi9tPeZBsJ3Xpso4O50poH+DP47jaTdI
	 CHdFvsMhnKYvXMJFy4BEY4IM5d5gpqIZ5Bc3VtssdVPmw6cJ+V8pfEG8yzF84xw+Sc
	 5EW+DYeMCZ6IWld7UJ+MsqmhuvlgrRddm16FsUnqZ/nFXpDX35OzbwP561NGiNAP3f
	 6F7A41P2aDdttCiIMLMc4llBd3Qt5mG63wp3e/i7uOZQJrnWFUPTRXioexcAo3+7Kg
	 yR9A1G7KxLHcQ==
Message-ID: <b7ad6ad9-c1ed-4a53-a73e-4a4306107a55@gaisler.com>
Date: Fri, 19 Sep 2025 20:01:00 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org,
 davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
 ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250716012446.10357-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-16 03:24, Anthony Yznaga wrote:
> An attempt to exercise sparc hugetlb code in a sun4u-based guest
> running under qemu results in the guest hanging due to being stuck
> in a trap loop. This is due to invalid hugetlb TTEs being installed
> that do not have the expected _PAGE_PMD_HUGE and page size bits set.
> Although the breakage has gone apparently unnoticed for several years,
> fix it now so there is the option to exercise sparc hugetlb code under
> qemu. This can be useful because sun4v support in qemu does not support
> linux guests currently and sun4v-based hardware resources may not be
> readily available.
> 
> Fix tested with a 6.15.2 and 6.16-rc6 kernels by running libhugetlbfs
> tests on a qemu guest running Debian 13.
> 
> Fixes: c7d9f77d33a7 ("sparc64: Multi-page size support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  arch/sparc/mm/hugetlbpage.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index 80504148d8a5..2048b5c42ca8 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -22,6 +22,26 @@
>  
>  static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
>  {
> +	unsigned long hugepage_size = _PAGE_SZ4MB_4U;
> +
> +	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4U;
> +
> +	switch (shift) {
> +	case HPAGE_256MB_SHIFT:
> +		hugepage_size = _PAGE_SZ256MB_4U;
> +		pte_val(entry) |= _PAGE_PMD_HUGE;
> +		break;
> +	case HPAGE_SHIFT:
> +		pte_val(entry) |= _PAGE_PMD_HUGE;
> +		break;
> +	case HPAGE_64K_SHIFT:
> +		hugepage_size = _PAGE_SZ64K_4U;
> +		break;
> +	default:
> +		WARN_ONCE(1, "unsupported hugepage shift=%u\n", shift);
> +	}
> +
> +	pte_val(entry) = pte_val(entry) | hugepage_size;
>  	return entry;
>  }

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


