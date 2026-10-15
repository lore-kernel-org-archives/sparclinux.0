Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C3501F4E;
	Thu, 15 Oct 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057014; cv=none; b=DztQQUi7z4R7yJ3BdXxJRQZhJaeWmi/QqOMR2YF+/ucIDIb/4zmrq603tLXPK54lGDapcEYnC/BhKmD6u9G5WQhFeSMtwPQEh30tU9lbw68yB+p8zPCEPYYRV8+Cl8Lg7P1NEGU3ovTOmVMRhwf3jsrBu8A6aGWUfLMjGF67ees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057014; c=relaxed/simple;
	bh=5sqpNvof8MuHAPKLoe4K3oHc6awGsxJxQTGEKdfGsog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZ6XjSt2fb1eLJcgT/Tn79Oz3UN86VajM59jIscflljPlkbtuCgu+uslKf/P4be3JyN/TzhK0x/5hoBXSom/0ws6GOzgOBQzkWMM4Tlzx+wXeS+gmD9+tAYJSvs3VdpYLChDs+NsbvP0os1Iyc4Y4y8oDKH7saeNcwtPDOU+2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GIWUVXCm; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GIWUVXCm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=x3wN+n+RLe6LYEfdS3KbfapbSOfa7ZrNdty2cZl3Zow=; t=1792057008;
	x=1792661808; b=GIWUVXCm9+dzPanYLm0Sk81nRpdGAPrHkiPaNfOcbAzz4iLQYhzaEGg9r2Hdf
	poHLXuyzmxRBSuXB+og9Zh1QCsek8qaWOdCRTk975uxPxCQgifVx1s8YK5iQJ0qt2PWCIco1+1gNf
	mETtYUDG+9GVddA0sLaIcx/PL91y/temaLtzstJvIQOcXWhFpoH2hNQL02CTWGW4gihJ+u8okmSjC
	WX4P5YicCreS0XC6jsB1IQE5zv3fTNi4mZxdHRwgPAEGFhEdFXY17V59IOV+XH9xzaBhzjdBokIIj
	fhVKIUaEbSFdnIa+yS7MRcDTQVP/RCgxLU2xhyzwHtHZR4jsuQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xHHtF-000000035io-033M; Thu, 15 Oct 2026 11:36:45 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xHHtE-00000003Fwi-3HCV; Thu, 15 Oct 2026 11:36:44 +0200
Message-ID: <8553d8909cc477ae1cb0fc1a071ffe579a8ee40a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sparc32: add the sparc_atomic_cmpxchg_32 system call
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Ramin Moussavi
 <ramin.moussavi@yacoub.de>,  Andreas Larsson <andreas@gaisler.com>, "David
 S . Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Guenter Roeck <linux@roeck-us.net>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Oct 2026 11:36:43 +0200
In-Reply-To: <026b6108-f25b-47a1-a4e0-fa7717d926d4@app.fastmail.com>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
	 <20261015085545.3246951-5-ramin.moussavi@yacoub.de>
	 <026b6108-f25b-47a1-a4e0-fa7717d926d4@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Thu, 2026-10-15 at 11:21 +0200, Arnd Bergmann wrote:
> On Thu, Oct 15, 2026, at 10:55, Ramin Moussavi wrote:
> > User space built for v8 has no compare-and-swap. C libraries emulate it
> > with ldstub locks of their own, and those have two problems the kernel
> > cannot see. They are not async-signal-safe: a handler that reaches an
> > atomic while the code it interrupted holds the lock spins forever. And
> > the kernel does not know them: FUTEX_WAKE_OP and robust futexes write
> > the same words without taking those locks.
>=20
> As far as I know, the baseline in sparc32 glibc has been leon3 or
> sparcv9 for a long time, so CASA should always be available.
>=20
> Any remaining sun4m users are on an ancient userspace with a
> pre-futex glibc.

There are several contributors that are trying to revive Linux on pre-Leon
32-bit SPARC machines. Recently, Magnus Lindholm made some contributions
to be able to boot a modern kernel on his old SuperSPARC workstation [1].

The changes have already been merged into Andreas' tree for linux-next [2].

Adrian

> [1] https://lore.kernel.org/all/20261007174128.959307-1-linmag7@gmail.com=
/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.=
git/log/?h=3Dfor-next

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
