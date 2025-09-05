Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84827935C;
	Fri,  5 Sep 2025 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054193; cv=none; b=BML4DoBQ0/j1iTFoPIGGqy4qG1NyNccDlD5lKrtulPJgYaP6+C1nMS6vBHUIdskExH1ODZjmkdhqeWs9tJZ2oUw/jmg8o2Yu6e87sXTg13cPigwtIBc23FrSPRhKWtFt3ofIgq+u38lpgWheqUY5s/Mm8WaCGtU93LGNFu8Exco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054193; c=relaxed/simple;
	bh=QUYBHIKAY450Fz4IIvEy5zG10OnMD8Rl9D4aIeaPjAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cV6oxN2TvwrSjs0v39jYZHlANWK4eqAJYU40LWGtkIQeMsk3WSmqKz8Pe/80Gm4Nbp578qLN7GlhaHSQaAtfQyR4mEGQscBMkVtiJ1heJ7LzZ2/ztdmYLpcQCSj+duF/+EZ++yi8ZLGt/5lvSNx1Njq5OjzW35lFHgnBQZU7/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lXpX8BPt; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lXpX8BPt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+K7HTFND7UVMspMIl+Drzz6wetYdHSVytzh9KFZKRLw=; t=1757054190;
	x=1757658990; b=lXpX8BPtJD5JQQ8+fy5RnquzWo3Ai5c43TafpDWfvhIRTTKC4WHnSFeUwJJks
	EArbyCbHnCHWNJ83XZfSeYbvRS1tuq1wwQ6nDQiV9fTFGpT5E32e2fAe3owslrlaruiWSdX2wvFVr
	iPYkQ3s5R+RvbKYRl88BqKn1siooc6lPBZyXAWqo3BOaLlXeHJC1DOU0lGxyhWnNaYNpY44WkzKLa
	wkPEAQzy+GrpWjhL4kFDug7OT0jL4ka51Q+on7CDVT+38Byu+9ifydT+SzV7KrK/2+SPLY2hDTo6X
	uOkf7/1BEr7dr9HY3tefkdlh2iJluoYYtxugDF+9nkohyihLCQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uuQ3e-00000002VMq-3m6Z; Fri, 05 Sep 2025 08:36:26 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uuQ3e-00000003qV9-2oBS; Fri, 05 Sep 2025 08:36:26 +0200
Message-ID: <332d8b631eec7fbf0234ab699e49f19ee059510d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ken Link <iissmart@numberzero.org>, Magnus Lindholm <linmag7@gmail.com>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Andreas Larsson
	 <andreas@gaisler.com>, Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 05 Sep 2025 08:36:26 +0200
In-Reply-To: <CAPZdOsbQYRV=6D1Y62BZw2QH24tx0-+26n0yyG_YutvrocygiQ@mail.gmail.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
	 <CA+=Fv5To0A3N0fajWVhP1SfjD4uv1oaPNOpi9dnFVt9yHfaPQw@mail.gmail.com>
	 <CAPZdOsbQYRV=6D1Y62BZw2QH24tx0-+26n0yyG_YutvrocygiQ@mail.gmail.com>
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

Hi Ken,

On Thu, 2025-09-04 at 22:31 -0500, Ken Link wrote:
> I can provide additional test coverage on a T1000, using Adrian's patched=
 kernel package from:
> https://people.debian.org/~glaubitz/sparc64/linux-image-6.12.3-sparc64-sm=
p_6.12.3-1+sparc64_sparc64.deb
>=20
> $ uname -a
> Linux t1000a 6.12.3-sparc64-smp #1 SMP Debian 6.12.3-1+sparc64 (2025-08-2=
8) sparc64 GNU/Linux
> $ lsb_release -a
>=20
> No LSB modules are available.
> Distributor ID: Debian
> Description: =C2=A0 =C2=A0Debian GNU/Linux bookworm/sid
> Release: =C2=A0 =C2=A0 =C2=A0 =C2=A0unstable
> Codename: =C2=A0 =C2=A0 =C2=A0 sid
> $ sudo dmesg | grep T1000
> [ =C2=A0 =C2=A00.979644] PLATFORM: banner-name [Sun Fire(TM) T1000]
> [ =C2=A0 =C2=A00.980069] PLATFORM: name [SUNW,Sun-Fire-T1000]
> $ lscpu
> Architecture: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sparc64
> =C2=A0 CPU op-mode(s): =C2=A0 =C2=A0 =C2=A032-bit, 64-bit
> =C2=A0 Byte Order: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Big Endian
> CPU(s): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024
> =C2=A0 On-line CPU(s) list: 0-23
> Model name: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UltraSparc T1 (Niaga=
ra)
> =C2=A0 Thread(s) per core: =C2=A04
> =C2=A0 Core(s) per socket: =C2=A06
> =C2=A0 Socket(s): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
> =C2=A0 Flags: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sun4v
> Caches (sum of all): =C2=A0=20
> =C2=A0 L1d: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 192 K=
iB (24 instances)
> =C2=A0 L1i: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 384 K=
iB (24 instances)
> =C2=A0 L2: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
72 MiB (24 instances)
>=20
> Tested-by: Ken Link <iissmart@numberzero.org>

Thanks for the testing. I think Michael will add this as well.

For clarification to Michael, this is a "Sun Fire T1000".

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
