Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE621B9FE;
	Mon,  7 Jul 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904369; cv=none; b=RamBXAAFXOlhgj3BED8+MAopkljQvWBEELSj+zoEbFlWnrbxJsV8cSEVMo8Txz08az8L6ohswqtFqcDlR4ZqO4U8q0P0pOfyxQKt7mbVapl1+wt4cxmcY2p2h3kftuzGHICFr/kW4WfYTXFlWsAiQjfQp6cMI41M03GX+WdXVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904369; c=relaxed/simple;
	bh=+mJqc+wkDovarHdy7XtJSfzyuIgbxmtkdkoz+9O46G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHaHYq2E/Qj61cEYjKX7Z/PGZk0R00iFKkh/DUMfpJsfW94inUNpLOMMo7+xM7X6dfn4CIbSNT1/nIuUyi4yfkrdutkSk80iNe8UOcR/TleL5GoobrdCi4zOjOPNH4PTlyewFcf6QIxcAwvEVG/cTappNPeKy8E8SsFmG2gU55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LN3Orkn6; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LN3Orkn6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nRsljUe5zdA6cK+PM2FKLbDHqSoDgLMv0J908LedHws=; t=1751904366; x=1752509166; 
	b=LN3Orkn6AELCRJxc65yAFugFk46tHH8QkMoFq6zAsevAPL+nFvSWMVuV+kW+TJ1m/iKre7RNyfi
	aIAOOaoPnOYD31EVv/3YFwGsfnZwJFmPSGrkxQ9DoRhZZzP5T+nIBDTcTgmwISEWUds/eTm6whkwX
	zfDKJ00WsiobFSDoRI36oy0UHroETUk+nIZqN1QjyYsZXL2pcZzuFSUpYo4W6bokKQjmKoTVl2kTT
	tC9Z37WX/g2R1HDD9cb5eEE3uJsLXA03mhDakvQsay/FCo/UY8QLPVp/MhA6UV8diAvHyyzutLM+1
	LDfbXfofpNGJKSRIqhsjVUyMzN1dl2D1yh9g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uYoLw-00000003kWK-0Qje; Mon, 07 Jul 2025 18:06:00 +0200
Received: from dynamic-089-012-227-082.89.12.pool.telefonica.de ([89.12.227.82] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uYoLv-000000036Cd-3baJ; Mon, 07 Jul 2025 18:06:00 +0200
Message-ID: <6b77e7da8c0bd6f211685bda9f624f8db971bbe1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>,  "David S . Miller"	
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino	
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, Anna-Maria Gleixner	
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Eric
 Biggers	 <ebiggers@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 07 Jul 2025 18:05:58 +0200
In-Reply-To: <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
References: <20250707144726.4008707-1-arnd@kernel.org>
	 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
	 <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
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

On Mon, 2025-07-07 at 17:45 +0200, Arnd Bergmann wrote:
> On Mon, Jul 7, 2025, at 17:22, John Paul Adrian Glaubitz wrote:
> > Hello Arnd,
> >=20
> > On Mon, 2025-07-07 at 16:46 +0200, Arnd Bergmann wrote:
> > > Rip out the whole thing and replace it with a minimal stub as we do
> > > on parisc and uml. This introduces a small performance regression whe=
n
> > > using a libc that is aware of the vdso (glibc-2.29 or higher).
> >=20
> > Can this performance hit quantified in any way?
>=20
> It's trivial to test calling glibc clock_gettime() in a loop
> on a specific piece of hardware, the difference should largely
> depend on how long the timer hardware access takes compared
> to the syscall overhead.
>=20
> On machines that have neither TICK nor STICK clocksource, the
> simpler version should even be minimally faster, on those that
> have one of the two, there is an added cost for entering the
> syscall on every clock_gettime() as we do on architectures without
> vdso.

OK, thanks. Since Andreas has access to a SPARC T4 as of recently, he shoul=
d
be able to test this. Please allow some time for him to review and test the
changes, so we can be sure this doesn't cause any serious regressions.

> > And is there previous serious where this change was made for other arch=
s?
>=20
> See=20
> https://lore.kernel.org/lkml/2078551b-c0b0-4201-b8d7-1faafa3647e6@app.fas=
tmail.com/#t
> for the thread that led to this one.
>=20
> There is also commit 5f55e098b8d0 ("parisc: Add 64-bit gettimeofday()
> and clock_gettime() vDSO functions") that adds similar stubs on
> parisc.

OK, thanks for the pointer.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
