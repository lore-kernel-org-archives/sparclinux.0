Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A43AE195
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745127; cv=pass; b=lVfBNO5hIk6Gh14UhbBwq7SAd6gzUKQRDzpdiOO3wLUlQDqaCmBXrvYkMDfTUhf5FLy54BWyImAOFzpAA7k6skIgJFTO39qwG6WdBcuMw+tuKNprxg7yGRd3Kwl7TBjoKmDyY7dSxo+Z2JYophnTKkwcrSNNj5cxVC5UxQiASiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745127; c=relaxed/simple;
	bh=CyJhYF1dxWogB271OZ/TEmNCFniiM/Zi/eP1DcW106w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5vByj+OxvftsdXoOvvcWauRFAbv0ezYWKsNJPN5RFji4Mhr+nzKZ3mTKmNnhbILeOCL7ygPmYd+UzyEHl7zg5Iz814sT9w1wLgXuhPbzFyBxb3su4yHplSWysXuUc+x8b0K9jeE3Af8efX2Gdx42Wa/RAF9ahn1VMpSYzFHdVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLx4xyUL; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLx4xyUL"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66807ba2f0fso2163506d50.3
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 15:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786745125; cv=none;
        d=google.com; s=arc-20260327;
        b=OjSe+TJCws/QNu0spaoj6AT4lCsX7l0vP/iqcAq/ecHhPR7HJqwvK9U4t+u+1wbFgf
         +RDfHp6gCHUppLeKmrEMyjN/3yfKFGRcL0hG6sTIip488P+e3AyQxEzd9pyi83U9M6LP
         ky4pvlWs0O8qc7MbUMibWuyPc9MtGBVHro0Lx2ubRpg4XUE9pz+nfvBPumpfS2eK1way
         VAq5AYHUxD05BF6E/hBczJn5bjYUUw/2ZenO+sScDxT4DKSG1+c4DE148pdMbDXpyWUV
         20ahRBhB9pJWpuwA5wRBgsk7Kbi8y0/AdfCwmpg8uZV8njquYUjQYTOXqWGt+aLGDBIy
         ks8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CyJhYF1dxWogB271OZ/TEmNCFniiM/Zi/eP1DcW106w=;
        fh=zt4EeHORU13XARKyXAjEAu2+8kTgMpFl6nvnBkx4L68=;
        b=hdckCOfooGKEP7LnegVaOtl4TtJieHF+XUnxvcLMD+6iEc65+chN2byYlyE/W38b8u
         ykjYUzpNaLeP7dc9WrHSttQvgki7A0uBBfuDkwN3ag6yXXOmjOBmd6p9IKLz6832xJut
         yF4MsBpK9NxpbVycdyuzTHcZEa9IITUqWIqQDxKy3vqSJNK06+RV98eVzgjk15AOIog1
         3NSUy1lZmHaKKwyKF/WJ/zpW+mJJsyDb/x5W4KaMhjcVkK0mPOFDXWgnY6pjUC/kOGSR
         OWPnsWj1+UL9agFG2kyoJp0tIROEAnebqmgwCsWBw6Zfeejm+edeKY/kjngdHSaX2wLD
         Y19w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745125; x=1787349925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CyJhYF1dxWogB271OZ/TEmNCFniiM/Zi/eP1DcW106w=;
        b=YLx4xyULDkP2w3HRSr9SYcLemSeUd8Q0gcJAart5B22+35DlKK2NFJD8zM5ONjxCbz
         CZqEHuy1Z0a73Wgekks+KMpG0aTbTrysPb6QHMuCKtx0NjlqF5HyxROMviEOhrnRpfaM
         GSP5e4L52dHRTg0Yc0TRxSjWa3dWh2+u4HQAbOoJFGoYGTuYjge/OexZRUfg99ycYTNY
         bOoRLin+B0y3HPSU+59NJ9HCc9PgYC5IIMnmYJg9HCUg0bFk7zP04j7vBZ23/8s5knx2
         h4jsX++AnWVdApdqsExnYXTvcFBNXjaf+pYcA1ekowrSshJpS/XV3nqK5vFw/S4kxRbB
         r/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745125; x=1787349925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyJhYF1dxWogB271OZ/TEmNCFniiM/Zi/eP1DcW106w=;
        b=tSNTb2Q9wrkF8qxzNe1fOz4DbLsGcI32h8IMKlWXqv3p1jvuTVMAavTQO1QlmJKP3S
         XUPTdAodsoomDq7wQm6GClwCNQCCW+Udb98UFeosUiu/inued2/bu3C90n9lYw9ix7zh
         m0vlTWml5DSmYsXGMyU/D5mQumaRhnu0pLZxsezPhHw3rlkYvdlUVRiwE7Maa+WdkK7d
         QLYX4Lr1+gMCDlJK8UCezWXr71NDtYsa9dGIpcSSOwcSWRvYHRodXTKLROcwxfGFbmav
         tXs5l2hyAOFHXRw6EhFniG1ljSfxIlXBoZQBh2s/I0sz5MC+zIcez4J0kBzq049oFAXj
         qpNw==
