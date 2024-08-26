Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DA81AD7
	for <sparclinux@vger.kernel.org>; Mon, 26 Aug 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653014; cv=none; b=JTa/D0mH0aHHudrSdUy33dbR/An7PFjGzdBSFa6nks9Vs/Bra3XG1wDEseawzpKFOo89+qkzjrBSqWi/1+5Agz4M24GHdlfz7NTp/ciPDkgvh6pY2ETJPRH+t0qB35xZKI101McCoynCeygU1gnhFoyMhjIh+rT/LrXSk3IjGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653014; c=relaxed/simple;
	bh=OxH7DwkvlaSlLEvipNmqgwxmyasajvhgDEfCExvjRjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eypk+RsPl1x+olYzTcq8ZQZxMlTWdY4gDYJKcNZkveiKZoYT8/Ulj7/2llc5aLonZNsY4BxqaFNNaZDi4219nZotSX1EOk6N00e+NZ+hHQSEUqrD8I0fAMwNMZRqfVjv+i1pyWz2ZuJZQCjVJOJP88gLxUxhOE8u+lMVlUpXAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MY/sKCaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY/sKCaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dB1NfwLF4sboQ9oAiJsmEAd6cRRc4sOW3f5DA5Z/91g=;
	b=MY/sKCaTjrBl8RIwTRt5lROwGlvJy1hjkLtRdC5LcqW5orl0kRGm4pr+30eActr3c3HICe
	lg1aiRhcPkqwke68sdAUGmpOh7T/a0peC4r0OiIxo8y5PkhY/tEgQzlRhlBZHoPV98QYHj
	B01PVTjOfiPp4IdnVg1iAJ6GommMvEE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-KoM1cQjuN--NDQdbLIotgg-1; Mon, 26 Aug 2024 02:16:49 -0400
X-MC-Unique: KoM1cQjuN--NDQdbLIotgg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d69603a62aso1416026a91.2
        for <sparclinux@vger.kernel.org>; Sun, 25 Aug 2024 23:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653009; x=1725257809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB1NfwLF4sboQ9oAiJsmEAd6cRRc4sOW3f5DA5Z/91g=;
        b=Vw5gc/EKiJXkKeTxStpf57NKX9DM0T9NYiil4DatrCEhy+v6y2yo8vKGPLlDNRe/FN
         Ushk+tAutP4c4m37xcoq/djYV2WTdv98Nl4B/W/3pRJivyLqRKBtzpYT/IiuuEab0b68
         rcUHGv9oCqsJiHNdvSP4EKgyKN87wrZiDHcgAV8Ie6PnkpjbH7tMT4inJj0N1mBb6WJc
         yG1sqw+lye/jbtl8npnWF66szgU+1Olm0eb2akgMH/RzzHjJmv+ITXvmNEVEcn/3Wo5a
         A5p7JYKRKuF+r70D5wlYXArUKNAKDwn9TVpzddDK4uAn+06giuw4BfqgkceKDM9ZqWiW
         xvpg==
X-Forwarded-Encrypted: i=1; AJvYcCXQfPjBnnLp/QBBmRAi/mVaMzXd1ZsXGUBq+aW0QvlmspF2voZeC6yQh/U6nY1SQ1uxkV0nSZGob8cp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nwX35MY7xw30b4bc0Rorr1F0hXtzbSAoNDVBJxcTQDNkERPh
	G8A9uzx/2CLyC9kg9B+eCoWuaPUT9qQJPA4T7XOa9WQYdqqA3a8Rtp4/3vm941bBdcjGarlLeUG
	XaRIgBvt5EHfNDB7+d2tr7iyJJPHydaFXFWM3KIUw1if+tWxYRXjO/DtnQt41MpEfNVJyQf/5AQ
	qwfPTmTdhR1JMnk4lmWlnx0ToUBR7FeOzhgA==
X-Received: by 2002:a17:90a:6287:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2d646d247f9mr9809281a91.33.1724653008874;
        Sun, 25 Aug 2024 23:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0WjIzDYmdUX7OY9EeJBLH76SMB2mi2zdVZl4NauXJ/eBoNO23zRck1BCKv7ZS6PzenwJTH61bASpm1vxRFd8=
X-Received: by 2002:a17:90a:6287:b0:2d3:cd27:c480 with SMTP id
 98e67ed59e1d1-2d646d247f9mr9809253a91.33.1724653008351; Sun, 25 Aug 2024
 23:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de>
In-Reply-To: <20240824035817.1163502-1-hch@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:16:36 +0800
Message-ID: <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 11:58=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> we've had a long standing problems where drivers try to hook into the
> DMA_OPS mechanisms to override them for something that is not DMA, or
> to introduce additional dispatching.
>
> Now that we are not using DMA_OPS support for dma-iommu and can build
> kernels without DMA_OPS support on many common setups this becomes even
> more problematic.
>
> This series renames the option to ARCH_DMA_OPS and adds very explicit
> comment to not use it in drivers.  The ipu6 and vdpa_sim/user drivers
> that abuse the mechanism are made to depend on the option instead of
> selecting it with a big comment, but I expect this to be fixed rather
> sooner than later (I know the ipu6 maintainers are on it based on a
> previous discussion).
>

I will try to fix the simulator considering virtio has already had
mapping ops now.

Thanks

