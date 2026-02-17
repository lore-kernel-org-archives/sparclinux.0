Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADA361DC3;
	Tue, 17 Feb 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334129; cv=none; b=OAG9KToVuQHoWfk7ul/7+oPVm26J59hylerH1EIp24r7WLAVu7Dzxd2TOoB/RA+Ee5mQWw1mSXmqGbre2m41bJzAe15no0MHGj19OiKauktEx8BzYuWHPq4lSNren0EuwUr/xd0cJu3sMjKiQfliK8rR8LsssRFr98hRiW335ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334129; c=relaxed/simple;
	bh=IFqWRnMOe90PHPZ6ogIhD60Li5AyK3EFhOC6WZ8V4S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVibJ5MM04GOxdcl5WJpisCbSEXJpDli5NNBAQ5iHsbUtNrx+RnDGxFf81D+DsSlDY/cBVpx0rwsC5B5vxF6oZaXg7L6E5tyC4JTtHvBMnjWNNjiucwHdVwwp3VQQE58WWYQTeXyngKc/q8eGDnaJpASPxpTIZPW8R1xRJvaBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F44Ix8zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F44Ix8zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCD7C4CEF7;
	Tue, 17 Feb 2026 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771334129;
	bh=IFqWRnMOe90PHPZ6ogIhD60Li5AyK3EFhOC6WZ8V4S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F44Ix8zfCzwWI4AQs9GQP2t1ynVHWLNSCY3twBxZFDsxlSu/RfSxZcW9hg0L7WEMK
	 DVLz5necSLs8Vd9sUbcqNxHiXhSe1wgYUNVz9W3t3HjIlpnMvOSIidbsZRLiskWn68
	 xItdSgwjZ64haQEHc9AA+Car4oFuKE6jJy6K1oZ9qp0NfO17s8m5QhB5G3se54yqng
	 +Woyi/px6vIOOUpaq+Jzvi7e5oKdunoebhikfsFPd3HTxF9VWSvih4dM6ug2R8hcj/
	 MvelNqZrwI6p0ECzsvxqAg+vPD6IuKSVLKEs3YzKCjc2YZAO5l2Mn9P1+IofP43CvT
	 66YAmYLUGAOHw==
Date: Tue, 17 Feb 2026 15:15:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geoff Levand <geoff@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v5 11/14] sparc: Use physical address DMA mapping
Message-ID: <20260217131525.GK12989@unreal>
References: <20251015-remove-map-page-v5-0-3bbfe3a25cdf@kernel.org>
 <20251015-remove-map-page-v5-11-3bbfe3a25cdf@kernel.org>
 <CGME20260217123216eucas1p2d74189a3cdf08e9301bebf1840491364@eucas1p2.samsung.com>
 <e294484787a5032c531dcd40071b22362bddcad4.camel@physik.fu-berlin.de>
 <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>

On Tue, Feb 17, 2026 at 01:55:56PM +0100, Marek Szyprowski wrote:
> On 17.02.2026 13:27, John Paul Adrian Glaubitz wrote:
> > On Wed, 2025-10-15 at 12:12 +0300, Leon Romanovsky wrote:
> >> From: Leon Romanovsky <leonro@nvidia.com>
> >>
> >> Convert sparc architecture DMA code to use .map_phys callback.
> >>
> >> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >> ---
> >>   arch/sparc/kernel/iommu.c     | 30 +++++++++++++++++-----------
> >>   arch/sparc/kernel/pci_sun4v.c | 31 ++++++++++++++++++-----------
> >>   arch/sparc/mm/io-unit.c       | 38 ++++++++++++++++++-----------------
> >>   arch/sparc/mm/iommu.c         | 46 ++++++++++++++++++++++---------------------
> >>   4 files changed, 82 insertions(+), 63 deletions(-)

<...>

> >> @@ -296,7 +305,6 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
> >>   	bus_addr = (iommu->tbl.table_map_base +
> >>   		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
> >>   	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
> >> -	base_paddr = __pa(oaddr & IO_PAGE_MASK);
> >>   	if (strbuf->strbuf_enabled)
> >>   		iopte_protection = IOPTE_STREAMING(ctx);
> >>   	else
> >> @@ -304,8 +312,8 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
> >>   	if (direction != DMA_TO_DEVICE)
> >>   		iopte_protection |= IOPTE_WRITE;
> >>   
> >> -	for (i = 0; i < npages; i++, base++, base_paddr += IO_PAGE_SIZE)
> >> -		iopte_val(*base) = iopte_protection | base_paddr;
> >> +	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
> >> +		iopte_val(*base) = iopte_protection | phys;
> 
> 'base_paddr' was aligned to start of a page before this patch, while 
> 'phys' includes the offset within a page.

Thanks for the fix. I had assumed we needed to revert all changes in
iounit_get_area().

Thanks

> 
> 
> Could You check if the following change fixes the issue?
> 
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 46ef88bc9c26..edb0ffb21e2f 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -312,6 +312,7 @@ static dma_addr_t dma_4u_map_phys(struct device 
> *dev, phys_addr_t phys,
>          if (direction != DMA_TO_DEVICE)
>                  iopte_protection |= IOPTE_WRITE;
> 
> +       phys -= offset_in_page(phys);
>          for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
>                  iopte_val(*base) = iopte_protection | phys;
> 
>  >> ...
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
