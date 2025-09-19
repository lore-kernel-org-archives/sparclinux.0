Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2D30DD3B
	for <sparclinux@vger.kernel.org>; Fri, 19 Sep 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281643; cv=none; b=eunVjy/cmkmfb9qJldGkLw4LA8eTTDYjTgLVPsLYRB4nclruLms4tsV+kdRyb/1vM4NAt8sd5r7NrXnRyIcRGlKv2z46CUcxQAYTdd0kZiCC9k4gARBT+vghHuMnTOkxfgw6zvCiFosolDQR32jV4V0vqUvmFocsL0lNxToP9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281643; c=relaxed/simple;
	bh=oYdpm756e/uW8vnYGV+erXhhzAepv84wAQeqx/8vuYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVGzoJv+6DXfwXBRUCDpJxGpNreqtS1nQzNRdti5esru77IV5OCP4ERAw41s1cHcAmj/UkkHF+Cx2cLhbTp7y9XrCtLuza/h0W9WeOleuOKxV89KoTq2539rY9UT81nfAncv2ESu6Tu4GI2eVAihiezedjUoYm7rXjWQQ6b3tIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MNrV6L63; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MNrV6L63"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=FSEaFPmWNqwmTI7bckOJBXCor+91fBgiTokGSIwzzA0=; t=1758281639;
	x=1758886439; b=MNrV6L63u9k7XsqZRFhPgTNgNHjDzVa7I37B0AtOd6Zl6QNcztJVAKDG4fNzr
	mBHnaUyO9+Suqy3GDFCYDmNytxKmfil3zDu1k5vt6wQtWKUYBlPAmZ9pCCoNmfX7cIYzooB+hpJq0
	bv4PPUwH2mIqDmfiJoZAtt+APZyAIGcQfmSoYiVaUT0jthkIj2a2VqCUBknbO1M7zvDw6Ls/Fbggz
	skUUSDjZtWO1azmhdwBCQ6dCLLoL+9VRhIAuYAvexc764gEBZtiF/bz9ZkNdw+sq7WsX7pZPCXnfT
	ArqYbqdwKX9nZbC+NVAHZ56OYuzdLAb4z3SSKr/WbX7wa+n6qQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uzZN9-00000001AlQ-3Gvt; Fri, 19 Sep 2025 13:33:51 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uzZN9-000000027kh-2Ldn; Fri, 19 Sep 2025 13:33:51 +0200
Message-ID: <06727889e8c2656c9401bb38586965c9ab1a31c0.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Fri, 19 Sep 2025 13:33:50 +0200
In-Reply-To: <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
	 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
	 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
	 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
	 <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

On Fri, 2025-09-19 at 13:10 +0200, Riccardo Mottola wrote:
> "strong" of my new setup I went bold testing and also exploited one more=
=20
> time the Sun Fire which was "install donor" for this installation before=
=20
> putting back its solaris disks and back in original state.

OK.

> I see this on the V120
> [=C2=A0=C2=A0=C2=A0 2.200440] rtc-m48t59 rtc-m48t59.0: hctosys: unable to=
 read the=20
> hardware clock

No idea, needs to be investigated.

> then the serial console looks a bit garbage, seems terminal types don't=
=20
> work well after apt updates! yet it is standard vt102 or ANSI through=20
> minicom as I always used :(
> I am able to luckily login via ssh. So machine is "alive". Just for=20
> double-check I rebooted the 6.16 kernel and it still spits out crap. I=
=20
> think it is color codes that corrupt something.
>=20
> Sun Fire V120 (1x UltraSparc IIe )
> ---------------------------------------------------------------
>=20
> debian-sparc64 6.16.7+deb14-sparc64 #1 Debian 6.16.7-1 (2025-09-11)=20
> sparc64 GNU/Linux : boots fine

This is an unpatched kernel, so not really relevant.

> debian-sparc64 6.17.0-rc5+ #1 SMP Fri Sep 12 20:37:32 UTC 2025 sparc64=
=20
> GNU/Linux : boots fine

This is the patched kernel, this needs to be tested.

> After several boots and restarts, eventually I got a crash on a "warm=20
> restart"...
>=20
>=20
> on Ultra 2:
> GRUB Loading kernel.... and hangs there.

Nothing to do with the kernel.

> I tried a set-defaults since the nvram chip is flakey until i fix it or=
=20
> a replacement comes, but nothing.
> Coherent with CDROM boot?
>=20
> hangs here....
>=20
>=20
> on Ultra 1:
> GRUB Loading kernel.... and hangs there.
> This one has a good nvram chip. So it appears that the old Ultras don't=
=20
> like GRUB? nor from CD nor from the installed system

The kernel image could be too big. Try stripping it with "strip vmlinux-6.1=
7.0-rc5+"
before rebooting.

> Could the GRUB version be "tailored" to the Fire 120 and not work on=20
> previous systems?

No. GRUB has simply never been really tested on these old machines, I think=
.

> As a 100% re-check I put in the solaris hard disk and it boots.. until=
=20
> it fails to fsck extra partition... I lost a disk. Still enough to prove=
=20
> the system is functional!
>=20
> So... not a shiny future right now for Linux on the old Ultras

You could try setting up SILO on these machines.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
