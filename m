Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C23BE168
	for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913818; cv=pass; b=evw2QVX32Eg6b62UXyjKZXB22pJfg61ERgekwkjyoTGkmZUDpm39pmBq3hNHrMcemZ72h6qXNvd4ECVT6Hi6V69uDaGDZgALMma+DfLPO5SpFpVUthHnB3aRw2XBx6pCjMTGVXVpZoYzUujRjxZGsilHqC4Rz1UhDwTUJv9SYQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913818; c=relaxed/simple;
	bh=mAC8tnE77zvB1Q9LVYn0Z5wKKFjwjoPN96NhWTRB9s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZOmzkQ2K8TOFk2qdIgeTxSJ+ZJAm93iMEIz9y6N4E1YnyZ2v+Rs/oKmrwphJ9ct/+NegN0/WiDRZPWAUJFsLRzsouJQNeKVhj3Biuoe/elxMuHFFBKC1kZxiT6Z44vKKvEVjcS7e6Sqitd1etRKslpQ2G37DrI7LUbJ2XYodss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVWrUnVL; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVWrUnVL"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso6038321a12.2
        for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 13:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786913815; cv=none;
        d=google.com; s=arc-20260327;
        b=LF1Npv28xDpSxuetVPjrkagVE5aMPrpSD68dcvuR2FjMgvZmt5aqdN7k/y8f2XMWZ2
         7JcVakGb/q7skN5+GlOv9A4mGNRltBIOI696anTc/2Tfj4rvFuZ7wpybSaiNdYiH62mj
         /eC3WJM0L+Zo510Pn7CkGr4lEL1wOfq8lXm4mhJwoTKb3ugn4lOCrfOkA7SguK6v6qRB
         WXR7+6EulKdMeYbwr+6d7nsuAehGYp6fb204yfphgCEzbKDFKkCLnWrnQEQLP/OJPzWw
         0iYN7FxUCJ8k+U32VA9QL+6SLMsM1x6Cr1UuYx2rB9ALItRt0Z+SUxjCeKCbePxLZqXG
         aguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAC8tnE77zvB1Q9LVYn0Z5wKKFjwjoPN96NhWTRB9s4=;
        fh=wveRlhgmW9Wo+GPUNyPdNOhzdyEvNNpOq7R890kPqtw=;
        b=SYTn1jc4HSVu7FJhiD8h1AMg3MOcCYfJ5EIO4MGCcff+bntocP1I6DzA0qXkpYP4aI
         HHIbCZzjcTZLS2c5441uWl3RN2gHvx07eW5kkcbBngEcY1E/3TlO9h/xwz/qjFRfrIhQ
         hzkD3kwTnHMosO92RAgH17XFmK46NO2Mjhl9JqLnkYFldxMyTdqKkEy8hBxuWOaEbiC6
         7pGWVd9f+Izgk3lhVuXiU7OyK1SmZO503wrEqjFayueiwArf64krrY1KAeNr2QIcYEde
         CesCRq5YpvR0LEsmaYbvqiW6HidO3Q3Yh6Di7EWrQ94VJFZgxCBG/+bbCiPnhiW19Z8+
         W2aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786913815; x=1787518615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mAC8tnE77zvB1Q9LVYn0Z5wKKFjwjoPN96NhWTRB9s4=;
        b=rVWrUnVLk5QcIe+2i27+TWvPY+n2Clb+OtadESbmz3dZEQcIIpnHCMw19mXqvlLvp8
         Qs/r6cW3qg7WQPKz/toAUbXe6Fe6ot8XKoysugAcMLmKgZR7iqpWG0wHSPMrh0juKNAx
         uo9lLmjxGkJ/aRwfYK3nnf+9F9LVAKzT/UFMTlpPWMgnRL2sS36VnRtMa8PztwzfwOv+
         56J01vTB+UQB0MlPJ/N0cGM9Ps2lo1c4LWjTbcIYUdMBdCPQJctOjDw6d6xbDtJ4ABYG
         4qdGry3oAeyWGTYZMUWaDBaD2rp3qFXmOJZgMuOw9yvpaIorw3XlcZ/COchp9D0e/y2o
         0bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786913815; x=1787518615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAC8tnE77zvB1Q9LVYn0Z5wKKFjwjoPN96NhWTRB9s4=;
        b=LpO2bRzCwTe8ikpulho/ajZH7FUy6NxOZc6eHCcYqxXk4WCFGhrVeEgiZXrkE6FpXF
         Vrk4HCic1TrsXPXE0/lj4rxiR+MikTe75GxEaHDYA/j59iKwYfH0TvBnCKoIcRQ5hDE3
         ILmRT+8muRfTmRjNF0AFoJkXSt2ehS9b3AZR3A93gmb9+4MTP3owe9J3CRRlsw+upYB2
         6iMZMujgXVw/9BT+mvI5y7ByQjWvRDcNWhoykCFJXpGMoGOqTE0MCGeSCL1yAxEsBIkQ
         8ZygFD1oDIiJxCVoeu1cO/UdFGvpzjXWNivSJCruDZUEAujHlgL7zhukKdC2XpgsC1i7
         TOFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQdSzCcpAUYWX26t1a6qBhgkK68PACzbPrvo1ZZvuZLcgggduKUmHMeagiM2p/8eUB4CCQqnRLNilC@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQQUbyvim6+H2XhrzW6HyD44K2DI73X8MAK8KMwCOdnNreJ2A
	FzP3Jp9Cj0ocuv+cjAulvqCK5v6BMp6KQo4Rku/wQMFXf9diteZ3EfFGHvOW5eYDOoiFI0404AM
	QG7KIefr/RJV8Llb+EHZ0OUtiJ0z4O/sRPpsx
