Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3D284694
	for <sparclinux@vger.kernel.org>; Wed, 18 Feb 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410497; cv=none; b=OeYLE+oursagaYvFqNhoSj8elW8FbeCPtr2zJuMi0c1LyBr1iWrFbSWWo8/U3hSvPVbsw0TdfNdjrn7lma8rNbL0/+T9JmxcXlfMJ0Y8rufNS3kRDPQpfVX0W15lmhbhNIGV+k9dkDmdeY+vpjKtXFSmJ3W50zSj1V1JPfCRlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410497; c=relaxed/simple;
	bh=ja7QsXClnH5fC2d+6KAmqInMSQLj/cwZr9gxtWAKnDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UBKrSfh3R+FyFumxyFAzIxlTphRsG+CuKXWXGSoqqFBSJgcTkv0hpr4qSZs7/JEtUCHJhYXLNt0Z53kh0FCEmNbmwB5KEar5KzzUhO8HtrG+wgsWwyZvLixJ4djwAYO5G4FRQU6zts/ZolFu+qXpqSLhwAufuHDngpV54FoyBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rrttDyty; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rrttDyty"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260218102813euoutp01ea7dfa9c4943d8eb11d33412c879c8a5~VUHVHgQIz0916309163euoutp01h
	for <sparclinux@vger.kernel.org>; Wed, 18 Feb 2026 10:28:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260218102813euoutp01ea7dfa9c4943d8eb11d33412c879c8a5~VUHVHgQIz0916309163euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771410493;
	bh=WYbuAzkmAoYdFGQJF6gMDEDJjTsojA819vtdrhe+N7Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rrttDyty2eH7ifkXZHvyt7ZQSGiuOh9l6xpLtdvSHfKGETnXXcsb4beJiUuySSF1y
	 cQmvIYhmlLFhfQzf243ijfshNox2QcIuu53SZfduGTXcE/+UrQd47lTGB3v8nLWHQM
	 Qs3W+Se2cqOV60xBliqrxQQyP99b0oQsofkE8scM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260218102812eucas1p2ad9d4f90fb5a37a5ffa38aa561ad89b5~VUHU5hHum0837908379eucas1p2I;
	Wed, 18 Feb 2026 10:28:12 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260218102812eusmtip191a5a92c80ab503e46e9e714fbebd102~VUHUhydGR1468614686eusmtip1n;
	Wed, 18 Feb 2026 10:28:12 +0000 (GMT)
Message-ID: <0bdd9ad5-e1b4-4dea-b936-e078b19d2996@samsung.com>
Date: Wed, 18 Feb 2026 11:28:10 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] sparc: Fix page alignment in dma mapping
To: stian@itx.no, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	<andreas@gaisler.com>, Leon Romanovsky <leon@kernel.org>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260217171104.5643-3-stian@itx.no>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260218102812eucas1p2ad9d4f90fb5a37a5ffa38aa561ad89b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260217171231eucas1p1f915cdb1081b194466431155fd8ec136
X-EPHeader: CA
X-CMS-RootMailID: 20260217171231eucas1p1f915cdb1081b194466431155fd8ec136
References: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
	<CGME20260217171231eucas1p1f915cdb1081b194466431155fd8ec136@eucas1p1.samsung.com>
	<20260217171104.5643-3-stian@itx.no>

On 17.02.2026 18:10, stian@itx.no wrote:
> From: Stian Halseth <stian@itx.no>
>
> 'phys' may include an offset within the page, while 'base_paddr' is already
> page-aligned. This caused incorrect DMA mapping in dma_4u_map_phys and
> dma_4v_map_phys.
>
> Fix both functions by masking phys with IO_PAGE_MASK or subtracting the
> page offset, covering both generic SPARC code and sun4v.
>
> Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
> Reported-by: Stian Halseth <stian@itx.no>
> Closes: https://protect2.fireeye.com/v1/url?k=4d8fbc00-1214850c-4d8e374f-000babff3563-ee1be24be576e072&q=1&e=0f8967ce-f558-4339-bddb-f324ec46c035&u=https%3A%2F%2Fgithub.com%2Fsparclinux%2Fissues%2Fissues%2F75
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   arch/sparc/kernel/iommu.c     | 2 ++
>   arch/sparc/kernel/pci_sun4v.c | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 46ef88bc9c26..f3755a388ac7 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
>   	if (direction != DMA_TO_DEVICE)
>   		iopte_protection |= IOPTE_WRITE;
>   
> +	phys -= offset_in_page(phys);
> +

I've just noticed that IO_PAGE_SIZE might not equal to PAGE_SIZE (not 
sure if this is true in case of SPARCs), so it would be better to rely 
on IO_PAGE_MASK or IO_PAGE_SIZE only. Just unify the fix for the both 
affected functions either by masking phys with IO_PAGE_SIZE where it is 
used or by subtracting (phys & ~IO_PAGE_MASK) from it.

>   	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
>   		iopte_val(*base) = iopte_protection | phys;
>   
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index 791f0a76665f..2f30eeac4861 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -411,7 +411,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
>   	iommu_batch_start(dev, prot, entry);
>   
>   	for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
> -		long err = iommu_batch_add(phys, mask);
> +		long err = iommu_batch_add(phys & IO_PAGE_MASK, mask);
>   		if (unlikely(err < 0L))
>   			goto iommu_map_fail;
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

