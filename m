Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382814;
	b=4rQ48Cz40pjiSPEVGdiKjhAdH1GYmtq+8Y/pCSIhzTTqR8Oq/jeEdkp0Jb+G/KWo6U5H
	 JsdcPOPpVZ3hTZgFwmPErPprjVG/kAYLBlJfDvdLSdly2s2sYqLR5Yb7aOwY6CLeGhUDA
	 rpPhXkbgdjQ3iEVWBS57rTEvuTUzdqZqiNtS8imh92YogLdCcEOUWxSO+sj0XZnhFoLoM
	 a8hv07eIYVG/Htqp0hO4HwzytHEt9iHfQADx0ngCgY6xxxxjSQ/uJeAJs+8D1fS0egaFq
	 RC3gR3G8ug3YepHYvFrzaX58CotONFTsE+7cU/Lu1wY4SLoTgspsZHAS3s8hO/FrHRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
	b=1LwcAQuXLQMmg/4nXK/Lbo3paOjbHWfbcTUkz72nDeAeKf438c15HE2/HPxj1KMNZ+Ym
	 pDlWrSv4owkRZwcOvKgxPY/S8sDOuikfZ8cz+oB3sD7yBImmYnS7cEZcboLq8lBv+Ytc2
	 Gu3apeKfb47keo/d4IhKnG/m1lDUIGP6gDmJorq4WehAv94Rfl8exEHEUseDj6PO6sOuK
	 vMEclbQ33EZNNvJ5+u5p5RUVE/ppe0aywnQlfNE4HQdTe38WxOq6BRW8iNGoSSV9hXmkH
	 lwbC6Qm+bGNeUXFlRTmUfhRG1YFo28wC165QMJkgJiuMTfYZEUo/gOTLOAM4ieXrMhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCD6QF64;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA0606A32A
	for <sparclinux@vger.kernel.org>; Wed, 11 Nov 2026 07:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAA0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCD6QF64
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso1702887a12.1
        for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 23:40:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794382812; cv=none;
        d=google.com; s=arc-20260327;
        b=XY81xseFfJ0LgQYpWzUIx98bYL7AQN/1O/sXDPZZcHW0N1RX/6MgYsryBC4yafOGiX
         wJx6ABc9OE4gnHvAf4KjyiukLgGlV1CZ4jBnDRGfh3aX0B6gHzNq4CqvcD43Asmp5ANV
         Pwxsq6j9rFHOqGzLkN7R4ZKvmG7BK3HcohuW7sFK3/JtAbBDjr3/lDXXMYbfyrDpgKtf
         xD46URO/feLg6m5xvoj9Fx3Z9NmgwFEa5OdFxTtGC9SguPRDDZLFTm9BYmM3zlM75k8h
         +RofxMeFu/OF5+Q/eXFbq8JifdiIPYt3E8PuQdwfCMT3AbJUFnmu9TaCd6HVOTHgQMWJ
         NDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
        fh=cikq3VGXReH54PKhlGFiHhy5sX1zbBIWnaixFSYV+nE=;
        b=A4SD/u6ixO7Chm6ujW5a16fDtmRufI8PS73xFQFqYNCuXBYYN/jYnjDV2qE9uXhn40
         wvFtAC4WNlCBwf6Pw1F2AGU+vaP1PBHxy3QyAPEZQVa+IzVUHDwpxJ7jIv8sBe1ISWJj
         yAqSUoSS6dfGOplkoO0u2gHAs4i+tpmxY40lTIdUkK6uZCOnBCAu8T2+07+j85jGXt6U
         zxtbeFqXcaACdCEjh4hzyr8yyIOc+UZwvq3m2LksRFrZCcXJztYaE7iaRYGDkNeX2CJf
         Ra3OYF60mgKEydMfpC/gZr4XNe/mxEoaFlNnpbOaDjCs/4fJARH+uFGevDu0TJupyyp9
         Evng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794382812; x=1794987612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
        b=VCD6QF64cq+6EajKVeH2KGvi/U5cBgOq2QaZUPujN9TUpScC8tW0bSWQt0oDUSy4JW
         S6Z8D6nWlIJvYo0C12W4DfrOkGdol86fJwYUUTyy4O1KRs5ZZZUMVLH5TcN2PkElzTMC
         CDPcO/9EjC2evHTSCepGDSbwuoSelf7KCGcOupsWhHmqIXstiHNkS+oNFTvRiDsE9USX
         LiWsrb9RYjjdGp3t/FMvX1MXOCXDbkNCM98PDcj50ceTD5evbGSrKBzvVmJsknTflsiz
         goYBb6lxDQzfivXfrbKsifTYJfLVgLYCutTWcyI9Jo7kHyPrf094IrOod562TSGGHij3
         JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794382812; x=1794987612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
        b=qOmB39d3YyIJQYUv3bVMf5yjkKCA8AuqXRId4Iw4cv7UmJ/fpRp79lobcnBtObJ+ok
         JlPaS+4Qzz3shPINMrr8lxudPTCRe2TuN+GF3kz8Gr047zwbMyPkwTNXZNG6IzNX5rLe
         9vYSwC4dSVhu6GKwaE73sZ6a1KInFSOhDBCCoeUpfoDPx+jIh2P3aL8VSPXO9RSJfOXe
         EOYYVKSjZIGKq4exUy+dFOitDv0aO0LdWvGXwYagatL06UC6k9hHwT8zvZ+tHhQ2j0Uy
         Mdg7F5uU7DTScOKxdpUkSaKEmU0zgx6BjxWHIgNU54U/8RhnCRtxJpp1SxhvVNfSW822
         MdVQ==
