Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFF22D9E9
	for <sparclinux@vger.kernel.org>; Sun, 19 Oct 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861465; cv=none; b=RAwJGiqP01Y4VDt/BSHnbWRVbutxGOAlLS7FP/SFFf9Ff9yOOANWkDJo0MEnn4JqfKQF/FCHT+3rS34oeDcqnFAhuPt+DvDbW7BiUfBG38WqLba5QCu7oXeYzX0wBbjNK0qOiOFmTGro3AIUKxO7ZcYATLNTvzXHiwn7qUidK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861465; c=relaxed/simple;
	bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mczsEQXFw8qQq8HZaCIfctS4HajXvKxCNaj9Txb4RXOX2MqI7foynk7HG2xI2bL6hdAN/BsSzbuhdu1SVyZXx8gc5dDMFwdhwc6uSkq462IOhMkji505iY2JbwEz1o5phzIc3OeFX8aLcREGfa2NQIgBy/BLJha4WQuwqTPO114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccTdEhIo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccTdEhIo"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7817c2d909cso36853587b3.1
        for <sparclinux@vger.kernel.org>; Sun, 19 Oct 2025 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760861461; x=1761466261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
        b=ccTdEhIopdhypwI8L3JBil5M4STne8SmRaQFfCBM02l9LkTDCeY07VksMZS734XIYW
         fSr9E0vMaFgWvM5hpUfvHCdQwXqN1rLdg7uGpCmcE1a8p73wsSFiGM9KgaCUVorU2bB4
         QXlk0k/rKjfCpslj0HWJBncYE9y9o12Mjtf9KUBJxsuzUFBzDISvTP/UdlOzuowk2O9I
         i6m0bPW8oTEyUXCgLGFGHisuLGD8VhQ1MKnYlEu61P8OxgXOJsE/nO9c7FNSYyLg97yE
         4ySn5cXO9k6TDK22f8AGkED3Ks52VuOYFicnSfjIjvJlszMjZfsukHxg61ULY8iC4TUN
         9kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760861461; x=1761466261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
        b=JYab94WEu8X+s8E2i/SkRsyvPT66FcdyIK7byDmr+x+ZuammioPAfG/NVbAEj6NaRC
         06f0O3TteuuesWbWTeOKk0zuzDvK+vED/YKwVw213wjQ0NopI6PgM8XkZKM6YWjVAtK3
         /+NxnV83EVIZ4NBGYoUSt3RjYn83HZUCYGUHEmJZWLq/Dd1xlDahbjikCysVaToNRA7l
         aMsXtCoeHFL0T4zNXiwqRBObm/aKN3vf7VW2E6qozogVqKrMbadZKvJCQpgykMtxRDWa
         1eMqfHMKWYazMUbkocl9WEMZZnK2TnrdqGP4k9IKkGbcToznSlhCMQSNEAueAuckClnB
         M1YA==
X-Forwarded-Encrypted: i=1; AJvYcCW7byvP6/lHHclW3M+BZpobtd8LH3sF1v/ggjxTTdLhDqpl+jUwdiNaLYf1B9O3nesyN/3XjREZ3m1a@vger.kernel.org
X-Gm-Message-State: AOJu0YxWn85SHZVA1al0JTLWdHVSp/hxCnpeiIynZoDY9X5GO42smhG9
	Qbth5ah4A81TR0AFCt5xHvwNq2XYl/bgwepG0MEmlbnY/WNmdF7m+mwFXexuvs0qSz2Vi2bBtCc
	2AlIgg2/AjNrhVt3EISaji3Vzl/Wbb+0=
X-Gm-Gg: ASbGncuYGA2p/HHxotnMzGcoyhEFuL70p1z2Dg2QTw1zLGtwnypP2/65bnYo/EqWk20
	/ShHrv9/KPpTMckVDBtikgThzkFOcRQwcatfgY7nMa5uM749Cy7Cyq3GaeK72zjhijkIvryKzRJ
	cLQknqpc0uOHEPbq+l1oZVDBb2HQni2TS+AfoH0k3bBLvH5sJZ65DXcIw39ktHo5Z9ona2O+qKf
	790msa9EBZ18C36zysb72hFCIG9Z6jP9G+fi0tvQDGvzTwzMNczk/+WZVQfwaUbocvO0U8odNQ=
X-Google-Smtp-Source: AGHT+IEDp/usYEtVSaz10lwwm2/rh8YYcBuxag2F0nuBjSfSMoio/EijPl9t2f1PGKCDHr/mRoxnx6oC2CKJ7h3r2Ic=
X-Received: by 2002:a05:690c:31e:b0:782:9037:1491 with SMTP id
 00721157ae682-7837780ba2dmr109813007b3.42.1760861461100; Sun, 19 Oct 2025
 01:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202010844.144356-16-ebiggers@kernel.org> <20251019060845.553414-1-safinaskar@gmail.com>
In-Reply-To: <20251019060845.553414-1-safinaskar@gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 19 Oct 2025 11:10:25 +0300
X-Gm-Features: AS18NWAhDVf2aU8hB0qWERPwO9zi-ils_dPukaoQchmqqRauvEb3B93Zz-69KFg
Message-ID: <CAPnZJGAb7AM4p=HdsDhYcANCzD8=gpGjuP4wYfr2utLp3WMSNQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] lib/crc32: make crc32c() go directly to lib
To: ebiggers@kernel.org
Cc: ardb@kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 9:09=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Eric Biggers <ebiggers@kernel.org>:
> > Now that the lower level __crc32c_le() library function is optimized fo=
r
>
> This patch (i. e. 38a9a5121c3b ("lib/crc32: make crc32c() go directly to =
lib"))
> solves actual bug I found in practice. So, please, backport it
> to stable kernels.

Oops. I just noticed that this patch removes module "libcrc32c".
And this breaks build for Debian kernel v6.12.48.
Previously I tested minimal build using "make localmodconfig".
Now I tried full build of Debian kernel using "dpkg-buildpackage".
And it failed, because some of Debian files reference "libcrc32c",
which is not available.

So, please, don't backport this patch to stable kernels.
I'm sorry.



--=20
Askar Safin
