Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214A2857EE
	for <sparclinux@vger.kernel.org>; Mon, 27 Apr 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326747; cv=none; b=rNoxuoTeCR1a7jsw/VRCw4IMyotvnZ5WBUaLf4IVP5EkIc8rXeQtgTF9K+oGcWrmLX0m06WlaIaOv60a8FEU21+2G46VjBsHk+FGj8PyN9zp0ZkSAfIbXhoJg7zDMwspMwrsuSsWSVsTTyPcyKk030n8MEnGxQe9oAVuy0fUYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326747; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUg+bkNz3PNsID+LqtvEoHE2Sur0aNQjrJ7Tb7hwgiHTv/0J9D0srlCj/pcrFuOtmyuCZYrW5Tfwvhhryc9xwNG8nMPoevANjUco6/UoLFgbVsasF8SicespU6qE4UUG3QB+a/n7+XDeoDsr5nGtPh3IMm3/VYsojazh6nd8Fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KMbVx6dF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KMbVx6dF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso1581253366b.3
        for <sparclinux@vger.kernel.org>; Mon, 27 Apr 2026 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326744; x=1777931544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=KMbVx6dFZM9arFT+vWwXgJNIDxEsaYpVfVTVp8ZNJudkD23NzoKEPfV5b4l1sVHDHy
         1E9VJHF6LPvCHv1nlCIip2g8hx/UIGaqcnSSh9gHSyUdGOb+ljfRE7VPgFqKrbiak5xZ
         IlQdbBMZLahNFmE+ZA5y7YjiZhR6Z6yg/mGic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326744; x=1777931544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=PM7LttF1bi1wAzusxUxN7bCZ6X7C86rP1TbRbtwluh7o0Inc3tz85kE8VkMHWHaBSW
         AQwHPKYpoCO1Lb/zUJDGVf6npHFkGj3VLnqYBOFvOlvDs60TCvi83UK/7PGXljzIntdF
         +bBP6Raail27YjPIMd9jxhq4VAj1izh6rjxZVaMP1QZxtLXHFMwYpXtSeF5AczYU80zx
         tDIxftnHdVtcCvQi147rLe6ucqT0PYYHxuWDWZz1ZfmOHCAvYfoopelXB5n3lQy4Hejm
         mWO2gisNvprKrYZ5Hfb1HSFNqKSJ+bhFgvIL7Sg/U+BfbMdzq933uVwOdeZYhtMJoXmn
         oMfg==
X-Forwarded-Encrypted: i=1; AFNElJ/6JLwgGto4BPZVctXgqdjJ1TfrguM9dn/Fkymtp0C0WPUfv1LItqHDDjNNiMMgc98KClAIbJQAkQmt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9YUDCF49Fm24B6S5RVkjtFzSc3Yc6NblUt67krBmFuC37pxf
	HadGPYXgovARZtP2Sz/FPapC7dv8HuuCVG8hiHQLpF147B8oM8rfnSq0QRUbK6wQQ0EfU08NCQy
	E7Thi5MVK5w==
X-Gm-Gg: AeBDiet4dewZaGSPZHwfr87fSkYDPhI5pS4tKG/PAwBiQeiZ604MtugJgOTT3yYM2cd
	IFvtNTQl59fWmGf2ss1QIUjSFkzn7AWuF3nUuKnG5gOyxBqV+fdbn5TuA/CCe15dYR/9r0Z+vSr
	shaaOjIVnj5KIBJl/RmeqPALN1silQGPc5C+tRhgvnpqbCsxXEGAmpdVUte6gj6DXQbAPDLH5b5
	q22HyI24arlYgTy1MLN36sD150DLg+iuzron27p1oJZkAxQ6G9LhwxyGgwiJGQB7EUmZrnNwqZP
	mZQEr5rBJmLv8AiTU/A96jhUyVWYPMgBo7C9ZY1/zYXRQxMpladsyO8ITkAO9YU46s0ilgZbSC8
	tVxcPAHygP13FBSwqxpNCaAE//ZqXa7IPeYZD4WzlA9XDlatQiNLrpQoMZmILAlaOoagmilrDmx
	PcYiMxm2M1KESgpT9K0jqNHjsJJ+kbKlFWvyP2JmniM54SM77egL+taAlKEJnKZqLPZACH2rlVU
	45u62AzrsE=
X-Received: by 2002:a17:907:a781:b0:bae:d7ef:de56 with SMTP id a640c23a62f3a-bb80443e602mr28862666b.44.1777326743893;
        Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2adcf1sm9947366b.35.2026.04.27.14.52.22
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9392459a12.2
        for <sparclinux@vger.kernel.org>; Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8NxRgOzOj9ISGu8Ox0x0+fPWakyTRoXCRq6bZwghF4QyxrLcx394F0qRQoYEEcBcMJq6pIe/qOlisd@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
