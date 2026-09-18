Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E344E73C0
	for <sparclinux@vger.kernel.org>; Fri, 18 Sep 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731393; cv=pass; b=ijYMoZYTDonD1/mvRLNQjA8RuTS7w348rFkhZN1+qIpi7ObetwO7O99FHaI+Mw/XofOfS+Bo3kBnudiNWKs2jSxFU4deBRZ6HXVWlr2o2zHOAhjlegGrVd941PrrhVZc98HABU/lrASSfb+Ubsy2SlWw61S07Fw3OQyG5gB883Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731393; c=relaxed/simple;
	bh=SM+WZSPeuzqNNHXbABDFo7m2xf8ZGs0pqFt1fmpcd8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzURpRmHo9N8/IY1aehin+5N+5b8bLUiZvFGAwCGQMPliKb0nf+5tDXvKO2+vXycpD6Jz8E2BSAZVrZd1rhXhS1I0+r4Pf7eLR2ZvWNrmdhCJQAKiMld4KdyzJdDpqP6qAHkE1/iNoW5HV4YBLSmL2TdQYHnrbCPTkqTKnq2ZhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB0WVjKQ; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB0WVjKQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a803458ba0so756664a12.0
        for <sparclinux@vger.kernel.org>; Fri, 18 Sep 2026 04:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789731389; cv=none;
        d=google.com; s=arc-20260327;
        b=SxTsnFtXrUOdfW0AFKIC3VpcaPGRYEq19J+6f8HayJOyO75mfRUxDF0Ro5P3P+rzEJ
         ZQzeFoxAsV3PhO8Sc3uWkIkcvaNMOV66bCERu//XtEy0n98Odl6WIM6MZQhAiov9RpIT
         5WGBcTfxmtmSdjKtMS+fyel4/fGpPgTGhbDAQEl5/fvqND9lB3Z4i+43n77YwxgXos8O
         Ta9O79ExXsTr6MCGdZsuVjghZ02IjTSqttb6U1nwbEJXrGEPhurvLjXMYoWlKQ4Sa/Dd
         0XNqOZv2owH3vA7daM2f0IEob7QTSK2SS/LUSA+XaWtbkdYesAiacS9lLBbLJMqjDDaa
         Q0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGJXKehN7uzhcfBB0KBhZiEIw68JYp4Edf9oro8cdRI=;
        fh=E2F+LW2N1sgW3rMSpb/xwYoFuro3BXNLqWB0DehGOBQ=;
        b=duyUZCfevYTm3pNv437BJrFCv6fCnSQ4UiDDj9XyUuP5b8+pmSt1eh6V96nPO/ojWL
         DCrtKssyRO61e0UDhxdNZyZdCmrBawJ4POBHJc+fBioVidw6nesdzln6u1iCr3/wHMDM
         9/zBP5Nnpt5e4tNoiY48wrItHVp5TWZPHACmRM3LnPfCGV8Vc+OJ55Iw8NiQUzvATlCi
         DJT6cGDn1UXMrtSN17Nwg1z1H1SsfpOSY2wYvm9IqWiiuC0ozHv6KMD5cBm5UJXvtNt9
         XqGK9AVfSJRzkAsc5OCdsMW2Do5WeQOYOq8JwKRCqt2nurPFBSFHFHVi6iTMhdfKsaZ3
         F/PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731389; x=1790336189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGJXKehN7uzhcfBB0KBhZiEIw68JYp4Edf9oro8cdRI=;
        b=bB0WVjKQFWGFLevQSZ6+wAuVr10y9ueGPJi48P/WjBtC8HiA56X/7cJR6K9vGM0O1b
         LOn9zSnVnB030apqwbpqkCcB8mZ9LvTeNyV8wzjrAVeJPSwPqR0YbfMFFX7oInCp+PO6
         AUrKAP72yTipK6iFJN6rwwDKibX21Hd5VtDQi6St4RCUM1ANGs5FdA15ckkqr0pWqS1M
         dmYrup7gqfRT9F5Zzs0SSzWEO/OrwvnvxLERcm1vKAiyBn3OnaeDPBAat3WD9kx440C8
         44rBdCLqBzQhueA3Sxz9dP/Ix0BSHZ78Qw6u1mlZL+iOzeg6cyHhJb2ZDhy8cpR45RAX
         2B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731389; x=1790336189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGJXKehN7uzhcfBB0KBhZiEIw68JYp4Edf9oro8cdRI=;
        b=Pzhw+2pYw1wWSszZzex8qfMqxc3DxWusfp+3pXO5o32tJbEC+w40u6hr+V6eg0LoWD
         f7YdazAKPJ4S8+ssgftvHqyQc228yzNbWK3o1oONAI0Sp5RFhTycBEWQRL8OmVaLAHED
         gRM4ERoGDBumfp4rmoT7r3/YUjLlh3xllHCGf6dgSG5g9Kwa21V5yc/P4d5EQ+dgW/W1
         3Vh+4bnrJgBm2rKXsPsWT8sNDNK7fTesxlYlNp+i6XpkJbWnCD9Ythvi4qvq2YOL0t5M
         DSRjXtFiModcEh+c+EYWdXx9SNCzgj3yDCK23rF3d+s3HjUlDr2WhfKSrIVpPlBBFAim
         Whfg==
