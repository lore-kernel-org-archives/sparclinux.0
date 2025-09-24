Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3F27B34C
	for <sparclinux@vger.kernel.org>; Wed, 24 Sep 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699141; cv=none; b=srm8P8p1/7SSt/JHLMzxY/0sOq0n0b3BiieaE2tCj8fwJgMkJDE09JqEiL3w7bX+UhFVlNjDzwNehosEoK9BD88fu5K5o8/IlavVqzAcP6SILMeu7P4xbwNGp9tCIsofAGIs9DoDR+EdRsrmyqtb8wbPE0UfYT8Xtrexay3jw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699141; c=relaxed/simple;
	bh=TX6kI82yO/RlICOevJbAdNu2g5LXBtW4mVT11ZayfNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwFj4jtNjb95JXZG/o9imm8fMkhSPlzRX7Z+OxJ3dagUpvHlBWkc3+1KcfprW7x21kVmYW9zH9ojQ0UPTB+dG0EKKrDk9AyMLG4E8lBWaOQGGxlbMnT7VsRdgMSNn7Jb/XG62jjoipjlWAiqmotNuCshdXXX4v8pUI9Uw04qEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apr75Ugi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apr75Ugi"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso9705327a12.0
        for <sparclinux@vger.kernel.org>; Wed, 24 Sep 2025 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758699138; x=1759303938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ogATJZj1jG8raAY2zUuQe4EmJHk/4W4xvGLcmqNCI=;
        b=Apr75Ugi6SUfNBAH+kYzUGDTjoRx4+4tdqorCAQPRdi6ZhXxBv0peiMsD+V4puAl/L
         VnxwZSNbl9FiKKvSAqE1eYwjqdZWh7FJCNF0dlJCMq2k1bWZYIlAjQgIervtcnAm3t8B
         GN105YKAWQyS6/Cr/MiE0AtzMIVY2JD6Cl6oo5pZJOVanYffCW03eXtoB23UbA49jJ7r
         M37tNlpRwrjn7OtFzfza/vp/LuwUFXCQHnS9le2rzn9s9XBPgWtVSKHOOn2Jak7mhDnY
         wGqCR0eC89eG87mkj1IyXNs4+n6M1Xm2c52C76N990iZ2sIOpbDuxtQDSZpysCj2x7fQ
         cVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699138; x=1759303938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9ogATJZj1jG8raAY2zUuQe4EmJHk/4W4xvGLcmqNCI=;
        b=ae4bQtsH4/iboCtm72h3dKYxNAlDHZJea2fBcsmAEBFgnHLvZWCFNdwy0CVC2K8aY8
         faO9fcjSeTHAX9MbCM2Bgu2MORBajwGD3nkGkIU3DF3Zj9ljAKIjl2wAX2eD770+Jx3P
         q6Nw1p7tYlx+mkUXPJNyWlXY7NCblGT2AWYDfyKwuquvH/dXHiQhNxIlzu1nF2MfY+mF
         HJhFqAdMIaqs40y492cnvX/0pjboUv9B4HtSXLklY9U2xgVaH4bagYQCo9mOyGyRU0/3
         Hnqb7DQvlrxK2U3w8N2uAXn6AnqxIau+ytZOZWA8yd0ngBw9UEpuInqnkJa3MCupRVAP
         fQDw==
X-Forwarded-Encrypted: i=1; AJvYcCW1POGXq3DDXnVvmLwd6YM8oF/eWfhd38M9P61JX8lh2iP9tJlwErCk51sxcWDiaAWCdZtDJxhXd060@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPPe8GG9t5yGQ1Py0AaKF08SBEnVldEpti4hVUr0FMViOZpbe
	Ts5yUHlGjhy9wKWi07MnPxlL0AxxCwdG7g0hiVGGZ/Jsc72HslUp+PMey7mY1lwxAw2I9wONdZ4
	pY2O7dVNlGWD9oxmDtL1MIlcISWPmRJo=
X-Gm-Gg: ASbGncsRh+s8e2dUxgWMVLCuJNQqoiXZHHxGx7jsJ4P9IgRZMvZgwNyOczEMjEc226T
	p54OJz23KstOKhVOa+qKgVGh7YfnDtpkZHGdLT/Iqrc7VfxV5mZNeOvIRBdMZsVcpdU2MN/Y9jA
	OjKA+X0NFHkB5+nWPc9HniiOWXrJM9uzzmfaO7B3/tJtbmrk6vZquhdni20W75LfrINPVlhmbPe
	yZvqd2W
X-Google-Smtp-Source: AGHT+IEsD22J4a5V9bbdMWtQv1Ep8AmuRuA2KpP+ndq9VMyD7XFtjS94kSm5rlJirOSxMvazqqoNAsq4GX/ON5RyqyA=
X-Received: by 2002:a05:6402:44dc:b0:633:4726:a077 with SMTP id
 4fb4d7f45d1cf-63467796df4mr4258422a12.15.1758699137992; Wed, 24 Sep 2025
 00:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com>
In-Reply-To: <20250923235318.GD2617119@nvidia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 24 Sep 2025 09:32:06 +0200
X-Gm-Features: AS18NWBrVH-9-wBlZ7ZFV3RxYYp-7iSL9DfIPq4jDzU8rxFLx7xmKKzveUA49as
Message-ID: <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
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

> Suggest testing the same branch with the alpha patch reverted just to
> rule out any issue in the core code. If it reproduces suggest to
> bisect Leon's branch.
>
I can try to revert just the patch containing the alpha-specific stuff and
see what happens and then, as  you say, maybe do a bisect from there.
First I'll just try the same kernel again a few times more just to make sure
that this is really reproducible.

/Magnus
