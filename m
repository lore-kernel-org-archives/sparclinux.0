Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015562ECE8B
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118239; cv=none; b=SPx1eWlrZogyO9rl0XOijx6PS6Os0ViotNycg0schmYOn6qV7/7XOoGQdx46vCeRism1ycZ17HEPNkBz9RA+pOsmnRV1BPQfBOmw43UYP12y4GLQzqeHaWwod3bkLKwdDxBjP2ZCDvsmFNq3/AWAr9X2ev60BVc4I3fF5MG9kT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118239; c=relaxed/simple;
	bh=Tfltw911eP3bfpUuhqI8yH1l/Q3ntgW2Uv7+ONu/GnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evgzmSE+gYIRt0HFGgHbuAOdgfs59OdXl1CC4lPktbzVMvwlaqMGAF3pURTEKG8yAV8wMGAbyJwx0O8GWp18B3iVzANhILI9lJO7HRIFCNczZ8lEES4E8DjyvFsAZ5Qih+AY6k+OMmg2yYkDy1DIoIzbbfF2/ENIquugIKkx/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Z6eLgUMM; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Z6eLgUMM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=uOXFxbmsl5lJKduOIknfIH8y61+ERlyJH7qGKafsGAY=; t=1758118236;
	x=1758723036; b=Z6eLgUMMANPgp2lrNmaCR14doebVQIAVqk37EmZ6eZfBbBGPtQ1YuDZib8ib/
	psXZ5wZ+eaZX/C7Tv4BIuxKc1IQnHzU3/GOygVCjhuKLsr0OqQnSh6MRZwDIjWpmb/p8z+2WwcbTo
	fempbn7vJ/kz2Wgexd7wCXouL/YEWhzO2y3hd91TNjM1ydYN9TZxexcw8GCC2MqxqF2kNxahji2ML
	IrKEsw15r8iXrUhQjqGPTsybQZTlW8IZGdnOxqFxqQDV17UeO1ihO7xI0L+ZVSc/ZEXMUvJTOFw/8
	rfn0fQPTG/V4sQqBVioCB1uPdbE8tKGjQfzZ4PT2YKZKBSCePA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uysrh-00000004AkI-3wdV; Wed, 17 Sep 2025 16:10:33 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uysrh-00000003JvK-39g4; Wed, 17 Sep 2025 16:10:33 +0200
Message-ID: <f666c3ad29b117bfdafebe23d42410ac2f1b228e.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Wed, 17 Sep 2025 16:10:33 +0200
In-Reply-To: <2f0fbc24-e73f-5b47-8b7e-ee48e720f899@libero.it>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
	 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
	 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
	 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
	 <a00eb0eb-5276-0f0b-f983-f14d20c62978@libero.it>
	 <701179a7ec724e3d921bcc8e31315f2fea45b4b7.camel@physik.fu-berlin.de>
	 <2f0fbc24-e73f-5b47-8b7e-ee48e720f899@libero.it>
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

On Wed, 2025-09-17 at 16:08 +0200, Riccardo Mottola wrote:
> John Paul Adrian Glaubitz wrote:
> > Looks like your machine has problems with power management.
>=20
> some feature previously not harnessed by older kernels?

Not necessarily a new feature, but simply how the hardware is being used
by the kernel. Could be hardware initialized in a different order etc.

> > Could be issues with the hardware. I would give Solaris 11.3 a try to v=
erify
> > that the hardware is actually working properly.
>=20
> That one is unfortunately long gone. It did work years ago before I=20
> "linuxized" it.
>=20
> Thanks to ALOM, I can check for faults and see:
> sc> showfaults
> Last POST run: SAT JAN 01 02:15:39 2000
> POST status: Passed all devices
>=20
>  =C2=A0 ID FRU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Fault
>  =C2=A0=C2=A0 0 SC/BAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BATTERY at SC/BAT/V_BAT has exceeded low warning=20
> threshold.
>=20
> that should be minor, just my NVRAM battery going low? IIRC it is=20
> user-replacemable on the T2000... put that on my TODO.

We have had someone on the list who ran into weird crashes because of a cor=
rupted
NVRAM. He only found out after test-installing Solaris on the machine confi=
rming
that the issues weren't Linux-specific. Hence the advise to test Solaris 11=
.3.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
