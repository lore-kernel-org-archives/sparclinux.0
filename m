Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350E27A935
	for <sparclinux@vger.kernel.org>; Sun, 15 Jun 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750016272; cv=none; b=qD930CWCxIT0MA2YoHtiThG5K5o/4RTnJY1OLdlQZz90JZsFvFax6tnHEQijJY7rp5LAQojH0SKkWX847++wQXCf8Lz/Cj5J8EreQ3sisH8Rhz9byjSHx9GzhU97WHuE4mQBATCekgaO8VYfPelQM5lcYft3BJA5DQrUopzWCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750016272; c=relaxed/simple;
	bh=+DdLJhNZpkF0mq6V6riPNHi40jkfNk/Fbp6sB9glqNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L71IYCoq0SKhqqmflUv1ues12EfuGNvy9/nv0eKSfLOUMGeLLvA2bzaj5PfmnhtWauKXSaTqZ2xwaDzVSoY9KbxP0dkc6XEQwTnNuazYrXjmSZG7y2xuASkdyPCfQUKzmetCPoElhtCNCl3RKJ41N7YH5aFW8xR/XqQaQpM+NGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XbbBwb9x; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XbbBwb9x"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso7898817a12.2
        for <sparclinux@vger.kernel.org>; Sun, 15 Jun 2025 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750016268; x=1750621068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bm1Ypz9xIQ9oSWoxmBY5SZFvMd6ktsJLpK/MNzMMqc=;
        b=XbbBwb9x0ravc+f0FvEQyaH6KRw5Ql9+dOM9gOA809dtqSMOXCwW5EvXmP7KOwndAi
         AF+w8TcehqMCjC7Lg/VfoRGzblQxJx/3L/STaEeHvNnZp101vIzLP5RvCtxaH4/FLmi4
         6l6OnahKKWc02zjXcar7rVlr1Y9VzdtjAbPk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750016268; x=1750621068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bm1Ypz9xIQ9oSWoxmBY5SZFvMd6ktsJLpK/MNzMMqc=;
        b=m0WJlfhGOu5UQ+U5M0AFEM8sX/Sb+DWflbhXhDeLLen6BmU+l6+0D4oCUtfdtV9Efq
         24ccctYgNoWziGUC3ArTy8zzjxrCeW+CwFc7YZHXn4qVo0oUCIlspSpweLNM8eADnyNv
         QfcqZynKVSpdGeqKZDQZOEbEQcsw7i9Iz0hnYK76IfsVjxo0igS6PgeEssLdUDugYMza
         mAN6rblDw7hQ+CXheKvxY3R367obZ7cfjFFtY5IG5Lr6VRKsIn8p3kz7+z6U/uGdAARa
         t2alRw8679VlvBpI9ipsgwTUhIFJxNWBouC43TrOoF4s0W9QlUV5QNQRWfkA3fy6lgpB
         /Fwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYFBF5oaG4CFrS/wUgV/yBqI4UwBPBy6RhRql0u6HERtWAdGvuwkS41N3MrtYcVjnD8KvlBd8pUNKL@vger.kernel.org
X-Gm-Message-State: AOJu0YylRlgPstwXxnEhTc1yG/FJvVoSib6RaaZX2RlFxe1hEBxDaWZb
	0IP9fRjV85eaSOuvhShY2ECB841hPqR007LFP/LoyyHz2k/YpGPy75fOlw9RYJg5QyUbOlrLx9v
	m6MeIISE=
X-Gm-Gg: ASbGncuPcxW4mZ2a1eKr18PnrH63xuwO3/xZko6w8dc7wVZaughOwdnmoAWjZKC4P0V
	NUFYb9D2VLG8zZ7COLACtl0D/063lWRxxNPPv1tDqC9EDPBW/n9+RfruxLWkjQ8ciYflOvdRl6K
	04rlCyLqjJfvpBidK2XMO4Q1MPnjAqH6afxHBfS3/FNcVE2ouy1tFxprvZuCTtE85xWRq8/gTXo
	wICXE+z+jDzb5LW6wv277m19xr2Z80WycvbmHJ7j9/5lunaesLKNi8xh4fBAdlS74T6vD1rseoZ
	IGg3+UOfatApuBv6Ry22Og27gQGJkY2oO0ZLL/nn2h4JaR+1PkmZ3DczlgEs0rTRgf4IisBMHrW
	o7WO/Hyl3sFp46Dv6sx+Txbt37+P5qxWYhvajmJ5Wg3OXpkk=
