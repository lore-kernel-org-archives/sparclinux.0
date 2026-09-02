Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4438758C
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327538; cv=pass; b=GJCn2GPkGz3QNHDGAH3TFNYxZ2y0SE7ka/lwt5lPjPCqn/f7Qm0DgU7DpoNJbOtYODFTnCrTUjMce1b19w0j6US2LLo+G6SUnMqBC/Wd2M0eLEnLSclLcfDZU4cvVGYKyTENnFfm5wplcfyqqmrR/+li3FPtUV5Jl+OLPk4+WFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327538; c=relaxed/simple;
	bh=gE6vkTgnAHnamDKA+igQgYq/8m3BMccvQocwRHbGwhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbgIoTW+nsM2vlDtif1BS1AfO8mNqPVDWVdDVMUncAZESzgBeaVeSLcl1vdy2avAHbWuRvJnih/sg33T69Q9MyYcYUgl1qP06OgDhlhpfaOtkU9KUOguAaHz1nwlZFEUnRRqlYtvvFP+7KykYsbV8pDLYhOS6vjV50AeO/jImk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9kfJJYA; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9kfJJYA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a5ebf75d62so1065741a12.1
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 22:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788327535; cv=none;
        d=google.com; s=arc-20260327;
        b=FUp520QrBw4a/OBf/MSkREYhrBT+WqnuhTyhESkjSYe0fPZAoEfqGswoxBZ+dX3w7H
         zkB5+YZzA2Anw5bFjFG4LRwqhJz4cR5CoTL+x04Lj/BM0LQnXiTUYR5pQexcglEo3aO9
         Jul/lcmThCjnvy/TpITRwYAJ7jgvptzaQ30iGx8hmw0FYja1n1Yg/prdejlwQkjZ++fM
         1zXNkfbWmG/b2Ms3NC8JtTxiGS+6LTopoIGUxQgwsvPSBO1/ewPSx9Sz4l+5NkkxdCnA
         qNkLOFXJOp+REH+5uwIkm7rbBGGlMF3v70EfnWjKtDZE1xV1byIFq18RQtoXArhb05AT
         X3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gE6vkTgnAHnamDKA+igQgYq/8m3BMccvQocwRHbGwhA=;
        fh=lIBdiMTals0VDbKkknJNa4hZrTGWR7Btvm26/3VRa0k=;
        b=gHa3W94NowiCe8C2SDDt9pJp7v2U6u+emF28nRO7o1ctmZKcn4fzUgbE4tqzRYw0GI
         NhjOKqbbzsWZxxPC9J4u6Wea2dPnX8dTG1xSgIRPC3GHzUb1jPoZgDygQM/UXyycdZ2z
         6iOwIiY/fjfddpbbRZpULbsSGxaYX0XAT6ztCQY78xY9ETDLTzotOX6jL0hGAOkvC6vA
         pQc2UcHh9AKsJH0pDgGnl2eAqp8jsloRn/914TILIZBy81Xg2UJF64kkqgf2tQugG0af
         0hyAbxw/4+ug7R892B0Go4QyVOJqjsOr61ShIf9goYTsnNycu4Befe0khR5pyBXJYXn3
         674A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788327535; x=1788932335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gE6vkTgnAHnamDKA+igQgYq/8m3BMccvQocwRHbGwhA=;
        b=l9kfJJYANtiQ+u1ltTK0WO3ROSM9otFrx6JsdH94A8+tWe2XvNP/j79xEzs27T81uV
         n4Mj0BAMEOt9q4ZtLYbP+ekCBMd6NaJrtbqsAZIi+7XqtyYIiK+hv5yj2dwbPjE047rG
         rpXyvHsFji4ebYTSibdHe6L8e68P2LTxn1P/2dYXSpgca4wIsaVHPwGFUCLoi/fJkAWG
         TnuaJw24IqqKrwEeVbVw3N3/3MfZDVpH2TtO5aC9C4m91VGV2xKxIaI4YaaT0zmwqB3y
         Er+p/48p6Oldpee2VtKITJ/0zLU/LUCEN0x5b8FuotB1HszJKQy40UeroS4P5mGfCUNK
         dyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788327535; x=1788932335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gE6vkTgnAHnamDKA+igQgYq/8m3BMccvQocwRHbGwhA=;
        b=RX4o/G27ycjsdMCemB08q+RMHE0uQoUoXDlc1BtvRctoH39vM83Djiln/gV/tvkizY
         w+FSZGHmZi2fDZY51Lza6oFQZBYqPVx4a400zlwdEGdv2VjnozxfxTnnevUrjVf38QK9
         3UayI1aZRR6H0WNc7tirc4VjfIWMBq7cnVN3nPOnDyonOsHKrjsF0NafqkqckDMjoxpy
         WFWvk8jDHFMnqnlXCe1u2yfosd1uKCH6sUl31zQsSqJKwTTn3xQQGJnsTAVuL02B6h/h
         AjaAqmd3pzLuu95yYUbuUV/2saMTUTLk5s7JknS2DIMYVIo8S1YXoBnEGIii2W+BF5zI
         CcPg==
