Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268FF4D2EF8
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357951; cv=pass; b=oVcevD9RyP5YmUZDl5ad1+Hqu1uzLdAXyKoTVkQhNQPxwoOQkxxXXKi29i625u2B3BflK90W/grPWtyIxF9R/jTlGqJ2iloETaQdDvGuBEYupIjsMqAghpB/+BDoXh4u3Dps2ORsGSUKRVsw06tYFK7RB3mxes0gyamnh7Vzof4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357951; c=relaxed/simple;
	bh=NPsBucZoFwuxN8LiTRthSe0scFYGQmpl05b1JbjgYpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlbNEscgSSikSJncPBvx14LL/5NYbk74Q1QcCrmZW6Cau+iLovxIho9+vWPXehG+DqQ3wO9AQnph6VdlYJvLXWXvPnrDEbs1hpsLVo+O2Q+6d7AnCBP1AT1dTtU4BbXIqYjrg5yCCN+nu9nTpcF5sEMFxAmaSF1ztqRXL+Zh0jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irKFaquj; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irKFaquj"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso2299407a12.3
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 14:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792357948; cv=none;
        d=google.com; s=arc-20260327;
        b=dCyOO7CeLc4lx3NlE2SLoTz3dNMXvl3kXYfZsYHOqgg6FXRgvVnlajyn+HwHLox7BA
         7Uj7tOJ4Q28JK4ZcmQbMdCIt1M1NNBZ4d5EiiwYKDhyjz5UB//ZhZcTGx14V1oFS18n0
         kJH8mAjR7oaFXvybjFf5eCEd5dClD/b/PkXFbACKfMY5FmTCcenVa5FNOhDsdvZ+8cqS
         beiDAO+ATbDtQA+YxHoM+nBssQVb5Yz3qTey+0UBacFXGfryC2srv+KJ8N4kp9E5gXJU
         IOjYUnHEzSLz9CGL0SeTlElTgQ0XzZwT0QUNfQgHQQXxfpu5ZToWIKUKoRghStrV1bli
         CIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EAVBbyjDy1OgZjxuIB+FMdM7v3vfb3dDBg1zMveAqQ=;
        fh=AkzozGSt0kGxGdqekNXnG2t3Vip1IXIAxddurp5Iu9A=;
        b=FigfALYYfxfDBGeppk9VJ2rdT4rB0pDqrkAy69IHaLooS/7jo0RjmAvUpaxI3nfVfz
         wAVBLDQXI8k9lzm9iHMDFbkxZQXO0JNqltvxE4mnHTwuFvP+7qtH+37iO/VrOU5lbeHs
         fFWtavWziL1XJGt1TNR2OfYWauaGxqgYnWtlk8DKXw4ydJE1/mmU7kglCBuwq+7it7Zp
         XUYmm9vk1vridqvsg8JSJdghWwc8NlWDn2RjKeFvsRRMjPVHaWbSONYmYTsVjFAVFW7E
         E+5mD+esterbAkUhOLCmhrZedbWuR8cDBpK9NbRbU1eHSGLV0b8aRybMA5R5eKbtcdBS
         pvIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792357948; x=1792962748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EAVBbyjDy1OgZjxuIB+FMdM7v3vfb3dDBg1zMveAqQ=;
        b=irKFaqujIcNIfHOszmaA9Phyke49g8IlIzaokVTm227c63VyLNBw8fEpPo3hB/BKWC
         +mABFka9Be2goaVwu7CrfheV5Z4XMdvud6KhxOZdDSFFNN6Dbb89bsmAhqt9pfakVufJ
         c6QMZOLUbtBGruXxjQrocF2xa9buR7S5hpBOozkHSba37E52cEo8qghDYecOXXoBddX3
         IlqTCh/klMUV/+fRaTBoCqz/KG/1ChML3oYFlJrLOW4g1jkkRfHiv9JeF/0r7BzdJWrc
         CHVguQJTRsWfbzhxZ1ySDOLxdBAzzIphhTWvt1E0pm6mPZqrR73GlZOXciME1LpImhz9
         /r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357948; x=1792962748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EAVBbyjDy1OgZjxuIB+FMdM7v3vfb3dDBg1zMveAqQ=;
        b=jY2ialxHinbTYFkpq4ab2I5zBSN/KPm5X3ceqPu1YIESiYE7QNQGDhjxlr5Zpeknlt
         z+EMdcYg/8GQUY6ZGShkbOpkk2ozt2SEWCoG4M9b5fu4KKeDIxfg7wRROuJLOl6ZqnLX
         bx504rl4zEeKauAC9PBeEq6lp/suo0X6VtqetZDOfl4KoYjosy94FfysFq0rCWCj0iIN
         ffOg0i+FKPqW0NYcdDXIN69ItFE/NVrJb0ulL1ezmuO+2NxVfhOCBxinTT2HPHjZSj5e
         G4hSOwxGsMQRbs1+1T7BdCaJfzGy9Q5gCXTx3/xl1Cr9TZei0VxYkv/HTYfK9beMQvw0
         l/Og==
