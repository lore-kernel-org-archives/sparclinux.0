Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55592D3EF6
	for <sparclinux@vger.kernel.org>; Mon, 20 Oct 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988101; cv=none; b=T3YLzXwdUUceFYvBZmg25R2XyZ0R6q4rwB384oozg+luUCrBwDxQj+3wU/6Ylmi63Pu0bD7PT9qaOWGDnKMUVoJNzOYCvYlWp95K7ehlSKl2niVRSOAOnvH89dymIsdhfE983lorVtfaV7e09IleBb5iBdLCzZdmgb8KTM2U1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988101; c=relaxed/simple;
	bh=+FvumsqfpDQJZ/idD43MmKSitNxq/j0aWCEe5f0PTEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qAj8Fnc4QTC5Ia+W4j0BxLiQj0dgV5CqBSYsLrKbXtLdw8upsQSGQHtyFzTBb0WGCyWygzhDr29zTjnOOA6Zifc3IUcIEwJjSXi0d2k3VTanuuA5Lpy/j8hUzLVeQSKs1DINMBTI7MjPln9ohfczQwCqQStkd6X3P6cTif6cIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=A+X1bpAw; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="A+X1bpAw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=z8x92ZaYN9FVYs6POlz29VPoNJsMJ9Fr20F8K7ps/gI=; t=1760988097;
	x=1761592897; b=A+X1bpAw19xzus0RONcLGF9lnhcVrvK7c26DJa7gGvBVS0OZrZj0PDFKIieMo
	PTH/4D1ToCUeXZa/VAa5oXZuH7CpJxO/ov344MkSnH8B+QzfxErWajI4BMts7Bh/sYcersLzIHclF
	7WnbTp8kXH7PVT4GDXY+QbK+cJgOujFMDsVrezFVez8K13se1x+DxlXkaaIGYRTTiRsB8VuiUjA8d
	rhXZRWGp9jOZDATo/tsb3N9jiD5Fo1Wdr7zC/XCXRsJDc1OZjiLU39AL8kFmB/gjtg9ZEkTubQhDW
	wtWV8mlYDnSWR5aX8Q64wKXMcSK/0Np4B06JgbPZ6zpH2Dngwg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vAvRi-00000002f1l-1nJ9; Mon, 20 Oct 2025 21:21:30 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vAvRi-00000000i6N-0vG1; Mon, 20 Oct 2025 21:21:30 +0200
Message-ID: <82e4d4e7e4439ebf9b4ead403d5f94e482b416fd.camel@physik.fu-berlin.de>
Subject: Re: New Debian sparc64 test kernel for stack corruption issue
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Mon, 20 Oct 2025 21:21:29 +0200
In-Reply-To: <ed13b363-71b7-0467-00eb-c8dedea39eb8@libero.it>
References: 
	<e61027c249c88484a77d2e1dd2a42d2bc1e2ac06.camel@physik.fu-berlin.de>
	 <ed13b363-71b7-0467-00eb-c8dedea39eb8@libero.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Riccardo,

On Mon, 2025-10-20 at 20:05 +0200, Riccardo Mottola wrote:
> https://people.debian.org/~glaubitz/sparc64/linux-image-6.16.12+3-sparc64=
-smp_6.16.12-2+sparc64.1_sparc64.deb
>=20
> On T2000 with Niagara
>=20
> [=C2=A0=C2=A0 12.126130] mptsas 0000:07:00.0: Unable to change power stat=
e from=20
> D3cold to
> D0, device inaccessible
> [=C2=A0=C2=A0 12.463473] NON-RESUMABLE ERROR: Reporting on cpu 31
> [=C2=A0=C2=A0 12.463643] NON-RESUMABLE ERROR: TPC [0x0000000010184034]=
=20
> <MakeIocReady+0x10/
> 0x298 [mptbase]>
> [=C2=A0=C2=A0 12.463810] NON-RESUMABLE ERROR: RAW=20
> [1f10000000000007:0000000e3179235c:00000
> 00202000004:000000ea00300000
> [=C2=A0=C2=A0 12.463894] NON-RESUMABLE ERROR: 00000000001f0000:0000000000=
000000:00000
> 00000000000:0000000000000000]
> [=C2=A0=C2=A0 12.463975] NON-RESUMABLE ERROR: handle [0x1f10000000000007]=
 stick=20
