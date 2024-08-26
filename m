Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A3126F0A
	for <sparclinux@vger.kernel.org>; Mon, 26 Aug 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653955; cv=none; b=MPWIdJAgC/twJlCMTs7+L9cFfT/m0Vzqg69Ff097KReJYM4f0jn0gEtKp6BIJmIQljN1ZWRk7yxmByngB/h+KGYv/s/SGaagVstGWImSV5PM9ViVXPT3WWAJEqxl6aPDXo/3YVTYXUXLifKU/Mqeu3a2iApmowInRzokgYLDbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653955; c=relaxed/simple;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elWLXqx21V7lcoGoqTtXNkF7LKx1qlYSdLstCafI9ok+qhTJaEks56esFrpgcXBm4XjMpElOuHOKiOC+IJNHBIP3FxR9Xr5AOmEQU9kDn2O9o3tG6+YHh8QfZ3mRdhiMkYj6mnGhiKavdtyUXpK70+WDiUAYgbHEKyzBTRBAMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6kGQxY4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6kGQxY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	b=E6kGQxY4xYiApSOlxL+UwCD068R0rgW2rO3CvvjD0WWae/XH95I5/A3nD01OT3+h0l+NkD
	QNOTW9GQ9Pt3Ocp3hGp60v3xX2RNiyAByuxWXnGSMz0pwOf/pgt/rfjZikGNGfdNq8KN5O
	X0QK3iumZ6bIojjfODaFgcI3atBhU/k=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-2b19waseMtCHE7PtTj2sMg-1; Mon, 26 Aug 2024 02:32:31 -0400
X-MC-Unique: 2b19waseMtCHE7PtTj2sMg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-498d9003facso1514184137.2
        for <sparclinux@vger.kernel.org>; Sun, 25 Aug 2024 23:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653951; x=1725258751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
        b=B8qdm1WTpUce0Y+x0L6m3pYPxS9NXhP4lZJTXLTRaa2aCjkMkGpqK0pxsv2SRd9K2w
         f0WuMs8/1Qkmg575xQElp+zPuDFYQAoYoW95VejN9Czmh2pWKUX/PvhEtsqMniGKwAgX
         3X3xqj2XcWv+et3ndRTcQ3tT7sPNJ0CLFEo7BsHHvAuefetLp0UM5Jd31PSbuIsAq919
         QzmJNPxDZlV8OpGUPFU3hBmbli7SwpLW+eePyLn0m4mG6N18AIiS8nocC9puGMZ7+ACK
         +cBb7YhJCflDfv2iQkW2un/H+q8L1BYG4YBVIT5e1OH83xRAPYzlT8Qgg0vF1NSPIJ2K
         A+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVXfCXDCrGMa4GpGf8RGjUQrRZN3lvs7Y13sFuobseEwe/iY/F4nwsVxgjMkaOwhpsxLgUdNPVf+jb3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Am11glsJDwsnGeNISeqZBxjktt6DRllnCZa2Hr1bzex2acxY
	RO2RVVGdYmwb4NZ6ff+dQ3/rKZiP5s4HjH0HV4UlIC25/iEvupKmVT4EcOrcGoitce96rK4DupW
	E7vb8P4CX+Fyh2HPrLoBqJb+22leV+FVTKS3P2fWPDcn1loDUykwV2EKE4XHQoPB1tUHX3JMOHL
	iOsxXFBUr71elEJJ6PguR1vTvZHsJ5TYASSA==
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id ada2fe7eead31-498f4768d98mr6498545137.31.1724653950682;
        Sun, 25 Aug 2024 23:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwydcuFOVlgtFmwjWlxiF2u2xtiMO6UvY+/x7l/PEgUFs/udwBSaHF5gxdau0K58G8iWDDv631otNdoDoL8Rg=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id
 ada2fe7eead31-498f4768d98mr6498530137.31.1724653950260; Sun, 25 Aug 2024
 23:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de> <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
 <CACGkMEu83MjTpkSS1mX02ar8RNDc5T4bsd4kkGHYhkH7LZY-wA@mail.gmail.com> <20240826063002.GA30266@lst.de>
In-Reply-To: <20240826063002.GA30266@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:32:15 +0800
Message-ID: <CACGkMEvB20-iwNKepBdJBNAvxN-5+MduxnX6XDbPFsVA4hNz5A@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-media@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Aug 26, 2024 at 02:27:27PM +0800, Jason Wang wrote:
> > Actually I meant, we can extend the virtio_config_ops to allow mapping
> > ops there, then simulator and VDUSE can hook the map ops there.
>
> From a quick glance that feels like the right layer of abstraction,
> although the config part of the name feels wrong at that point.

Right, or we could have a dedicated map_ops instead of trying to use
virtio_config_ops.

Thanks

>

