Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006B23C516
	for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575062; cv=none; b=sjAxm1CgvxaUoOuQ+OQHNwo+Tti23SZsHxiln5UlChRjmCd33XoQpzF0stUJaulJCl9BTIR3LC1JBGYvl7EINIkCyLR1YF3N+LDBWntYzDeJJEU4bB0sgnWEv8hZL0LqW/+VxioibG17RFtl2X4WcA33wmkTZ7xHvdN37eD5/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575062; c=relaxed/simple;
	bh=IR27taLTFITOYV4B00ku0qQKC4bEZ+4qpChrvPMvsvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn+zWAqPXKjqtKPt6HDpsuu4F4RhEPrsiFYN8lGvyb4Z81JtmSomelkKGAjDOkLpFsuu9K6a0zrI1Evl1yAZIfX0qxjIAHF0gIelb5whLrc5rcPv+ADYH+BljmNbtFwHEjTqHN2NVTJfo0VK57UULT44mUAjZp4uNdZgpc5Q4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRjSels8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRjSels8"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so6261474a12.3
        for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758575058; x=1759179858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=BRjSels8DOVs7qW6xbfiJMfD/GfyjPcjHOVYe2Rgt+KQAzD3xMEVJXn/vZai3COf86
         269dksgcmZHtamVFgfH8sYfTPVXXWSuMj9MoViEJ5+4HLu8qwGyL8EUOtmG2hqR5p35V
         yI+hLu0BNSLw4AGDXrR09NtFb5VtSS8BBpbe5PJujhaqK2PoEpJVh1aX00FoUE8A2jMh
         S65Fu9Jqc6iQF0ibDHrITbxfN0HoM2BjS0IqXUlVyhwKuWSvIFhUUw5rAt3xLQDHs/5D
         F1s6d0NCxxk9yD17M7mGb0zy+bcuTCjw3cgLGT8FGCPFRs0GsBG4kg471XqJ3SJQ2cCK
         lVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575058; x=1759179858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=M+Ezv7tuFmabVaJfkrmtKXviBVTiZ5y4qvq5L0TlG/XoPgz8Fk9m55yn5nuZXq/pdd
         pJpge6DR5jt2vQIa+2lUVJM7BdT0VyF0cpAjxzpm/2oIZmmCRWCW5KSDZjAGcgVD+KMv
         YD+3uttcHNUTtJQA6oYephQRKcQSuYHqaip2wL80nRUulDgJJM+KVG8HEBY3u+Dw5bsb
         2HuXa8L04+ndUVNQBuomtTX50QueloNzULdtop+9ZqwkpJIikAPGgRZ1Zfjm5S1g5v2L
         MXn2VRFnNQPXDVmXnyuQZhdfXGABX1810tHO7cVAJRtJAp6PpaUP4H2UzbfaOIs9/z7Z
         Duhg==
X-Forwarded-Encrypted: i=1; AJvYcCXLzP5JDqxSh6oLxuu/BUaba0UMgN6kJ11zzARn/s2fWoM0RZT5tOrp4hQcIf4Cn4BaVpzcdkESjhO7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9rPKMewtZR1Rb8n8aPx6Is9QkeJxtgN/B3cNqQs+9Ezd5WW6
	ve9txu4CpT4g203tevONZffO9IBxsFQU14qOyQ7BfSwCKEtWkc2Ok1MS0cfb7pW1vxV8af/pRii
	tdseh44ndiEAlrC2N6RX5PIfROOYN8qg=
X-Gm-Gg: ASbGncvfDm0sGxYFTL5tZ2KUtHCejoB03BzdvsRga0xXD3NJeZy6SsfSDXct6NnRQ47
	coNjOW+vkuO0uOkextYptBE2c3op0fjtlRzALpEDwTmY+4W3eAROF2DmCnsQDBT5xK0yvSZM8L0
	PIpUwNEimFQpeZ7RZHjIAQC5MFLxMHDxE7PWstMOUyKIWH4vSduL4T9ER1KHiYwKNS/EuHJug9u
	v3PnEEPgBZDGhSfhD8=
X-Google-Smtp-Source: AGHT+IFr06URzpJ6aUp4DpRFc3gqIF/QKzvPatkXOguRNAK+5vyBht27Wi77YYUi7cw/QJFO8eHWzN6Nc8/pR3lh7aU=
X-Received: by 2002:a17:907:72cb:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b3026c84e0cmr5356866b.20.1758575058272; Mon, 22 Sep 2025
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
In-Reply-To: <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 22 Sep 2025 23:04:06 +0200
X-Gm-Features: AS18NWDVFMZZnWEreuo7vPXyYUB8RQkWA0R_TESbZnVi7LcEMvax5dEHcVzVJVI
Message-ID: <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.


Hi,

SInce this patch affects the Alpha platform I got curious and decided to
try it out. The patch series requires some preparatory patches. Leon
provided me with links to his dmabuf-vfio branch, which had the
patches (and some prerequisite stuff) applied already.

Based on the dmabuf-vfio branch,  I've built a kernel and tested it on
my ES40 Alphaserver, the kernel booted fine but after a while of
moderate filesystem load I started seeing some ext3/4 related error
messages in the system logs. Rebooting with my old kernel into
single user mode, I was able to recover the filesystem using fsck.
Clearly this set of patches breaks things (at least on Alpha).

I haven't yet dug any deeper into the root causes of the file system
corruptions and I've only tested this on Alpha, maybe there has been
more testing done on other platforms targeted by this set
of patches?

Regards

Magnus Lindholm
