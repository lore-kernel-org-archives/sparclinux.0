Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093031A3029
	for <sparclinux@vger.kernel.org>; Fri, 19 Sep 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285156; cv=none; b=A0PEsAxkS+vM0TKktJlja9ymi9xzmxtz5QbvsBbcR5pHvgMAzPvT5BJMkqBKLIHzprVjD88TW11t91/DlhENKMvJZghQzRmaBzDT+P9VbQGcWbyTFqQ6kkk700p0E0OtuZ2j13chRPsLz+zmNMrPDwsXHM16ippC13shMi9SL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285156; c=relaxed/simple;
	bh=WsSvsNHHW+vhnBeVkPkKjDs225JFzm3ybFAXRlFFGSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odKhAvrqktvW95bF3e4CQRO+V+NNitb4dk+mTzMZ0KjoX2dvAGV1zE6UpXF5J0EY8TheDduhbloyvYAfelezIfYCGbUI82Li/4GMRA883RGJtz1507mUhiwWnLmQvuFbXJG5FAphn+tsgTbDdkJcwmjSjEQXXKazZ7C0DaXadeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=SMDONf4T; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="SMDONf4T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=D1cYk/a6J6SsbVBnQRhih5S4U7oSPExFWVDvVtMcs6U=; t=1758285154;
	x=1758889954; b=SMDONf4TrIxRmufHsA2qLX0Db1foc6PUqQtK1P50x208hM1SUs2X1zY4ZOAgo
	RjAUDTGyEnLxGtqJefo3ek3SujJzwTG+83/ICJnAmWJpaGCbTd1iRj46g2tpGQH4EQcPw+ogcZkMn
	Yhv/8w03iXLXJAQMdHKYX9+obUIQFPxwUlDSWEpvmSjqPEMDml6y1oUmfAZ+9f2eL/sBGvSoOszAQ
	Qt5R0Bl1ucUUwb+BUQQ9dE5z0PUJG/PyZqPl7wQ/Ii4uLJPaNv1xSetFTs+korvghE6DkoTxVvpkz
	cgLGB7mO16rovK7uaVmaKHpfbAoGjjk8MVqLwql5v88yV9FWtg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uzaHv-00000001TyE-3rfa; Fri, 19 Sep 2025 14:32:31 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uzaHv-00000002Fue-2u8Q; Fri, 19 Sep 2025 14:32:31 +0200
Message-ID: <1fa3006823b14ca10aa6c42474300e00630479ac.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Robin Cremer <robin.cremer@medicem.de>, Riccardo Mottola
	 <riccardo.mottola@libero.it>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
 sparclinux <sparclinux@vger.kernel.org>
Date: Fri, 19 Sep 2025 14:32:30 +0200
In-Reply-To: <f12d40b7-9dd8-49c1-b65d-b725c154d7c8@medicem.de>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
	 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
	 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
	 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
	 <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
	 <f12d40b7-9dd8-49c1-b65d-b725c154d7c8@medicem.de>
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

Hi Robin

On Fri, 2025-09-19 at 14:23 +0200, Robin Cremer wrote:
> Are you sure it hangs? Or maybe console is going to a different output?
> Do these systems have a framebuffer installed? Linux might favor output
> there. What cmdline are you using for the kernels in grub?

Very good point.

It might be necessary to set up the serial console as described here:

https://wiki.archlinux.org/title/Working_with_the_serial_console

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
