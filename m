Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C57272807
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439225; cv=none; b=PtycCkys9jyQFRYtfXbifsnEfHl73iDukFCVHodMyIDfnvh90V+Eqg1pTkgLRZ2lAqdpFY6EftO8Tj1JEus2gHjhoZcHw8ErtAi0X6C7bI53FHm9vC84cFGxPfiidB8CTRgsNVK00uBG5ME9JqYA8PuY5eztW8vSmO1HFWANdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439225; c=relaxed/simple;
	bh=CJkpZETzrOJvATyv3gBiJb4f890+NaaT3kXeiofzdE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEtDFzk0g+tkgaxoN7ElJKffGQKemrphprGUKMs7JpnavqzgdNOtUhfQ28k4ycg8auBZCRAdRUv1YzGOfs6noCLKXNBqzGAJKcinXMLAPa2iqcX9QAAWfMW92O/VLtlFgrPUBsMMJGcu4rHSykNKfzhwAM4N7mFyz7BLh8yMsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=J74cpqzJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="J74cpqzJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tCO8CvJPq78LPnBXnN/tHf/cCX9rbdNfdwHDrRdC+oE=; t=1757439223;
	x=1758044023; b=J74cpqzJ9qAls/ktSMXKfy5xMJ8dXGx6x8Cc3y7sEm3453T/4YCjzsRwvMyPy
	Zr6/Q5qBsV2EdvbQKzo0V2KplJe2NhDN+EdN7WUyrNPfRO3oCT773iaxuuhyKkqRrPvUwOkD50I07
	DUwFITijmIGEETJxTFrobIjAvPh8VeIJCAo6S4sKFYMQh3hdqcd/Jywo7dIdhlVsnA/GzKFtj82aQ
	DRg7tQ8fYU38ALEQmz+XnFD/XcNKTJKmkpOPohsRFuLKd13wuumKy8AOIjrAh/XLM9OPFO0IEwQff
	cmM7n8rf1iERBkBmnC3eUsQE9SwVmZeLjMXup2/SOKWl406HSg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uw2Dt-00000002U3X-11Nh; Tue, 09 Sep 2025 19:33:41 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uw2Dt-00000000BCH-02vr; Tue, 09 Sep 2025 19:33:41 +0200
Message-ID: <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Tue, 09 Sep 2025 19:33:40 +0200
In-Reply-To: <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
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

On Tue, 2025-09-09 at 19:34 +0200, Riccardo Mottola wrote:
> John Paul Adrian Glaubitz wrote:
> > https://people.debian.org/~glaubitz/sparc64/
> >=20
> > Don't mind the weird version number, it's a 6.12.3 kernel:
> >=20
> > linux (6.12.43-1+nothp1) UNRELEASED; urgency=3Dmedium
> >=20
> >    * Add sparc64_fix_hugetlb.patch
> >    * Add sparc64_fix_copyops.patch
> >    * Disable CONFIG_TRANSPARENT_HUGEPAGE
> >    * Disable CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS
>=20
> Sorry, but this is not a good one. On the Sun Fire T2000 i used the=20
> "smp" kernel and it crashes on boot:
> Loading Linux 6.12+unreleased-sparc64-smp ...tect other bootable=20
> partitions. =C3=A2
> Loading initial ramdisk ...GNU GRUB=C2=A0 version 2.04-16onfiguration. =
=C3=A2
> Check GRUB_DISABLE_OS_PROBER documentation entry. =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.919995] pci 0000:02:00.0: failed to populate child =
OF nodes=20
> (-19)------+ =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.920055] pci 0000:03:01.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.920103] pci 0000:03:02.0: failed to populate child =
OF nodes=20
> (-19))=C2=A0=C2=A0=C2=A0=C2=A0 | =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.920150] pci 0000:03:08.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |4) ... =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.920197] pci 0000:03:09.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.995757] pci 0001:02:00.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.995812] pci 0001:03:01.0: failed to populate child =
OF nodes=20
> (-19)de)=C2=A0=C2=A0 | =C3=A2
> [=C2=A0=C2=A0=C2=A0 2.995860] pci 0001:03:02.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100%
> [=C2=A0=C2=A0=C2=A0 2.995907] pci 0001:03:08.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> [=C2=A0=C2=A0=C2=A0 2.995954] pci 0001:03:09.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> [=C2=A0=C2=A0=C2=A0 2.996002] pci 0001:04:00.0: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> [=C2=A0=C2=A0=C2=A0 2.996048] pci 0001:04:00.2: failed to populate child =
OF nodes=20
> (-19)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |v
> [=C2=A0=C2=A0 10.810326] mptsas 0000:07:00.0: Unable to change power stat=
e from=20
> D3cold to D0, device inaccessible
> [=C2=A0=C2=A0 11.147798] NON-RESUMABLE ERROR: Reporting on cpu=20
> 24-----------------------+
> [=C2=A0=C2=A0 11.147975] NON-RESUMABLE ERROR: TPC [0x000000001017e034]=
=20
> <MakeIocReady+0x10/0x298 [mptbase]>
> [=C2=A0=C2=A0 11.148142] NON-RESUMABLE ERROR: RAW=20
> [1810000000000001:00000010e6e37b64:0000000202000004:000000ea00300000
> [=C2=A0=C2=A0 11.148226] NON-RESUMABLE ERROR:=20
> 0000000000180000:0000000000000000:0000000000000000:0000000000000000]
> [=C2=A0=C2=A0 11.148307] NON-RESUMABLE ERROR: handle [0x1810000000000001]=
 stick=20
