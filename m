Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F21367B91
	for <sparclinux@vger.kernel.org>; Wed, 20 May 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294064; cv=none; b=A1ukOI3iCHVTzlWoHFHPMdKJDhZrcPxC3ANDri38iUUgtAfqrmmFTqGD85EpZmeh3GCKApSquJzMAxQJHkTDmLszbicYsmjX7mvBeuDj0YkrldR3qAyMM7whKOxCImFvHYxQYK52/GD6B4IqTurVxOVe1x7/a5iohDr0PfKP/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294064; c=relaxed/simple;
	bh=qYPRTP3iQMlx5HrmiTZPaMTnMA/LljDJ13hVTLdeCFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqi6gjaVpkEKd6hH82lKq4J1EmoHj2vGZ6HNXQ2ufjoDz1nPqOnHT8Bo2G+jJfltgUNbed7fEMXwbAXxUjh8hJS8MQJqz8qApymiRKyfaEgLTwrdG+opwy5uixKN2nzNsOdHWxUmh93Zv354EQ5sGZQTYHLd5J7KURt9M+1+06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=R6SWXnRK; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="R6SWXnRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779294054; x=1779553254;
	bh=qYPRTP3iQMlx5HrmiTZPaMTnMA/LljDJ13hVTLdeCFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R6SWXnRKnfxeRlILBwWc24LPUd49clXY5kFKpfjDETwTRBohzAHSf3cgxRPmxKyHS
	 slrTPeWsLEKHui1aUufqn0yny7xS0FFU7dB221Ztdsmx7iLrBjHGAJnXSRFA/dx3zT
	 hvgVz7fqzQtbrILjdpTEVbEHEHkNfJ2ACc6rs7ShsLpARvW52i3/1jMgqgEFa+RpkC
	 RgEXKWw/KFObVimCEEFymvCRtYCavMFkkh+K3LVYExseb0+Ijn1nRXPMAAZK8PcBSh
	 y8+8opiquF83bjOYeO1+cBrzReTrSBF2SReW+Kp+FJ7YPAkjeWkxDxbMjYvCbjq90T
	 6tis8BqLx+w/w==
Date: Wed, 20 May 2026 16:20:50 +0000
To: Nathan Chancellor <nathan@kernel.org>
From: Koakuma <koachan@protonmail.com>
Cc: Rosen Penev <rosenp@gmail.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, open list <linux-kernel@vger.kernel.org>, "open list:CLANG/LLVM BUILD SUPPORT:Keyword:\\\\b(?i:clang|llvm)\\\\b" <llvm@lists.linux.dev>
Subject: Re: [PATCH] sparc: Avoid unsupported LLD branch relocations
Message-ID: <ov9qx_G3-lAxKXO_ur8gXhE8J5toGs8NkZ2mtMBdwEVND6y0f9CakihiR1kVbaS_lgMVbYs3NegNpFgCRjzzb79wzfbm4_1WeVt1q5pe_f0=@protonmail.com>
In-Reply-To: <20260514125820.GB1781775@ax162>
References: <20260514041908.874355-1-rosenp@gmail.com> <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de> <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com> <20260514125820.GB1781775@ax162>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: dc4801de4e8e130a94d9c0d4ad5566170f8ca541
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nathan Chancellor <nathan@kernel.org> wrote:

> + Koakuma
>=20
> On Wed, May 13, 2026 at 10:34:44PM -0700, Rosen Penev wrote:
> > On Wed, May 13, 2026 at 10:03=E2=80=AFPM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > >
> > > Hi Rosen,
> > >
> > > On Wed, 2026-05-13 at 21:19 -0700, Rosen Penev wrote:
> > > > LLD does not support several SPARC branch relocation types, includi=
ng
> > > > R_SPARC_WDISP16, R_SPARC_WDISP19, and R_SPARC_WDISP22. A sparc64
> > > > allmodconfig LLVM build can therefore fail when trap table code and
> > > > low-level assembly leave branches to global symbols for the linker.
> > > >
> > > > Use local labels for branches that stay within the same assembled
> > > > object so the assembler can resolve them directly. Convert the
> > > > remaining cross-object branches and tail calls to absolute set/jmpl
> > > > sequences, which LLD handles through the usual HI22/LO10 relocation=
s.
> > > >
> > > > Disable the unused sparc32 syscall trace entry points when compat
> > > > support is not built, and request sys_llseek for the native syscall
> > > > table so the LLD allmodconfig build remains self-contained.
> > >
> > > I would rather fix LLD than making such intrusive changes to the SPAR=
C
> > > code in the kernel. In particular, since this touches the CPU-optimiz=
ed
> > > memory routines which had been haunted by subtle bugs for years and w=
ere
> > > only fixed recently.
> > >
> > > Is improving LLD in this case not possible?
> > Above my paygrade. I use this so that allmodconfig succeeds.
>=20
> We document sparc64 as only having support for clang as the compiler
> (not even supporting the integrated assembler yet, although maybe that
> needs to be updated [1]?) in Documentation/kbuild/llvm.rst, so I don't
> think we should take a patch like this. As far as I am aware, ld.lld
> work for sparc64 has not happened yet to make it work with the kernel.
> If you need to test with clang, use CC=3Dclang LLVM_IAS=3D0 with GNU
> binutils (CROSS_COMPILE=3Dsparc64-linux-gnu-).
>=20
> [1]: https://github.com/llvm/llvm-project/issues/40792

Yes, at the moment LLD only has very basic capabilities and still can't lin=
k
the kernel, at least not without some rather invasive changes.
(And even if you manage to land all the changes to the kernel, still there =
are
many complex programs out there that's currently unlinkable by LLD that I f=
eel
like improving LLD would be a better use of resources, in the long term)

As for the integrated assembler, now that PR 187534 [1] is merged it should
be possible to build the kernel with IAS, but that commit hasn't made it in=
to
a release yet so I don't feel like it's the time to update the kernel's
docs... maybe?

[1]: https://github.com/llvm/llvm-project/pull/187534
