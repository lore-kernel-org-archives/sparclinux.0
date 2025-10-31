Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857533290E
	for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904298; cv=none; b=Ae8rnP2SSXDJx1NfgzkXA+QLMWLu7OQnib/4sUXon7CFXGls427mRi8a+ngU4TJi3DY7E+bMFOttHNXhh72IIwR0O8lpgoz5OIbonYvfu4Ym2jSCFXvHAIcq+heJgi1pTDK8NwYX3qfjOCMcbGcIXD5nlhudR4Ict5ezoIMM3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904298; c=relaxed/simple;
	bh=RwoS/PDm0zxnUlW4Huu6pywDv/HskMxqzUb9B5plkDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjPPltZrOY5qQrDxACIyEuDiELhYkQ+43jyDOBEnhuND3FvYO4ibV7hbf48JuZBqtbT2MQofmLij5QefxCeRzoJIUUiOhHB8oKPze3K0mXuNlfQYl8o4c/k/hoGggwtEhmUalzP9Lcmz0BzSB+FNYTAe9d9WTMUH3KBZIADzDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxT4RJ95; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxT4RJ95"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso18421225e9.0
        for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761904294; x=1762509094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IQtVhF5z2Qs400V3EordEf1XdwEv4+Wc34rjUmUuvY=;
        b=gxT4RJ95rehUKo7kmquvEjbm5CIUe2zg10bCdu0yBv80WzaE1vWnmnVANFa/gwPgDl
         P3IaT/6VVLGZ+fc05r8VYMJBomKGRow920LnwPRZ9lk7dKeSclCxBLwiju34I/7tFlBj
         3+Z712Fhs33j7zMLvmWjYiXwAK2F7mTCxt6/trz4Bqh64ALZ4B61ZjBo0uuwt3foE5AU
         t0UiJ81Om6aLoswj0i400sE0IgLYf47gdZWTLyCfxlGvJmsAGZYd3/kyxzdFy1kRkHp5
         +TpFplkswQcJO5dMRDThmXNlfRI0EHIbR/5gMC0tD1HcGKDEuSfdikaw21qSEgs5VXdm
         eQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904294; x=1762509094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IQtVhF5z2Qs400V3EordEf1XdwEv4+Wc34rjUmUuvY=;
        b=NKEeXAtn3iFiocVqWFE9S9mpmbAGtWlYcr++Kw9hE6fVnOUIeE3Z7M9WBi0DsEyz+B
         e0a9XydRp60XbxChuyIN4zs4sLSUlbx3SubY4ZzmA59NJOjcrM8QFnUi8p3X1kg1ENHH
         c4qyS8HLAhR80hRViZ3EPXOnEh9ptSPjqYwf/OLCqyqgZxzqPecln+ZTX39YmV1SgNif
         tx7wgRzQ4cdUvvIuE6h1KDmjLF2pEK6nTfA+3KJKcELJgR3CT0b7bLwXrEEidMCiLHDz
         MdGvxLrn21VcCPXJ9P/U80qZmwwjbqQAHe3quv5Lw8WGyfae9BlgiIPz4P+zx3rFNvga
         WakA==
X-Forwarded-Encrypted: i=1; AJvYcCWb2W6kz1DYn7/UXg9vdpzys/ljSpjG1KHKbgbHD1fmCz+4JrIPCLsL6DC8GM7S9Ct7ec8MBM5ZLkOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBJAGhh7/nDcovGvKk7WMq5dYqw60QHwwMaKsmKSZhr8iL/JD
	6XKv2DMR04MRmSIHMejVym26yr5/JGQrg2nnCYKQjsL5Ms8LBQD4pLe1
X-Gm-Gg: ASbGncvBZ6WjSRArk4sgOjc+Ts42d+5qXLLlIBlpPT9cw8BckC3TA12Wda1UtU85fgA
	1/tcANdyrEFkjRa9wwnfScV7dDIkANVP73W632n0hYs+b34NtpcUNnsABGBUUZkAcAqWjy3hH5B
	v98WpXJcqtlnz8LFCo1aYQGe6cSnu5jXbgB/egFRukt54mW3VcCCnjlUgP8jsQ8+s6ALsg73rQi
	MqsJ2r2H8SZyEewZdOgpoj9OOmTbyTy6X9PIrIK5bZ+8Gm3SKLgr6Yz051BDIUbwXl/N0hYVgDH
	X2jjXqqc+Rk3Colzduh38ayKNUZ8HI8NFsAAAeF7XIu1Zl9beB77g3oAkZ++aWORkHAplzBDnVk
	igm5TloHt2I2/mdFbFTe8GB6f5s/g92DOnIm06Gpb27wdN5naF3Qn/Aydcns916n7+hERTh6c8d
	KJfuODWHDgqatuV6MIDa4bkCBMqy6lgK+RRG8NTMaI7T5k7GIowPKJ
X-Google-Smtp-Source: AGHT+IHhOwaM87UnJaQRrN7fhHF0k/Vk8dAJKE4DsDjg6unQFW9Cs7BqIsOLGGMUISX91/3zXJdi9g==
X-Received: by 2002:a05:600c:630e:b0:471:11a3:a6a9 with SMTP id 5b1f17b1804b1-477308acfe4mr25198435e9.37.1761904294421;
        Fri, 31 Oct 2025 02:51:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477389b3acasm10684535e9.6.2025.10.31.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:51:34 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:51:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, sparclinux@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Larsson
 <andreas@gaisler.com>, Christoph Lameter <cl@linux.com>, "David S. Miller"
 <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>, Tejun Heo
 <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
Message-ID: <20251031095132.3db72d29@pumpkin>
In-Reply-To: <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
	<CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
	<33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 09:46:25 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6>> +++ b/arch/sparc/kernel/time_64.c
> >> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
> >>                              : /* no outputs */
> >>                              : "r" (pstate));
> >>
> >> -       sevt =3D this_cpu_ptr(&sparc64_events);
> >> -
> >> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
> >> +       sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clocke=
vent, sizeof(*sevt)); =20
> >=20
> > IMHO this makes the code harder to read:
> >   - Only 0.15% of the memcpy() calls in the kernel use the
> >     memcpy() chaining feature, =20
>=20
> I obviously propose to refactor this implementation detail.

Reduce it to 0% and the kernel memcpy() can be made 'void'. :-)
That will simplify the architecture specific implementations.

The same can be done for strcpy() and strcat() (etc).
Where the 'useful' return value would be the address of the '\0'.

	David


