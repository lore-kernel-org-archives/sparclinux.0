Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999C326922;
	Wed, 18 Feb 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404509; cv=none; b=tDfveeVs2+7Z8xerXJVxoSi2m36QNG7r3rP34XTBH7KZ2W+YGZPIUQiM4b+ue06N+vfTux/9ypedHGv/at9yndAcv1WZ02K6qrPHzKI3zXL+NNGFjTRzbNHNU8uPpH9vcVbxMRagIiJXKs20SA0IvHmbTxRdcSjGY3GWxAxhQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404509; c=relaxed/simple;
	bh=sxxP+bY0yRF7qpKJ+XIgxzMieYZaHNYX9o3cpM5JelU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpWG5oDS/KTdNgZf1FoAEhTQOWVHU8YIEi6Ir1ekPLe5/wX0LLsSsV6umETRl61S3s1j3P9k095p+je4bHOVHV7uPNGVbDSUPHB0tIw5KPjfhlivEp6EQTgLZh4faoBkmO/BR2xj71kCsm9qH1TnanqsDmEd8B1VtbOY2zhb3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/hNnsLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/hNnsLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DFFC19421;
	Wed, 18 Feb 2026 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771404509;
	bh=sxxP+bY0yRF7qpKJ+XIgxzMieYZaHNYX9o3cpM5JelU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/hNnsLwmjnqccXkoaMgRnV0smMmo5y2Lx1VTvaPXPd54yH87HQCLNmJdrAwxjTCc
	 eAKqhY2bKn+kYfNqSFit/GX4F6gRPcg5/uWaNv+vem41Hj6JycbHdht8RAZdy/Wo4W
	 4XBAHgcc3odTYwkCRb8lpYig7z/xXtc7O07zoNCGFwsuSTImB6332sb7EXxl4Tn1fP
	 LsiWTlA0fxAwhfQX2a1pe0AgcSxgIqlikwVoBjMwolk9f/YIEpmUibvfpSu9j5ModS
	 pxGOwb+d523Geue8jSVemszEVDTDD2HFJKMM6+wb1+n3M216DlA8onQvddqKquAwqE
	 hcuQffkFG3sgw==
Date: Wed, 18 Feb 2026 10:48:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: stian@itx.no
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sparc: Fix page alignment in dma mapping
Message-ID: <20260218084826.GB10368@unreal>
References: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
 <20260217171104.5643-3-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217171104.5643-3-stian@itx.no>

On Tue, Feb 17, 2026 at 06:10:19PM +0100, stian@itx.no wrote:
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
>  arch/sparc/kernel/iommu.c     | 2 ++
>  arch/sparc/kernel/pci_sun4v.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