X-Forwarded-Encrypted: i=1; AKwUvBzCoOywXqr/xTyIND2pfUYfSuLvykJINMra2avugwnZO3gDE/EzmpGUc8NRDAgLvywBom7mubuRqXV2@vger.kernel.org
X-Gm-Message-State: AFuF++l9shgadjCSMy++x3WRdahC+/HuTi4d/wiUI2kzztQIBglxw7Nv
	LF7ydyMBsvXke8UAZflqNoAFrD45bXEe7gmaALuMIxUWw1+v8Jx5fSqS2pf1SsmxSVB/zfKq1lr
	3aRHucI2YRfPhvOY91sSxhzdTK3AwaRA=
X-Gm-Gg: AYBFou2BqoUXcWJyCOLMYKd4KPQsyjT+ypHbAYylGYhF5KWaRMydl1Rq0ftTSP8sczV
	px5Yhw+nrrL9iuwLjk2VQyAdv4wM6Cs28bUkGUL/6I9/W+yEajU0d5LyNx6CsArmY8OqPGQlPhH
	WqhdpAG6phfr69tpLI7OAqvGxGI+ur7z1n3Ly4g1aIMU+T6jZn3NXdZDWTU/B4VOCC2Oe+3g+wY
	wqfiUH8g7bnTm5TGXpK1xpzDiGnKKrJJRlVwitQrU7pKHWKsq+/qxzQ4ZE/8XDDGTjZ7ci6/FB1
	hyyaRayDCSzt5EOsbWQu0eYJzQjZgpL2gPVZMA+p71bzcPTzD88W6Fzoru08Dyt3+6ZBCmdXONq
	Q0j4Ge1OlvkfAYNipyxRiVeCdmCCY4CrcGSWaq8kA/A==
X-Received: by 2002:a17:907:948f:b0:c29:5d41:dfe8 with SMTP id
 a640c23a62f3a-c2a1582698fmr217595066b.43.1789731389390; Fri, 18 Sep 2026
 04:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com> <20260917-tonyk-syscall_table-v7-11-f4cd8f8e3265@igalia.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-11-f4cd8f8e3265@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 18 Sep 2026 13:36:17 +0200
X-Gm-Features: AcwNN1W0uIsrBudlRZeSpl5_CSJhjtWRK4S-OK-90sOk1QFHdqx3jezfZnvgjR0
Message-ID: <CA+=Fv5To=fUfD+9OtAcNJcaquBy+xv6oNUFES6sVwpOKzH8qgw@mail.gmail.com>
Subject: Re: [PATCH v7 11/13] alpha: Define entry point for
 set_mempolicy_home_node syscall
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Fri, Sep 18, 2026 at 1:47=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall i=
n
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 52e3538cc7df..8fc4701a6328 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -489,7 +489,7 @@
>  # 557 reserved for memfd_secret
>  558    common  process_mrelease                sys_process_mrelease
>  559    common  futex_waitv                     sys_futex_waitv
> -560    common  set_mempolicy_home_node         sys_ni_syscall
> +560    common  set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
>  561    common  cachestat                       sys_cachestat
>  562    common  fchmodat2                       sys_fchmodat2
>  563    common  map_shadow_stack                sys_map_shadow_stack
>
> --
> 2.55.0
>
>

Looks good to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