> [0x00000010e6e37b64]
> [=C2=A0=C2=A0 11.148382] NON-RESUMABLE ERROR: type [precise nonresumable]
> [=C2=A0=C2=A0 11.148444] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp=
-faulted=20
> priv >
> [=C2=A0=C2=A0 11.148568] NON-RESUMABLE ERROR: raddr [0x000000ea00300000].
> [=C2=A0=C2=A0 11.149692] Kernel panic - not syncing: Non-resumable error.
> [=C2=A0=C2=A0 11.149772] CPU: 24 UID: 0 PID: 405 Comm: (udev-worker) Not =
tainted=20
> 6.12+unreleased-sparc64-smp #1=C2=A0 Debian 6.12.43-1+nothp1
> [=C2=A0=C2=A0 11.149898] Call Trace:
> [=C2=A0=C2=A0 11.149951] [<0000000000eff2b4>] dump_stack+0x8/0x18
> [=C2=A0=C2=A0 11.150042] [<0000000000ef1930>] panic+0xf4/0x398
> [=C2=A0=C2=A0 11.150121] [<000000000042a48c>] sun4v_nonresum_error+0x16c/=
0x240
> [=C2=A0=C2=A0 11.150217] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd=
8
> [=C2=A0=C2=A0 11.150320] [<000000001017e034>] MakeIocReady+0x10/0x298 [mp=
tbase]
> [=C2=A0=C2=A0 11.150426] [<000000001017e4b4>] mpt_do_ioc_recovery+0x9c/0x=
1110=20
> [mptbase]
> [=C2=A0=C2=A0 11.150532] [<000000001017d6f8>] mpt_attach+0xb58/0xd20 [mpt=
base]
> [=C2=A0=C2=A0 11.150636] [<0000000010283f30>] mptsas_probe+0x10/0x440 [mp=
tsas]
> [=C2=A0=C2=A0 11.150761] [<0000000000ad1fac>] pci_device_probe+0xac/0x180
> [=C2=A0=C2=A0 11.150862] [<0000000000b8b8e8>] really_probe+0xc8/0x400
> [=C2=A0=C2=A0 11.150956] [<0000000000b8bcac>] __driver_probe_device+0x8c/=
0x160
> [=C2=A0=C2=A0 11.151050] [<0000000000b8be68>] driver_probe_device+0x28/0x=
100
> [=C2=A0=C2=A0 11.151145] [<0000000000b8c11c>] __driver_attach+0xbc/0x1e0
> [=C2=A0=C2=A0 11.151238] [<0000000000b8927c>] bus_for_each_dev+0x5c/0xc0
> [=C2=A0=C2=A0 11.151328] [<0000000000b8b09c>] driver_attach+0x1c/0x40
> [=C2=A0=C2=A0 11.151419] [<0000000000b8a860>] bus_add_driver+0x180/0x240
> [=C2=A0=C2=A0 11.772806] Press Stop-A (L1-A) from sun keyboard or send br=
eak
> [=C2=A0=C2=A0 11.772806] twice on console to return to the boot prom
> [=C2=A0=C2=A0 11.773113] ---[ end Kernel panic - not syncing: Non-resumab=
le error.=20
> ]---
>=20
>=20
> the first part "failed to populate child OF node" happens also with=20
> kernel that do boot and run successfully.

Keep in mind you may have to keep the machine off for a longer time or rese=
t
the NV-RAM. We've got multiple reports now of machines that became stable
after that.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
