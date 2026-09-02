Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A243161A2;
	Wed,  2 Sep 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333321; cv=none; b=YkGiVJrFZLEdiAISUfilHQQw0EWzXhxwjhOxtlnlyg4Ld4qTjPwFu/BdufszdcjyuqJGBa/t8YbM2CibEfq5vpQkPiwWG11JzgItdz/W1PUdpp64+GvebPeva3XdFMt1+BiLrJf1mWVzcFGJWLCPXfNHpdsRxGjspw7qb/w4lP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333321; c=relaxed/simple;
	bh=TULE/6SE5n1boqxK7ZQgRanXq0k+D+3OcpZAkjJBKok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFvnFSCXtU+w91h+a67vzRDdTAy//8x9QuY8aF2A0w4BRHrvyYN+1TdXQobGcclOC01wYiDhLYrxXsAsx7OLgTJjIEdJCSLbFzGorTY/dhNj6CXM8L4PaIvTApLu5hwfzVYK1fkDhLVcUkfsyiys19lyD2raw9a8ZteZGiXu2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=QBLIiwlv; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="QBLIiwlv"
Message-ID: <d4d5d20bd3fd8bab30c1a28fd1eda374e62d9038.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788333315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TULE/6SE5n1boqxK7ZQgRanXq0k+D+3OcpZAkjJBKok=;
	b=QBLIiwlvAWrtqU/vGMgphtTJCoLCvYT3obPLVboVEXANI7dO1tJmg14bt8J4pC4nRtsSR+
	loy4VzTiTBUGhyMS9zqtbikelW1vAjePF9mNAIKZjVu/kn8JVK9NMwscfpP3FYKYvtMEsG
	AjdAokGMIRcXdEjguc3gHNafAeCmxis=
Subject: Re: [PATCH 2/2] selftests/seccomp: add sparc64 support
From: Stian Halseth <stian@itx.no>
To: Kees Cook <kees@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S . Miller"
	 <davem@davemloft.net>, sparclinux@vger.kernel.org, Andy Lutomirski
	 <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov
	 <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 02 Sep 2026 09:15:14 +0200
In-Reply-To: <202609011700.E21C37761@keescook>
References: <20260901220811.3369666-1-stian@itx.no>
	 <20260901220811.3369666-3-stian@itx.no> <202609011700.E21C37761@keescook>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-aCqa6BYqcQXmFQVaMdYN"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-aCqa6BYqcQXmFQVaMdYN
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-01 at 17:02 -0700, Kees Cook wrote:

> Thanks for getting the working on sparc! :)
>=20
Thank you for the quick and friendly review! This is my first feature
submission to the kernel. I've only sent some bug fixes earlier, so
that's much appreciated.=20
>=20
> Is struct sparc64_user_regs not exported to userspace anywhere? We
> haven't normally needed to put the raw user_regs struct definition
> into
> the test before.
>=20
Good point.=20

Sparc has its own PTRACE_GETREGS64/PTRACE_SETREGS64 requests that
transfer the uapi struct pt_regs directly from <asm/ptrace.h>, so thel
ocal definition wasn't needed after all.

One small quirk I hit though. The requests use the historical layout
that omits %g0, so the transferred block starts at %g1 and every u_regs
index is one lower than the register number suggests (%g1 is u_regs[0],
%o0 is u_regs[7]).=A0

Will post v2 with a comment saying so now. Re-ran the suite on
the T4-1 with the new version: still 95 of 95.


--=20
Best regards
Stian Halseth

--=-aCqa6BYqcQXmFQVaMdYN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCapfNAgAKCRDoeAEuJe36
Vp52AP9jy6gTvy82icZnj/+rMwEuR4QwNbTeJI8JhIWa7/a6pAEA7PEqpaJRc5f0
LyqV9/s0/CnhI2LfDaUg/jTUfuTalAk=
=FO2U
-----END PGP SIGNATURE-----

--=-aCqa6BYqcQXmFQVaMdYN--
