Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6E3093BD;
	Wed, 18 Feb 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413256; cv=none; b=GG0cVR1vj50rVginWMiEaufps6HGrwUq5YZIhzGxlUAQYj046OofhsgKjea5+26GhlEvtWRrZWPvoZTIkFRaQ9kkjBh7SZaAJISGze1AwJ5zIfSAmS+gCtMaLEeD9YyfXdOkcWavWklts6/0WuOpG1bmzUGFuKhrTGzINLf3oCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413256; c=relaxed/simple;
	bh=2/JT6yLV1vqPr0/WZJO8FBEzr+KYQWi/oZu9jX/ePkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8d09a2XMbN65H4SBHMkSYSy4hS8+LlS+PdLE4KJddA6RNRn+yEtuZNkiHILoKHgD3o80qvJbeNl/Qg2A/4HkLHiGgDhmVXTSAFmnpsXCkjahQqdZZ3DBAH9raU/7/FB6gjqCLyMVrAG7jFgAIHSbK4l911Ihc0ttbGx3HdTIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZuhrf5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZuhrf5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D47DC19421;
	Wed, 18 Feb 2026 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771413255;
	bh=2/JT6yLV1vqPr0/WZJO8FBEzr+KYQWi/oZu9jX/ePkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZuhrf5Gn/OfI0/jvrAKrFTMH+5u/VXFRyrhnJwtGT46LTB/2gR+YB1HBinWv5jU9
	 Hy3eUG7Plh2NLwRFJWecSFVOZeC9rqkDmdmUmhAQi66GTZu+sfBL2pZx2QKqOBbowT
	 dzOiq8n41Q4bNXwEVCU72KqcPGPoEUTZrFSn8BD+gv5l/mdFM/gADUBA7gZ6e0p3Bs
	 BhgqahSFfVSYPUnJadmRDg7o5LE8bi+WH9FKTI/IIZ47m4vERT9LPxZTFcw4hDkMAy
	 tm+9kw3OxcuVx1nalkB0AxJu4LfR8mDLE5qB7HK1A3IKzDTyQnlkuhnxY3lpg5wIS6
	 xKp7slP1Mj/Ag==
Date: Wed, 18 Feb 2026 13:14:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sparc: Fix page alignment in dma mapping
Message-ID: <20260218111412.GG10368@unreal>
References: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
 <CGME20260217171231eucas1p1f915cdb1081b194466431155fd8ec136@eucas1p1.samsung.com>
 <20260217171104.5643-3-stian@itx.no>
 <0bdd9ad5-e1b4-4dea-b936-e078b19d2996@samsung.com>
 <37bd2be353f839c1cb13b0d18bc9e8903b31f9c0.camel@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37bd2be353f839c1cb13b0d18bc9e8903b31f9c0.camel@itx.no>

On Wed, Feb 18, 2026 at 12:09:06PM +0100, Stian Halseth wrote:
> On Wed, 2026-02-18 at 11:28 +0100, Marek Szyprowski wrote:
> > On 17.02.2026 18:10, stian@itx.no wrote:
> > > From: Stian Halseth <stian@itx.no>
> > > 
> > > 'phys' may include an offset within the page, while 'base_paddr' is
> > > already
> > > page-aligned. This caused incorrect DMA mapping in dma_4u_map_phys
> > > and
> > > dma_4v_map_phys.
> > > 
> > > Fix both functions by masking phys with IO_PAGE_MASK or subtracting
> > > the
> > > page offset, covering both generic SPARC code and sun4v.
> > > 
> > > Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
> > > Reported-by: Stian Halseth <stian@itx.no>
> > > Closes: https://protect2.fireeye.com/v1/url?k=4d8fbc00-1214850c-
> > > 4d8e374f-000babff3563-ee1be24be576e072&q=1&e=0f8967ce-f558-4339-
> > > bddb-
> > > f324ec46c035&u=https%3A%2F%2Fgithub.com%2Fsparclinux%2Fissues%2Fiss
> > > ues%2F75
> > > Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Stian Halseth <stian@itx.no>
> > > ---
> > >   arch/sparc/kernel/iommu.c     | 2 ++
> > >   arch/sparc/kernel/pci_sun4v.c | 2 +-
> > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> > > index 46ef88bc9c26..f3755a388ac7 100644
> > > --- a/arch/sparc/kernel/iommu.c
> > > +++ b/arch/sparc/kernel/iommu.c
> > > @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device
> > > *dev, phys_addr_t phys,
> > >    if (direction != DMA_TO_DEVICE)
> > >    iopte_protection |= IOPTE_WRITE;
> > >   
> > > + phys -= offset_in_page(phys);
> > > +
> > 
> > I've just noticed that IO_PAGE_SIZE might not equal to PAGE_SIZE (not
> > sure if this is true in case of SPARCs), so it would be better to
> > rely 
> > on IO_PAGE_MASK or IO_PAGE_SIZE only. Just unify the fix for the both
> > affected functions either by masking phys with IO_PAGE_SIZE where it
> > is 
> > used or by subtracting (phys & ~IO_PAGE_MASK) from it.
> > 
> 
> Good point, and thanks for the review.
> 
> I failed to consider that the offset_in_page is based on PAGE_SIZE, not
> IO_PAGE_SIZE.
> 
> Suggestion, subtract IO_PAGE_MASK in both functions.
> 
> arch/sparc/kernel/iommu.c:
>  -phys -= offset_in_page(phys)
>  +phys &= IO_PAGE_MASK;
> 
> 
> arch/sparc/kernel/pci_sun4v.c (better to subtract before loop?):
>  +phys &= IO_PAGE_MASK;
> 
>  for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
>          -long err = iommu_batch_add(phys & IO_PAGE_MASK, mask);
>          +long err = iommu_batch_add(phys, mask);
>          if (unlikely(err < 0L))
>                  goto iommu_map_fail;
>  }
> 
> Is this acceptable, and in line with kernel coding style?
> 
> If yes, I can submit patch v3 with this proposed change.
> 
> And Patch v3, should be sent using the message ID of this review
> response, right? Still learning :)

No, just send patch v3 without Reply-To field. Add changelog under ---
trailer line and describe changes.

Thanks
