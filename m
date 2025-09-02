Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCD4414;
	Tue,  2 Sep 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832015; cv=none; b=q4E6D7r9Aih5lTId9AYompaIrVWgx2wkaBlrsabwHiK/RuipkbX9gmYN53UZYRToaZ7cEvA9D0OF9N75DZxmU4BpjFqJC5dwbs5rfyPw7g99lfq4urb6HrpCjKqw1H//LWGbwKRx//fDrMBZ2H+F167TJpiuexSzcpYUK8G9xf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832015; c=relaxed/simple;
	bh=R+ACoH+lEBYZVk4nuFlvegVxMkm1rjimRO4QUad75kU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSmMbuo4blhAnWqahyMeMs9Q8+WDJ9N+c1gP3PeQb37L5FjyuD/WkCmuivNKEgcIboZXgcGTIS7LkrIhxre4U1pC3dGCypOaUUtMf0M52ozZS0pYdvLPKCHQ9wrX3xKScZpt7AkBSxe5oxPHdqQv6w9LOnutDHFyytlapnemHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fHHPjN3+; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fHHPjN3+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8QK/HXjVdiEu5+NeJ7Wcfz+HDZ43lh4nkMmlLLp6DwY=; t=1756832013;
	x=1757436813; b=fHHPjN3+liElbiFFOHFY4hIYymD81QQOkJWu2qt+lN/0EMytwc16NkcX6heS0
	0NdVB7RmMcuiSkcdLpSkYm8SGBVpwSPLliddGQRhc6PZ9jKzMCQsu2HuvvBm6XVqfeAle40cEfQK6
	B4hAZ+9bgEBgLLNGONO6a5FjYC5vuUplgfQay/7dmTj/GY9sBX3Y0g2WDPFBe7VlqE++ulj63BPXc
	TQ1V18u/9tF6yw7GQiokuCC2wi01Sx5XM6dQFp/TzMbOhHO9x+38sjHqyyBpaqSMAVp19hu6aYIzV
	Xm7XUoUoWZaMRHdTDumXlghpNonIL8stDxxkcCQGZRj1DpMC8Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utUGA-00000003wkt-3LpX; Tue, 02 Sep 2025 18:53:30 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utUGA-000000009W0-2Pcs; Tue, 02 Sep 2025 18:53:30 +0200
Message-ID: <1d32418278ac11e4a2f65c8b6bcd4c90143a1451.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rene Rebe <rene@exactcode.com>
Cc: kernel@mkarcher.dialup.fu-berlin.de, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, andreas@gaisler.com, anthony.yznaga@oracle.com
Date: Tue, 02 Sep 2025 18:53:29 +0200
In-Reply-To: <20250902.185101.101005511917098882.rene@exactcode.com>
References: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
		<20250902.184011.440504961051160142.rene@exactcode.com>
		<cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
	 <20250902.185101.101005511917098882.rene@exactcode.com>
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

On Tue, 2025-09-02 at 18:51 +0200, Rene Rebe wrote:
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>=20
> > Hi Rene,
> >=20
> > On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
> > > Hi,
> > >=20
> > > From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > >=20
> > > > Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to acc=
urate exception reporting.")
> > > > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de=
>
> > >=20
> > > Tested-by: Ren=C3=A9 Rebe <rene@exactcode.com> # UltraSparc T4 SPARC =
T4-1 Server
> >=20
> > Thanks for the testing! However, this actually needs to be tested on a =
SPARC T1
> > as both T2 and T4 have their own implementation that is being used. Tes=
ting on a
> > T4 will therefore not invoke this particular code unless you modify the=
 kernel in
> > head_64.S to employ the Niagara 1 code on Niagara 4.
>=20
> Ah right, sorry, IIRC you wrote that :-/
>=20
> > Do you happen to have a SPARC T1?
>=20
> Unfortuantely not. A T2 user might have one, but I could also modify
> the kernel and use the less optimized T1 code if that helps, ...

I have done that already to test the Niagara 1 code on Niagara 4.

However, it would be nice to test on a real T1. Unfortunately, I haven't fo=
und
anyone yet who got one. If you could ask your users, that would be great.

Otherwise, we will have to go with the current level of testing.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