X-Forwarded-Encrypted: i=1; AHgh+RpF511hXDdMYF/73xflta+1/maetL7XA4XOKGTi56U2m4cSJI5yH10HtluFlbdvDmKUEp484ucvlo52@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVr2YHVh4PY/uQdw+mrAvRqBiXzVa1Ep9ekFFGcZdPXU/KXmT
	SccSZXdf/SjOr/GgfXhYGZlRpBIS9orDBx6dK4PQ5pd6OcdXcLWbl3FnORHjxOro74wmLLK5mpq
	tCTkL7D2EMruKmMxKl/Rg0Mmfg4/rqZXBZed7
X-Gm-Gg: AR+sD13vs7CrX/Tyv9zFzJGE9hlhOKL3OrwgXpAKcrsKNW3oY+PsBKHj22E0kE7EkCj
	4GI8SgVS5bHgK5CakjKY7g2N0791Ti7I5tbLtbW1v/bdEpUhFekPvJ1a5Ilr1tYWElw1f73yokX
	9e5FMV3DkBoKWXb9coGggKJXi8gZnmfcmvfLEbxIX64Ym/2/2Iyu9RGW39XeMdsG0XLYep68pDV
	r94A+MOPPPeMGl+Einu7p5FKCllN97G/35xatBtkNYq+qKy/zNpD+/T0OiasB9x3jH19UashfGf
	Ce9ULzcbuf/c+6J6chVy9wSXt6sfsTB2HLNRmYcuR684hLrOwYsQt9ZyzJGGpCBkbez4dSoSUBH
	AowgL4yjaoCDZd1XqEdhlBjC96CI8Dys=
X-Received: by 2002:a05:690e:d0d:b0:667:bb60:78b2 with SMTP id
 956f58d0204a3-66c72cbf313mr3498396d50.34.1786745125304; Fri, 14 Aug 2026
 15:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814105723.3454511-1-linmag7@gmail.com> <20260814205326.GD534878@ravnborg.org>
In-Reply-To: <20260814205326.GD534878@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 15 Aug 2026 00:05:12 +0200
X-Gm-Features: AUfX_myhZbgf3EgxK8-4sIwbGCEj4OpegKMiShe4eNO2Q1XcNQ4z3IlDB5GLngc
Message-ID: <CA+=Fv5SvAi2JH1M-juJrH-aa64E_s0ia7pv5FXhTQFsCJBgYxQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc32: allow a kernel loaded away from the start of RAM
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Fri, Aug 14, 2026 at 10:53=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wr=
ote:
>
>
> I thought Viking was only used by the large sun4d machine.
> Good to learn something new here.
>
> Nice to see someone having fun with these Sun machines.
> I gave up and have actually tried to have the support for sun4m and
> sun4d removed from the kernel.
>

I think I remember some of those discussions on the mailing list. I'm glad
the code was kept, the old sparcs still have a few cpu cycles to give.


Magnus
