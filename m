Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46792459E7;
	Fri,  5 Sep 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062940; cv=none; b=tkg9JogRtU5z4GRka7hS179MbcwAgnFnfxVOCSf7KJsfuPBuYQq4pMzSEOiJW5/z4hMwqC1GHHQs0vRQYLgFHP+S17UF2dJuNv5J3ZND8VRJrj0FEdmY+lb1A+0wg3Nb8lyKXWQVFH3xBlOsTMC3C4xNHvROn1D7tfmD59LlM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062940; c=relaxed/simple;
	bh=b6pNNu1kZuCqmC2pn3qZj6MsJda0RifZCd6eEAHIVpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9rnMOAh6yV8i3ghetljiHUJSPaTFOK+iWMSor915Ob4C3jsA2shWajjFv8K47ibpNOcWcQ4GKUmy7yGlWenOxJcTjl0RbjkUK/RSPQ5RyvI3ImIMDAdfdW6OiGlenJAVuZup2ze++Bfb9p1BUD5SosbIlbpap4zmMmGY/syHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pi8XHduV; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pi8XHduV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9NszR2Bf8DLTmFmz7B9WrX9IE8Qe4vm+3b/4QW49/qg=; t=1757062936;
	x=1757667736; b=pi8XHduV73FzMVzGUiqCOG0vzqtjK1D6dr/s8lcyJy2M/ISkDIHIQX+HewC0R
	JBgfqR4zZYlx4eyG4XlbjQ6VpseWBnYyzJGeoKi/m3nBFKGegvsCGJ8owIlKa8GzrVHg7AKdQo2DP
	tUanyRuDU4nQuWlA83HNoyYNomAIRo9Y6tlfy0XBQBTaIYY+L8DHTO3AzURXRJuCjPOckRc5PsT0Q
	SKPzKs5TDKUNk0Au94z+I74B+RsFaynOQxcQJyQ6Ta1d96WEyYb8R5VPuzLZr18tsTMeApvC19QQV
	D8D7X5anrSS6hpv7NWI4Mbk7NpHOnzn36ZKXGFA9RX1pqU7EGA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uuSKd-00000003JN3-3UMl; Fri, 05 Sep 2025 11:02:07 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uuSKd-00000000BTu-2b4S; Fri, 05 Sep 2025 11:02:07 +0200
Message-ID: <129fc4699cb74035813b199651282e741c8838cc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, Rene Rebe <rene@exactcode.com>, 
	kernel@mkarcher.dialup.fu-berlin.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	anthony.yznaga@oracle.com
Date: Fri, 05 Sep 2025 11:02:07 +0200
In-Reply-To: <8deb9ed8-6c12-4fef-a78c-028de7928803@gaisler.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250902.184011.440504961051160142.rene@exactcode.com>
	 <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
	 <8deb9ed8-6c12-4fef-a78c-028de7928803@gaisler.com>
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

On Fri, 2025-09-05 at 10:04 +0200, Andreas Larsson wrote:
> On 2025-09-02 18:47, John Paul Adrian Glaubitz wrote:
> > On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
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
> Did you have the fourth patch, that is for Niagara 4, applied as well
> when you did this testing? If so, we could add your Tested-by to that
> patch instead.

I just talked to Rene in person and he confirmed that he applied all patche=
s and
tested on SPARC T4. Thus, please add his Tested-by to the Niagara 4 patch a=
s:

Tested-by: Ren=C3=A9 Rebe <rene@exactcode.com> # on Oracle SPARC T4-1

(also, to be consistent with my tag, we tested on the same model).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
