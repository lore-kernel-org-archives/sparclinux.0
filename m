Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA823816D;
	Wed, 23 Jul 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269057; cv=none; b=Cqj12m5GywNiyRK1p0ooC9Lq0b0spCHUVngoXlBvoQjvis1gtcymXtk0nkl7o10f6/hPsDZzg3wWB6mYTrqDnz3Ajg0CkzB0WSDWWqc5j+w2E7qDzknzuafnlRNAc/zZY5kk7XbcrLHrCKb77LCBHHRODyWMyrJnGA452FiCIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269057; c=relaxed/simple;
	bh=DunwfruC9iVmD36ZMU4PtaJNgkrsVxN225+vcXKScF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msZta8Zp2FOguLlThe3cePmtdl+Uui8DWNe2GXTySrS7UTUGrZbRPUJ57s8pFNy8HmgmbYnSJTyBSOqBxRxZZzAVAxZBaau/4EMcE3Ie1JMe7BAHEvKta+KyJaG1bZezEUOPmZeRfdfn/19QwPNTLIWn18ocXJRFO1Oillss0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DeommFLX; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DeommFLX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l1hF9XemOTc1IHnOuFhl4uRUDBrQsmJSosbBAV2OQaU=; t=1753269054; x=1753873854; 
	b=DeommFLXElLKHgkdIaPi/wyemp3d4WkIlNwpNPr9eNLKe0iZ8AO6PenO2nLd5OanqcUQoyuAokW
	SHSds2Zd68EM9F44vrJYFeQc95r9txbllkLzJC1MybnwfdD3teGOdGtAsKO1LsobfT6gNLOd+pJEe
	bMpRave9qYmdnbLEjNep+/0maw4HMvG5+EuckHDM9PMvc6dyMudebhwpa1H11NAXm1UgIKRliHmDt
	UfUHxliXRwdzbYayuV3VrMrDkp6BN01zoZ4tkib01xGpQIvvSO7aPCLk+0hcNfv7FGA4VCOy9ctuZ
	6sNp2EdcbVPVuGtPpGljUJ+Iq4yKyBwKyO5g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ueXMv-000000037LP-1R4R; Wed, 23 Jul 2025 13:10:41 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ueXMv-00000001KPV-0IY5; Wed, 23 Jul 2025 13:10:41 +0200
Message-ID: <0f42d4d49e3b1d9bb1b9b7c323d29e8b1c62c844.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
 <tglx@linutronix.de>,  "David S. Miller" <davem@davemloft.net>, Andy
 Lutomirski <luto@kernel.org>, Vincenzo Frascino	
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd
 Bergmann	 <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
 sparclinux@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 23 Jul 2025 13:10:39 +0200
In-Reply-To: <20250723125455-92ce2791-cb22-4389-a3cf-a9407a14ece8@linutronix.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
	 <20250723125455-92ce2791-cb22-4389-a3cf-a9407a14ece8@linutronix.de>
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

Hi Thomas,

On Wed, 2025-07-23 at 12:57 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Jul 07, 2025 at 04:46:37PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > sparc64 is the only remaining architecture that has its own implementat=
ion
> > of the vdso clock_gettime/gettimeofday helpers in place of the generic
> > code. This causes a number of issues:
> >=20
> >  - Changes to the vdso interfaces require adding sparc64 specific hacks
> >    even when nothing else needs them
> >=20
> >  - The prototypes in <vdso/gettime.h> don't match the function implemen=
tation,
> >    and not including that header to avoid the build error from that cau=
ses
> >    another warning:
> >=20
> >   arch/sparc/vdso/vclock_gettime.c:274:1: error: no previous prototype =
for '__vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> >     274 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_tim=
espec *ts)
> >         | ^~~~~~~~~~~~~~~~~~~~
> >=20
> >  - Nobody has ever implemented the clock_gettime64() vdso that is requi=
red for
> >    32-bit compat tasks
> >=20
> >  - The warning about the missing executable-stack flag was missed:
> >=20
> >   sparc-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.G=
NU-stack section implies executable stack
> >   sparc-linux-ld: NOTE: This behaviour is deprecated and will be remove=
d in a future version of the linker
> >=20
> > Most of the removed code only exists on sparc in order to dynamically
> > patch the vdso based on the presence of the tick vs vtick based
> > clocksource.
> >=20
> > Rip out the whole thing and replace it with a minimal stub as we do
> > on parisc and uml. This introduces a small performance regression when
> > using a libc that is aware of the vdso (glibc-2.29 or higher).
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> FYI I have a series prepared that will move SPARC to the generic vDSO and=
 also
> addresses the problems listed above and mentioned by tglx.
>=20
> I'll send it after the merge window.

Great, thanks a lot! Andreas can then retest the patch and see if the perfo=
rmance
hit is measurable or acceptable at all.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