X-Google-Smtp-Source: AGHT+IEQTlO/DuhwH0oZ+8mgWyHstogC5ZDzjwisfTlasHP3IzahepGXwuq5/uKN9ovmXD5BH87IgA==
X-Received: by 2002:a17:907:2da9:b0:ade:3bec:ea40 with SMTP id a640c23a62f3a-adfad277614mr645842766b.10.1750016267976;
        Sun, 15 Jun 2025 12:37:47 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81566afsm534569166b.19.2025.06.15.12.37.46
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 12:37:46 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so7500986a12.1
        for <sparclinux@vger.kernel.org>; Sun, 15 Jun 2025 12:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9bNrU1NHPShCZQ4/d0cVJcC/elKMHCrQGD1QhpfmBk8dj1mRHsGq4MlNw5EVAV/j5pTGWoyruFCVA@vger.kernel.org
X-Received: by 2002:a05:6402:50cc:b0:5f3:26bb:8858 with SMTP id
 4fb4d7f45d1cf-608d09a2d16mr6285703a12.34.1750016266135; Sun, 15 Jun 2025
 12:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEjo6YZn59m5FnZ_@gondor.apana.org.au> <20250611033957.GA1484147@sol>
 <aEj8J3ZIYEFp_XT4@gondor.apana.org.au> <20250611035842.GB1484147@sol>
 <20250613053624.GA163131@sol> <aEu5cyDOMcKteW_b@gondor.apana.org.au>
 <20250613055439.GB163131@sol> <aEvmmr0huGGd2Psv@gondor.apana.org.au>
 <20250615031807.GA81869@sol> <CAMj1kXGd93Kg0Vs8ExLhK=fxhRBASU9sOPfgYUogv+rwVqgUsg@mail.gmail.com>
 <20250615184638.GA1480@sol>
In-Reply-To: <20250615184638.GA1480@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Jun 2025 12:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAh0fnfm-LomMWDV=OGhCHCp0C_7xZASE_8pZ3ZP0CXg@mail.gmail.com>
X-Gm-Features: AX0GCFsirgA8Ga0u26X0ToUgNd-a86j5gL8Na8fIUJo1Hy2_joO0gogaJwm_iSM
Message-ID: <CAHk-=wiAh0fnfm-LomMWDV=OGhCHCp0C_7xZASE_8pZ3ZP0CXg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ahash - Stop legacy tfms from using the set_virt
 fallback path
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 11:47, Eric Biggers <ebiggers@kernel.org> wrote:
>
> So yes, QCE seems to have only one queue, and even that one queue is *much*
> slower than just using the CPU.  It's even slower than the generic C code.

Honestly, I have *NEVER* seen an external crypto accelerator that is
worth using unless it's integrated with the target IO.

Now, it's not my area of expertise either, so there may well be some
random case that I haven't heard about, but the only sensible use-case
I'm aware of is when the network card just does all the offloading and
just does the whole SSL thing (or IPsec or whatever, but if you care
about performance you'd be better off using wireguard and doing it all
on the CPU anyway)

And even then, people tend to not be happy with the results, because
the hardware is too inflexible or too rare.

(Replace "network card" with "disk controller" if that's your thing -
the basic idea is the same: it's worthwhile if it's done natively by
the IO target, not done by some third party accelerator - and while
I'm convinced encryption on the disk controller makes sense, I'm not
sure I'd actually *trust* it from a real cryptographic standpoint if
you really care about it, because some of those are most definitely
black boxes with the trust model seemingly being based on the "Trust
me, Bro" approach to security).

The other case is the "key is physically separate and isn't even under
kernel control at all", but then it's never about performance in the
first place (ie security keys etc).

Even if the hardware crypto engine is fast - and as you see, no they
aren't - any possible performance is absolutely killed by lack of
caches and the IO overhead.

This seems to also be pretty much true of async SMP crypto on the CPU
as well.  You can get better benchmarks by offloading the crypto to
other CPU's, but I'm not convinced it's actually a good trade-off in
reality. The cost of scheduling and just all the overhead of
synchronization is very very real, and the benchmarks where it looks
good tend to be the "we do nothing else, and we don't actually touch
the data anyway, it's just purely about pointless benchmarking".

Just the set-up costs for doing things asynchronously can be higher
than the cost of just doing the operation itself.

             Linus
