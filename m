Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FF560AAF
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928197; cv=pass; b=cLjnzfARHnSLwc+7NUeVGqPhEq6swb1Yvi0t1Bdra3znOoCSvnQOv1MrfwpO87MSEbr1Wzwe2nMvsk5PXTg8DdwTc8MKk2JrlacwjgEar89f+gSwvjGlv0iywnERk8J/fjm2Uac7XKEzjFSeN5wLRUmcDqiQVcyw6YbLnDFEjMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928197; c=relaxed/simple;
	bh=hioDiOlURo8xdbGjD/3syLKxQLmoLjjsZ6hoRskxKGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJAkhCwZzLfFR4WLGIDJ0xuP+Swz/e5iR957B0Ly+xeEops4qd3R9sAkko5+8+Zz2tFgLO9+Ge/DXBS5sAHYwGE+RuJ3YK1yX9PcL+q+Vkyt12KhpVjeQWHiFuo6QUmngXQu6FMiYeeMfY+8JQAIztCrw3eNkszEtf4WC9kCtxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3/OjAZ2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3/OjAZ2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so309162a12.0
        for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 14:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791928194; cv=none;
        d=google.com; s=arc-20260327;
        b=EWClKqmtUS97vvJr81nV8+HYgXbXXCCv3qWzln8tXVotmUwH4oqwEvCmqqzoI0ElJD
         zFjO2+GMNG7en0aESqzv6GdMVpFgFq1+OEoy1t0NqY+7N3BXDl2mgGUcIOZbprETsroH
         8bXRG38kq3TdP0R0x2kbQFI3I6rTLAsCPdSOLSzpphJ/TfaUVlscdWbsprevUH09qBJu
         w/1sEHJB00nsN3Kk6VEPclUJl3jXARZwBNAvGGDnJAxOdtjnsQBtG7ihIoTAulNHb+rq
         UGtxRBvyez0Y9MDCHEESlKi7x4j7cF4VyMiWA5bOE0YL/QONhKKyuhplvHln2Sn5XKkN
         r39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        fh=tEIwYgVF6W7YlCtmb8v+OojORKpQWOTvUNEp489Fkks=;
        b=EwGd26CYe1MoTG6c5XPXfsIKAUdM61ktT9e+r+QgJqkboojUzzb0TOqg6VGlLHmlhV
         thWuB3QqGprhfIYZixcWgWx+6kN44EuPJwqAVsXQGC/5xishWfW0sZ3M6kKFclcExFMI
         SQIVZEbvfEcJe1FgrIhR63HU/kZEvdnEtVvKqdf4Mt4TYxDFzy+3RUPnK2r2iSQHMoeC
         6WIn3R637imCMRgDMidNbKIn2E5LjTlwqOB6PQHNyxN4ghjGPqsgXDX1BhA8uoCLcofY
         tQSqjMOqr1SZgeWAZQm//Z1OA475+M/TsvdoVQ3E5tq2pZg3LLAIFrjpq0mmM3Nf7kPU
         uirA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791928194; x=1792532994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        b=j3/OjAZ2nl4PNfdvBJaIEKA+mtEOUNX8P7VSxSdCJLLB3MzVMECxJlnYgjTPI/5jG6
         IZaVysbD+iWra/+q8m4MJes9UopmcyB5p8NSmEkiBGgC0r5HAJsVEYzHzPAOw160ZOox
         KuUn30o/U8bghCHneid+szoLLs3o+EVMCmSRUTCfQi5t2Ah6jAwxTYGGGq5FVu7vv74j
         j5+jiyRPRPdnC37+SzQlv+UyQYXJ1NIbebJJJeLGESeEiyqShar0gOPQMtLJBKPjH/ZP
         F/1qKkfwpU6vRLKluukHB1ljWWwdgwJWOSSqQK6+jxSZ2lm6c49kJARPROD+wRdF/FTI
         UB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791928194; x=1792532994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        b=QGssrddddujms1Y0LB2MTvfvikVeDpN8k58iOO3/xwLgkPlHKrYJRQGAzJoE8eVtSo
         9km6u5Iyn64XPI27Q0N7KrCbGeVJPEImDWY7FYhzyTHVIrunmVXImNdbiuBabYJA3EY/
         4gxLOOD2Qoimt8BgfCSEDX0WsuSmrOvcChDLcgFOK3mE5ny9NTA/YXavjByNA0K60lEf
         /LkEBb4enqn1bUmlQBVZhXbszC5o+vjVqe3FDjJsKkSdkO/H7NK9lO8TkXWpxq8gBftG
         LzOnf0ih2OLB4k2EWGQzfHmYTuNKUqqRlzMx12xDWJ4Oo1ts1Mg3lGaUszRAud8GBfrh
         Eang==
