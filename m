Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EE30B518
	for <sparclinux@vger.kernel.org>; Wed, 18 Feb 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414864; cv=none; b=O8iY+fmOzvzS5TltRMUa0TDTxC+SwEb5ph696dn3r4Ak+xGIyDTpszgvaPlhWuAYjh7BLNvocMWHYxJja0UJxkufGWKIFgl8k9o4kwhZRHDMUQ6d2uG9m8soJI/DBeKc8Ai94Ze9wk1xgoEc6nMm+RPq+O9e2mkbGozGMIdn9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414864; c=relaxed/simple;
	bh=SVB4bbzB+oslR8hqjrL1UXXGo+jKpFrLK69aTLpEyO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=owb226ZVL23lasSF66XGEz/P6MgW7Vkb/Uw3Kk2Ai9JUvJ/3TonRcbQTlonxxKbCvoIkT1S9iyRXzXG5ZsrWkiD8rJLwUhVqn9HsGCF47VmMIuSOBPJO295ObfZ0uRWD+ihrZvIxGHWxMnDUgmGwj2qBIddorQOfxqbIzVUrZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Bepd81VX; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bepd81VX"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260218114059euoutp02d0db0a090d3a0f609b84afee3eddcb74~VVG3pmZh21124911249euoutp020
	for <sparclinux@vger.kernel.org>; Wed, 18 Feb 2026 11:40:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260218114059euoutp02d0db0a090d3a0f609b84afee3eddcb74~VVG3pmZh21124911249euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771414859;
	bh=fNQHViyhICIpmAznN1q8XBGJEU+N5LMh6nyXBImqpTE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Bepd81VXJp2WrHQB8sN7rFP3fMBFr9qhJVAjxof4z7MgS4jHjrrM8rDVA7cpIB2dE
	 dCml/Q+88q1gI0CVS5+sVLRWBMNWoQfpdpctcUsyWHvy1ZvxdWXWwVYQ2YkPr0eiqQ
	 PoozSdoFMMDkb9q4MKxLCzuSXmBJAtyFh9bPOPB4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260218114059eucas1p286bc48f3304d6b588b2b9465f4d8c566~VVG3Y0iCh1386313863eucas1p2p;
	Wed, 18 Feb 2026 11:40:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260218114058eusmtip1a851b4868194199b4374a4de65dc4ffb~VVG2n_FEM3089630896eusmtip15;
	Wed, 18 Feb 2026 11:40:58 +0000 (GMT)
Message-ID: <5e5a4514-228a-4631-ae91-aec1df8f67c7@samsung.com>
Date: Wed, 18 Feb 2026 12:40:57 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] sparc: Fix page alignment in dma mapping
To: Stian Halseth <stian@itx.no>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	<andreas@gaisler.com>, Leon Romanovsky <leon@kernel.org>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <37bd2be353f839c1cb13b0d18bc9e8903b31f9c0.camel@itx.no>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260218114059eucas1p286bc48f3304d6b588b2b9465f4d8c566
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260217171231eucas1p1f915cdb1081b194466431155fd8ec136
X-EPHeader: CA
X-CMS-RootMailID: 20260217171231eucas1p1f915cdb1081b194466431155fd8ec136
References: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
	<CGME20260217171231eucas1p1f915cdb1081b194466431155fd8ec136@eucas1p1.samsung.com>
	<20260217171104.5643-3-stian@itx.no>
	<0bdd9ad5-e1b4-4dea-b936-e078b19d2996@samsung.com>
	<37bd2be353f839c1cb13b0d18bc9e8903b31f9c0.camel@itx.no>

On 18.02.2026 12:09, Stian Halseth wrote:
> On Wed, 2026-02-18 at 11:28 +0100, Marek Szyprowski wrote:
>> On 17.02.2026 18:10, stian@itx.no wrote:
>>> From: Stian Halseth <stian@itx.no>
>>>
>>> 'phys' may include an offset within the page, while 'base_paddr' is
>>> already
>>> page-aligned. This caused incorrect DMA mapping in dma_4u_map_phys
>>> and
>>> dma_4v_map_phys.
>>>
>>> Fix both functions by masking phys with IO_PAGE_MASK or subtracting
>>> the
>>> page offset, covering both generic SPARC code and sun4v.
>>>
>>> Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
>>> Reported-by: Stian Halseth <stian@itx.no>
>>> Closes: https://protect2.fireeye.com/v1/url?k=4d8fbc00-1214850c-
>>> 4d8e374f-000babff3563-ee1be24be576e072&q=1&e=0f8967ce-f558-4339-
>>> bddb-
>>> f324ec46c035&u=https%3A%2F%2Fgithub.com%2Fsparclinux%2Fissues%2Fiss
>>> ues%2F75
>>> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Signed-off-by: Stian Halseth <stian@itx.no>
>>> ---
>>>    arch/sparc/kernel/iommu.c     | 2 ++
>>>    arch/sparc/kernel/pci_sun4v.c | 2 +-
>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
>>> index 46ef88bc9c26..f3755a388ac7 100644
>>> --- a/arch/sparc/kernel/iommu.c
>>> +++ b/arch/sparc/kernel/iommu.c
>>> @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device
>>> *dev, phys_addr_t phys,
>>>     if (direction != DMA_TO_DEVICE)
>>>     iopte_protection |= IOPTE_WRITE;
>>>    
>>> + phys -= offset_in_page(phys);
>>> +
>> I've just noticed that IO_PAGE_SIZE might not equal to PAGE_SIZE (not
>> sure if this is true in case of SPARCs), so it would be better to
>> rely
>> on IO_PAGE_MASK or IO_PAGE_SIZE only. Just unify the fix for the both
>> affected functions either by masking phys with IO_PAGE_SIZE where it
>> is
>> used or by subtracting (phys & ~IO_PAGE_MASK) from it.
>>
> Good point, and thanks for the review.
>
> I failed to consider that the offset_in_page is based on PAGE_SIZE, not
> IO_PAGE_SIZE.
>
> Suggestion, subtract IO_PAGE_MASK in both functions.
>
> arch/sparc/kernel/iommu.c:
>   -phys -= offset_in_page(phys)
>   +phys &= IO_PAGE_MASK;
>
>
> arch/sparc/kernel/pci_sun4v.c (better to subtract before loop?):
>   +phys &= IO_PAGE_MASK;
>
>   for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
>           -long err = iommu_batch_add(phys & IO_PAGE_MASK, mask);
>           +long err = iommu_batch_add(phys, mask);
>           if (unlikely(err < 0L))
>                   goto iommu_map_fail;
>   }
>
> Is this acceptable, and in line with kernel coding style?

Yes, that's fine.

> If yes, I can submit patch v3 with this proposed change.
>
> And Patch v3, should be sent using the message ID of this review
> response, right? Still learning :)

Usually the next version is being sent as a new thread. Just add a few 
lines of history and links to the previous attempt(s) to it, like for 
example here: 
https://lore.kernel.org/all/20260203102133.1478331-1-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

