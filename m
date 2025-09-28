Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D629E115
	for <sparclinux@vger.kernel.org>; Sun, 28 Sep 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055043; cv=none; b=tTWsPcn1XJbcTSOCg3tZAbxF3N7hc+NE8UL08wVdBkMTe8jbuflGepcyYDgmOy0vvFmRO2KoGmi6dVukVpqo5lv+Y/neyOjtX74Shc0jXUpVytWt0HCIUEIjzA4ULARxkDAzINunT4WLE7ldPYRPZwQJQ8wH91LA45QstX6LijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055043; c=relaxed/simple;
	bh=D6IUpv1N1uqZnzwjcSW/CDPKsLpnOn0CcSzXGCV/+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkfhQPnnlIz+6CN1k7X43Xg7DPPuITpEUfQJ3M6Nybo+aJnU5zPK4NfGvhjMlFYM5aQV5KVkBWQDv64g9H392BqzbNls7GYiCwcRIPd4a2Vlim2RZloMVYsHnrlDk3gEKq0WyJvOx/qLI3Ga0ZUF2o2WiCZFBdo0i1tcsg6t9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/XX24QA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/XX24QA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so7349488a12.3
        for <sparclinux@vger.kernel.org>; Sun, 28 Sep 2025 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759055040; x=1759659840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=D/XX24QARRVg99CyYmaO9aZB29n9O+hNxVas7M+YzXr5W7iyod8yNdTxpmyrKOV4SX
         DIfaJZoYKVQ9KEXkBdz5AID/d9kdtcD7ndQNhTpu2Xk59V2jhcI3OpiXANWBXkrz+eQA
         r8DCz+sL0/yp3fEIavbG55VbvrNwtgV74aMrTXJ0BsTwNp+PDCQLEAgygdChwzwpWktJ
         /x2euhGfuhI02XnIa6MLzSDchc8s3K0CZl1Uo7vNt9Bbnj4MhMEaBsWCOGFnjkpTYuZF
         AWMV6ZS36p5oLtbP9Leu83seM5pLLPG5rjgV/nKptnplpwcVzIdTjn9sAsWDQ/reRqYF
         5Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759055040; x=1759659840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=BJ3XLQLCxMBycb0j1m9cAkHisU2KnEryWPrihu8SXvegTgr+L8s9C2/1RbFYoo5gKY
         S+woQ4hDjPcrqgEN7fkPNHte7itLSkmq6eCg2EdWtdXP9qIephGRf09Utd1IAjysyix6
         qE/HLAGoVteeYozL0mVOqKLJk8yiwV/ApSF9SoMbe3dZryjpiuH+HLYbUeDZ4z8NTyTq
         O48OAW0AQz9TNmLt6YOFxvsf5fxdKGFdBJQZHKGFEEij57/Q4K5+X9VH4+7YB1E5I4LX
         W33c0lKgCvlBRn4HYTLq6W5B+TsLUyk0g1Mt2dwCtyr7KOZSA5zOFXX2akCaryS/X+aB
         x3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX8lbe3GlDTCtI3UqW4xcy29Ll1cYaHLEBsu68fe8dJjanxLSYdkt18GKCueC3KjR7qh92zNqVW3+WV@vger.kernel.org
X-Gm-Message-State: AOJu0YxiD2b+zuuJIGdWi+lJgbj22DVa77WTNyY620wX8TRaFnXWMyA7
	gG9yg4C0iM7v7+ne+oseXeuqmlAtTwxe/tJyXDpJ8rZTiIPNt9x1SqMlRh5XCWeyNCsQN7UY/gf
	QTH4smuhsiBMt1x2uJbj3ZolEcpZuYtI=
X-Gm-Gg: ASbGnctjsAkvQYuid5Mqa2GVoOWCZtyCoRfsy+0q4bJutm+GjF4ZEwhb7QIZg+bXzO2
	Zw9D/ELPKUKmKak6Bv2ckDpaxNRxO7HekQ++lXdGWaPncEvZXw9dztJGD8PbuwL8oy70+Mk1RF5
	m1yUKkVlt0hPHTVFUGpUUPXgpUFd7mjpM28RjtgvMy59AsCLafYe+K+5hWzXzJTD1wzECA2EZqy
	JINke2/
X-Google-Smtp-Source: AGHT+IGAq0LbOWTh24q9bLB+mXJC5ix6EL+ilnN7HstffL1oa4ImYTxpRTBcFvmhE8oxPjiGws6tJF6LzW8U7U3nO24=
X-Received: by 2002:a05:6402:606:b0:633:8337:da95 with SMTP id
 4fb4d7f45d1cf-6349fa9f661mr8379897a12.38.1759055040002; Sun, 28 Sep 2025
 03:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
 <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 12:23:48 +0200
X-Gm-Features: AS18NWC4Nb9W4XCpYP_OV5Q9pNZrLenXw3hzv9kO6uALa6_OupoUAOrEskTs214
Message-ID: <CA+=Fv5TF+RTPEkQEmVd0_=B9xbqKycLz3ck3UwcPDqacezYfFQ@mail.gmail.com>
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

> After reverting the above commits, I'm able to build a working kernel,
> that is, no filesystem corruption occurs. I'll take a closer look at this
> after the weekend.
>

Short update,  It is enough to revert the following commits, in order to
have a working kernel on alpha:

e78a9d72517a88faa6f16dab4d1c6f966ed378ae
(dma-mapping: remove unused map_page callback)

d459e3b80ad1c81bf596d63d2e3347cf8c7bb0d9
(alpha: Convert mapping routine to rely on physical address)


/Magnus
