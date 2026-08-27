Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D34B048C
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855199; cv=none; b=kgVy9ImtAohh0rPR7CLoUlWUPVkiXRWY/rw7RlJY7McHMKLPGB6ImAQ48JLYGwDdNpTsFKv/4OxoulmszCEiDerbAyFC0zu6/VskKUhpbo6z/BGlvLY5nJjAJTm7iLC60BLmo8ZKCVHU8B1KXEBEan1Dgp94uBRFs8EnYT9fHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855199; c=relaxed/simple;
	bh=otES2IL0Q5tRQnJ07uBCLSTu7ZT0irLPYULt16jBq/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nK5IW6dbJoxjcdkDOHEHfbgx9RKT0+pXLr/bI3idXQjpGz1hFixJ3eDxWJUhCLriQ+7QPWT+ZtZNKA7BSzw2vRMgDL2/vPJhGWrYqCc/yFgE59KvFZk4zpUvHbrYjvOPelMsr28SbqyAGlWIALkFv/EH0sIKjbHiRTUkS8MQq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=AwmOYLss; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="AwmOYLss"
Message-ID: <f39d0413947affe8e7fb3bc802ca05e96a0cb517.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1787854821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDuiEc5qx4lbQSiINzkv0vJEeJWErNjRuac6m4R4j08=;
	b=AwmOYLssnBX7VrcSvA9E9lXtM9VrzsgKAFeFtmy0GuaC15Oysp55p/6SVVAITAwNxab1ks
	286tGlhWcdcRiGxLNtQ308j204f2TJ4m4Z4a1hWeuUBmEGoInuDEvaDB28MEP1pHSCHo8E
	KxSly6DsY76Vjx2SVDy1fkqwCvbUOx8=
Subject: Re: SPARC kernel soft-lockup with CONFIG_TRANSPARENT_HUGEPAGE and
 Golang
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas
 Larsson <andreas@gaisler.com>, sparclinux <sparclinux@vger.kernel.org>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>, Michael Karcher
 <mail@michael-karcher.net>
Date: Thu, 27 Aug 2026 20:20:21 +0200
In-Reply-To: <fe9a51c4d5a4d1e0ddcc1978bd8ee39ed9c82a72.camel@physik.fu-berlin.de>
References: 
	<fe9a51c4d5a4d1e0ddcc1978bd8ee39ed9c82a72.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Adrian. One small correction, since it changes where to look:
there are two separate bugs here, and only the second one involves THP.

1. The soft lockup itself does not depend on THP (proposed patch [2])
The C reproducer[1] works with CONFIG_TRANSPARENT_HUGEPAGE not set

2. A second, THP-only bug, which is the one Go kept hitting
With patch[2] applied the soft lockup was replaced by intermittent=20
SIGSEGV at an address that made no sense.=C2=A0I believe this is a differen=
t
defect in the huge-page path in arch/sparc/kernel/tsb.S.

THP as the trigger was confirmed, with two tests taken from one boot by
toggling
/sys/kernel/mm/transparent_hugepage/enabled:
  THP=3Dalways   2/2 builds died, at 63 s and 68 s
  THP=3Dnever    2/2 builds completed, 562 s each

After applying patch[3], a native Go toolchain build is green and three
full cgo builds of Grafana Alloy (~2500 packages each) have completed
with no faults, all with THP enabled.


[1]
https://github.com/user-attachments/files/31473033/sparc64-signal-livelock.=
c
[2]
https://github.com/user-attachments/files/31480409/fix-asi-urtt-fill.patch
[3]
https://github.com/user-attachments/files/31487949/fix-hugetlb-fill-glbank.=
patch


--=20
Best regards
Stian Halseth=E2=80=8B

On Thu, 2026-08-27 at 16:53 +0200, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> we recently discovered a new reproducer for triggering a soft-lockup
> in
> the SPARC Linux kernel. The issue was originally discovered by me
> while
> testing Stian Halseth's Go port for SPARC [1].
>=20
> Stian then spent some time on the issue and was able to write a small
> reproducer in C and found out that it can only be triggered when the
> option CONFIG_TRANSPARENT_HUGEPAGE is enabled.
>=20
> The issue is discussed in [2], the C reproducer can be found in [3].
>=20
> Huge thanks go to Stian, both for his efforts to finish the Go port
> for
> SPARC as well as debugging the kernel issue.
>=20
> Adrian
>=20
> > [1] https://github.com/shalseth/go
> > [2] https://github.com/sparclinux/issues/issues/87
> > [3] https://github.com/sparclinux/issues/issues/87#issuecomment-
> > 5431263859
>=20
