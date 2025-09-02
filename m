Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DE306D49
	for <sparclinux@vger.kernel.org>; Tue,  2 Sep 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834077; cv=none; b=mdlghzekQ/F30b8a04ApNR4eqYUqPXG9OmOKN4Q2OqWyI6ihzzMHIDKAH1DSLKWPWWAg07Ofp9SdJoEyZt/n6Y9WouiaI8+Xndt4OKWKk7Uwxd7PujKAor3Au8MXZVX3ex20cWcq6BrrlTviwlmxYIS6jzmtofk1thoMstK0oeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834077; c=relaxed/simple;
	bh=4iECseUcRiiwSDhTQgWjclrJ6BHLnl3yHdBToRWPcTM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGlKOZz+rnaF6jj9LxCyio8IEk/hlkeZnldx1oiIaEokLAl1p7rNKKF2LXe082GbFobPQiilkeLNPrsql4ERVLzU4B6wd12ASNysyalOFF6Cmy/1sDmwNU4mKpBTATTisla5rBFTKNI9zmOJTAqbWS0zKbPPefCLNu2fI0/MuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=X0gvI0ab; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="X0gvI0ab"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=opo+0mS6k3uLazNLLGZrpPjshUV9zbjmEx8g/JYQOlc=; t=1756834074;
	x=1757438874; b=X0gvI0abKuZ01QdvnsEdWCLkEjQqXeVuXuxNjbrFFyLYVYwURi/Gs7+SETuGB
	Kh80byU/MFL40/VA1ShO6QFRCAjPKnxSCjwE6QoaAnWJwjm2RhUwUrJrlcQSVPCUm4NZb2RlzKH5C
	aR3XCaSBAsDEXMH76SdRDY+cKucmB/52VmBbKIvmzOhJ5vOkHkB96RB7UFhAkGTT1t7seJxLkV/I3
	UrqZ9y6tJn8/rHv3ew4RPpZ19fxy5xqjxLam58MxiGyFa6tNUYKcgDmWpdksbsZfu36SqnRsgb5Sn
	3qJBHvqDBCXHAPlJ8q/V1LBdReipS6BKJdVniZiH+UKcYShBKw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utUnQ-000000046fp-3pwk; Tue, 02 Sep 2025 19:27:52 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utUnQ-00000000Fvd-2fPB; Tue, 02 Sep 2025 19:27:52 +0200
Message-ID: <5464e6bb9996a926eea150bddb1491d4d7803ffa.camel@physik.fu-berlin.de>
Subject: Test kernel available - was: Re: 5.10.0-4-sparc64-smp #1 Debian
 5.10.19-1 crashes on T2000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Frank Scheiner <frank.scheiner@web.de>, Riccardo Mottola
	 <riccardo.mottola@libero.it>
Cc: debian-sparc@lists.debian.org, Michael Karcher	
 <kernel@mkarcher.dialup.fu-berlin.de>, sparclinux
 <sparclinux@vger.kernel.org>
Date: Tue, 02 Sep 2025 19:27:51 +0200
In-Reply-To: <a73a4541-46c4-3d37-b82e-db8d543aad92@web.de>
References: <22412473-c5e5-7edb-781e-247ad17d5bac@libero.it>
	 <d40bf065-76a4-4b87-bed8-25ce3fc4ce7e@web.de>
	 <20c0adff-a7bb-68fc-dc84-5ea94fd49f91@libero.it>
	 <38af3187-a151-7b20-0971-b40c8bb008f0@physik.fu-berlin.de>
	 <1d00497f-cc96-313b-f3ba-5fb78db9a85e@libero.it>
	 <2bfd6c8c-e35e-e8e2-5a72-df74c813099d@physik.fu-berlin.de>
	 <6a48107e-3501-8f97-8e57-7148e0b73b26@libero.it>
	 <0b15f50a-afe2-f447-aea8-d82512a05c14@libero.it>
	 <a73a4541-46c4-3d37-b82e-db8d543aad92@web.de>
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

Hi Frank and Ricardo,

On Wed, 2022-02-02 at 15:27 +0100, Frank Scheiner wrote:
> I yesterday found the time to give Linux 5.15.0-3 a try on my T1000
> (UltraSPARC T1) and V210 (US IIIi), but the boot issue is still there -
> at least for my use case: The klibc based tools inside of the initramfs
> are not able to mount the root FS over NFS (details further below).
>=20
> But it's still good to see that mounting an on-disk root FS seems to
> work now for your T2000, though the instabilities during runtime are not
> reassuring.
>=20
> For me the last good Debian kernel - at least for booting, more on that
> shortly - is 5.9.0-5. Both T1000 and V210 boot fine with it (incl.
> mounting the root FS via NFS(v3 BTW)). But during operation (tested with
> `apt upgrade` on a root FS replicated multiple times for testing from
> the same tarball) the V210 crashes (=3D> kernel panic), the T1000 does
> not. For the V210 I also see that for 5.8.0-3. Doing the same with
> kernel 4.19.0-5 running on the V210, no problems are seen, not even the
> messages below.
>=20
> The crash when running 5.9.0-5 or 5.8.0-3 is usually "announced" (or at
> least accompanied) by one or more occurrence(s) of the following messages=
:
> ```
> [...]
> [  360.489852] CPU[0]: Cheetah+ D-cache parity error at
> TPC[00000000005b28c8]
> [  360.580300] TPC<bpf_check+0x1f68/0x34e0>
> [...]
> ```
> ...which should be familiar for UltraSPARC IIIi users with newer kernels
> (see for example [1] which shows it for 4.16.x). According to [2] this
> error should be recoverable (otherwise it would be followed by a panic
> and "Irrecoverable Cheetah+ parity error."), which seems to happen,
> until it is no longer, but I don't see that second message, so something
> else must happen.
>=20
> [1]: https://www.spinics.net/lists/sparclinux/msg21019.html
>=20
> [2]:
> https://github.com/torvalds/linux/blob/master/arch/sparc/kernel/traps_64.=
c#L1767..L1799
>=20
> Of course our CPU's caches don't go pop magically. There is something
> broken in the newer kernels (> 4.19.x) for UltraSPARC IIIi (and most
> likely all the other related processors, too), apart from the mounting
> issues for NFS (see [3] for processors affected by this, update to that:
> US II is not affected, too).
>=20
> [3]: https://lists.debian.org/debian-sparc/2021/12/msg00004.html
>=20
> If I find the time and mood I'll try to bisect this US IIIi specific
> issue in the hope that we will eventually get a fix for it, also still
> hoping for a fix for [4].
>=20
> [4]: https://lists.debian.org/debian-sparc/2021/03/msg00045.html

Can either of you test the following kernel packages on your T1000 or T2000=
:

https://people.debian.org/~glaubitz/sparc64/

These contain a potential fix for the crash you are seeing.

If the kernel works for you, please reply to the following message with a
"Tested-by":

https://lore.kernel.org/all/20250826160312.2070-4-kernel@mkarcher.dialup.fu=
-berlin.de/

If you are not subscribed to the sparclinux kernel mailing list, you can re=
ply
to the message by downloading the following mbox file and importing it into
your mail client of choice, then reply to the imported mail:

https://lore.kernel.org/all/20250826160312.2070-4-kernel@mkarcher.dialup.fu=
-berlin.de/raw

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
