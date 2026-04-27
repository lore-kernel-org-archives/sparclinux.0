Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315F37F009
	for <sparclinux@vger.kernel.org>; Mon, 27 Apr 2026 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326454; cv=none; b=gz4zRt8TVPUVobS6Gzae8DyLem4C9FnicPp9fcyvjYDmx5eRQI4uWUC5Smrfnr1llKJCCX96OKPrDha3eLiVGLZT+hIA/01l7wwH8vhOPicWsbG7jiyzxUeoK5ZoWRSqloUuHRjGM/BMd5S+rWxVfcmtr2shHX9Ag/vJQOektlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326454; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq1btYLHAomhahWi6Cv2LbYGAhqmrREgN9bUE7SPPWU/BOQqUxl2xNX1O1Xl+mmJIFa4LJOqR+8HAD5D1oRkcMaBJ2CN81l8ByAdIoIG4JQdurS0rRHBc9irHfTwnUZGEJ1N3PN4bsOCPEOzLHamLovRwxVhnrW/QXE2c/IW77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aap/nStR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aap/nStR"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5634576a12.3
        for <sparclinux@vger.kernel.org>; Mon, 27 Apr 2026 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326451; x=1777931251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=aap/nStRZA7tMCfWTViRBLcrZwSFuSnL2hh5QepQpYNOJ+0KXqWzGSuzLNKHq64KeT
         Sy6ADTWYNjmAIr/EI2zJcY5gyOHbaPdp/Pi2wPGJzdeY6fIvwfA5mNkyW6b2l7n66wJI
         QsLEe4t4DzE3LVE5Of5/tF7RXiAYhEeIw3+BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326451; x=1777931251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=M5TkFR6JWXOurzpVyKaPd5coNx+h901YBrJB7UKKGs24c29qZyfHcfzZFWxA8mQhby
         Ll5OM2Z2e6Bx6ZfS53FCT0rz+UF17vtCLUcwgn7sBwv5aRajmYnIyjEopM9d0rG99yP/
         ZV8LT7jclrFjWdYm6K10NVvcc5L6I5h5LfOxX7spbb3YSJar+86HOlxu2Bd4rqs91NJz
         c9R1+BjDxlGOPpk/DFX33T5aIzc1lLjYg7JWMUu4Z0MZwXj/kdjPt92pZlAJ+MopOe2H
         Zh2rSEqGYAx+byVeQ86CKGXcGnWEacri94wN3NXQJEw52BVoEjRisFgnrfWk2TVF+3MX
         gLRA==
X-Forwarded-Encrypted: i=1; AFNElJ9+miugPLbAC/dnwqHDDIYIgXM1iY70YJh0EJmf0WO07Vyh8UPAs6BeAarupeZqwT+W8tqpS6U4GiWD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5pGhK4bkZM8JshnEVq9cKGzwkN+s2CTJ8q+aY9X25W/kEAzM
	Tw8qLpNk2h0bBV9Va1bdNDz9+DqNnDtsFxxxx9fzkEvU7NbH8F+xSqGeqOamEMLHF9chhiGxkva
	mQMetCE0Hdw==
X-Gm-Gg: AeBDievkyvVe3Unq4O/9Ec5j2GlrKSurmYrMKBaTLIHnD/Tak6g02yYAEN3B6+mc7GT
	5io1aSp60Nk4C/ZyZXjxmhIKyLCETNnJmdapbEJ+1C2qEBQ3/CHAOIZmukeIa+BCtbejWzJew3M
	PCR+WUWfPetuATALVXdbsZqkKciaSCnoG0CQ05BAt6TCOaUNJzFX+nrZvtQs31BjePtxzatVrYe
	+XJqiZl1B/aLFxb/2VJVj2NgAQYCM/4z9JQ5h8b+MeSvII5g6dwtjylOTrTQzCTMMFvyNcp2tNc
	l5350TZHz+ptxtU7tu7rpDhMOnaumgixDnQ2675VflNG4p/MQCp1BUZk4ExJ5cPIzMW9KAF/dmS
	4d3OTH//K3+czGDAhM5+4iM3D5xUho86bVduQjY4xx36rGuZ8CbsQ7ws92r6Nq7S+4zQU2PPJcm
	p6ckbVvePN2B0QC4D4cS0+4t8VJaRJzs6skYpqwtjt/0j4x0q8NymAgKO3bI/t1J4eyzZJQt2VL
	tgwMFRJgms=
X-Received: by 2002:a05:6402:1f4a:b0:66e:b9ad:9669 with SMTP id 4fb4d7f45d1cf-679bb09a369mr148908a12.21.1777326451390;
        Mon, 27 Apr 2026 14:47:31 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67638ccsm165619a12.0.2026.04.27.14.47.31
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:47:31 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so6521489a12.0
        for <sparclinux@vger.kernel.org>; Mon, 27 Apr 2026 14:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZjjleboMQF42M47cF9LGeNSkeUsCSVFRjoz6lgFi8rb3BRSRtT8iDGoShdCwH4IdirX1UeCLbVzob@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