X-Gm-Gg: AR+sD109Nhi9vgjxu+tsh7UunsQeoeJISIAQvxEjBSAZhpf5ExI4aA0HM6flZhHWpLk
	ZV22+sxdKWt7HixW4WhbEXw45SlXq9mnV8xpgTuYKvyReik+s0w6cpPSbG7MHCzYM+mz8MoIez2
	qEmkZMSoSRYM0ZVlyaMXKPjZluZ28mFyK2M2kd+IexO7Nf08P1UCas1ruiG9V60QptXkyZTbvon
	XdDcX/HfTMKfBaGoBQYV2Lx7PxyFGZCbjJv8dhkyDbnnmNakl+0LeSZT/VbI3z3uhVuYPNPflvL
	LZkB2t/th4j9l8ArWCmHUFFHRKrwCGCjMMJXMjoh3Vvd5xLjGSmSEo/8S814/ih7Po9qpVDyz/H
	man0Bq7AH00cG6sKnTZz9ng4y6xYMU/U=
X-Received: by 2002:a05:6402:5293:b0:6a1:f933:2403 with SMTP id
 4fb4d7f45d1cf-6a38a98a165mr9482195a12.17.1786913815012; Sun, 16 Aug 2026
 13:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816075141.3489194-1-linmag7@gmail.com> <20260816075141.3489194-3-linmag7@gmail.com>
 <20260816195456.GA660273@ravnborg.org>
In-Reply-To: <20260816195456.GA660273@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 16 Aug 2026 22:56:43 +0200
X-Gm-Features: AcwNN1WsmyarUtZv4PbXUZ5ZV5f6FVDFIIBDR3gYhkw1llJEV6gCWOBiurdO6GU
Message-ID: <CA+=Fv5SfLQo+LMoEH2gtmuuw814hjcjfnd551E7Og4t=JsFWug@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 9:54=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wro=
te:

> sp_banks. Can we somehow use memblock for this?
>
> Part of my old grand plan was to replace all uses of sp_banks with
> memblock. I have some old patches somewhere in case you are ready to
> give this a spin.
>
> The patch is:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> My sp_banks comment shall not hold it back.
> It is anyway Andreas that will handle them.
>

Thanks a lot for taking the time to review this series.

Moving sparc32 off sp_banks and onto memblock sounds like the right
direction, setup_arch() already had the array to hand, which is the only
reason this patch reaches for it. I'd be glad to pick up your old patches
and take them for a spin, just point me at where I can find them.

Magnus
