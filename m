Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664611A0BD3
	for <sparclinux@vger.kernel.org>; Tue,  3 Sep 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356356; cv=none; b=Vdt30xfgAh3jNO7b4FSsmUx0LuVCqa+I8MIlqwdb1vW4RWSNNvhemCS3P3ye4cR82ejcS1W5THtm95PMB6fkokZpnm1Kc7rGysDAoEiwyIl4V3lgLfAjhbTce5FXjlM+CROuQMzn3HDzAGGql9w7VVebYzzSGsm0juwEq2FNpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356356; c=relaxed/simple;
	bh=Roj+Ea7LEvenEhyYiuiVmXINZE+I65g3EEz0Bl+4ooc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhVf4kPHHg9JAI2/XNSusnuJwawlNwaPcKt6DDX9lsF2fFIazG4NGEQVihtI4ybtp0UWFUFsCrPAc0+TyjryFtwve6U1YSeKPjTo/meuwrRnUxy6XvLRBpziy4sGEXQ3rrHmdM4cuW1coJUlnzeSLJbDGoy0lILM6W5pOgRbT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dzg0MTH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dzg0MTH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ROekkmcoe+OX/H/SJ0CegmonvJxcYbn0m80zXzGYZLw=;
	b=Dzg0MTH81X5MuDrt2OLTZjTsfh9S3IMwT3enhoGoSO6WkamznRckYPFV/zOLIYifHtDPca
	1BhbhhsTEHZPay5jkVb1UzEAC5MMmXvBQ+sjnV4TH/VcTe8ZWyQmeNvCC9sazU0q3Vk4Zx
	a1E8p1kuNnRNg9omv2MGxYn1oIYzP+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-WVa1NlJCO9W96Hu-PvKY9A-1; Tue, 03 Sep 2024 05:39:11 -0400
X-MC-Unique: WVa1NlJCO9W96Hu-PvKY9A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42c80412dc1so21029035e9.2
        for <sparclinux@vger.kernel.org>; Tue, 03 Sep 2024 02:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356350; x=1725961150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROekkmcoe+OX/H/SJ0CegmonvJxcYbn0m80zXzGYZLw=;
        b=syBTMF1zQAkA+BDOJo9PrLMMglJQLGDNfMUHsalEAXCTlZPadFwN0gGmfcS8DAaqUd
         g7xeR1Keyj/9qqv5I570RZTykYfl7kmYcd/v1OB7fLhKt8tML9uNVFwAmjaIYRrh6WXk
         4kwEry4ab3e7rEZQbOflwi0EqSC17iu9mc3zzhZU7sjyXXPiBzarH+qCoyDmucxMa6+3
         M/9GvpYqQjrNKlrsBz0eOU3ZRUsB9u46HBQ23QE0EQmcPYdHkjs10jlHhW3tFiDdfy0I
         0yANKVatqQEnLPM6QPRNrksuYhILTwimjwLhcKIDE1PEujDQMvUTBSXi51Skv1XB6FgG
         7hsg==
X-Forwarded-Encrypted: i=1; AJvYcCXigTUSihjEcel/noFZ04cglbAe7ajeegjiSbbUOynbbh3xX/5KiRaHyE8NZWcfNqhDu+O7iiFeWAjL@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNiZfjTpg7p+Tm6PGL7wStApfNIrmtMvt11Wr1XyITcLjbNi5
	tBbmREjSYBs64mALELC751bAzBK0+M6tyzYEDC29aqQ7g76OWxJJL5ZybUfR4PpXfko/A52+RgU
	YV48DbqNDIJmDIcGkrQnjqTh/dj6ZhXAGzlMaU557pPm0YUXLQoLRLDxLFZI=
X-Received: by 2002:a05:600c:3d0d:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42bdc6375abmr66533125e9.19.1725356350124;
        Tue, 03 Sep 2024 02:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmeosf/mJIf4OuBVOC1FXDQtaN47WobnVUFS/lrBzspPK+LAJFhvAiwYTR4QIKkjIzV+Hhfw==
X-Received: by 2002:a05:600c:3d0d:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42bdc6375abmr66532735e9.19.1725356349385;
        Tue, 03 Sep 2024 02:39:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba57bb20sm142356975e9.4.2024.09.03.02.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 05:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>, Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-media@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] vdpa_sim: don't select DMA_OPS
Message-ID: <20240903053857-mutt-send-email-mst@kernel.org>
References: <20240828061104.1925127-1-hch@lst.de>
 <20240828061104.1925127-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828061104.1925127-2-hch@lst.de>

On Wed, Aug 28, 2024 at 09:10:28AM +0300, Christoph Hellwig wrote:
> vdpa_sim has been fixed to not override the dma_map_ops in commit
> 6c3d329e6486 ("vdpa_sim: get rid of DMA ops"), so don't select the
> symbol and don't depend on HAS_DMA.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vdpa/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 5265d09fc1c409..b08de3b7706109 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -11,8 +11,7 @@ if VDPA
>  
>  config VDPA_SIM
>  	tristate "vDPA device simulator core"
> -	depends on RUNTIME_TESTING_MENU && HAS_DMA
> -	select DMA_OPS
> +	depends on RUNTIME_TESTING_MENU
>  	select VHOST_RING
>  	select IOMMU_IOVA
>  	help
> -- 
> 2.43.0

