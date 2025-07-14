Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1F72600;
	Mon, 14 Jul 2025 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482460; cv=none; b=A6S+nl2KZWEoT5xTKKs4EUQ7mR1/r9vsJmALoobySj8DE3vfVVYC7/MYbBsdzTvcozu/BFVYAsb0O1YjM05yB4ak9NaAteJ4xXGgNLoRwYVT9jrqaAEKYx3T+B7mA1ZEtIfg8WTOHhjQy4aE0ZEaHJ+8fujwtVpAydH8KIYuWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482460; c=relaxed/simple;
	bh=v2VRkts/Zx1rF43HvxXtnSPcGoYdWgjg2pLAEYFvqN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFWfNpVcgKejuyrVdw3Iv1b6mubgeoE6e8+B1OCU533KdU3+oTZsWoMulGFzIhQxIVpWYnUvIQAj5HaC+dFGft3b+a5TGAFlJXv1rUMAOmA7muMMjuNAliRL0urSvB98OzXxLXJSZViUz0dOMI3ZQECqfTrBN67dBKm+Je3sOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HZihgED6; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HZihgED6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b3rN+WlnOjw8gvJly9EwRFG9AjBWEoJiVEl4e+5e7rE=; t=1752482457; x=1753087257; 
	b=HZihgED6AZOCKV6KL6z3GTR/1TCHEU0bzZzpky0KS3MPclgZmwNQpPChSG3i6CNc0ejiCjNbL1G
	dMwJ470kN9wOpYtfTEMgs6QMXe+bdlqOgi/k/D0ZrIqG61xqsIOwwciY/U8g/kZrnsPn+rQzN8hVd
	1mVIVDzlAsZ11CrogBHNGGLFxifQLDSsOtktDRbDAy7BPXKnqYjXm2c1tQ2vnO8C4sYtyvWEl86bt
	GVbIMZRKuKxKdASXqpCs9wtw7C3xueMFuHOlr4U4Ci+SnTw1nQToCCqw2CP+ECz9y/OxvsS7XXMOV
	7NRGgcqeey8T1ziSOgpMmKY3FqZ/VvgB7uZA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ubEjx-00000003jKN-2XH2; Mon, 14 Jul 2025 10:40:49 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ubEjx-00000002vEm-1K9l; Mon, 14 Jul 2025 10:40:49 +0200
Message-ID: <d5fb6ea95666737c15069abd4d011571c95d7ae6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Andreas Larsson <andreas@gaisler.com>, 
 Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?=	 <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino	
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, Anna-Maria Gleixner	
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Eric
 Biggers	 <ebiggers@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 10:40:48 +0200
In-Reply-To: <ba62bc7b-fa3e-4f34-a966-cc734468b8ef@app.fastmail.com>
References: <20250707144726.4008707-1-arnd@kernel.org>
	 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
	 <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
	 <6b77e7da8c0bd6f211685bda9f624f8db971bbe1.camel@physik.fu-berlin.de>
	 <7e29bcc1-3dc7-40f8-84f0-fbe497fb01bf@gaisler.com>
	 <ba62bc7b-fa3e-4f34-a966-cc734468b8ef@app.fastmail.com>
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

Hello Arnd,

On Fri, 2025-07-11 at 12:31 +0200, Arnd Bergmann wrote:
> It is probably not all that hard to convert the VDSO to use the
> generic implementation if you remove the runtime patching between
> TICK and STICK mode. From the code and the documentation, it
> seems that any JPS1 compatible CPU (or newer) uses STICK,
> this would be UltraSPARC III (Cheetah), SPARC64 V (Zeus)
> and all UltraSPARC T. If you want to give it a try to do the
> conversion to the generic VDSO, I could respin my patch to only
> remove the older TICK version and the runtime patching but leave
> the STICK one. I don't think it's worth my time trying to convert
> STICK myself since I have no way of testing it.

I could create an account for you on the SPARC T4 that Andreas is
currently using for testing, so you could test these changes on real
hardware (Linux LDOM running on Solaris 11.4).

In about one month, I could also create an account for you on a SPARC T5
which is much faster and where you have more RAM and disk space available
for testing.

Please send me a private email if you're interested.

I can also help with other architectures such as SuperH, MIPS, PowerPC or
Alpha. All on real hardware.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
