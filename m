Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB52DF3E8
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116708; cv=none; b=sZ6XxYrueTFaF3DEb1yXoaLB9imAtj65H2PIdrN3elG7jlYqZziNWPgNoeya1ccuuNcMR5mDeEBVv8SM3eZTE103ThDvnmc/1+Y2XuwaL4W8ocv1VeH+3gyi/Jq7Bw9M+S0Zr4QhhsvkoTQBBFTIbklogIhqLmFOGormOGz4c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116708; c=relaxed/simple;
	bh=vLrvgrekMYOFqJdvWhBzvCUbI+JI4U855Y2yl0Ue+aI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFNrRxGDM7U7hgLUu02y1zLHjEEMRjvabbJjRH8s6+V/kr5wejBXg9D+x9WHpeGdZm5/j+eEk3VXCXBJdyJZAjd3mcaGNRdpXGOppK6Z1j019A3VoyV1higymgEaK2lZRHP5eWf2iG1BvEaN/ehhB2rZLuOrtfb64eWn8iKgvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=j1pMIHY0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="j1pMIHY0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0Utw/K2BdQA5OEt9fqKitQTwsk7/U4TvdqSs7qU/N6E=; t=1758116704;
	x=1758721504; b=j1pMIHY0CFBjceQsC+pjWf6/RPWtQUtYyiPG4CIQbnjtArDwtu2ycyy6/cvXl
	CurbIK7Sz8ulkPxqC8xY10hGzB5iHhyp+s0kEE0eOcDpRLcYILnCBOtU8Eed+xDUrvL8zIiYnHRVt
	qimyRdVZJse/IY3ygr6TMvJwFYUzDuaCYV7XBl3Giqnn0t8Txy68AKgQ9J5oDV7VUuwckOpwVwm+5
	KJavf7cg4OcqKu3vWFGsAdLiHSxMYTa0+0PnYm0i6uGW/4WJo/eW5tmsnK9x0nLPyihLR9DSsmLto
	WSbtXTqhw3mDmwPbJD/ZCTdepIOxCgf0rF554Z+GPjCut+keVg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uysSy-00000003xVH-13bv; Wed, 17 Sep 2025 15:45:00 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uysSy-00000003ENT-0BXw; Wed, 17 Sep 2025 15:45:00 +0200
Message-ID: <701179a7ec724e3d921bcc8e31315f2fea45b4b7.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Wed, 17 Sep 2025 15:44:54 +0200
In-Reply-To: <a00eb0eb-5276-0f0b-f983-f14d20c62978@libero.it>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
	 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
	 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
	 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
	 <a00eb0eb-5276-0f0b-f983-f14d20c62978@libero.it>
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

Hi,

On Wed, 2025-09-17 at 15:38 +0200, Riccardo Mottola wrote:
> Still fails, but there is more error reporting:
> [=C2=A0=C2=A0=C2=A0 9.358051] mptsas 0000:07:00.0: Unable to change power=
 state from=20
> D3cold to D0, device inaccessible
> [=C2=A0=C2=A0=C2=A0 9.695479] NON-RESUMABLE ERROR: Reporting on cpu 24
> [=C2=A0=C2=A0=C2=A0 9.695655] NON-RESUMABLE ERROR: TPC [0x000000001016806=
4]=20
> <MakeIocReady+0x10/0x294 [mptbase]>
> [=C2=A0=C2=A0=C2=A0 9.695821] NON-RESUMABLE ERROR: RAW=20
> [1810000000000007:0000000c3414f764:0000000202000004:000000ea00300000
> [=C2=A0=C2=A0=C2=A0 9.695913] NON-RESUMABLE ERROR:=20
> 0000000000180000:0000000000000000:0000000000000000:0000000000000000]
> [=C2=A0=C2=A0=C2=A0 9.695998] NON-RESUMABLE ERROR: handle [0x181000000000=
0007] stick=20
> [0x0000000c3414f764]
> [=C2=A0=C2=A0=C2=A0 9.696071] NON-RESUMABLE ERROR: type [precise nonresum=
able]
> [=C2=A0=C2=A0=C2=A0 9.696133] NON-RESUMABLE ERROR: attrs [0x02000004] < P=
IO sp-faulted=20
> priv >
> [=C2=A0=C2=A0=C2=A0 9.696238] NON-RESUMABLE ERROR: raddr [0x000000ea00300=
000]
> [=C2=A0=C2=A0=C2=A0 9.697323] Kernel panic - not syncing: Non-resumable e=
rror.
> [=C2=A0=C2=A0=C2=A0 9.697391] CPU: 24 UID: 0 PID: 296 Comm: (udev-worker)=
 Not tainted=20
