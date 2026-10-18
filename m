Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA5434998
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355891; cv=pass; b=CdgHHjKC3B+knrKSxYBwRWtzA4qGZuFdVl0HP4DVr7Hyv0Hxq85koTO/g+YkdaQca2XhBBh2V6mLK068wZ9+BpjIQhE99eCaxqxFCEYpGjrgRmwPzD7ZFG6MgJvqj0ltg5D/0qK/qSEjSvtFurCNw0OVIFAsF1bhEmEYRF3Sk6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355891; c=relaxed/simple;
	bh=grwPLF9rvrThlCbEVNYFA11CM//ZaiKIyqYKtaq9cYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TN5tySOTXgYMOprDyAq2RmpkM5jQ69CluWNayj4o4ABnjXm+/Zo+YAAfYkiAEUNSSSI3P6JDvw61VxE4fXolEJBd087CdUIcdRrGRg12EdkAlhzZKVEY49sGdqfN19zeJw1qabN6GSAM3OEVNazBQsKIPZIXQCxV2bIvrTzluso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/ruDCtl; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/ruDCtl"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so2077777a12.3
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792355889; cv=none;
        d=google.com; s=arc-20260327;
        b=JEhQJceAx/QvUS60CY+NWdQYrS8wtU3Vq862NVgg1EZZXujAS5LvBz74y/gKZx0Jix
         VPCnxOMMXVWoW5QjTqNY0UuwhtXnji8Qa17gJqQ4dh3EPBv45gbPnEEEWvOfN0lIsouy
         nBKY0DBKA5J/v4ElO6O0pt2B8q6o912pvl4eU2xZ4FzvTmv0gwWPkPtBL+O7ZUHqn0mv
         ajWsAbFIDWkgzMxCYkWDq5siUTW7kmvwjFjXhHnSbIZPGggmEjJ1AR09kLg5sJlj6x4X
         grvJ7t76YEaltaCxY9xYnUWemO7JOq+SiFoC52wel8SdgzF2KkBg7KH+Y2nfomOphv2u
         2sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQEuJfxQYvtnYsFieIFSsWi3xut1QyYW+h2Ko2bI0iw=;
        fh=jfQoSThbGD2J1o/UN+815bXgfHiWqRPN8kSYjTA7eWk=;
        b=o7REPd3z+F7LVw0VgSkl2SilZxBOluZzTNX93ksj4j0pNBdoUwXGkj+1Q8prxXJfe8
         U9R71D9FjX6ePUlT//eYY0mUvFJtCzvsg1xdS8s+H/flbnP5G3aNQicDEcTG/TkflBOg
         z0Q5k4XTfsbtWejgzCKeDGfM/3SVOyXSZall5K0e2CgXysY+TaIRah0X64ahrTUh0kwY
         FhEWVHrbXAgHTuAoLhfYT+M1i++eV3iA/IcGQH/iUuJ5eN6Ze5z2qBRJZYZFDLivXznW
         /lBSNlWkdE1f1n2sEbRUaijBob488gawF6J8OVjSd8L1GTOaqckfYtWrlELrJ5peUxmD
         SURg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792355889; x=1792960689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQEuJfxQYvtnYsFieIFSsWi3xut1QyYW+h2Ko2bI0iw=;
        b=J/ruDCtlP5Bs5KVBK2O4gdMy8ltSGLFVDGMguwLjwiR9SsupD44G+swuqbtMv0JLRr
         BaJ8lBh4ghZe8giEIxGgml8pRpQg7X19ABGTsBUwfqiFufHDd+2yI/nPDjyE3eawu3V3
         acbI1Ew/Hi3fNz/jrjTbAGcrIOy9iDxLhxaTVt/LGIMUpUB9Ex/WobcAj1hpzpT0QcRL
         gTJORb70jK1+BL8qrwxKXEnK/816Fz0/soPdpccU+kipNJS8aAPn/XZv9s6K+mxi3tLM
         f4zANHD5ix24J9py5e4GxMeO++wiXit6BMxLVs/v7iSilL2OTPoHlhGZ7O/YE6Vm5tx9
         cSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355889; x=1792960689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQEuJfxQYvtnYsFieIFSsWi3xut1QyYW+h2Ko2bI0iw=;
        b=lQAPVZQpAwy5RhDTsIBhPlYkR11DZJ83ckbXpTCDEFH2mPBcDufDbOKoahsz4S/u23
         b735I9inoAvT6hAzJR8RYNiIVbMvupiHp5oG266KMcYsRko/T0ywrr+v0ddsVy5nnCUn
         FwveWLijlSNPmqcX7NlNeRTYigQDE2U9NFxFkEMw3+i/xSJB0vVgOMTiOuAEdRo66l34
         pTADmY/Zli+YtjU0+uqjCNNml93qRhkHz35GTNrivLsCjS+fmbuj3EnyWVIrITzwl96s
         CE8XtD2pZWnPQZzguRiYGqvQVnXDTVYMa5AEJA3gLaU1zlqjupb6cj+fB21r9uAt/7D8
         IHGw==
