Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD9528436
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904674; cv=none; b=sSwv4G94iHEXpP5i7MYYRGuiWQeuEUDWzbaTeFkYBcJwgd/C9kIRGM6G2Z4FN47EG+YBA9HCJA0l7OVMaDESDzVP077i06T0v1C0OIAKncyi5n+bRBVJDZtnGY3FkpirF/eKvlR1KR/n/yfGK879FL+fJetBMp2OYJz+1cmEmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904674; c=relaxed/simple;
	bh=ANBMM5ephrnapb5OYmQbKJvZAthcMgVUq0Ua6nBD8RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Mp2d/mOxj4m69HN/G2FhXoZ8o7G9ZCO9V7zSRdUfkni6q7LCqKn8pwph6ue6zKGp/eKkHrv6xzilSrstMnHK0NoRaWQq4rujcnMgY0TrILq7jrW2LIGGBeWcJW9rIA1y5COrTyLiJxIpHwUGMDfpSwAR7euEAC3zh73K+4QlopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A6elkmxv; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A6elkmxv"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261013151749euoutp01223dfb4414a1033d0ffc84fe993037a7~eH82WB4js2065720657euoutp01N
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 15:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261013151749euoutp01223dfb4414a1033d0ffc84fe993037a7~eH82WB4js2065720657euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791904669;
	bh=Vt9ECYRZaEE72jD/XAkrUXRFnR4nOeWo1TSAUIvqHPk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=A6elkmxvHNZDwDcrgqs0Zs8+WogDiKmAUQouw0MWnRntm4XHyEpyUeT1qOKXy3kBq
	 6GhWMaro3vwdQ7wS1CZaYkSbheWutPROq6a3FG5Uj+iDJzCHYQaEeNniUN6kvvXOKI
	 yPIIl1DAcEDtGacyoe4pQKhD31ydhhRF0if4ltMw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261013151749eucas1p13e81f7b76814cf812749a88580315b1a~eH82IrTif1828418284eucas1p1C;
	Tue, 13 Oct 2026 15:17:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261013151748eusmtip2f4370a403874628766669465e656de1e~eH81d-LDK0927309273eusmtip2X;
	Tue, 13 Oct 2026 15:17:48 +0000 (GMT)
Message-ID: <db165539-0203-40ae-b49f-883f002c231b@samsung.com>
Date: Tue, 13 Oct 2026 17:17:48 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] sparc64: Use relaxed ordering for DMA_FROM_DEVICE
 mappings on sun4v
To: Stian Halseth <stian@itx.no>, Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Leon Romanovsky <leon@kernel.org>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261013133731.1795299-1-stian@itx.no>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013151749eucas1p13e81f7b76814cf812749a88580315b1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261013133752eucas1p1ad5d155a4dd8316d7a3da5cb7772af3f
X-EPHeader: CA
X-CMS-RootMailID: 20261013133752eucas1p1ad5d155a4dd8316d7a3da5cb7772af3f
References: <CGME20261013133752eucas1p1ad5d155a4dd8316d7a3da5cb7772af3f@eucas1p1.samsung.com>
	<20261013133731.1795299-1-stian@itx.no>

On 13.10.2026 15:37, Stian Halseth wrote:
> sun4v IOMMU and ATU mappings carry a relaxed ordering attribute, but
> dma_4v_map_phys() and dma_4v_map_sg() set it only when the caller
> passes DMA_ATTR_WEAK_ORDERING. Some network drivers do, storage drivers
> do not. Without it every device write into memory is strictly ordered,
> which on a T7-1 (M7) caps DMA reads at about 280 MiB/s per PCIe device
> while writes run at full speed.
>
> Set the attribute for every DMA_FROM_DEVICE streaming mapping. Devices
> report completion through coherent memory or an interrupt, which stay
> strictly ordered, and a strictly ordered write does not pass the writes
> before it.
>
> T7-1, fio 1M sequential read, QD32:
>
>                       before        after
>   NVMe (PM1725, x4)   281 MiB/s     3169 MiB/s
>   SATA SSD (mpt3sas)  278 MiB/s      502 MiB/s
>
> Closes: https://protect2.fireeye.com/v1/url?k=e7e38a98-865a22d7-e7e201d7-000babe84d41-bac19a2569e412a9&q=1&e=ae0c8a5d-455c-422c-8bfa-d99f41e1f1b6&u=https%3A%2F%2Fgithub.com%2Fsparclinux%2Fissues%2Fissues%2F114
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Tested on a T7-1 (M7) and a T4-1:
>
> - T7: fresh RAID1 on two NVMe drives, 192 GB fio crc32c write+verify
>   and md check: no errors, mismatch_cnt 0.
> - T7 and T4: file checksums on the SAS boot mirrors identical to a
>   strictly ordered kernel; no new messages in dmesg.
> - 4k random read and sequential writes unchanged.
>
>  arch/sparc/kernel/pci_sun4v.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

I assume this will go via sparc tree.


> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index 61f14b4c8f90d..4dd17b65dd6cc 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -403,7 +403,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
>  	if (direction != DMA_TO_DEVICE)
>  		prot |= HV_PCI_MAP_ATTR_WRITE;
>  
> -	if (attrs & DMA_ATTR_WEAK_ORDERING)
> +	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
>  		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
>  
>  	local_irq_save(flags);
> @@ -503,7 +503,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
>  	if (direction != DMA_TO_DEVICE)
>  		prot |= HV_PCI_MAP_ATTR_WRITE;
>  
> -	if (attrs & DMA_ATTR_WEAK_ORDERING)
> +	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
>  		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
>  
>  	outs = s = segstart = &sglist[0];

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

