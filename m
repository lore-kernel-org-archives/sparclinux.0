Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB225C828
	for <sparclinux@vger.kernel.org>; Sat, 26 Apr 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680676; cv=none; b=six6JoY7gZpQA85qGgEBfbeaVYBXB6LLquF1Ngj861/Gcq6CdwCOQNjWM31aW5Ntxx2EJkKahUwqwha/gOvZ3KEhONWI+Ywqoa1mn6FuQhAJuraAs68c4a/R3waThoBsbVa6lZH1PnGsmwVWG/HcVNYesRBb262hnabHpFx5YzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680676; c=relaxed/simple;
	bh=lwUT3Iv8t9p6mwjxLMSSqUxpKJyupbTKnPyyqPO3ZNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca0fXqlqU05m/R15N613opIBTHG7YhgIqkZVT1Oz7Gq/ovByhvbLdDEgwVrbw+k9cSyYx+KDBMT07n037CSRRV4TZQ3LCluy7zL4M4ptING6EMIHih/tUkpTHiwMPj4iAaAK0ZfrECPEReHFKHEriG15yKtDobxc63Gsf9dwMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mc6MG6/V; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mc6MG6/V"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so6003304a12.0
        for <sparclinux@vger.kernel.org>; Sat, 26 Apr 2025 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745680673; x=1746285473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNlY1Kyobnrt/7plmlszUhTRPyZa/aNAr5+UYAUEWpg=;
        b=Mc6MG6/V6hwO06vE3eA+UHCuAFh26Ni9xSB3MnoZo28aig7wbb4DbE9E1a3fZW0pcs
         hivHrDcIiTfsUfCbHy8L7Yp8+MDzK/m2PXJlFpkZZvq5fltmDFG/7I+/2ttHPPtNqCQ4
         HfP3s0X/gdLU8OsXPu1tChe+cpWZUUG5MeMDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745680673; x=1746285473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNlY1Kyobnrt/7plmlszUhTRPyZa/aNAr5+UYAUEWpg=;
        b=QEx4gIV6cAIAeuAeMTB6zX7+JvGN+CvQQLFfkD666GFplRMUGb3DyzRIHxhqNbBnwf
         c3RxN9ZFdfirhJWZZWiBBPedkDvYNDe242zOfAulL/+J6vC+l01P7RX1SFDLJLkPT4ef
         59f8sSDucTO/VUWXGAz7j/CIKfPSx53KiHWtjYDXcSpi8m/8zPw+ZwbPeb9YXazuRLke
         vyrrgf/TsKtQvqw7qrKL68/UkuvvH73d4IQGiJHgAOQnBMysa3mKBVFDtkJalCjkUbE8
         WYmA6oNQInLiyt0ymzKMHP4WtT46R6RzT55beYD+HW2P6n6j+BDnvFvyH4oGaFFlPoYF
         YS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaI4SRG1Nc/FMjE0+Lmu1cEhmBu5Vow9/2UD0MJ65xbmjSTAH2VwKECCnLrXThrx6TXTXF8R2c8EfP@vger.kernel.org
X-Gm-Message-State: AOJu0YylqYeZRHhYO8v7PGCuXQXuHOFOkZr47LQFRFhTt5vuau8xujug
	aok8hL7+FrmNYy8HTHf2PssAc21GfE4qGcyYSyNilY7eEVcC4kuj9mxpqOcAxgQD7/taSuxxQrE
	vNTE=
X-Gm-Gg: ASbGncty3RXzZrvPI28OfA51KoTdDdBJEYTuCu4pRTmbcCQFD5suQpJAugHhCm2QyF3
	pU6StZCJGA/hsovFDe7HmR+2BMyOV7jZtBgxY/QKVwCEfimFLTm9MsBo60RbJDkXUizVnqtQPzr
	wr4HYcJRG+Nh74lrkVoK5p+nP776itzBtuhJp44rwka7ogQEyEgtfr+wA8cvRZ8IS5GYaZfjnz+
	rdKDAb9bXmA0HsVwLgWq2gNujxCn0SP7zDvC0yPG/JEwewPslxwxGkjesLdaPjeMDp3VwfscRKp
	IaCd/Jj6na/3K8eE7J892puGJC4HIZAVa3q5v/WbQoCdTxea/MjmuqlOPJa1G5IfrA/qZkYGGwD
	0JC8pX7zuwz7EPjI=
X-Google-Smtp-Source: AGHT+IH7xPA2goR1oWhu2y5K7jE5PRopfgkuiyVrCY8jH59KrM1Djb9yFSZpUFBC4zkzRrUfIPiJMw==
X-Received: by 2002:a17:907:3f9a:b0:ac7:c688:9fd7 with SMTP id a640c23a62f3a-ace848f7749mr280099266b.18.1745680672798;
        Sat, 26 Apr 2025 08:17:52 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbc3sm302981166b.3.2025.04.26.08.17.51
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so5851557a12.2
        for <sparclinux@vger.kernel.org>; Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5n1OtFpHj9tFmybDK+rSJzE0qs4lvELIssfQHDAqwP2+WOoXeTCFo4iVrrqAECysbaMMW1UxWgoQq@vger.kernel.org
X-Received: by 2002:a17:907:7e95:b0:ac3:8895:2776 with SMTP id
 a640c23a62f3a-ace848c0439mr259814066b.5.1745680670908; Sat, 26 Apr 2025
 08:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426065041.1551914-1-ebiggers@kernel.org>
In-Reply-To: <20250426065041.1551914-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Apr 2025 08:17:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_ArMFL9E9SehR2Z3pfV5QPut0XwbJs9mYWkRvcZcSRw@mail.gmail.com>
X-Gm-Features: ATxdqUFbLPq86s-2TFMi3kWckNkp7TWtoBPlYGSlRtiuXxSXCOJQKui7bzYM-j0
Message-ID: <CAHk-=wg_ArMFL9E9SehR2Z3pfV5QPut0XwbJs9mYWkRvcZcSRw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Architecture-optimized SHA-256 library API
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 23:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Following the example of several other algorithms (e.g. CRC32, ChaCha,
> Poly1305, BLAKE2s), this series refactors the kernel's existing
> architecture-optimized SHA-256 code to be available via the library API,
> instead of just via the crypto_shash API as it was before.  It also
> reimplements the SHA-256 crypto_shash API on top of the library API.

Well, this certainly looks a lot simpler, and avoids the duplicated
crypto glue setup for each architecture.

So this very much seems to be the RightThing(tm) to do.

               Linus
