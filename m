Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE93783A2
	for <sparclinux@vger.kernel.org>; Thu, 19 Mar 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930484; cv=pass; b=lhGhsh0hUair6pq6MYZtD+f8jQO7MyzRcH78cCUaxpRqH/I1nkc0EThjdRtpVn2GtFq5Xe+J6YygJerjTDRYruhy/Ix33lYTI6CWZ6xnQiN8kg/ZsiMXflhTvGLJgCxADNZ6H3V13yE/ZkFKi2da7kydQpzf3NsZxPU01MChyIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930484; c=relaxed/simple;
	bh=x6wZk7AvpBRTPYt5th9R3ycT2p5XdAgtnR98fAb1EOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXna/wBdy4eBxFf1JLy4UFyJtgEtLV6abAxXicPEixGUZBavhqcd6R9jMhNXFvoB5uW9sxYrdAQGpcI2avEbuQyPooz/cWHZtu9MRz69+ICzSzGUCCPWCO2dirVkTof2I0JKhg1u1ZdeyvGaUABCdvkZTuFSDc1wEITD8RgB4sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcCKrhoY; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcCKrhoY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66132b22182so1466271a12.2
        for <sparclinux@vger.kernel.org>; Thu, 19 Mar 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773930479; cv=none;
        d=google.com; s=arc-20240605;
        b=ifsae+EvShEV0NgKv5xN0ud1fhpBHmb0WJ0xID4JxI96IA0EfX+4RaM3bqtreFU65n
         HU/H/7MW/ee34PZe7ifTeuPlOQDJwpABacoPamYIci+wQUyFWzwmIw+mjJ1uETgLsZ6I
         GeJmw0wEFhk+UxZFhbz/1muMucDvozjJFxj1caCc0eSXqRSPmA8s3xiZCkMZym786y3e
         Q4kFjkO7bKX116skD07UfgU8AxIcMW8M3Eu+4rEm/jnEZPBUzldEjNzGBubvdu0adGNq
         6TDtsWyo7pdZp2gEagpdAOQ1tEj/6fTagNwLI/HwhS4rk9eM0IK0xg2WCcutIt3j/195
         mNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        fh=X0lL/ZyK9BrQNGI0dHBsm96r44+9EXc7aWJ0Sg3+iwQ=;
        b=lSUAlKKaSKHuegIqry9HN5+kZybe05dq3lp/bk2VmuCwMm3scnpC1BLmg0J4JaL9Mg
         6agWbR4BF7e29iG7U6/P5nE517dljBKP4MgUnM76l0qP03E5U00a1YVac8uDaNUKTHb0
         exXbUlNHRwtbBEIjg3ZnGmcDOKzmyl6RQjE1k2Db0KdpeQfSKxEGnQdzZzkKPtTZlSrN
         4JusKah3ZtceGyS5uK7Y6RsNzGQTif7LIY2Jir+4kDnQGS3EGX3qjRcv4qA6Z53QErRo
         sF+LSgQAkAFz4BeU6BjLo8S/q5n2NvkOLTzoUxcMtGBBCf5p8OWWbvBWs/lJr56B+8y4
         AZxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930479; x=1774535279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=kcCKrhoYX+8CZszcDQbuZD6T4DnxTVx1KFlZ0Jph2pEsT7DV9Mnj1YT1bYrXCuAa+S
         hpDAfQ1xXxUjFpI++GUXCzaWS1y6BSStTwjGD+OnOBciNoZ7Xp1VqamSGoaSAqSZ1u5R
         945g+zKdeorBhg1AKG/Bb90H6R2LtDirpwrPvj5Oh9WzuAiCQSN2EnknkZHTKsbab/zB
         fnD79VSfUGwENxCYTTrjL7dnOT3K9jltAF8JDxfu2vpVHutMN4ta0fP0qdP80PoqOA/o
         HPeL/1Ukubwi4cdQoCwu31uFJ5Bte1R3lZPg/JzllRmeny1zCPKEmeQumCaUrIAZcRJw
         +4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930479; x=1774535279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=Di6wf3ykhez04denfyMG48KhMz+ifiArxw2XinxTjp3bsqVrFxNTzeyUEpOkbqGjTA
         jqBE0qOeK+PrrYxKvFuQSwuJeDocubUB5bhccYcaBV3g7sr0pT0Q+KqciK/CltWYKCzL
         R+V77TMwxHaJ0AN8SIJjuYmNDeBwxD489YHPr2zBis+Xm0/Zq3JvXwO76WJW3xuN0yQD
         Y667ixBmD+Uio56A0FbkNi+cLbte+RZHWPC7ZocXNNCz/eLqLeMlOxc1H9aK6hucQN/4
         e9eDFFfSL1m22W66gj9l4iEeEdIdCzFKBRndQM2NMPPW++LgAH5VAVXVGi79dvrUn0Ly
         eptw==
X-Forwarded-Encrypted: i=1; AJvYcCXvalS4x1E30QoMDGkpSqmJgHpHHLBZt9WlPT03/kY1W7VjFPPjFg2BvXbN387RaUAiHWcF6Ma4i8pP@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxEciJm5z9lfu4OhxCfz4waPxGrTsUjEZ0IOgXNqnpqynmDgA
	+FQj0bw0OzP/iIhRoOc7S7Tpt3Bj7z+hrgVsOdw1rQYB2q+27aqZXurYXwIITYf0f+NJ3V+N9rL
	ZOAvPVK4MhzBltmxvmvbrMGymRrqEXXQ=
X-Gm-Gg: ATEYQzxhy2kBPno2HaHeHjqQDzpoO+zxNuFCH55ro2+VW5a9i0aJS/+2hZx/YJ/eC5r
	KaSpc82e0Pgn2saWEnoOkQ9OPlA5VH7qTU3ZUqse6aOsODOjsXXt0he012W9JT3s/evzmbxJUW1
	6VNblrA+MljMUQ4gGCdcUUqtP2VEyF+EdTQe3E6jlmSKSodSHk+Hkrc5uJUeF5TRXilT+xH7QRQ
	hQ03k+m3dVvrHUIBHYrU8BCbtkCycS9lrCyWufw6S8OwrBGIW9gb/Uzml3AnZDqUhSa8Luz50bX
	frRakBBfgA==
X-Received: by 2002:a17:906:ee83:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b97f4ab7799mr545864466b.41.1773930478856; Thu, 19 Mar 2026
 07:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 19 Mar 2026 09:27:47 -0500
X-Gm-Features: AaiRm52wQD6uRKulnt1Y_ioaRFL-b1bqEKDLHZMA0LYwV13CAWHAV79Bf5laR-o
Message-ID: <CAFTtA3O74BTJz8d87CJFQpa8Sub_ouKyyAB8cTXUxd=BnUzS7Q@mail.gmail.com>
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:27=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h |  2 --
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/aux=
vec.h
> new file mode 100644
> index 000000000000..fb4233445276
> --- /dev/null
> +++ b/arch/riscv/include/asm/auxvec.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Regents of the University of California
> + */
> +
> +#ifndef _ASM_RISCV_AUXVEC_H
> +#define _ASM_RISCV_AUXVEC_H
> +
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH    10
> +
> +#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/ua=
pi/asm/auxvec.h
> index 95050ebe9ad0..0a725f2aa2e7 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -33,8 +33,6 @@
>  #define AT_L3_CACHESIZE                46
>  #define AT_L3_CACHEGEOMETRY    47
>
> -/* entries in ARCH_DLINFO */
> -#define AT_VECTOR_SIZE_ARCH    10
>  #define AT_MINSIGSTKSZ         51
>
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
>
> --
> 2.53.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
