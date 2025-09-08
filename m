Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0722F757
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346641; cv=none; b=Duj4vZEYU1wQ7cBje3HWC8w65ZcsDf00x5gjnSV0Vu0kEuDS3QKe1uZTJlSMhds+2yQyC00dssm1odG2PJLCo2sWJgEanBRWRU2/FVRCyhmLLp9GL67nBO/rVXqE3Bn5R+I835OvZ7tW1eeUfz6PxIhVNC0X2hzyy/WdQNHz5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346641; c=relaxed/simple;
	bh=vdhJXcPbZorBcF9vgqBK3KsdPODDM/iQR8S/W0/pNEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZXU3bJw3aOGwp+kLtaWpvbx0hlw75dOGaxdmx9zpLe2FNTBNPEKoS0xz758Nm0FvrtJvGc9uBLpT4Npql3x59bWsIBxtwIetwRZ5QfPDHm89VX1d9tRCHQExc7YvB3M3LLlcosgV1xhUd+4WrGFHq5YhXJ2G59Y7pp+SgiqKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=H1KS8MYe; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="H1KS8MYe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5AjejLX+Ay4Rt8JWubE+Fhry9uI2MYP81NiLm8MoW60=; t=1757346638;
	x=1757951438; b=H1KS8MYeoyGzLkIvevYvfQeA/gO0oa3kU2Z2/lgPRi8iC+tEFt2Nhh1WDKC+V
	xPyRD/tIfhtt4MEPgb+E6KJUsh/j1Kwc6oMaUG+o0rl9y0/16HrL9e8rHfGk1vfhD2ymdlyqWd/UE
	BoFR01+1U2kjjRkZoxFuUF8cO6TYlslMTTQ7pOLdfhz4O+j+FSQdFZQgmDRuc3iTRWWbvGSMq6omA
	4KMiZ03wc8U2y2U/syK0SiG7F4CQ2xFLsN3MSYRZHWqAukyXB6rMgPSVB20ruxrUXJuLmH7qk7Ve4
	wlWkyC7EgYjTj3Nem5fKAPaPLMbxamPZcN/fyByvNiiE0XUYQg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uve8a-00000003Nc1-366v; Mon, 08 Sep 2025 17:50:36 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop-2.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uve8a-00000002R9T-2EeJ; Mon, 08 Sep 2025 17:50:36 +0200
Message-ID: <80181c7d6f6a3303eeb5df06c7a6a3c76a2619e9.camel@physik.fu-berlin.de>
Subject: Re: New test kernel available - please verify
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Mon, 08 Sep 2025 17:50:36 +0200
In-Reply-To: <24e383af5b1714de3debb8a4043016ec801a0bae.camel@physik.fu-berlin.de>
References: 
	<46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
	 <24e383af5b1714de3debb8a4043016ec801a0bae.camel@physik.fu-berlin.de>
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

On Mon, 2025-09-08 at 17:37 +0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-09-08 at 17:31 +0200, John Paul Adrian Glaubitz wrote:
> > I just uploaded a 6.16.3 Debian kernel package with:
> >=20
> > - all patches by Michael Karcher to fix copy_{to,from}_user
> > - the patch by Anthony Yznaga to fix HugeTLB support on sun4u
> > - support for transparent huge pages disabled
> >=20
> > Packages are available here: https://people.debian.org/~glaubitz/sparc6=
4/
> >=20
> > Please test and report back!
>=20
> Never mind, it's broken. Most likely due to the binutils version used.
>=20
> Will have to rebuild with binutils 2.43.

New kernel is building, old packages have been deleted to keep users from
testing kernel packages known to be broken.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