X-Forwarded-Encrypted: i=1; AKwUvBxhZmEzNK10D1oiuwS+Gaz2GW6QepDZdxwHW7s6OVqjxtPQwmrI850Cwq9Ho9PRPkIYvqjh5g0H1OJB@vger.kernel.org
X-Gm-Message-State: AFq9FYK2IQjF1fkYosEuv1CObZaYdTDwwku91ykwoJfB9cjonNJ/nDux
	JKKkhsEtkj5J7PxEs/8Qp29Hd2LlY1sGAh4It269Fj9N1FkE51TY7SgdrGIgoNF88U0uDtRzAeU
	/zagjoC2/1zWGhqDtOM74S71MWIpbXH1QhvwZ0C8=
X-Gm-Gg: AYBFou3rVgvQ7DsPbkCrK+4DqBR8jMF4WIMGvDd9amGRAZs7m7Mvc9Nnx21CoDYLOvO
	BZk+oh4AycHRnAdLNJXBX51NVXeZcX8pYQNFUEizbTB1j3wGaEaf6FG1uEVoUM3Yd0EO9jKrcjl
	uEGVLMJ43KQ9+is04wdEuToDxNyDBgzafGbpCaCpyVBj3n5IN81Dn2XeJjVp9HOpjS62GjIu5Io
	zenP91SXR7NFK7PdcxZLr85P3oel+zwFHZyGzlyhGw9+TKXW6FZXfo0Om2fzgof+z+tvcl7YH5L
	oXQuIQoZq2LakpII0OSrq0gA74qoGYyg3s6GXkNk31KinWA5xHHMqPoRpK4FaOqduXpJ6nS1KFc
	s0GZnsZtzg5qm7a6QbX0cJ7K5obEYCeBzVI0Y9+u+eA==
X-Received: by 2002:a05:6402:21c4:b0:6b3:bcb8:8a9e with SMTP id
 4fb4d7f45d1cf-6b3bcb88dd3mr1755246a12.23.1792355888546; Sun, 18 Oct 2026
 13:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018122734.2594904-1-stian@itx.no> <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
 <6e2d2b2b7aa4029c261831016d8b6c40bc335341.camel@itx.no> <4f7dacd9b4cf0a43209be84f2408e6f7e033fd3d.camel@itx.no>
In-Reply-To: <4f7dacd9b4cf0a43209be84f2408e6f7e033fd3d.camel@itx.no>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 18 Oct 2026 22:37:57 +0200
X-Gm-Features: AclHuK9-5GZYJ5otQ0xBPe9DcsaMy9Ec48RLx_aOqeCX25Ag9ve1MlPXyk4JPi4
Message-ID: <CA+=Fv5R31wpXsm-7_H7ZR_U4ASubis+_zWKotpj2iNeWW_MTUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
To: Stian Halseth <stian@itx.no>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	"David S . Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>, 
	Michel Lespinasse <michel@lespinasse.org>, Jan Engelhardt <jengelh@inai.de>, sparclinux@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 18, 2026 at 3:38=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
>
> On Sun, 2026-10-18 at 15:33 +0200, Stian Halseth wrote:
> > Hi Adrian,
> >
> > On Sun, 2026-10-18 at 15:09 +0200, John Paul Adrian Glaubitz wrote:
> > >
> > > What about sparc32? Does it use address base randomization at all?
> > >
> >
> > sparc32 is at the same state as sparc64 was before this series. Only
> > the stack moves.
> >
> > I've only tested 32-bit programs on sparc64. The same approach will
> > probably work, but needs testing on real sparc32. Could be possibly
> > be
> > added as a follow up, if someone with sparc32 hardware can test it.
> >
> > /Stian
> >
>
> Additionally, outside of qemu testing, I'm a bit worried about sparc32
> machines with virtually indexed caches. I've heard those can be fun,
> and I wouldn't feel confident about implementing it without testing on
> the "real thing".
>

Stian, following your exchange with Adrian, would you be willing to put
together a native sparc32 version? I can test it  on my Hypersparc SS-20.

Thanks,
Magnus
