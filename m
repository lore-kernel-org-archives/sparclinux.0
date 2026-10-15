Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF934EFFC4;
	Thu, 15 Oct 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056546; cv=none; b=kvQKQDdp9fsWQhQoJaDXZURCTuRU3Y4NJY4P2n1ad93vbJ7VapoFWQnj8RrpE4w/pUyRktD6BQPMHMdkL8cByxMHt+QkCVTmXQT1UXbMwQsvq2pijqAFXL9NSwWtDxRGDLSVYhVOQzkPkOEf+igcR2bX6eTYEs6fRtJ56836Kpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056546; c=relaxed/simple;
	bh=NSqNR+ngoZZw0eODXMM7eM0Krmpuk5J5E1Muf3YGwzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VChdNYmjohSXdxNM4rnCxi73I0KLDO7J/eURVT2SmOit/UnStDf/kR17AY5XMAIgtnZI8QMZ1UNeqcmjPEbeyPFpPctUmGSu+I169rB2L5CFLae6YY/Oy79mjqwJSC/y4Baa/hbO+V+Y/6n5ql69eeJtnIlZBbkHy7dy/xrg3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HlKVv/7V; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HlKVv/7V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jZxueYXNwc1g9ouJPv18Fw9eXntISx5E+iCNK1BHUXI=; t=1792056541;
	x=1792661341; b=HlKVv/7VU9djDiiPqGTrLqEXE0+adkjDsGmpGVwfnyPluS8goFDMjrnXzcW+l
	fMTj1JSbawoFYZ6Kqi9c8eLzx4qBJ0PERfeUWiwr/0YWYsA6bpxSp5SsZfe+l6Bw/d99/dxzb3t8P
	FAlDcnSDgsJrlHw8TWXdwwYPd7eJk1SPQnD/Zb0Egc3vlyfrCPihNZrEBzpDzn6FXYePrq0yP/gyB
	FtWbYwZmBUxQazTNQCtLsX/5Fi/oS1cRkYTCv3YLeAUrP+o0uZ+GI3sse6t94EV9R/zPyJshxtAet
	VOCx7uODcJI7d1/25PbFMGk4oEiEg8bvVMjdCIWPNpgzDmPpjg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xHHlY-000000031kz-1E1P; Thu, 15 Oct 2026 11:28:48 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xHHlY-00000003EdM-0H7L; Thu, 15 Oct 2026 11:28:48 +0200
Message-ID: <ed61723a01eeeb2e94306de3be3a363974b984fb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc32: implement futex atomics, with casa
 detected at run time
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Ramin Moussavi
 <ramin.moussavi@yacoub.de>,  Andreas Larsson <andreas@gaisler.com>, "David
 S . Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Guenter Roeck <linux@roeck-us.net>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Imre Kaloz	
 <kaloz@kernel.org>
Date: Thu, 15 Oct 2026 11:28:47 +0200
In-Reply-To: <7334b77c-2ec7-4678-8296-f187e0304f49@app.fastmail.com>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
	 <20261015085545.3246951-4-ramin.moussavi@yacoub.de>
	 <7334b77c-2ec7-4678-8296-f187e0304f49@app.fastmail.com>
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

On Thu, 2026-10-15 at 11:23 +0200, Arnd Bergmann wrote:
> On Thu, Oct 15, 2026, at 10:55, Ramin Moussavi wrote:
> > sparc32 has no futex_atomic_cmpxchg_inatomic() or
> > arch_futex_atomic_op_inuser() of its own. The generic versions only
> > work on UP, so FUTEX depends on !(SPARC32 && SMP) and an SMP kernel
> > has no futexes at all; NPTL cannot run on it.
>=20
> I believe there are existing patches for LEON with CASA that
> should just be merged, I would not worry about supporting broken
> CPUs that never had this.

I think you mean the series by Imre Kaloz [1]? If yes, he actually
implements CASA emulation unless I'm missing something.

Adrian

> [1] https://lore.kernel.org/sparclinux/20260927005821.8369-1-kaloz@kernel=
.org/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
