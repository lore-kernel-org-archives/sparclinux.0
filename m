Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBA1A0BE7
	for <sparclinux@vger.kernel.org>; Tue,  3 Sep 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356389; cv=none; b=ssZu2DO/ekWYRevZZdqj1auaoxQCvRp5qXwZWIaXHmVZn4WR0a4Vm7L+LESsII64Kdi5TaBzg+LNsFvMfWtmgzMLtDxltzpcXnCi7rCrHkMRkteHnlPvJgl/B66Hl7yuGUtpopdlqJvHi9/XFrwU1kJMlODtq5IQtCSYPY9C0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356389; c=relaxed/simple;
	bh=pE3Mr0PnS9xl+CUiCEH2hxI4fWM92/vwv+iNfIiq4l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB+v8OrTtAWoJ/ZtShjTDy4IpV4XHqT3Vn/dnffk/oy+o34mTXK2bRH2mbTeNJwFPmPF9pEirZur//DagiDPciRkZQ18yfxOD2n3PcTCpdlRIAznIBMmlA0g3qhiLKjRVNqMuEeids8+wkhUcjel2nAYOvqufbojHUvVKJrIovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hh5kBEjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh5kBEjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIxA/7+yR2jXA4ieeKPuD5EUL5lArHR8csGiCMl6eW4=;
	b=Hh5kBEjOrdKZk3kRJinPc6wdUa5u6DXLTuWECSxYMTKrHHUGqSFrQ2EZzMzn9n3jPjSkDp
	GC6ifzE63Y1thpL3mpxcPpx/fxnMhjD+tQ5mrxZr3Pk0X0fXkFZ29JbgHWf97tb3WJzpaF
	VBc2DqBSZXXc3dJ3AutwG9VxR12KmZ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-0qcag-YYMOGn85c8IvVRhA-1; Tue, 03 Sep 2024 05:39:46 -0400
X-MC-Unique: 0qcag-YYMOGn85c8IvVRhA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb8610792so45160745e9.3
        for <sparclinux@vger.kernel.org>; Tue, 03 Sep 2024 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356385; x=1725961185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIxA/7+yR2jXA4ieeKPuD5EUL5lArHR8csGiCMl6eW4=;
        b=HBsd7JhqeHmhBWL4kTbZ3m9KZVpDIdEXmwlWvCBnqg/QhJyXui9fVoYgSyktHuZHzA
         qycTkKD/cP6tX3hVFY2nPNJnrZZHw4LgL7uHMaBd3yX6VrTzV6PKFn6o+wsbjmn37z8A
         iq/p0DOUf55rIfM9VaS+1TaQUmiT1hlya2teh36bdZV7rw+qPxNhEmKSQ7IwXWg2XW7D
         rCuJl4eiFSZkbSHipGoY8CmAwP67WWlLYKWGFq5HW7AVagdWP1peeWloMX7+cz9NKcyy
         skWBZOBG4fik19cy/eEOUumvWJ/2iLngEFW3CTm8M9iyfWt6UN6J3V6Za8eZKkz6EABZ
         2p5w==
X-Forwarded-Encrypted: i=1; AJvYcCUiA/2LdPCJUa7PsgpxyJdwLUNkOZREwGpFIowdCI+vbmQgZREf1qv3SOozSo7zcLXChqBrAjkQyWb5@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHUWTJ3k0NYYhNMj/tYE5SPuS4y0HY9GQj1cTYDbdSrt5SSqC
	luiPqSZqqTnEIer0f5Sncrm1m2M5XDH9Fz7Bqyi5hHW4fnlAjB+LA4VbpS82R+mfEyRqsF6nK3K
	iVvTAeeXj9i16YHKK6J9KsgqjVDyx8I0VorY78HMNjIfdu9mBw7x9WEfw2jU=
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42bb02ecb7emr124596345e9.12.1725356385060;
        Tue, 03 Sep 2024 02:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx9ZT+cp/JOzMdJ0eMMwlRMn2QkU5Mi38V0c6sZIqJTMhc/MD50iSbcQF046e0ymvaKlJlng==
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42bb02ecb7emr124595995e9.12.1725356384137;
        Tue, 03 Sep 2024 02:39:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0f41sm164222235e9.19.2024.09.03.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:43 -0700 (PDT)
Date: Tue, 3 Sep 2024 05:39:39 -0400
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
Subject: Re: clearly mark DMA_OPS support as an architecture feature v2
Message-ID: <20240903053917-mutt-send-email-mst@kernel.org>
References: <20240828061104.1925127-1-hch@lst.de>
 <20240903072744.GA2082@lst.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903072744.GA2082@lst.de>

On Tue, Sep 03, 2024 at 09:27:44AM +0200, Christoph Hellwig wrote:
> I've pulled this into the dma-mapping for-next tree, although I'd
> love to see one of the vdpa maintainers look over patch 1.  I'm
> pretty sure it's correct, but a confirmation would be good.

Missed patch 1, I was wondering why I'm CC'd. Looks good, thanks.

