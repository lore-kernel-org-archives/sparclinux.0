Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF08EC0;
	Thu,  7 Nov 2024 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730955564; cv=none; b=TFuzg7iHGg63Ld5uP98+5iA0gzwZyBDIWEZGzW6BEU3GbyRGvLaEdn1/pqAuOGESFuG2RuZYkyEVF2Yeq5VUOocn5SObCok3mQr7djq/63lDJUWEINvrYAV1QKXxoZnPGZPSpTiSQfAaqMVt+ckHJaS/4Z42097L8lffhYuZ/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730955564; c=relaxed/simple;
	bh=G7Gxwsmv0+3x5lOyM08ljVWb/XbhyZ2QrdlGiuqIGGQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g98V5JJuY2GcOskM1nzfFXgnZJLq47H3fePCd4YqJIwGYDSbG8aMoGodYll2LmV6q1zx4PQHCUTvJjYaJN2xKcZDkTWuciHsPQlKrKairjaC0D+PzzUVKmCBy5nrOfyyPBNLE/daDp9KrAQ9AHI5fbvTB6aOFKuXiospyHuZnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LfCWsxJa; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LfCWsxJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1730955559; x=1731214759;
	bh=G7Gxwsmv0+3x5lOyM08ljVWb/XbhyZ2QrdlGiuqIGGQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LfCWsxJaELfUNy4MWW7my9jM6f9EGW5SzXgj4lvlgrHZbENCgfTkxOIyqATjVaRdT
	 GKGl6h4HcgB1OKQBkiQQbzQFojSmdQik+S7MwUKkkcEsbDcxp2qS0JuyWvb9s2RFBk
	 GY1/3KUCwYG21nEW/ilWyrZY751vxxbxex4nE5afMhAaDb9jHQ/s/3Dc+s18i5oPec
	 kfAv/yw30LGy7nR6gc4+/PUXnGJ/mEC7TYIM0enEvFUEi8oq7g1dBX0JWvEGYRhZ5l
	 hyOpg50ZBFl1EyPhjOW+zGxOSMSivkH/epFHDT5RWGpMmvUbM4c0pw6cwqDZ5hPPPu
	 go1q3MOq1VpLA==
Date: Thu, 07 Nov 2024 04:59:14 +0000
To: Nathan Chancellor <nathan@kernel.org>
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, glaubitz@physik.fu-berlin.de, Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sparc/build: Put usage of -fcall-used* flags behind cc-option
Message-ID: <rYw6ZTCE58uNrfyK1pJXSaAnn3kXRYBiLf-TYQI8tnJSU3ECWG01RkUahjZC_rkJomCiROTUUvg6Jf1u5VfyBfIalrSF2jHtGqI94MGK8zg=@protonmail.com>
In-Reply-To: <20241029222421.GA2632697@thelio-3990X>
References: <20241029-sparc-cflags-v3-0-b28745a6bd71@protonmail.com> <20241029-sparc-cflags-v3-1-b28745a6bd71@protonmail.com> <20241029222421.GA2632697@thelio-3990X>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 0a66f026db29138ca89fc00dcc0965591dc038fd
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nathan Chancellor <nathan@kernel.org> wrote:
>=20
> Clang builds now succeed with this series and builds with GCC 14.2.0
> continue to pass and boot successfully.
>=20
> Reviewed-by: Nathan Chancellor nathan@kernel.org
>=20
> Tested-by: Nathan Chancellor nathan@kernel.org
>=20
> One comment below, please carry these tags forward if there are future
> revisions without substantial technical changes.

Forgive me for still being unfamiliar with the term, but does this mean tha=
t
when I send a v4 I should paste the Reviewed-by and Tested-by lines into th=
e
commit message of the patch?

> > -KBUILD_CFLAGS +=3D -m32 -mcpu=3Dv8 -pipe -mno-fpu -fcall-used-g5 -fcal=
l-used-g7
> > +KBUILD_CFLAGS +=3D -m32 -mcpu=3Dv8 -pipe -mno-fpu $(call cc-option,-fc=
all-used-g5) $(call cc-option,-fcall-used-g7)
>=20
>=20
> Small nit, this (and the one in the vdso) could probably be one
> cc-option call? Is it likely that one flag would be implemented in the
> compiler without the other?
>=20
> $(call cc-option,-fcall-used-g5 -fcall-used-g7)

Ah, didn't know it's possible to do that, the other uses of it I see seem
to use one flag per call. I'll test and send a new revision, thanks.
