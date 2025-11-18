Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E8357731
	for <sparclinux@vger.kernel.org>; Tue, 18 Nov 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478638; cv=none; b=mwFXADxLnEVEdM4Y6YePcVbAUvcCTEWkfpo5jcNhjI0G5gFBd9f5QOEo6fpjAr1+Y0zXJyjoAr8vVTb0kuZP6k5Uy5I+hwxnOsSk8bNZCo3oBXBbMe3LpSQclxEiWupjOfO4q169q+Aam/Qr7xfmlqwCeSylWJoQHOGlzHRzz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478638; c=relaxed/simple;
	bh=WwpIMOnhmpqS2WzOFl1RHV0GBoebO6/cXbGvPHJQHCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWQentZJou9GBSw0PV8KXOoeHeAV5VILi3mAIMABxmSvcUe5bfG5dLP+NoqO8oVCfl7EY8W8LLFG0iaK5K3FyZjmjehCALoQBGHysqJLt9IKE1MU66IPsut50Ug0T+eo7eS+qXh2ccAjcFsZ2pd1hue4p0PRodhRGLUihtf4YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Ba8GXHkW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Ba8GXHkW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jJJNFkpG3h+e3olsT5apb5Rao7QMML42g4WE6D6rZwU=; t=1763478635;
	x=1764083435; b=Ba8GXHkW62htu+oz/UsuwkSEzGCg94irQRTUc/siBEgNRfX9w93F0NjeOwSUf
	sadpxk81Yvg8JS3/upivxLL9t+rg6Pb22UJWfTSAV0vJXvqIj+l4DDcqemoh1xbZtMXJY4heTf8ou
	UBkifYsnQ/B5lqi82yFZMy7eVF9412Ns3qbryDqB9i+8DibalfVBW24ZPoc8MWlWIY5Y6Hy4C7Nbh
	uXhVLbZiwgx6NBZtuLMQBwOdQQh8Gp7Li2EBwwGKqJFBzAYPiF2+5InvcOndh4I85Bb2JUPbbHZWT
	b5iqrqwExL8ZoerGLpu9f1QNEu0hN9/EH6jcgVlEAStKbvAeRQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLNLj-00000000oLM-3JuR; Tue, 18 Nov 2025 16:10:31 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLNLj-00000003L2M-2Ox2; Tue, 18 Nov 2025 16:10:31 +0100
Message-ID: <baf12ef8dcf7ec72423bc2795d4824c06ed32adf.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: Correctly recognize Sonoma S7/S8 cpus and perf
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>, 
	sparclinux@vger.kernel.org
Cc: Joe Moriarty <joe.moriarty@oracle.com>, Dave Aldridge	
 <david.j.aldridge@oracle.com>, Allen Pais <allen.pais@oracle.com>, "David
 S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
Date: Tue, 18 Nov 2025 16:10:30 +0100
In-Reply-To: <20251118.142521.973960159957848254.rene@exactco.de>
References: <20251118.142521.973960159957848254.rene@exactco.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

On Tue, 2025-11-18 at 14:25 +0100, Ren=C3=A9 Rebe wrote:
> Fix SPARC Sonoma S7 incorrectly identify as M7. Orabug: 23041
>=20
> Add support for Sonoma S7 into perf to ensure that perf will
> recognise that it is running on a Sonoma device and initialize
> correctly. Orabug: 24931042
>=20
> Rename SN to correctly identifying Sonoma 2 systems. Orabug: 22960812
>=20
> While at it, fix S8 to use M7 optimizations instead of Niagra4, too.
>=20
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
> Originally-by: Joe Moriarty <joe.moriarty@oracle.com>
> Originally-by: Dave Aldridge <david.j.aldridge@oracle.com>
> Originally-by: Allen Pais <allen.pais@oracle.com>

This should be approved by someone from Oracle so that we don't run into
any risks of copyright litigation.

Furthermore, it would be nice to get an approval for the other patches
that are part of Oracle's UEK kernel which have not been upstreamed yet.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
