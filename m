Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9F13AD32
	for <sparclinux@vger.kernel.org>; Mon, 26 Aug 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653666; cv=none; b=dF7wN+MVa8aJsUq0TKWfV4BghL23NseOeLZeqAWc6lBFlGylgRdIPH5Vt8kD9HINYxXw+qwKE182tWzoiDBmfsXRr37yyV1NGH9V7JJoIHqCuyEf5IDaDcmJSFU064l30DVdq+jnfIbcn+d4X3zTH9uqFhPk2Oy7n9aqoNIBmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653666; c=relaxed/simple;
	bh=9FdJ3ALSTNHxptv1eM+dVepm0TpConKuAyxPlsMtLjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP4noSqFLhLlaRfXJhMiaKcR09hD/BlS9PlsJ4URKH03P8rA+3tLNCXCVLsnMbTreVuWi5agJK1y6vvyAVKGkOm7dVpwUAhip0jhyTSFH+MAA75eIDLGKCBdGL/vAW6rsWkr+jMl2n58WdsVVkFNUSK9QkeXw/LwR/DQJcIOlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUUE5btv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUUE5btv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs8AUYhSmmGXuJkf0JZ3EFqr6hWEcb9C7Q1wG4ibjBY=;
	b=QUUE5btv6RfWxCyQDJ/2p9TcfOTYnP7Db37oj4pjFUN1V//urHQ7fJtRcWoikQm/qkEs/Q
	LcK/LH3bqSZvC6qolazKP1EjNt5V5gI+v8kdZZsbcZKzEwfFYV7nPj1LAfVZHkoNz5Imr4
	ysCOBykQ1lEmXMtecPrMY0vF0qTxxBU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-zOx01KOPOHKr9tIDuAXzSA-1; Mon, 26 Aug 2024 02:27:40 -0400
X-MC-Unique: zOx01KOPOHKr9tIDuAXzSA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb5847ff53so4911378a91.2
        for <sparclinux@vger.kernel.org>; Sun, 25 Aug 2024 23:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653659; x=1725258459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs8AUYhSmmGXuJkf0JZ3EFqr6hWEcb9C7Q1wG4ibjBY=;
        b=sccas96gQxPuXwBITw42Y19B9QhKnAep9AZcFY6z3Z6mXchOhg1kXSap7apa6SEL+m
         7WB65Is0RVpsrnY3MrUfciztvmVXAafRB6S6oEbqhs8iBtf7yHjeG83rD5FVjRrWbCpC
         YIDETBV9Ivcvj40qKnS1nnosS2E8xTfIf2WIbRDq0OGo3ENtCUi5z0T5rlvOH1EcMdJB
         lPGcPQfAsiGxgGmvTfEM7+7gg3i9bOE7fuZNbc6UhTBusUHZZWsQrd3zKx2N2BK+FHSA
         aotNMURJDRXXgETxwX67xsnUt9n1cSw/cJVPMg6LBv7jkErOKtJGkxeQTE4FwaHPcD4u
         NINQ==
X-Forwarded-Encrypted: i=1; AJvYcCWes0YA6u9lqkNCbQNAIxwhDqPmwXJkVZHc4tk1CqlZVfj3VfsLjX42w0rSrr1/i0Ib1M9uJkB2tFZE@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLrrKMKOoaGE6wAr70djaV6LSfo0+CFNC+jerSqZ4cyZH3zcV
	kvWvw/f6n802c/fRQ9t0p6lP7Kqli2XwApetFmRVmUBOWs8JIzxJncW26Kkj2ToU31ltEZf0dSo
	vaFoF0QJl+tTq3hgRJn6E4GRE7REc9n7bt/31Nrc9EpXyFpHva6nx2brAY/PmJXAnxOT0zeTBd8
	bcR5HbQ12KLf+6L4XtSMQLla95FQMU4qWRNg==
X-Received: by 2002:a17:90b:ecd:b0:2cd:619:6826 with SMTP id 98e67ed59e1d1-2d646d4dcfbmr11272925a91.34.1724653659611;
        Sun, 25 Aug 2024 23:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP3GZqzlMhqPuuYHeWu96SGn+Tu3LWd1hDEbxpGhfc1OXWvtkUWRElPm7DPTwJzR3LmdWyUKTz2DeMu9Do6/Q=
X-Received: by 2002:a17:90b:ecd:b0:2cd:619:6826 with SMTP id
 98e67ed59e1d1-2d646d4dcfbmr11272892a91.34.1724653659123; Sun, 25 Aug 2024
 23:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de> <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
In-Reply-To: <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:27:27 +0800
Message-ID: <CACGkMEu83MjTpkSS1mX02ar8RNDc5T4bsd4kkGHYhkH7LZY-wA@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:16=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Aug 24, 2024 at 11:58=E2=80=AFAM Christoph Hellwig <hch@lst.de> w=
rote:
> >
> > Hi all,
> >
> > we've had a long standing problems where drivers try to hook into the
> > DMA_OPS mechanisms to override them for something that is not DMA, or
> > to introduce additional dispatching.
> >
> > Now that we are not using DMA_OPS support for dma-iommu and can build
> > kernels without DMA_OPS support on many common setups this becomes even
> > more problematic.
> >
> > This series renames the option to ARCH_DMA_OPS and adds very explicit
> > comment to not use it in drivers.  The ipu6 and vdpa_sim/user drivers
> > that abuse the mechanism are made to depend on the option instead of
> > selecting it with a big comment, but I expect this to be fixed rather
> > sooner than later (I know the ipu6 maintainers are on it based on a
> > previous discussion).
> >
>
> I will try to fix the simulator considering virtio has already had
> mapping ops now.

Actually I meant, we can extend the virtio_config_ops to allow mapping
ops there, then simulator and VDUSE can hook the map ops there.

Not sure if Michael is fine with this.

Thanks

>
> Thanks

