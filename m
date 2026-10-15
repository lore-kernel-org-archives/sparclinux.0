Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039A1E0DE8;
	Thu, 15 Oct 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091350; cv=none; b=ZPoZPdLbn00ja0u72r559qWjAU4ap+ylAHRYJpcTd6IUqqWYhHFHLqSo8HYAJKsT9ReWJVN3hWjVfPtdxzdA8N0dLfyiRJWJaHctYS24dV+D4GYH647V92oxM2cftxoMoOgEv4eBZsOyN9V1595NlkE28aOJLOez4k9SIEF/uKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091350; c=relaxed/simple;
	bh=jUfU0f3zsC10P/8pR6GXO/BKrWJG+Uce66yr3DepwWE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D325imYrhKFOFy25Duo/B8mAFKgt5J1P12LB/tp63gW2geswxfU+uFwCObkLWgeQVF0rreUo/Uxq7IqAZ6TNdaDQ3nGmZ+QGxBngIT+O9HGlpA7HAkJikQ71VBVwCvkQJUu9kJEbE7o6xV9g8gtHOoBUr+SmYVX4Bu7XJCKSGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBovHMBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBovHMBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5400F1F000C5;
	Thu, 15 Oct 2026 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792091349;
	bh=1e8FnY/sUUHomnbKY79841G8lAl+4mTRU7gfh9UH87o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=SBovHMBYM7GQ4Mr8LbgViIa02JsLn1jJJppHVAG1px+qS3YejPLvXgaXC3YsDV+CK
	 Q4y8y13B8xOBV7bHTJpyErGOk2uVcNP5Jw5LiL5019/LvlWFdCBYqg/xq3T0Q/XExx
	 oYkas/LbqEJn7a+YKf6y9Jr0zg/yyJZEVZMkeBoFM+kQMNqL5w4DW7nCcBVzEzo5qt
	 dTsbsajLIakKIGrGQFkDaw7y+3qHD+PzEm1El3Lh26FocgL/+4BjivYmHNV2IVNqpn
	 TOACyBpeEykSFYQXgzABwDH5C5trWWH6+UxBnXwshRH5eG/VQvdxf/MeEmZNu1H/SL
	 piglcmXOUjmYw==
Date: Thu, 15 Oct 2026 21:08:03 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Ramin Moussavi <ramin.moussavi@yacoub.de>
cc: Magnus Lindholm <linmag7@gmail.com>, Andreas Larsson <andreas@gaisler.com>, 
    "David S . Miller" <davem@davemloft.net>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sparc32: emulate casa on V8 CPUs
In-Reply-To: <20261015141508.3335785-1-ramin.moussavi@yacoub.de>
Message-ID: <2de8857e-a5ec-a1b3-cc4e-a201457e1a9b@kernel.org>
References: <20260927005821.8369-3-kaloz@kernel.org> <20261015141508.3335785-1-ramin.moussavi@yacoub.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1709895545-1792091288=:25347"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1709895545-1792091288=:25347
Content-Type: text/plain; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Hi Ramin,

On Thu, 15 Oct 2026, Ramin Moussavi wrote:

> On Sun, Sep 27, 2026 at 02:58 AM Imre Kaloz wrote:
>> so a C library can use one casa for its 32-bit atomics on any V8 part.
>
> I sent a series covering part of the same ground, Magnus and Adrian
> pointed me here -- I had not seen yours, so we worked on the same
> problem in parallel:
> https://lore.kernel.org/sparclinux/20261015085545.3246951-1-ramin.moussavi@yacoub.de/
>
> Your casa emulation looks like a good approach to me. What I would
> still need is a way for a C library to find out whether the kernel
> has it: a library built for v8 needs to keep its own fallback for
> older kernels, and there casa is SIGILL. I see three ways a library
> could tell:
>
> - an AT_HWCAP bit, like HWCAP_SPARC_CASTRAP in Magnus' RFC but meaning
>  "casa works, in hardware or emulated",
> - a system call it can probe for ENOSYS, like patch 4 of my series,
> - or trying casa once under a SIGILL handler at startup.
>
> I know glibc does not want arch-specific atomics: on v8 the compiler
> turns the atomic builtins into calls, and glibc would rather have
> libgcc implement those with casa. But libgcc then faces the same
> question, unless it simply requires a kernel with the emulation; and
> uClibc-ng in my case keeps a fallback for older kernels. So from the
> kernel side the question how a library can tell remains.

Thanks, glad the approach works for you too.

My own view is that moving a C library to casa means rebuilding it
anyway, and that build can simply require a kernel with the
emulation, as with any other new kernel feature a library starts to
depend on. On an older kernel it stops with SIGILL at the first
casa, which at least fails clearly. A library that wants to keep its
fallback can probe casa once under a SIGILL handler, and that works
on every kernel without new ABI. Whichever way you go, use ASI 0x0A:
it also runs natively on LEON parts that have casa.

Whether the kernel should offer an explicit way to tell is Andreas¢
call, though. Andreas, if you¢d like one, I¢m happy to add whatever
you prefer, an AT_HWCAP bit or something else.


Thanks,
Imre
--8323329-1709895545-1792091288=:25347--