> 6.17.0-rc5+ #1 NONE
> [=C2=A0=C2=A0=C2=A0 9.697476] Call Trace:
> [=C2=A0=C2=A0=C2=A0 9.697517] [<0000000000436b54>] dump_stack+0x8/0x18
> [=C2=A0=C2=A0=C2=A0 9.697595] [<00000000004294c4>] vpanic+0xdc/0x310
> [=C2=A0=C2=A0=C2=A0 9.697663] [<000000000042971c>] panic+0x24/0x30
> [=C2=A0=C2=A0=C2=A0 9.697726] [<000000000043aea0>] sun4v_nonresum_error+0=
x140/0x200
> [=C2=A0=C2=A0=C2=A0 9.697812] [<0000000000406eb8>] sun4v_nonres_mondo+0xc=
8/0xd8
> [=C2=A0=C2=A0=C2=A0 9.697901] [<0000000010168064>] MakeIocReady+0x10/0x29=
4 [mptbase]
> [=C2=A0=C2=A0=C2=A0 9.697995] [<00000000101684e0>] mpt_do_ioc_recovery+0x=
a0/0x11b4=20
> [mptbase]
> [=C2=A0=C2=A0=C2=A0 9.698101] [<0000000010167748>] mpt_attach+0xae8/0xca0=
 [mptbase]
> [=C2=A0=C2=A0=C2=A0 9.698204] [<00000000101bc010>] mptsas_probe+0x10/0x44=
0 [mptsas]
> [=C2=A0=C2=A0=C2=A0 9.698333] [<0000000000b380d4>] local_pci_probe+0x34/0=
x80
> [=C2=A0=C2=A0=C2=A0 9.698433] [<0000000000b39094>] pci_device_probe+0xb4/=
0x200
> [=C2=A0=C2=A0=C2=A0 9.698520] [<0000000000c05e48>] really_probe+0xc8/0x42=
0
> [=C2=A0=C2=A0=C2=A0 9.698612] [<0000000000c0622c>] __driver_probe_device+=
0x8c/0x160
> [=C2=A0=C2=A0=C2=A0 9.698706] [<0000000000c063e8>] driver_probe_device+0x=
28/0xe0
> [=C2=A0=C2=A0=C2=A0 9.698799] [<0000000000c066c4>] __driver_attach+0xe4/0=
x1e0
> [=C2=A0=C2=A0=C2=A0 9.698891] [<0000000000c03714>] bus_for_each_dev+0x54/=
0xc0
> [=C2=A0=C2=A0 10.320382] Press Stop-A (L1-A) from sun keyboard or send br=
eak
> [=C2=A0=C2=A0 10.320382] twice on console to return to the boot prom
> [=C2=A0=C2=A0 10.320546] ---[ end Kernel panic - not syncing: Non-resumab=
le error.=20
> ]---
>=20
>=20
> I retried and had the quickness to clear console screen to be sure of=20
> message and see this:
>=20
> Loading initial ramdisk .....
>=20
> [=C2=A0=C2=A0=C2=A0 9.337432] mptsas 0000:07:00.0: Unable to change power=
 state from=20
