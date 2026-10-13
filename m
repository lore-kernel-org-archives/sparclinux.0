Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B743CF21C;
	Tue, 13 Oct 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899859; cv=none; b=e9WhXLlvVtAqtt8Vv1nrpYqQlJ1DAAl3xbrzLPKwvJe1Et68YxdwiNR20QyG/YWU5T0dvOqUU6iEs2oYRgAfQgH0y483pSLzF8IS8rzaa6lPm/W3qhH6PKaiXG4epXPU78Isgmqa0r2QqV8sV4t0hZl3f7N7IEpTq/aQnT6sWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899859; c=relaxed/simple;
	bh=Ztp60YRiqqxKSMkfCAEpijG260xYAeSzy+HEAPecqX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck1x40z4P79LF0tddPKIzJrfbXxq9Jo+j8QZAaPhyEwnKPoIrGI/q75zzMKSAJDaEDzWMaXv0Ux0wpjyv3cC8mawDSkzK+mIuqdWyjmWt2Ws5uKlaX2zSErUJ22G+n3trL/bnDwXTQi7nGBrRw3cAYtzJfs7i1PmlRyFYwYaYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioz9pG7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioz9pG7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FC81F0089A;
	Tue, 13 Oct 2026 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899858;
	bh=H7KWRQK4hT/yqssG6blYbL1n9Ej/g4doszqPuBgzNq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ioz9pG7ltYQH/vAif7tO5sXfM+JGnFLMMGyIpeSElIWR83ntOm4MoK7Uc5jlVWFG0
	 OVaOQguo61a77o5h9JYendnrxv31PHyx4oINhBAX8xi8cb1gTbnXyYiokDcvf7BxU1
	 OEmYuYUtQIt+f5f8gs+r83amkFlzU3THcUBQOrVwFiU2Fvcg/Wi9MqZ/h3eJdlAwvM
	 XpnAXYhJCSpVN8RTx+/xEAJL1bGWeIZG4KMiHGU+y4yyGrz/Db2jCZicZL1dKhB7sJ
	 ib+AHTkW+s496S2IYl2jldOxiSMJOg9oDBn8JB1i1e8sgh/e8JPXhAgp30aZXV0FJG
	 doTZBcMX47oeQ==
Date: Tue, 13 Oct 2026 16:57:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: Use relaxed ordering for DMA_FROM_DEVICE
 mappings on sun4v
Message-ID: <20261013135733.GO219304@unreal>
References: <20261013133731.1795299-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013133731.1795299-1-stian@itx.no>

On Tue, Oct 13, 2026 at 03:37:30PM +0200, Stian Halseth wrote:
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
> Closes: https://github.com/sparclinux/issues/issues/114
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
> 

Looks right to me.

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