> [0x0000000
> e3179235c]
> [=C2=A0=C2=A0 12.464050] NON-RESUMABLE ERROR: type [precise nonresumable]
> [=C2=A0=C2=A0 12.464113] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp=
-faulted=20
> priv >
> [=C2=A0=C2=A0 12.464221] NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
> [=C2=A0=C2=A0 12.465352] Kernel panic - not syncing: Non-resumable error.
> [=C2=A0=C2=A0 12.465422] CPU: 31 UID: 0 PID: 367 Comm: (udev-worker) Not =
tainted=20
> 6.16.12+3
> -sparc64-smp #1 NONE=C2=A0 Debian 6.16.12-2+sparc64.1
> [=C2=A0=C2=A0 12.465532] Call Trace:
> [=C2=A0=C2=A0 12.465574] [<00000000004373c4>] dump_stack+0x8/0x18
> [=C2=A0=C2=A0 12.465656] [<0000000000429540>] panic+0xf4/0x398
> [=C2=A0=C2=A0 12.465727] [<000000000043afcc>] sun4v_nonresum_error+0x16c/=
0x240
> [=C2=A0=C2=A0 12.465817] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd=
8
> [=C2=A0=C2=A0 12.465910] [<0000000010184034>] MakeIocReady+0x10/0x298 [mp=
tbase]
> [=C2=A0=C2=A0 12.466007] [<00000000101844b4>] mpt_do_ioc_recovery+0x9c/0x=
1110=20
> [mptbase]
> [=C2=A0=C2=A0 12.466103] [<00000000101836f8>] mpt_attach+0xb58/0xd20 [mpt=
base]
> [=C2=A0=C2=A0 12.466209] [<0000000010287f30>] mptsas_probe+0x10/0x440 [mp=
tsas]
> [=C2=A0=C2=A0 12.466336] [<0000000000b3fab0>] local_pci_probe+0x30/0x80
> [=C2=A0=C2=A0 12.466427] [<0000000000b405d4>] pci_device_probe+0xb4/0x240
> [=C2=A0=C2=A0 12.466518] [<0000000000bfd348>] really_probe+0xc8/0x400
> [=C2=A0=C2=A0 12.466612] [<0000000000bfd70c>] __driver_probe_device+0x8c/=
0x160
> [=C2=A0=C2=A0 12.466709] [<0000000000bfd8c8>] driver_probe_device+0x28/0x=
100
> [=C2=A0=C2=A0 12.466805] [<0000000000bfdb7c>] __driver_attach+0xbc/0x1e0
> [=C2=A0=C2=A0 12.466900] [<0000000000bfacfc>] bus_for_each_dev+0x5c/0xc0
> [=C2=A0=C2=A0 12.466992] [<0000000000bfcafc>] driver_attach+0x1c/0x40
> [=C2=A0=C2=A0 13.088506] Press Stop-A (L1-A) from sun keyboard or send br=
eak
> [=C2=A0=C2=A0 13.088506] twice on console to return to the boot prom
> [=C2=A0=C2=A0 13.088811] ---[ end Kernel panic - not syncing: Non-resumab=
le error.=20
> ]---
>=20
> still crash, but there is some "information"

I have not seen that crash on any of my machines, so I'm really wondering w=
here it comes from.

> Take in consideration that on this sytem my sweet spot for kernel is:
> 6.12.38+deb13-sparc64-smp

Would you be able to bisect this?

> older stuff was crashy, IIRC all newer kernel (or most?) straigt from=20
> debian and most kernel you provided fail to boot.
>=20
> Instead on single-CPU I tested:
>=20
> https://people.debian.org/~glaubitz/sparc64/linux-image-6.16.12+3-sparc64=
_6.16.12-2+sparc64.1_sparc64.deb
>=20
> On Netra T1 UltraSPARC IIe
>=20
> - boots fine
> - basic operations like apt-get work fine
> - some compilation - survives fine
>=20
> In dmesg I see no failures, errors... except this:
>=20
> [=C2=A0=C2=A0=C2=A0 0.952369] pci_bus 0000:01: extended config space not =
accessible
> [=C2=A0=C2=A0=C2=A0 0.957507] pci_bus 0000:02: extended config space not =
accessible
> [=C2=A0=C2=A0 10.402607] This architecture does not have kernel memory pr=
otection.
> [=C2=A0=C2=A0 21.640233] Warning! ehci_hcd should always be loaded before=
 uhci_hcd=20
> and ohci_hcd, not after
> [=C2=A0=C2=A0 33.087538] PM: Image not found (code -22)
> [=C2=A0=C2=A0 35.720238] Not activating Mandatory Access Control as=20
> /sbin/tomoyo-init does not exist.

Out of curiosity, can you try reinstalling the openssh-server package?

# apt install --reinstall openssh-server

This causes crashes for me with certain kernels on UltraSPARC III.

> Then I tried the said kernel on Ultra1 with UltraSPARC I (literally=20
> transferring the same Hard Disk)
> As "expected" there were no improvements over other kernels. same boot=
=20
> failure:
> Invalid sbus slot number 31
> Invalid sbus slot number 31
> error: canonicalise devname failed.
> Can't read disk label.
> Can't open disk label package
> error: unable to open /sbus@1f,0/SUNW,fdtwo@f,1400000.
> Invalid SCSI target number fffe55d0
> error: unable to open /sbus@1f,0/SUNW,fas@e,8800000/sd.
>=20
> This is really the same I even got with 6.1 kernels. I was not able to=
=20
> boot this system into debian at all.

We can look into this later, this is not a kernel but a bootloader problem.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
