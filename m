Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646A4DA04
	for <sparclinux@vger.kernel.org>; Sat, 23 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211878; cv=none; b=DYrEO8VmAi5NvcEiz5jcpZCeqST3Bt1DT6BNIiy6oxoA9gIaQRAnte63aeJk4ONQru3hUsslmKJb0C4BGWIjmxBd7WrYjZKn2fYgqamUEVo1E1wlzx+9j1SZBZgywKMPSHb5SBl1TfQyCDmdnnpFvfflQSpN4NNgyStB3aTH4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211878; c=relaxed/simple;
	bh=XEiB6i9LbUv2gvZ0g7Rzdz2DBRkWU14YeEGBU6bTRsc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5khF4T0aq+3N0ZnY11Vuv+jw+3Emb3oeNSk6hnqJr2+W/bctASCaLld4B6WPlqu/tOmVFWH/9TXzKfjsN/T3uvqosRbnYDIlkn+qaTUJH9icGsR6apDfvuOcXaQSquqf9Miyv+G/qTp1hswHhGdYKJHDEaOsLFkY5Gu+0i9q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=vh6YNanG; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vh6YNanG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711211860; x=1711471060;
	bh=XEiB6i9LbUv2gvZ0g7Rzdz2DBRkWU14YeEGBU6bTRsc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vh6YNanGH1X20zGK1tfAaV4nESkLDgECUm44By3xP/rrepE0RC54y96FmF8vXXoAX
	 C8OKoFzrhRaela23fr04aAr9c9G2k19VwHX2hon3KR5Ww1bdaSY3UiHRthffDJvkbO
	 vGnHnfWrjy3AqBoDJlHzl0sN3UtpvfHC1wkQiFeZzIg2BjW8P4jyQJcs/uNsUOAo8b
	 hRInHyvu2tAFYn2J7gbRiwVWNGTN3SKlnU3vwFFRAnSLfUFFaRPx7Zh8H1BW/APelU
	 UOHoNnylCMXjdiHAPiN/8IXicIHHkO52kCjxeGvzWdlGLNNJYDuqcCv8wRFnta3igC
	 6Wb2bQ5hnio2Q==
Date: Sat, 23 Mar 2024 16:37:27 +0000
To: Sam Ravnborg <sam@ravnborg.org>
From: Koakuma <koachan@protonmail.com>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "ndesaulniers@google.com" <ndesaulniers@google.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [sparc] Use of -fcall-used-* flags in Makefile?
Message-ID: <FLtGz1AK53Qsar2xlt7KBdmT7JLz3H_NoxJQ0UaC0zqNmBtsQ2eSU6LA_lojbVQh8gArSmZoVikYxEuTC4j75PMP_BcnGPuAM2mv1YK7GHA=@protonmail.com>
In-Reply-To: <20240319221615.GA379167@ravnborg.org>
References: <JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com> <20240319221615.GA379167@ravnborg.org>
Feedback-ID: 6608610:user:proton
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Sam,

Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Koakuma,
> Looking at https://github.com/gcc-mirror/gcc/blob/master/gcc/config/sparc=
/sparc.h
> I read that:
>=20
> On v9 systems:
> g1,g5 are free to use as temporaries, and are free to use between calls
> ...
> g6-g7 are reserved for the operating system (or application in
> embedded case).
>=20
> Based on the above I would assume gcc do not change behaviour with or
> without -fcall-used-g7.
> [...]
> For sparc32 the above file says:
>=20
> g5 through g7 are reserved for the operating system.
>=20
> So again - it looks like -fcall-used-g5 -fcall-used-g7 should have no
> effect here and verification on a real target would be nice.
>=20
> Sam

From my understanding (and looking at the codegen results) those flags
forces GCC to treat the named register as volatile, despite what the ABI
says. However, I also believe that removing them wouldn't be harmful?

To quote my reasoning in the LLVM tracker:
> omitting the flags shouldn't be harmful either - compilers will now
> simply refuse to touch them, and any assembly code that happens
> to touch them would still work like usual (because Linux' conventions
> already treats them as volatile anyway).

But I am not entirely sure about it, that is why it'd be great if there's
some explaination on why those flags were added in the first place.

> I do not have a sparc64 system at my hands - and for this qemu may not
> cut it. But it would be super if someone with a working sparc64 target
> could verify if the kernel could be built and works without
> -fcall-used-g7.

I am currently running a build with those flags taken out on a T5120,
and the kernel seems to be running okay for what I do (LLVM development),
but I don't know if there are more comprehensive test suite for me
to try on.

