Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314193;
	b=bm/cSmNqNUNF7/n7I7Vp1pT9bOxr7DQbLJ+C82134GualynVNLp/ywHtJGmCSzAyAONV
	 10HJBnNJv+MvP1jywndIBrJ/in7swH8dazJ+qnHqtytVmhrDeYHvW/9LPOdet/fKzvM5P
	 42EEjxgroRgAv07e5p+EG2sC2FtSGuqfm+jThUCvFCpuUa+sdXOQXIzBe9GlIx0DxnMa2
	 E38UXjhiVJL4f8HQDmzjgPEk5YaRgGHJiFInS7uGKQzK5OYPdJ6eBXk8yX2omq+0adLKZ
	 tftvpCz2BofklsoVqilJCVxHOwWE+WgcX+Qo7oSfXHCkprl29uJFpNYAqMHZD9XUcaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UCyHUDojeaiawZobyhmexXtTH6dNWwo2NHOImjmL6Ps=;
	b=PlV8juCak+RBfZVwjIR2HgzqALJ/ongd5owhP8O+jY10P6G/sTV44d4gcAxhwR+u32Bm
	 bcb1w5ugoLkDq8mRv6zCXMMXhqDrgHJUdDJ3libYlsjmB//z0cN93ylMsuvB179OtuDX6
	 6jum5wstZKJ5ESCYUnEUQe8sAsFVqEvFH9+RYSvVuU1MZxFroU6Hdg/UFVys1QveBoJ4T
	 xRnNdrWr6Dcjl2eoFC4ZUb7cxphBgF+Wvm9wH7udE9jysAu9Jvf/M+zdakdqyqtSzjZYl
	 2qEx8EpcOwBC0RDJL2C9djYwXubdHcAp5eU3U5Cfi1N1n59wfXcZcJ2psv82f5qsBhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=caUfpwgl;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28792606A31A
	for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 22:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28792606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=caUfpwgl
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so77508a12.3
        for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793314190; x=1793918990; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCyHUDojeaiawZobyhmexXtTH6dNWwo2NHOImjmL6Ps=;
        b=caUfpwgl/e8HBzC59AFErdM8hGazYLXT2QdVbkWpWsq7Nkenu8zmNze1Ei/JGHD5fB
         eDELYukTjNongDyh5Tlh3kARHJQ7C1R7EQ4FqmDamXr4xpiOwhjaHtemE+NDpKfE9XHD
         C7rod81pCApwL2zjcEnPy7+y8n9hZ5/uGcbm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793314190; x=1793918990;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCyHUDojeaiawZobyhmexXtTH6dNWwo2NHOImjmL6Ps=;
        b=2t+QteADAyKVIVqwOORphH+rMjUPtFuP51hgTj7NGmVvo9Irjx53tGz024id27ko2I
         OXWRThFTvWv5UngG9CE2cr0o/wBYbisytfQQElieu1amxi7q31n+Db8vwjNz1ucmXRWK
         G86l7a2MG4HEmLMgRavZ7GLyjkaWDBigr99Ns+YOAb/K3yOWX47U1cHMYCDQDoRDiJ/l
         W1djlCgrH9369q+tOpxsaxmb/D7NtR+vtoGZ1jZ4XoutXCdACsvWKSQj0drg6YwxCzHv
         P1gd4fwzyVoO9QUBAw9r9tU6uXBWthLL+OtevBkhUMriUdwhDyK4oJRVxAP3A1qja/L/
         z9xw==
X-Forwarded-Encrypted: i=1; AKwUvBwwNdi39uX5IYhBcloQU/WDcHUjRmLvAcNs/cJXowZTF+3pvt27ilD/+/dnJka8DkMjzwh8SXYPAS3i@vger.kernel.org
X-Gm-Message-State: AFq9FYIDE1m7YQuDfHng1F4RCu+ib0oGe5p92hqYh+JYTdCozlyo6ObT
	LVkkpB3RB5eVI18RcHdoIVUrJS9d0lGm+prLcCwmJqSg1bUtBx3VHX80MZXjcxj39rFk8ZMcC0j
	hA7Xb1ogXuw==
