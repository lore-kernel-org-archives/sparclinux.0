Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE814A0B8;
	Tue, 25 Jun 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333443; cv=none; b=U8MRJih7E0MOx7E7gW2Lcz/fsndIIN5LK9/jKboBQvSQ6AAAQWuFdJI6o2KME1+ufrCwCfkgR4zLKsBuJMF36f+v6v01fMR7l35t4Mya311pJTSFcAacvUgPMGBh9nvumlwiELeqRpr+9iZCyddGzmu27YPq4M48m+tabMBUvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333443; c=relaxed/simple;
	bh=fnPzckJzBpwtTvvkEfm3K3Gv3jko4xHw6k7B6ll5zXc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk5Qc4ZFniXQABqkhJDeM6ooUu3p4vS4wi9Kz+sff3Di7kn+Eoff3MmB1leZog1kPHDChUzWSsTBdsalIWr7alLnNoacszr9ngxKtptfHDR5/puxJwFlG4dTOsuUK/7hVFtspYSE2L8Z+YdEVRMX5nuG5cxOnXizpekyNdsKuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xDiSTt7t; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xDiSTt7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719333431; x=1719592631;
	bh=fnPzckJzBpwtTvvkEfm3K3Gv3jko4xHw6k7B6ll5zXc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xDiSTt7tz+4vsmZSrWjaFL63uTKGBV2BWBe5l7IioUo9YKRQ28uXYf5jyaKpErlh6
	 78UjmOal/QfRHOzVWF0fG0Z3yzEhl9Lm9vcPs/0jfQu1XqXAv5BT4wtbHF6SohTflJ
	 Tg6y5HqjycK/2g7ScNRenhuRLA4k7hwzt6LB/AckGZ4xyA7mOfG+JyjaNcSS9WlZp7
	 BVEWNFNVtMa2fxohYYxI7pHB+CuCEVPsSifs/KkFbWw4VVFyRzCCzAmBEntjbmE9W3
	 9jmFW+p4Reg9oej3/rh6rg72OJZ9Kq+FSWO9mYmcKQCrXAIRI/crtH9YbGN+w3TVy2
	 xgt74pjbJWbuA==
Date: Tue, 25 Jun 2024 16:37:08 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/build: Make all compiler flags also clang-compatible
Message-ID: <Wcr4bsqUbuLm7J7tfuNMYZZ1cvYyh4CfBDt-siTQySe6jReMpHb7-AXX_Mao7uEh8exzhq6_Tyg9YoRzKCE77KfqFoc6L7_TEE5CuWg5Pp0=@protonmail.com>
In-Reply-To: <e359b140839606b1856c5625669e5b6bd7ebc7eb.camel@physik.fu-berlin.de>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com> <9449319ebbcd59719614ee786f1abe18256d0331.camel@physik.fu-berlin.de> <Mz-kWneLsFvKbBcTaGnC2xMA2U55fINzOJqmMRMumrtTaeHW40WfS5rYUjF_71aoXG56jSHo0vJ0oRPNoCrxpE_oIr7mmnK6fg9dFC_J9hk=@protonmail.com> <e359b140839606b1856c5625669e5b6bd7ebc7eb.camel@physik.fu-berlin.de>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 2dda54422a63525ab282c15bd0175fdcac607147
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
> Would be interesting to find out what Sun's own C/C++ compiler (Sun Studi=
o)
> does in this case. I can try to run some tests on Solaris or you can chec=
k
> out the Solaris machines in the GCC compile farm [1].

I am using the version included in Oracle Studio 12.6, and it seems
that it always emit a EM_SPARC32PLUS type for 32-bit objects.

The documentation for the -xarch also states that even when using
the most generic target (`sparc`), it only supports emitting for V9 ISA
(that is, EM_SPARC32PLUS for 32-bit target):

> sparc
> Compile for the SPARC-V9 ISA.
> Compile for the V9 ISA, but without the Visual Instruction Set (VIS),
> and without other implementation-specific ISA extensions. This option
> enables the compiler to generate code for good performance on
> the V9 ISA.

From https://docs.oracle.com/cd/E77782_01/html/E77803/cc-1.html

Other versions of the compiler might act differently, but sadly I have
no access to them.

> I just had a brief look - will do the proper review later - and I think
> it's the right approach for the time being. However, I am wondering wheth=
er
> we should add "-mv8plus" to clang as well.
>=20
> I wondering though whether "-mcpu=3Dv9 -m32" is truly identical to "-mv8p=
lus"
> or not.

Hmm, so I just found out after some digging that while `-m32 -mv8plus`
and `-m32 -mcpu=3Dv9` can differ a little, I am not sure if supporting
the full behavior in clang would be worth the effort? I think I can
add `-mv8plus`/`-mno-v8plus` as an alias for `-mcpu=3Dv9`/`-mcpu=3Dv8`, but
any more would probably be too much effort for too little gain?

`-mv8plus` basically allows the compiler to treat the G and O registers
as being 64-bit wide, allowing the compiler to use any of the new
64-bit V9 instructions (e.g. `casx`) as it sees fit. From GCC's docs:

> With `-mv8plus`, GCC generates code for the SPARC-V8+ ABI.
> The difference from the V8 ABI is that the global and out registers
> are considered 64 bits wide.=20

https://gcc.gnu.org/onlinedocs/gcc/SPARC-Options.html#index-mv8plus

Note that it does not change value passing in parameters or returns
(outgoing parameters still need to be trimmed to 32-bit even though
they are placed in the O registers, for example) so EM_SPARC32PLUS
objects can be freely mixed with EM_SPARC ones.

Also, this seems to be undocumented, but at least from my testing,
`-mv8plus` implies `-mcpu=3Dv9` unless it gets overridden by a later
`-mcpu` flag. So, in theory, it is totally permissible to have
flags like `-m32 -mno-v8plus -mcpu=3Dv9` or `-m32 -mv8plus -mcpu=3Dv8`,
however this will be useless in practice since the combination will
end up disallowing the compiler from using any V9 instructions...

And so far, looking around at kernel sources at least, there seem
to be no need for such kind of flag combinations... though probably
you or others who are more familar could comment on this?