> D3cold to D0, device inaccessible
> [=C2=A0=C2=A0=C2=A0 9.674834] NON-RESUMABLE ERROR: Reporting on cpu 11
> [=C2=A0=C2=A0=C2=A0 9.675005] NON-RESUMABLE ERROR: TPC [0x000000001010206=
4]=20
> <MakeIocReady+0x10/0x294 [mptbase]>
> [=C2=A0=C2=A0=C2=A0 9.675166] NON-RESUMABLE ERROR: RAW=20
> [0b10000000000007:0000000cde51497c:0000000202000004:000000ea00300000
> [=C2=A0=C2=A0=C2=A0 9.675248] NON-RESUMABLE ERROR:=20
> 00000000000b0000:0000000000000000:0000000000000000:0000000000000000]
> [=C2=A0=C2=A0=C2=A0 9.675327] NON-RESUMABLE ERROR: handle [0x0b1000000000=
0007] stick=20
> [0x0000000cde51497c]
> [=C2=A0=C2=A0=C2=A0 9.675399] NON-RESUMABLE ERROR: type [precise nonresum=
able]
> [=C2=A0=C2=A0=C2=A0 9.675461] NON-RESUMABLE ERROR: attrs [0x02000004] < P=
IO sp-faulted=20
> priv >
> [=C2=A0=C2=A0=C2=A0 9.675565] NON-RESUMABLE ERROR: raddr [0x000000ea00300=
000]
> [=C2=A0=C2=A0=C2=A0 9.676654] Kernel panic - not syncing: Non-resumable e=
rror.
> [=C2=A0=C2=A0=C2=A0 9.676722] CPU: 11 UID: 0 PID: 305 Comm: (udev-worker)=
 Not tainted=20
> 6.17.0-rc5+ #1 NONE
> [=C2=A0=C2=A0=C2=A0 9.676808] Call Trace:
> [=C2=A0=C2=A0=C2=A0 9.676849] [<0000000000436b54>] dump_stack+0x8/0x18
> [=C2=A0=C2=A0=C2=A0 9.676926] [<00000000004294c4>] vpanic+0xdc/0x310
> [=C2=A0=C2=A0=C2=A0 9.676994] [<000000000042971c>] panic+0x24/0x30
> [=C2=A0=C2=A0=C2=A0 9.677057] [<000000000043aea0>] sun4v_nonresum_error+0=
x140/0x200
> [=C2=A0=C2=A0=C2=A0 9.677142] [<0000000000406eb8>] sun4v_nonres_mondo+0xc=
8/0xd8
> [=C2=A0=C2=A0=C2=A0 9.677232] [<0000000010102064>] MakeIocReady+0x10/0x29=
4 [mptbase]
> [=C2=A0=C2=A0=C2=A0 9.677325] [<00000000101024e0>] mpt_do_ioc_recovery+0x=
a0/0x11b4=20
> [mptbase]
> [=C2=A0=C2=A0=C2=A0 9.677431] [<0000000010101748>] mpt_attach+0xae8/0xca0=
 [mptbase]
> [=C2=A0=C2=A0=C2=A0 9.677534] [<000000001019c010>] mptsas_probe+0x10/0x44=
0 [mptsas]
> [=C2=A0=C2=A0=C2=A0 9.677664] [<0000000000b380d4>] local_pci_probe+0x34/0=
x80
> [=C2=A0=C2=A0=C2=A0 9.677765] [<0000000000b39094>] pci_device_probe+0xb4/=
0x200
> [=C2=A0=C2=A0=C2=A0 9.677851] [<0000000000c05e48>] really_probe+0xc8/0x42=
0
> [=C2=A0=C2=A0=C2=A0 9.677943] [<0000000000c0622c>] __driver_probe_device+=
0x8c/0x160
> [=C2=A0=C2=A0=C2=A0 9.678036] [<0000000000c063e8>] driver_probe_device+0x=
28/0xe0
> [=C2=A0=C2=A0=C2=A0 9.678129] [<0000000000c066c4>] __driver_attach+0xe4/0=
x1e0
> [=C2=A0=C2=A0=C2=A0 9.678221] [<0000000000c03714>] bus_for_each_dev+0x54/=
0xc0
> [=C2=A0=C2=A0 10.299883] Press Stop-A (L1-A) from sun keyboard or send br=
eak
> [=C2=A0=C2=A0 10.299883] twice on console to return to the boot prom
> [=C2=A0=C2=A0 10.300200] ---[ end Kernel panic - not syncing: Non-resumab=
le error.=20
> ]---
>=20
>=20
> so still random CPU/cores. Does this help, though?

Looks like your machine has problems with power management.

Could be issues with the hardware. I would give Solaris 11.3 a try to verif=
y
that the hardware is actually working properly.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
