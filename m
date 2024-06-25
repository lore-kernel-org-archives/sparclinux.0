Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378404437A
	for <sparclinux@vger.kernel.org>; Tue, 25 Jun 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281226; cv=none; b=ThMZZCdStxQoHWQPyh82cC0hGdpp4PVlxUoxfOClI4QkMqd2JxhbJz4EvIHs46GjrcO/5BA6c2z/+bQzcQenY1aUuMa9ew0lUkyS3TU/Fs89H2UPExFVgR51oE89hi2aupHBWhY0bfvfaNfaisEHvO1JvVsNzN1TD1mrosYJlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281226; c=relaxed/simple;
	bh=9oiFlq7AV3k2xbej2ZbU4/OiFqF+imjoOPmd3hJcCBI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVRm6Urv8pnPqj6Bm058Dt5liR5ZRhmO3P/PiSzTrnFMjyzuanP9H30ZjgSQzPBPYgdy1w/IsptXVbZiNozba1rTFbhrr0bcFr1Kq1PMaPbBItg19nsyMB/g5fl0Fq/my6bvJx1DryqNaGrDthxFaYRhqbo7t/oFZa8B5VEqo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ip6dVi2p; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ip6dVi2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719281217; x=1719540417;
	bh=9oiFlq7AV3k2xbej2ZbU4/OiFqF+imjoOPmd3hJcCBI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ip6dVi2pEojfzMU9DGPZTBmQOQSKgW4Qy78HLmOWkXVVOjweDC6PixuVRJzjKVlSz
	 aOWKbOkz1drEdV9SHT+UcZ18xxx2H9cSlElSRCqdEsxTZMLUKKzKXuce/KMAyTECc+
	 9LC7Rsb2mrvlbkxkwXZzU+uoqEnZQ7MkrH0Jma56etAjrzHrs/MedrtKeHdnI3tIY5
	 dgc/Sk/9Z8f0QT6RxViqAU0MthZkYXYlz12csAjahmE1CJm8f9bKHv3kKli82I17d/
	 FXAZ34EwhRSXg7lJ1ujVOgTjMxX7Zam3o/N0dS1oq21oBjA1x3zDNQox6zfTkrYLbk
	 IfPNVGmCU0GcA==
Date: Tue, 25 Jun 2024 02:06:54 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/build: Make all compiler flags also clang-compatible
Message-ID: <Mz-kWneLsFvKbBcTaGnC2xMA2U55fINzOJqmMRMumrtTaeHW40WfS5rYUjF_71aoXG56jSHo0vJ0oRPNoCrxpE_oIr7mmnK6fg9dFC_J9hk=@protonmail.com>
In-Reply-To: <9449319ebbcd59719614ee786f1abe18256d0331.camel@physik.fu-berlin.de>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com> <9449319ebbcd59719614ee786f1abe18256d0331.camel@physik.fu-berlin.de>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 537760d7c9f6ad72dbf6cbce2b6cb1dce58bdca2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Adrian~

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> V8plus does not use VIS instructions and also has a different ELF machine
> type, namely EM_SPARC32PLUS instead of EM_SPARCV9 if I understand correct=
ly.
>
> So, we should make sure that the above change will not affect the ELF mac=
hine
> type.

When assembling with GNU as, there seem to be no control as to what
machine type we want to emit, as it simply tries to autodetect it based
on the instruction mix in the assembly code:
- If there's a V9 instruction inside, then use EM_SPARC32PLUS; and
- Emit EM_SPARC otherwise.

This is also the case with GCC - it simply happens that GCC will try
to emit V9 instructions whenever possible with `-m32 -mv8plus`
or `-m32 -mcpu=3Dv9` so there's a high chance that the resulting object
file will be of a EM_SPARC32PLUS type, but this does not seem to be
a guaranteed behavior.

With LLVM's as, we can have finer control of emitted machine type, but
so far it never sets the type to EM_SPARC32PLUS - for this I have made
a patch over at https://github.com/llvm/llvm-project/pull/96583.

As for VIS, GCC (and clang when it eventually supports vectorization)
should not emit it unless explicitly asked, so I think we are
in the clear here?

> With `-mvis`, GCC generates code that takes advantage of
> the UltraSPARC Visual Instruction Set extensions.
> The default is `-mno-vis`.

From https://gcc.gnu.org/onlinedocs/gcc/SPARC-Options.html#index-mvis