X-Forwarded-Encrypted: i=1; AL+hErGBYGuwAlaHyH4dFZ7GGOnrYgTMUmsfna2uh6n1DGJDT7Z6PzDqwc9LgZEBgxWnEeViTG/e15RGL3MG@vger.kernel.org
X-Gm-Message-State: APuU4Z+zvVuqxbG2wew1Ik+HkWQkIM6waO067B2Gv7cdJC+XAo9tD3FJ
	LALfmOhD5pfHED3fWK+04DsKcwUcPRg0j1vuoAjEJpuk9f5cnHFzgxueZxKVmtK5Lrpn0Xk1KmO
	2T6f2p1uTKIzqQyY4OQnimTPysmDIEBs=
X-Gm-Gg: AYBFou3q1NFdzE7qPiRlXJicisrZ6G3XMVP/FGG/sq5hwT0zXxevgw5k9HopM9vsxZe
	t0IWMFmeYJqLS7PZIGGOOIzGZzCbFEMEH7K0K+erFyYV6VhU1u9NCVyMPuvioVh6qMoFcdfpSab
	6oncXYALUOOLN/RLs7ISPbxwt2DVtgJVe8JfFnt2YOGdNrKuw5+RFvkhYa1HCKBDo0mPlL6lzBj
	irhNQPuk+G2WrW3fbkzGI2K7miPvNyh4s3CEJVYSakGNu9E8G7YryoA4sHMcVLFqGxRBtnvlRi0
	3SDaUoqN0oJ9HJe84Q5qfcVqZph0TDOrDlnu9vm3yZsoKnn6tULdEkm260f+q7jPZxT/BhfTFZs
	Wro8leGHyVG46JjaxIO8pbHeBmMLZxaIPE1JGX3UOzK/zNUrLO+t+q/XgeAhv3vnCUyVLVg==
X-Received: by 2002:a05:6402:a614:b0:6b4:2aa6:2bf7 with SMTP id
 4fb4d7f45d1cf-6b7773fba00mr814626a12.17.1794382812113; Tue, 10 Nov 2026
 23:40:12 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com> <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Nov 2026 08:40:00 +0100
X-Gm-Features: AclHuK-efo-IN8C0PeBM3H51GRM-qrC5WxHB8slQK0l-tYnt6GeST1OC-lb_0Yw
Message-ID: <CA+=Fv5RNznnVyh4AM_ZTdwyK4iv-8TEO5Ejx0_81sf5CTeoGgw@mail.gmail.com>
Subject: Re: [PATCH v9 10/15] alpha: Define entry point for
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

Hi Andr=C3=A9

On Thu, Nov 5, 2026 at 9:06=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
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
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
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
> 2.56.0
>

My Acked-by already in this patch still stands.

I tested the series against my Alpha for-next, with the integration
adjustments described in my replies to patches 11 and 12. Full GENERIC
SMP and DP264 UP builds passed.

The generated dispatch table changes syscall 560 to
sys_set_mempolicy_home_node as intended. Alpha has no NUMA support,
so this still resolves to the sys_ni_syscall fallback.

Thanks,
Magnus
