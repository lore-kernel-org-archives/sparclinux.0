Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B041D6DC7
	for <sparclinux@vger.kernel.org>; Tue,  3 Sep 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351358; cv=none; b=Re/1bOUR6QhoRBU6BzYp9sdQNy20k00EFNM5CHTSW5lycAeptPnelbE+iqicaTwhUdBOqWNJ6BTmklxfVwTvGCjmvpt8HHX0bct16j6HhOq7DxK5xQO6Us/gdpXPdtuf9EMJjn9IBksEKYNqeWaak5//A+EjANFRnFcX7dCCB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351358; c=relaxed/simple;
	bh=XalfatGpV6iiyLeqmDkm70/mwvefjH6mSJZE0+LSm0I=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=AcnxauKJxQWmKt83RDCex0wo7yCeqgLeQetzJ/yiDbJFKREGeyRWSb7q5dm8+ANn7sL4pHQs6hZagXQA7wpgIhGXofddQtT6ExmgLBrcvTbrHt0CelvW/5wDyH2alqmrZDgTpxfdMIFYhSKrNa7ypzBXCg9zwb0/SE/9eNZM/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=SUfXA99t; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="SUfXA99t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s9F8Tm4qBEVoifridoh0NAL3x0Os5fJYZrKFenvWnYE=; t=1725351355; x=1725956155; 
	b=SUfXA99tFz8nfNhj/x5JXy0r0LUwObyeZdNS0/CyJUj487uGlKBNxH0EbcfVqES36vnlldFDITz
	M8UZDZr3uBw+YymPgeAGIpizpzVEVTgtyAjs6V/vJPyDqPhjwO5N/ydBKz30K/aqCWL2E6gDZDom5
	IYp1Dku3Lh8OXxbZv5p19wGCAsxyHEJjhUibcvPlIHIHVlVNOH/2zZEw4hJ3WAPeskVr8zl6tIkst
	ifNFSp915v8gPOLom2Hshv+o/phkYb/qOqVMABjgwmL9KJSrK5HogLCd1ghgW02lbcOVTyYygef69
	qkKw3M9QNZu6QnZ7db9JpTxFI061g+Y8Ow2w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1slOhW-00000000ZYS-3hk1; Tue, 03 Sep 2024 10:15:46 +0200
Received: from p5b13a591.dip0.t-ipconnect.de ([91.19.165.145] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1slOhW-00000003Khc-2reJ; Tue, 03 Sep 2024 10:15:46 +0200
Message-ID: <caf9102c649a8c76e7eb444ab8c702e3a8da8a52.camel@physik.fu-berlin.de>
Subject: Linux kernel  stability fixes for older SPARCs
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc: Ignacio Soriano Hernandez <bond6872@googlemail.com>, sparclinux
	 <sparclinux@vger.kernel.org>, "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Date: Tue, 03 Sep 2024 10:15:46 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rene,

according to these posts [1][2] by Iggi, you figured out the stability prob=
lem
with newer kernels on older SPARC machines. There has been a regression on =
older
SPARCs since around kernel 4.19.x which I haven't gotten around to bisectin=
g yet.

If you've found and fixed the bug in question, it would be great if you cou=
ld share
your fix with the community and maybe whip up a kernel patch to fix the bug=
 upstream.

Newer SPARCs are not affected by this bug, although there are other issues.

Thanks,
Adrian

> [1] https://x.com/Iggi76123640/status/1828396228444389600
> [2] https://x.com/Iggi76123640/status/1828673611080589641

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
