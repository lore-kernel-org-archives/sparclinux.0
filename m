Received: from arcturus.nroach44.id.au (arcturus.nroach44.id.au [45.32.188.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F933D6FE;
	Fri, 20 Feb 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.188.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583539; cv=none; b=suj2sgdrW5MFalPeOwxdkKxO6FkWXtvYP6yOSF/G1cvgXRQJFFrHi1bbI3d2XpyFd9OUl8CP2tiSUR0oos5jk5cRDigsO6mE0uidLhF4Gjv96gD10DmNlKiHzELZUERGQZdzXT3oGyLri5yse//xhoZ4I4YUe61BvjcnqbqQRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583539; c=relaxed/simple;
	bh=Df57nKCcMiwTtM2SwdQRAqyIqLeHlEsALPol4bSpMnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPLh6XZH8/xZZHAYi9KQHYEy+mBoVY2a098rzCwz2eoHJ0t0piTXbaHrCkOZTOZoo6m8iJlvoGxND74jaP5fJMvkICdKd//sk5dJofEXdajA/YJvsfgICSlyKvsIyNLu8iQFl/qKtxLfzyJqjt9BOCzaBJL22dxchyFRzKunI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nroach44.id.au; spf=pass smtp.mailfrom=nroach44.id.au; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b=jnlp4lpN; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b=jnlp4lpN; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b=HFVuento; arc=none smtp.client-ip=45.32.188.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nroach44.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nroach44.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b="jnlp4lpN";
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b="jnlp4lpN";
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b="HFVuento"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1771583528;
	bh=Df57nKCcMiwTtM2SwdQRAqyIqLeHlEsALPol4bSpMnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jnlp4lpNCkshx8i3/YlvGpVN8QRDFqP4yJPP8P2/11ZvJXtHb+fZpa4cJAdkBdibJ
	 sU6eYdalU/NAPI/ja8YSdhwOJVNq7ZHtEwHtwyL0f9LzisudS5ratsjy3+kBcOWhxw
	 wPwXtSCz5mDtyLFIFiQgebY7Q5+un7XaCkRCcdmgOGVx1ugglCAz4E99CUOm5KrrqN
	 cDMMPY+xx1aaUfT1WQtUrwx77njzvlZVF+BjkOfkvrEMFjn6lc5dJ/YIN3V1Jiywgz
	 i6QEBAEAXc4RGUqrLvBI05Rs7qCXd/acT01Tc2ijYbX1c3dLCJrXhZXDqY+v5s3o85
	 WHsqL6x+Dy9fQ==
Received: from arcturus.nroach44.id.au (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by arcturus.nroach44.id.au (Postfix) with ESMTPS id 862C630CB5;
	Fri, 20 Feb 2026 18:32:08 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1771583528;
	bh=Df57nKCcMiwTtM2SwdQRAqyIqLeHlEsALPol4bSpMnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jnlp4lpNCkshx8i3/YlvGpVN8QRDFqP4yJPP8P2/11ZvJXtHb+fZpa4cJAdkBdibJ
	 sU6eYdalU/NAPI/ja8YSdhwOJVNq7ZHtEwHtwyL0f9LzisudS5ratsjy3+kBcOWhxw
	 wPwXtSCz5mDtyLFIFiQgebY7Q5+un7XaCkRCcdmgOGVx1ugglCAz4E99CUOm5KrrqN
	 cDMMPY+xx1aaUfT1WQtUrwx77njzvlZVF+BjkOfkvrEMFjn6lc5dJ/YIN3V1Jiywgz
	 i6QEBAEAXc4RGUqrLvBI05Rs7qCXd/acT01Tc2ijYbX1c3dLCJrXhZXDqY+v5s3o85
	 WHsqL6x+Dy9fQ==
Received: by arcturus.nroach44.id.au (Postfix, from userid 5555)
	id 68C8930CBD; Fri, 20 Feb 2026 18:32:08 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1771583519;
	bh=Df57nKCcMiwTtM2SwdQRAqyIqLeHlEsALPol4bSpMnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFVuentowrMqhEEn/Jbvba7jBNMDq+iEtVRErmqcq7adzES2Uph+hOnW/CXN4c8aQ
	 Z+3AiT4rX6FjQXi8YHEKMemGLSeQWOvaxDLQIGUpVNa7tTYCCcwNVYPW/j59OzETU6
	 WDhQhsETb1ommfaCvfPghIv01AzRltejjILRZNBCK3ZpKQsI/yiEScDVo+YlFkFwxC
	 mBIMzoxq6c7QEFDGALdrt0HxDlMlciiHAdGbwYnk4hr+zuTBqSlofu4dNQQhA+017I
	 pKwIqpJm7ZOa6dzSOCpxdwLAKNJGSPCjEPIwJ33SrdmGJDLcUZ6SdDWS/0e0jx84gf
	 jRkdohOdx3Mxg==
Received: from [IPV6:2403:5814:4228:10:a559:f4f7:79c8:12ed] (unknown [IPv6:2403:5814:4228:10:a559:f4f7:79c8:12ed])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by arcturus.nroach44.id.au (Postfix) with ESMTPSA id 5280730AB4;
	Fri, 20 Feb 2026 18:31:59 +0800 (AWST)
Message-ID: <8fd4ecc9-93e6-4ea8-b6da-371a8f4e5cd9@nroach44.id.au>
Date: Fri, 20 Feb 2026 18:31:58 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc: Fix page alignment in dma mapping
To: stian@itx.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Leon Romanovsky <leon@kernel.org>
References: <20260218120056.3366-2-stian@itx.no>
Content-Language: en-US
From: Nathaniel Roach <nroach44@nroach44.id.au>
In-Reply-To: <20260218120056.3366-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/2/26 20:00, stian@itx.no wrote:
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
> Closes: https://github.com/sparclinux/issues/issues/75
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
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

Tested-by: Nathaniel Roach <nroach44@nroach44.id.au>


