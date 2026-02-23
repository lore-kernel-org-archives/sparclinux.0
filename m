Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C4F4F1
	for <sparclinux@vger.kernel.org>; Mon, 23 Feb 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832189; cv=none; b=Mm6B55CNlgLTPVpv6tmKxMM5o7r71kNfmmz/b7TA8mvHG0BQW2LVLfqOOZ/6S+1zMyQiuNFOlxg3amvNHmLeFfBAjmteP3d0mTPCv3tiMFs/fjbvzOvhq4MAErXNJ8mIoeOY1QjB7EPH2oGjkoMv5EJ5Mi2JBGinNmadQhHGOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832189; c=relaxed/simple;
	bh=WIH0B/pATi1JcvK2MOwlnqqmM90GQFjIRygcVbshkv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Z35TdD1s8G7nHXbSFfp1mebKFNMqe3vzevdwndw/IrtE2zizPTttriLad6K8jNcrJrxrQzICdqne4Tx1hh8EregSuhJS+HyvhGbqZjghMV062ydX/6Qghxnn1BsIJmXh27kbPdgtA+z0bwBfs7Fvn8RHXprkHvRZKQSnje/RonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b02dNdHU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b02dNdHU"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260223073625euoutp0138475740c841fa6b18ebc5afe2518952~Wz-waF1QQ2952929529euoutp01y
	for <sparclinux@vger.kernel.org>; Mon, 23 Feb 2026 07:36:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260223073625euoutp0138475740c841fa6b18ebc5afe2518952~Wz-waF1QQ2952929529euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771832185;
	bh=siN3nhK4xAmEu87Kj9QrjRdSzOGuHIv1AjOJb1pKcic=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=b02dNdHUYBiLCPloSEBrF9FXGv74V6WONMKZBKkTmE3kzB1zkV7jZXXlSYlIZPiSH
	 C0ytk8MupDch9LUepNlgIlFGgDNbwDsYqGeJLPZ/+4Me/SWJ0xufHxGVXFPFEVHwQ/
	 fFZWBbcz5mtjagYdQcphswhuDcEP88YoLMjMjP48=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260223073624eucas1p2e4f7a971ee7f9761b90aef9b901ed185~Wz-wJtp8J2724727247eucas1p2N;
	Mon, 23 Feb 2026 07:36:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260223073624eusmtip1180bf9a1dd8cd8fdbdc15862f619f56b~Wz-vY9DTK1262412624eusmtip1b;
	Mon, 23 Feb 2026 07:36:23 +0000 (GMT)
Message-ID: <c5d135fe-0983-43bf-b9c2-b6ba01323074@samsung.com>
Date: Mon, 23 Feb 2026 08:36:23 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3] sparc: Fix page alignment in dma mapping
To: stian@itx.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	<andreas@gaisler.com>, Leon Romanovsky <leon@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260218120056.3366-2-stian@itx.no>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260223073624eucas1p2e4f7a971ee7f9761b90aef9b901ed185
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260218120247eucas1p2a4201e330790c4f8a9c846fd6dbdf889
X-EPHeader: CA
X-CMS-RootMailID: 20260218120247eucas1p2a4201e330790c4f8a9c846fd6dbdf889
References: <CGME20260218120247eucas1p2a4201e330790c4f8a9c846fd6dbdf889@eucas1p2.samsung.com>
	<20260218120056.3366-2-stian@itx.no>

On 18.02.2026 13:00, stian@itx.no wrote:
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
> Closes: https://protect2.fireeye.com/v1/url?k=7ae4b721-1b6fa20e-7ae53c6e-74fe485cbfe7-9b567c88f1f84114&q=1&e=1e25ada4-9521-4797-a8c9-57719379250d&u=https%3A%2F%2Fgithub.com%2Fsparclinux%2Fissues%2Fissues%2F75
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Stian Halseth <stian@itx.no>

Applied to dma-mapping-fixes branch with slightly adjusted commit 
description (to match v3 changes). Thanks!

> ---
> Changelog:
> v3:
> - Use IO_PAGE_MASK for alignment in both dma_4u_map_phys and dma_4v_map_phys
> - Align phys before the loop in pci_sun4v.c
> - Drop masking inside iommu_batch_add()
>
> v2: https://lore.kernel.org/all/20260217171104.5643-3-stian@itx.no/
> - Add Fixes tag
> - Add Closes tag
> - Trim commit message to 80-column lines
> - Remove newlines
> - Subject: Remove the "iommu/pci_sun4v:" (generic sparc patch, not specific to sun4v)
>
> v1: https://lore.kernel.org/all/20260217150350.3541-2-stian@itx.no/
> ---
>   arch/sparc/kernel/iommu.c     | 2 ++
>   arch/sparc/kernel/pci_sun4v.c | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 46ef88bc9c26..7613ab0ffb89 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
>   	if (direction != DMA_TO_DEVICE)
>   		iopte_protection |= IOPTE_WRITE;
>   
> +	phys &= IO_PAGE_MASK;
> +
>   	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
>   		iopte_val(*base) = iopte_protection | phys;
>   
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index 791f0a76665f..58ca4148f86b 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -410,6 +410,8 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
>   
>   	iommu_batch_start(dev, prot, entry);
>   
> +	phys &= IO_PAGE_MASK;
> +
>   	for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
>   		long err = iommu_batch_add(phys, mask);
>   		if (unlikely(err < 0L))

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