X-Gm-Gg: AYBFou0+VppUuXOyxvtoRhZU4Z0pIvmNKvtSUMVBgfwmUSeTqOq4PXLITnZEkKStEOH
	84oGflCnwxGEXPj3Q161Aj8ljPXCwa0pirOOUD4StF8uFkua8UHlYkVRizSmcHkFtFFHy/ZaIMO
	Hx0nAyxsAxfspd5G+UOtJccm5d2Bbe/zotB67W/9Xbpjm0WzDGvpUM09HW7GrHYt10f37EmwbnK
	SM51Gw+61Kpm8PxB2uA+DJtxCU2gIFoK9AHsbq7C4r3tCLObaFYS/UsKviPa1E3q8+NTvQOq9h/
	sFWEbtLjSmwcRS/4QHFCXHskoyE1bbYqAm+YAImHBuWA5LSuJI/8XEzFHRS5qsas7QLpa+KxZ4G
	yIxTtUteQrLZ3RZzsqSRujFpYIgYxmDvC7rSHXHtiLuqRm0dw2rKhEM+mBVai5y8sd8Jo+azbkZ
	kmz3dTlnGK2XP2yczWIv6Do1P9ywoyX5nl5nak6LHQ4q++JDIQ6oHNkQD7YdhClbkRFgk57SXRl
	C5uUqo1UguYI5Zt3F0FTKqpPSPlBFAcqYlMEu6hiP+oGDfZEXBA5Z5U+dTb70EQB+BHrp4wmFoD
	lpwnudyRzHGRL9pKlaaAn1P3jWGjgMrwEClDw+q0CevHj9BnIy4rJ9ZApqKd9ptoFKJXbLEvHta
	O4UY=
X-Received: by 2002:a17:907:1b08:b0:c41:835b:8f24 with SMTP id a640c23a62f3a-c4ca7adc682mr41742766b.49.1793314190357;
        Thu, 29 Oct 2026 15:49:50 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b1c592sm49080a12.25.2026.10.29.15.49.49
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 15:49:49 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso107582a12.0
        for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 15:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYdJSM+eEQfNaNxj9omGGhucRdGcrWQJ3/lbLITG8E9vvAyPSeFU84LoPsk1mWQImWC/zgPzzEkMSK@vger.kernel.org
X-Received: by 2002:a17:907:3e22:b0:c40:5ee3:8698 with SMTP id
 a640c23a62f3a-c4ca7a9ec9fmr41675366b.31.1793314189653; Thu, 29 Oct 2026
 15:49:49 -0700 (PDT)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
 <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com> <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
In-Reply-To: <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Oct 2026 12:49:31 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiXTPC_jJ9o7k2JGVwA=F5_JFt4ikY2J4E69xJqYtAFGg@mail.gmail.com>
X-Gm-Features: AclHuK8ovhjIuw_35KXUyLPUI3rgCa2BuC78QWMpFkG7i9RDHr4wcqAe8Ud7n1E
Message-ID: <CAHk-=wiXTPC_jJ9o7k2JGVwA=F5_JFt4ikY2J4E69xJqYtAFGg@mail.gmail.com>
Subject: Re: [GIT PULL] sparc updates for v7.4
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andreas Larsson <andreas@gaisler.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 22:06, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> If you really want to modify an old commit without touching the date, you
> can use this git rebase command:

STOP THIS DAMMIT!

You are now telling people to LIE about what they do.

No. The fix is to NOT REBASE POINTLESSLY.

And no, adding a "tested-by" is simply not a good enough reason to
rebase long after-the-fact.

So stop doing bad things. Bad things include:
 - lying about commit times
 - rebasing mindlessly
 - sending me pull requests for stuff that hasn't been in linux-next

And if you have a *major* and actual real reason to rebase (completely
broken history that needs to be fixed), it should be mentioned and
explained.

Not hidden away by lying about the commit times.

John, wow I don't want to pull anything from you, since you clearly
have this completely broken mentality where it's ok to lie about
rebases to hide the fact that you do it.

     Linus
