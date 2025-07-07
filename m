Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F02E424A;
	Mon,  7 Jul 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901957; cv=none; b=n1rtoA1spjwo2v+9epzBPkVF25nEeSszwVqHuvk3+SZVgYvt3ROGenJhtnfP6rXErn0ZqHxzcxfGz5GMCaF3+QUWHyKFSA5I6/XouqeylzNyhgMfZ/hySnGqaub9HhBghhJNHyi4MfUTHsgu1EN8cG7HyTynlhSVp/iz/orJb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901957; c=relaxed/simple;
	bh=gGFnpPztww0nEcz6MFO0gSNdz7cMeejh7YU1pnFlC8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQBypCPK6WZLyS3VJhIrPWUGgY2GiZ/0WmXRpnXlvpsMk2FNig+3n9MJUb/jmeCGGVPOYezKnaylq91iuwbJYu48FZHtjotcGSxrFLoLhx38xTMmuM9YFtyrH6hDl8o0USJeuCSz/qsPNoaj6vjsDzlPxJwG5WfigFF+NNW1eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KCWF+LNd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KCWF+LNd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2LtYLZehN3nst7NYT3lu6IrXRn9WzxMWsCM2rI//Kpk=; t=1751901955; x=1752506755; 
	b=KCWF+LNdBKgrpNDfQrvLeYdrQLh8lTi9Ix88IrN97hgEnU+lQkkRxlJK4QFtxj4E90DPXU9V2J5
	unLjmBB9+KCG71OqePZqMKYjOSluigismQMBEMUmXvaLJlgjluSwOzv+Ryr6LDnnNIBn+hZxBHpXw
	ktFa3/mXTbM6Ba63JUFYQqpb5Cl9ZWKdrtLbU7TLiCAAFttgahHGQIVlSw45naa2CAzhscd6u3fJj
	NyNiEyA3gAVIIwbw2PCi4r9CeAbrIT+4KV01fd4j27JGr3zhicvmgJBXITWurLV6ubCLmf2whBH/k
	9bgJVR1ZFpp1qy+WEAi8EDPJTvOSpAfPgEfQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uYnff-00000003Pm9-2MAh; Mon, 07 Jul 2025 17:22:19 +0200
Received: from pd9f741c2.dip0.t-ipconnect.de ([217.247.65.194] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uYnff-00000002zWh-1FRp; Mon, 07 Jul 2025 17:22:19 +0200
Message-ID: <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?=	 <thomas.weissschuh@linutronix.de>,
 "David S. Miller" <davem@davemloft.net>,  Andreas Larsson
 <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino	
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd
 Bergmann	 <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
 sparclinux@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 07 Jul 2025 17:22:18 +0200
In-Reply-To: <20250707144726.4008707-1-arnd@kernel.org>
References: <20250707144726.4008707-1-arnd@kernel.org>
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

On Mon, 2025-07-07 at 16:46 +0200, Arnd Bergmann wrote:
> Rip out the whole thing and replace it with a minimal stub as we do
> on parisc and uml. This introduces a small performance regression when
> using a libc that is aware of the vdso (glibc-2.29 or higher).

Can this performance hit quantified in any way?

And is there previous serious where this change was made for other archs?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
