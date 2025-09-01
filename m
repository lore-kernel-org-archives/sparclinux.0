Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3B263C90
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738975; cv=none; b=TCAoHFLKMsO/dr9UfJLJJuEQAtanULdWHGBQgqUDukVHgJ4CJcLEYrZhHarH8wEbLO2++lL9zVOO0MejrGuuvYw1m04qrJoFvH8CDAEZz4n9aPB7hnW6uHGSWyjXeUeCeWT9Gy7yVUDgbcKo/AZ/KUXTQ5XkTzbCKiS5S6JOatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738975; c=relaxed/simple;
	bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqH3inlJoFHgH+UELLcpwRjr8WrCChdjsuaJ82uy3PpNVHy++5EfcUxjfwi6qCjfkpGBnDb/Fr3d4T0AveL+OJ0MTR+/jjniHUf879UYxnVoTlSNiARfK4uzj8XumuZc4EzWfKYjFD0XF29P9OKjPN9RSMlTkbsnJ4nZkExCgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Stosj4/A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Stosj4/A"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b042ec947e4so164420966b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756738973; x=1757343773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
        b=Stosj4/Aq8oxFTo/ihuTjbA+4h14ygVQT2Vf3seTTjcfK1EGSTxLiJycvkGy4ZyMoU
         UuJxeAYE9u8W27b33iGd/Bdg8cFCGz/B5skbr9E/lH5WCRebN+rF243H9EE7OUDgc56j
         0o0z/j9f/kqJVKgLaDDaDw9jlvsUczS6Ncjk9alHAju3nvtIU8LVmgCDxE8jjs6jD/2x
         zXolOkwsMN1k5Mb3l0poWo2hHZxLaVzVU8biozCFy9xcOIfHMwbbep6S5ZTEdxSlUELX
         xpE9+65K/5q3c/ZK8xnWhTROPQoG39E189LT9qFoCkqjF0INIDFTs2Ec/R4UEa0NXk15
         C/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756738973; x=1757343773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
        b=Z7qe36uanVKnRQTprfLRcGD5EWZg0SEj4isncyxn7b7Fmrn3/qtzpf9AbCgTFzBUYs
         yB3tvgtdMqVRwrrgc3fG8hPhjx6jEsCLUWogi27kz/2Xc+LXfqBGGF3KtmnvPAgYxrAY
         1ZQKHk8EbqABRxEUZVGg74WrCDgN98DtIhdHy163Ovr0uUvZELh/3k1CRJSqVkQl4B5/
         J95Lre1/IDf+bjvcoEeIUHPr8SP5RGuX4ivhhxJ6P6yazpTX7pVHPtpAbHdavlPXMRoY
         nc51pPdzifOk+CipO93/jt+fzpEO0u6OT2FNRNsSFHEEoc9byiYCI4K5OKkPu1730AzZ
         w3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9zoAAK3DQxWO3kdWO3Oj2CnJFdUtlXIczy8TphPUc2XytxQaFz+FIEnx13wlThdJVe1/j60TO4yo@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaNGJPlQ5wqWNKFvXO5dzQ+opFNTwCM6eJOWNwTf0TNnCWl6r
	qTSimF5lY6mECNSGTKtnfRaiEbo1caAZVLjQF50cnbaUqdodpYZOxbJKVf2GazKBfEGOizrEhkg
	KzIjvWRsBn2SvNhFxyIciakE8sm8VFP8kYtOocJ4yYQ==
X-Gm-Gg: ASbGnctUOZ7H4/0Fz/2+57v6vHfVHBAIyYhsKVO+QQZfvmfXYn6qJSgZEDcgYpG8UHN
	ugTdTKIW1jKDAkX5FXveFtDt0GbxQwIyERsSPswnxshPrO2JXw+i0kedV7raxr1WHFp1nW8gYAV
	DOzEiEsYRFPvEt8opDfbwHyinELqLde7+DHHaZZ/i8aGpeXfNZbjq4IIQVXCiAFebhCZraWrylG
	R1/HUKxc4D/ZM3iJ14iofIKAiXGzXMO9dQ=
X-Google-Smtp-Source: AGHT+IFezK1h8zD4ulbO+LoYFx9UJvceg5e5MjfORD1cX6aK9EX6zhmOpTUVOQiq+Ui4qjbP7WefWWIq7O/4+eTMSZU=
X-Received: by 2002:a17:907:3d42:b0:aff:d39:e350 with SMTP id
 a640c23a62f3a-b01d8a25c91mr803197066b.3.1756738972529; Mon, 01 Sep 2025
 08:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
In-Reply-To: <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:02:41 +0200
X-Gm-Features: Ac12FXwscizWLWhMN1KX5yHTr-lGd0ZaL5gCF07LzPcgk8nWDqkiCbWTaVe_QQY
Message-ID: <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -int vma_is_stack_for_current(struct vm_area_struct *vma);
> > +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>
> Should this also be *const ?

No. These are function protoypes. A "const" on a parameter value
(pointer address, not pointed-to memory) makes no sense on a
prototype.