X-Forwarded-Encrypted: i=1; AKwUvByfRg8KF1ePWjjPrChK9KS9apJsp6VO/1XKkQCVc7jAJW4resR4ihA86Tay3bDz8AlEGf5olv1Z/Y1n@vger.kernel.org
X-Gm-Message-State: AFq9FYIe77f4+HX2H4a7PLr9UnIzTWuwwuEYcwhxH75z8IMLMK+hf0Zy
	/y6U5avBmET24E1Kt46Wn014bPT/ILGEqB3EjwEi7EmqjKaBuZuGr5TLri8dzc4CNq0jDUcD5nE
	nltZkeDXvd/tUcSEprm6SbQAFVvY/9E4=
X-Gm-Gg: AYBFou27Oz4Ir4AGDO3PnBdjpFEEfgDordUS/1EmqlmwbiiqLNQhMTwae9n76AyTSP8
	IKzL06ghmKq5JLqlZBBodO/tNckifJ0WBVs1sDhjy6JkTjorRIzqW6tHiSntLWBf31OJPt3X+5C
	/NfZnjXpVqimOrgv7dVlVkQKCHPjOsKxaT2+U9W69Lam3n7l2RZKOk0TBM7h8ERXYs7MVsx6iqm
	SoZI2mr6RPRNVd6f6k4ZRb/6W6YoJDvYTm2nUEP5yvmnMdiUemJ20a5uTW+hi+yI/agR7GnLz6A
	Swqf2RUvk3eWCUMZfTD8emStZm/GVF4JN5SX1m6vQq95G84pm0ji8t02iXVPwMMw03gJdO9pFSe
	fkSAN6krVpp0xIJoafGmiTpbAZIIq/M/DuE3lr1DnNQ==
X-Received: by 2002:a05:6402:4006:b0:6b1:c526:afcd with SMTP id
 4fb4d7f45d1cf-6b1c526bc10mr5749588a12.11.1791928193882; Tue, 13 Oct 2026
 14:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012184826.986050-1-linmag7@gmail.com> <20261012184826.986050-9-linmag7@gmail.com>
 <2026101313-plank-outlet-d3da@gregkh>
In-Reply-To: <2026101313-plank-outlet-d3da@gregkh>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 13 Oct 2026 23:49:40 +0200
X-Gm-Features: AclHuK9ealETNMhI5yAH6CuVcBjpteVRfkO1A49G7BEeIOYibyNYpBtxXrN7t70
Message-ID: <CA+=Fv5TuSDvXc0kXkTVHSver1znah2pbMofgrfMFmiyCZgHfGA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, 
	oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Oct 13, 2026 at 3:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 12, 2026 at 08:48:09PM +0200, Magnus Lindholm wrote:
> > Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
> > the firmware model and console endpoints before registering it. Keep
> > firmware buffers in locked kernel mappings and serialize their use in
> > atomic console contexts through the existing SPARC p1275 interface.
> >
> > Poll input while the TTY is open and synchronize close with timer
> > rearming. Return zero on no progress so HVC retries buffered TTY output
> > but drops stalled console chunks instead of spinning indefinitely.
> > A firmware call that does not return remains unbounded.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > ---
> >  MAINTAINERS                 |   6 ++
> >  drivers/tty/hvc/Kconfig     |  10 ++
> >  drivers/tty/hvc/Makefile    |   1 +
> >  drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 219 insertions(+)
> >  create mode 100644 drivers/tty/hvc/hvc_m3000.c
>
> I'm guessing this will go through the sparc tree, so:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> thanks,
>
> greg k-h

Thanks for taking the time to review this patch,  I hope to
get the full series through the sparc tree. I'll pick up your
tag for a v4 which I'll send out asap.

Regards
Magnus