X-Gm-Message-State: AFuF++nV1PxpRzpaHzovofZhkJ7j6zsosG8sqezxBer02dmiykFLNK4p
	dKe89sfQOGwP793fBGw7oM2aXHIAjO0KPr3OXWMYFmCbKSCDaV8NX9+JxyjhISstvJuroEV5EgI
	A3+PFXek7+wZflTbPkFmQmLLYwGdoo88=
X-Gm-Gg: AYBFou0cnmr83PlZfx8bUTnLfoxPij5ZBvRkvIJQwF2BLiLquc9GgxQvpgpwyUjF1Z7
	ONXiYw81g5ewCx1GA3QyFihx7dyPX2Xd4q7u1ZWouZfq7iXXmgCqQw1jsRf2//TGoKwzAOXzC8c
	yw6JsNceTZvlXit050eOj+Cd3vIU46dek4PW3HacxEg7JdAV+Ox9E/P7GciI2y3/LN92TjtK1HU
	f4dSIpsbpaZ2+x1dguk6XXyx1EqIl1nJOwJINuMWpRaF1KAvZyRK7yDe2VjNWy8NlLf2z+LkBiF
	Dq/ae50rH+gSDM2FsyrwU5wKb4sywGxQ6Of34LTHrHV5E7GdDVusuDN2wEzZQpFvWh0LjdYU14t
	8P4OM4EmbQUyrTPGiPqDyNhEbWQe1XgtauE7dp0VaBCQ=
X-Received: by 2002:a05:6402:4406:b0:6a6:75c8:6bba with SMTP id
 4fb4d7f45d1cf-6a68a55196emr379910a12.7.1788327534406; Tue, 01 Sep 2026
 22:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901214611.60560-1-linmag7@gmail.com> <20260902053540.GB338380@ravnborg.org>
In-Reply-To: <20260902053540.GB338380@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 2 Sep 2026 07:38:42 +0200
X-Gm-Features: AcwNN1Vu-Vp6k3k-HA37zla-acUKeXYAi2KMc4dYXKBa6LxbxZIme52Bazb2qHQ
Message-ID: <CA+=Fv5QBPP6mjZpXePrzCwUt5YmkM++5g624N0hruDR_P1PHEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] sparc32: replace sp_banks with memblock
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com, 
	linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Wed, Sep 2, 2026 at 7:35=E2=80=AFAM Sam Ravnborg <sam@ravnborg.org> wrot=
e:

> The full series looks good now, thanks for picking this up and adressing
> my review feedback.
> For anyone looking at sparc32 code this is now much more standard
> and you managed to remove ~250 lines of old code.
>
> It is now ready for Andreas to take a look.
>

Thanks alot for spending time on reviewing this, and for all the
feedback pointing me in the right direction.

Magnus
