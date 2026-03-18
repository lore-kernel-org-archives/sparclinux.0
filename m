Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C73644C3
	for <sparclinux@vger.kernel.org>; Wed, 18 Mar 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814602; cv=pass; b=KJ91auaG8+o6x88B0DHuTVZThXw4c2OkQ7fCjY34Bd0Viue9rZ1j/raCxUiyTJ2ijhX8R0VJ7Z9xqkAAs2/X8Hw1DDqUo4qsbm/RA6t8FPwDbArOOzuCMps40RqBxbx0qePYQ4U6iXpMMbhj3GnTsd/UvBLxkIhrIMrGPiKjnjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814602; c=relaxed/simple;
	bh=LyvuvQqufknbMfPTy2o7n/T+OqohBBDpzWX+jX0Ni6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmZnJFq2BG0xyf6HXzqfkiY/o2Q1MomsZLQnlDiNKBr47j7hlZs7fV89328k5QxXjlC4OubQWPoBeu3B9/OnFr+a52F7zBQP4BkyYaNztNZL6nPt2N8fu0rFOZ5zbYsiGNkCTmPT0q2slSCewDyKNkPlUN4lGhGMtA/hCm4SocE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czA+VIq9; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czA+VIq9"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97a06d7629so541523666b.0
        for <sparclinux@vger.kernel.org>; Tue, 17 Mar 2026 23:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773814598; cv=none;
        d=google.com; s=arc-20240605;
        b=KaXiJ8MP+AlAh53Z96DwWA9TZGKyvtXvqZwo5IcR+sEyMvgRM28X2AcmZu7BNBf0Qp
         /zTzGUyxoF5y3JtAPf9rm06sh1xc8RkWbrhYN6iUgXfpCbeUyZgNCPyPtTFw7jHnb8Tj
         lOvB5FsLucmlrAITtZhcbTQDiNdg040ibXUqwiCnMuNQpXdz0q4P1w8H2BcwJXjcrBbC
         Y/KMOXpcIsLDZdZOW8lYNkeRsHzgm93LGBaELGI1ljNUibikTDis9OpVu/7ek5ZB3o/J
         sejFu5g9YJ4e3wY/QKkrC1z7r49KRxo2S1eIZDTW9ad+QJHsbxm8XB762aJlWYPvgaEH
         MedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        fh=trg7GruATHRVn3Zc7uSlyssQFCVPHTD3CV6XRPg/Hos=;
        b=fOJrQKbrlubJaRTdXudz49vEBa0Df31Y5v6GROcp4m/uQMP1odsHTKKX/KQQ6E39kY
         iJhKYyTUy9IMaHRjxWz5WhC06o6Zi4t+h4FWjlzsUWPG3467eJdCWLj8PUt9C9l6hGrn
         zeJMzq9pjg2U/8f59Zh7NcK4wwVYMXaCrRHm6wyLekWmxJ2nCUOt/Hmoq0jY5GHFlXI8
         VduxsBKsAllo4bbt9jOeolK6ETOWQE2e5TB1/E6bW2dmfSIpm+nnn16XIOcNK3/MaVIT
         0mRJRrljfo/r10IzL90auDRj9fVmm1jmZZgJaoigg3vlVWU14WpTjR+NlB5U/2ie141t
         ksJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814598; x=1774419398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=czA+VIq9QGWQxIWviOuOrte+AkszdW/h15AxwnnBl8PgQdCUSJeFt/rkA58JF8bw1z
         MYdnPYGFr5y46Y9Ze6hH0uQbYgBxWhk4ISCFrpb1oCRqUKW8TesUGp2nfyk/tjdH6ZzI
         DwOCFfQmjthVedmcIE7z/9904oV0s5pfRk6WMlT+ADyKZllzFK45VHyMvAMFKoo37U/j
         J1nqKAueMk09QeZKqRnb2BbN9+d1iclFRFK4eWers79RzlXUT6c5NL6yIGsvvdDwBLkL
         mIaXTaJyIolZxl+55rCZtIapNWvPnqXYQeH5Kjuv+rgtZgAO2r5C3jf4lHbFErXbdAiD
         Zyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814598; x=1774419398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=i7losIGl8dmmlCREFgluqswkNIjuuqdosDMbuC4YhtEASfLd3DJeZugGuRfWyL96Ss
         BT3MOx4Yh0TYXGnWJtfoNeHxJvNBBu8/lexBOjFNSdPtO8gCHNJRuTw0bL6bq0sm9I+p
         NjDJf213hnhxC/cELCr2mx2aJjlhQ0WhRxgPCiWgb/IJKeWT3otjaWibJMS0yI1HFgem
         GATcuBdJ2qTIYAUikKYSU5shuA6sMB1gkuuIugSNnf5ZS2cLKzMY4yikT4GWBOBl5U7o
         skOK4eYJTpA6N0C29NCtE4AQ//5u0asEjmeNAOJE99lsYjZAJT88CDkWOmkiKutOjnif
         OT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4hGEr3mz8WWztQPfj+/bRiabIo2N1T6CGiY7b65424ZYFZupgDRc14jKLxvZxWV6uw3ysFR31LoBz@vger.kernel.org
X-Gm-Message-State: AOJu0YzCb8ghy5Ny8RmIhrWCKT6qPTCjxxd9Q2LJVK9EQyLLhLtQTgsa
	dGEAZrWCl+cV8N3julvvxPAXAiRAxz+wrQmmhV1/7pknrRsWm7hvn/G+MLASB7u5XsF6n3a8Ule
	PVHmP9q3cVjQPclPzpXn7ZVa9FJqb21Q=
X-Gm-Gg: ATEYQzwSjP7qgT5eLSnMM9Iog0uNcg29DbEcfm9UiClSGerceoy9l+DC6W0VnDvEBy3
	lhmI91Kwwndn/RkitND1Ey/zyaUIODvwi8AWkN8LRgM9cV9lUFDqfiOrKH+xbIf3Vupm2F9Rs8W
	EC1KR2KnbHTCjMqt/HbU5ie6ODHzuPwq8iL+GOaD2XbG14V8xXUhrE0Omy/N+t9r1u7wOXzvUgx
	jmufg+3tRD2QWSf7fssG1s7Jv6M0kOE+vdqqWZXD+ESXm0pWtzdt+rJ95bQ3FkVftenYsSOfURk
	JLX0XDxLLad/e1TsTckcGuqEYMX0eRDa+Od1Cr+PzeEuxhEfc3U=
X-Received: by 2002:a17:907:7b93:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b97f4801ab5mr133040366b.15.1773814597747; Tue, 17 Mar 2026
 23:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Mar 2026 07:16:26 +0100
X-Gm-Features: AaiRm51Xx89jeaivgNYAhMk2LxpIu3kD6j5N4SuQDZ84WCnP1EAzJIW2dMNKGiE
Message-ID: <CA+=Fv5RLtUPp9BhXfFEUk3roE3Gah0iUamDEZ-MXCNM_xKm3PA@mail.gmail.com>
Subject: Re: [PATCH 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
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

On Mon, Mar 2, 2026 at 1:32=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/alpha/include/asm/auxvec.h      | 7 +++++++
>  arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>

Build-tested on alpha, no issues here.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