X-Forwarded-Encrypted: i=1; AKwUvBzI1C5C7yH238PqNth4tHDna1zTE67v7+XZ5dc78df70Ca2P2/ZfxRdxgNr3JHx8t5xwy5+IwJ22yse@vger.kernel.org
X-Gm-Message-State: AFq9FYI4m+v8Q+xDbDdvjUOoegkd9fKJ26Z14LNoTHbSPbS+HWfCxn9E
	o6P4pAwkRNlJt5PdjXW36fwQpsBZ8aX1ZQbesPvYgIyGtv1Vv3ej84Uv+Fov8BdAudNvhO1Bfh+
	ro9XQoBlUkNySNpPPkZa2FBRdnSN+FeE=
X-Gm-Gg: AYBFou1p/HJ0zV7/MWOWOPOpxYgvprVtX+A/nQd8NmsQf/dgW/WjW4eYBMnRwnEViu4
	8MN3ixrPPaPyYNagJO9+BQLbNBzDz2ik+8l8YiDfNgcHeJ6SAPBtIVY5My5kXlHBG3uUz916hHq
	AG9dum2HibmU1tmVxCJ8pIdZM4oawzIZdTcNb6rXEj4IZsLCJl9T3mUUG7ukxf21RnQHfHt3kjL
	YXqkXbClXxwpczuoCO1H0nkO3mgzbCElX56RitnG2VivWly7jBEWn4IDidUuEblQj+0hSqtxsPL
	J48fAJ6WWhJKCrREKkr87tDrZmCVAKSXRw5DgJlATs3iXZ6A95dmquPlEjCDT5Q7ATnHc13nv/h
	C4PS5RGxPtFUL1WHj0Ok43bY3ar0NxU/ZTnr3jASQMc9BEfGZYDxs
X-Received: by 2002:a05:6402:190e:b0:6ac:b9b5:8e8b with SMTP id
 4fb4d7f45d1cf-6b3a8176960mr3673422a12.15.1792357948108; Sun, 18 Oct 2026
 14:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018122734.2594904-1-stian@itx.no> <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
 <6e2d2b2b7aa4029c261831016d8b6c40bc335341.camel@itx.no> <4f7dacd9b4cf0a43209be84f2408e6f7e033fd3d.camel@itx.no>
 <CA+=Fv5R31wpXsm-7_H7ZR_U4ASubis+_zWKotpj2iNeWW_MTUg@mail.gmail.com> <d233287d5dcb6726403703a7b923b05a8134cb1a.camel@itx.no>
In-Reply-To: <d233287d5dcb6726403703a7b923b05a8134cb1a.camel@itx.no>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 18 Oct 2026 23:12:16 +0200
X-Gm-Features: AclHuK-e2-z8ormz3qEfmYHF3HvTKszgUZZKRMKr4teyS0FgOEFwplPC8KtpOVc
Message-ID: <CA+=Fv5S1kF19rOgYjYoMP51QBvhEng+HbO9wDdj7Ue8rVrRO5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
To: Stian Halseth <stian@itx.no>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	"David S . Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>, 
	Michel Lespinasse <michel@lespinasse.org>, Jan Engelhardt <jengelh@inai.de>, sparclinux@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stian,

On Sun, Oct 18, 2026 at 11:08=E2=80=AFPM Stian Halseth <stian@itx.no> wrote=
:
>
> Hi Magnus,
>
> On Sun, 2026-10-18 at 22:37 +0200, Magnus Lindholm wrote:
> > >
> > > Additionally, outside of qemu testing, I'm a bit worried about
> > > sparc32
> > > machines with virtually indexed caches. I've heard those can be
> > > fun,
> > > and I wouldn't feel confident about implementing it without testing
> > > on
> > > the "real thing".
> > >
> >
> > Stian, following your exchange with Adrian, would you be willing to
> > put
> > together a native sparc32 version? I can test it  on my Hypersparc
> > SS-20.
> >
> Sure, I could do that.
>
> Ideally, I would like to get this sparc64 series through review before
> I add anything else. Could be a follow up series based on this one.
>

Agree, no need to mess with this series while it's in flight.

Magnus
