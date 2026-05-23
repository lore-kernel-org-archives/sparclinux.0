Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84619EED0
	for <sparclinux@vger.kernel.org>; Sat, 23 May 2026 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779522567; cv=none; b=SFe2SLlna9u4INThZo8j3NPfq62EyyaaJ5LJCYTHy8wY/EBm71HGpbDc6IGlSqBWCQ0FMoiAVXbbBdLQmGkdQMTHtcXedoxxtN7ZpRh32GaOv0aoK1D0kIw2RMM2+8CXtiIkNRLK2RqBb/HBEq3+wFujWlM5ZdSyw3mmBZOne14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779522567; c=relaxed/simple;
	bh=1jhg6sTHeh1E2j/W8P1sv3pc+XbkFjCe0BeeX/4GKPU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvG2bTAF/fEPE6/qn8bk8jfqIsLmPcTLrhV6VL9RL5tXSOTDqr0NwAeTR2TaSYWRmVKHpDP0PFSejkzKuVRfHfigOewWPOme9GCk6eH8ty213g08szgx4/AzLQow/nA+CNyJLQ97ZF0hnoOkdeB4eR02L8GEX4gK1864eZ9Dk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=poxQ7+yU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="poxQ7+yU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6uwGD75lkdyxoXytpNI1Cv3USy26VoHcrsIHMO6E8c0=; t=1779522563;
	x=1780127363; b=poxQ7+yUAcdmpLxEJYBIUWCpEj7FSM677EZXiHFXZHki/wVy9kEXktx3PL7kJ
	+x2cRBjw3HPqWaYdD414b+h7b9QLL0dnCjrqxTchMER6cXDx6+D9pMo+UmWkDOGzlNqkKvTfwa7rn
	aztIWzrSJXhzIK6YkPyKHzuve4uyF8NQvTClHOhE8yXxVPRXC/EeWrpdoOXQ3r/X0U+J3ojcT01kC
	MDKm2is5wYsRcX1bTTRNCQK1ugvglaRLhoFnYABiW8d2yRoLtSXBuTVtuNK3IJGu4tMRMkB7xt/xv
	02jVJrrgksgdvZkJmvYrsqT4iAc4Sr2qSRQLUem1zonR2KAVQg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wQh6g-0000000118G-1Squ; Sat, 23 May 2026 09:49:14 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wQh6g-00000003n2W-0WtW; Sat, 23 May 2026 09:49:14 +0200
Message-ID: <d754f87694da033d9d80581c9a60df891e3c763d.camel@physik.fu-berlin.de>
Subject: Re: [patch 1/1] sparc: add _mcount() prototype
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Date: Sat, 23 May 2026 09:49:13 +0200
In-Reply-To: <20260523042535.C3A6B1F000E9@smtp.kernel.org>
References: <20260523042535.C3A6B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Andrew,

On Fri, 2026-05-22 at 21:25 -0700, Andrew Morton wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: sparc: add _mcount() prototype
> Date: Fri May 22 09:20:26 PM PDT 2026
>=20
> sparc64 defconfig told me
>=20
> WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation fa=
iled, symbol will not be versioned.
> Is "_mcount" prototyped in <asm/asm-prototypes.h>?

I think that must be a regression as I haven't seen this before. I should
pull and build a current kernel, my last build was around v7.1-rc1.

> so I added it.
>=20
> BTW, altering arch/sparc/include/asm/asm-prototypes.h then running `make'
> doesn't compile anything, so there's a missing dependency somewhere?

Thanks for catching this. I will have a look here as well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
