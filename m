Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFC2FF66A
	for <sparclinux@vger.kernel.org>; Mon, 19 Jan 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817186; cv=none; b=BbmvSvz6Gcai4+CQTd1oa6X/FJoxejAVIKWOuXKlcDbttvafYi8MBXbG7SHuXxfG+IQVU/vaxjDwoXSty+kNd5SmWHs3Y6LqZTtYML6wmXD0DcfBqp20j6psVle+9vP6+xs7wGZoZGhnGdyTbx6wI0v6vUSJw1IkyE0e6ty5+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817186; c=relaxed/simple;
	bh=1JkATqi5wAX+Tb/87K06CYv0cw7OmX176NC/mF093QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InRPXc4vgwBUT5aqDjk4d9WrlNhAz13fr5770EpEfHmmNdSDjY1DwGPZy8Xg1w1DaFRL7Eit2pCOAfaxilqH4wJEGm15a6ew7+i06GQMgKOB1o2z2NJySxphfFJBg7nWLg4K7Tver4x3IT3lXPznpjRrUX37GTuPGGx7LB1fTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNId2tL4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNId2tL4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so21727325e9.1
        for <sparclinux@vger.kernel.org>; Mon, 19 Jan 2026 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768817181; x=1769421981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqVWadMkJ0xV7b+9+R2K7XfNBOxyor4uthrrFNDywHI=;
        b=GNId2tL4UUadX1eRxP+Jav/HOUdQyFp8nhdDul70ZA7S7Us41CtEWt9VRcJg4nKhdn
         uPxukOVDj0Wq0KtfC9SZxdVEksPnLerG0W07HYK9SPp4w7rDoTOO0ynmwMA4GlbOqIoP
         ZGaRp5oCLyQBRCAv9LX3KgM1apjp9JT9BvI6WcXt8+6ZC+jvsVLCqkr2nhzP0TCF9P1X
         LWsncDVpjX10Equ2qlufyi9LDiAx8gd9JVE1vchGqVXgksD2vFfFz3NELiV1IKRHk4XI
         l0ZPXxqbiwZ0uXOi3xYcbXzyuFWai5zF0SnyyFiyRVk5KAa31l1M6/1bREstapugS3hK
         FuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817181; x=1769421981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqVWadMkJ0xV7b+9+R2K7XfNBOxyor4uthrrFNDywHI=;
        b=q3UXFZyU2gx/FgzyQPDuji8gGUEGiupbhRCnz1AP/bNzxsxcKKZkk1L69Eq5cIU/yO
         ulumZnGaQDU8a0BYJUi+fbhvrdJS2uE/lxE6glTm96bp8XU/hMzppesvx0ogF1IgQQeo
         1fwAnIi18/yp0G54zrwmF1x9i53YFQPENmBJ6eBRJLSFKeSaUXMa9d92rc2ywudISuXN
         oJOTWPyp2/lIDAFDj7ldmZ1EQ8/JIWT/v5U7d3b8EbNU5nNTOHNq29yv5tsiKHOfDrCs
         b9XDbTlneMjNYqfw72tfJENx1zsQtOtRG952HovPiDZFVbSGZMdK57iu6ckTua49ggEB
         oC8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhbaK6XMuF7koNIl1tmJJcWRZhxldfD/PDQ6tzpLiQI+ne9oZuKzhezRQNg8Ew9sLqkF46NkDRkFZn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4Ltc3Ofk11/+jDL7pde0qALUpnNVwlDj+LjwKvg/W0ssQfNr
	IMaeyChoNyUwbmuMQw7h4vLGcmgn30FlOp2eNcwLl9grcBlLrt5+1KpW
X-Gm-Gg: AY/fxX7Lu0ZBHVP8aiL/mxTxhWDczj/4wdKaPvrI0cAevk0u8qdF0YYrYuhXUldcGK7
	qA3R6CGNfY8Y+2qst+OjxynHBeVwCGUXqW05mUwuP3e+y2FaCm/9mOEDk6oBxup7xzLn3uc8HLS
	ydOszpQIKLL65Vtv3lqJhtqBfPV6p3nAALFKgmXaKsvsZ+xDlv3JTl4PxeWQTbJe4805iNz5gex
	BL3JTMqlffZiBN/yMfZ1Pi+fj7+5h5nZTkN1PMRqBudZTTosNTf4OdsjqH4PdExTfJkJL987M+K
	l35xuGLeeZ1o26HDam/2IEVXHZhW7V0k97/QCI8Ft2sKpv/H6RtT4iXrlunm4FeoPZtJyiR9OwB
	Qx2YyQODSsghcDsSi5ftJM6YsfF1wpViSiW1YzDKZnmz5QKpG4+KjjDfNbczrKte4xf0BGKnKMB
	IrUx84pJrdvxpYxKpMzIEc/TP7X3vDbT57V9evSUAUX9bB4Rwmj7qA
X-Received: by 2002:a05:600c:5285:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4801e33c1e1mr121349185e9.21.1768817181059;
        Mon, 19 Jan 2026 02:06:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e80c477sm213350375e9.0.2026.01.19.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:06:20 -0800 (PST)
Date: Mon, 19 Jan 2026 10:06:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119100619.479bcff3@pumpkin>
In-Reply-To: <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 08:40:27 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> The value of __BITS_PER_LONG from architecture-specific logic should
> always match the generic one if that is available. It should also match
> the actual C type 'long'.
>=20
> Mismatches can happen for example when building the compat vDSO. Either
> during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> when mismatched CHECKFLAGS are inherited from the kernel build.
>=20
> Add some consistency checks which detect such issues early and clearly.
> The tests are added to the UAPI header to make sure it is also used when
> building the vDSO as that is not supposed to use regular kernel headers.
>=20
> The kernel-interal BITS_PER_LONG is not checked as it is derived from
> CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> deactivated check in include/asm-generic/bitsperlong.h.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-ge=
neric/bitsperlong.h
> index fadb3f857f28..9d762097ae0c 100644
> --- a/include/uapi/asm-generic/bitsperlong.h
> +++ b/include/uapi/asm-generic/bitsperlong.h
> @@ -28,4 +28,18 @@
>  #define __BITS_PER_LONG_LONG 64
>  #endif
> =20
> +/* Consistency checks */
> +#ifdef __KERNEL__
> +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> +#if __BITS_PER_LONG !=3D (__CHAR_BIT__ * __SIZEOF_LONG__)
> +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> +#endif
> +#endif
> +
> +#ifndef __ASSEMBLER__
> +_Static_assert(sizeof(long) * 8 =3D=3D __BITS_PER_LONG,
> +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");

nak...

You can't assume the compiler has _Static_assert().
All the ones that do probably define __SIZEOF_LONG__.
You could use something 'old-school' like:
typedef char __inconsistent_long_size[1 - 2 * (sizeof(long) * 8 !=3D __BITS=
_PER_LONG))];

	David

> +#endif
> +#endif /* __KERNEL__ */
> +
>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
>=20

