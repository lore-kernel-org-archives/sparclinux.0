Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB051597A
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898950; cv=none; b=hp2SthMQNwMuE2Bl3WJiB78IJSQfxxkPhG22tX69xvRU36/NH2MD4UQ8ylKxzzrM0kdSSfO7hQ7SkikHgp7Zfptn86tb5hb27gXILiIgDFLXKaILHQA0aZmQajD53YQlJw4+P5/ybiIurxGf7Mj7hkvQJfO4kPx225Ip/cZzhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898950; c=relaxed/simple;
	bh=r4/NHVj7xrGy2yTVliV8eaqdPiCqOJN1EZ4HXPeb9xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=il+Yw4U1RE8fAWx4eIpTABoYleE+kuBZkCK/4QcFgFYuV8wKo1sNs4XoK87DchwpDFUg4HA0RI4N5U0AeVkGTNotqopngnQzW8zh/m/7sOje+2HXQOn+NzE0bV4vxaFfveWDNrkoS6azNz2tln0Iywa1dTn12qQriMBThNkSgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pBE4fxVP; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pBE4fxVP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KSqetGp4Y5oauWFuKXz+TzPOH0FfSWAIpLVn/Tgph2M=; t=1791898948;
	x=1792503748; b=pBE4fxVPL5jq6r9Oi7Dda8E/jxIdUzL79acmgcRuSa9ZGI5A5u/LTRMiO4ukA
	sfjp8/gkLaeoOInOAzc4JyizrYD4lIMMLRCyqvV62uSfC26bzPJF5u3KEE5hx463hStJJZaDHyiEm
	7gaa1O4RLcyqKpDQ4ysMOUZKJa4wo3Kcm6T9Li+uw5aad7XwFQk5jtKmS+tvSowQCIb/Y+ULnbSTN
	eoDNqNLxdtKdcl1DD6pKnwEEeRgiddrO5MIl1hc/4CKO0/lvfO4uJfFGIlkv/tnlydcMUo5Yb28uS
	NoQ/WAb8fx/9SjiB8Rg0iTDGDeUV7J0Oz1WHwO0vcIEup2oNow==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xGclt-00000003mPg-3ib4; Tue, 13 Oct 2026 15:42:25 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xGclt-00000003sCY-2hu5; Tue, 13 Oct 2026 15:42:25 +0200
Message-ID: <46d577c5dae4d57c2acc712e733c02774dd70a93.camel@physik.fu-berlin.de>
Subject: Re: SPARC Meetup at FOSDEM
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, Magnus Lindholm <linmag7@gmail.com>, 
 Andreas Larsson <andreas@gaisler.com>, Imre Kaloz <kaloz@kernel.org>, Sam
 James <sam@gentoo.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, 
 "<debian-sparc@lists.debian.org>"	 <debian-sparc@lists.debian.org>,
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Date: Tue, 13 Oct 2026 15:42:24 +0200
In-Reply-To: <690d59600b7a2562d62440ead25b94505739e3bf.camel@itx.no>
References: 
	<8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
	 <690d59600b7a2562d62440ead25b94505739e3bf.camel@itx.no>
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

Hi Stian,

On Tue, 2026-10-13 at 15:24 +0200, Stian Halseth wrote:
> Thank you for the initiative.
>=20
> I've actually never attended FOSDEM before, but sounds interesting, and
> I will absolutely consider it.

Yes, you should. It's worth it already for the beer ;-).

> Perhaps I will place my wife in a hotel somewhere in Brussels.=C2=A0
>=20
> We could possibly make a wife camp, if this is common issue.=C2=A0
> Could create an issue at sparclinux for wife tracking, if necessary.

:D

> Let's see how the response is.

I will be around in any case.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
