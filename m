Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A254654
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358102; cv=none; b=fKTqjU8kDSGM1sNmTqo5X11bx0vYJExVssFg+19akCwTE04S4HPVvUQYpcExCoxva6YDQtmNCiygQGUBaZtYRGqxoeGxDnoKm0Jkjfi5hcIvX0inPGkD9szm/K5zRRN/bOIoMWPWtZbXyrxIDWcCxxP0WQnLApRaoqkHEo58w3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358102; c=relaxed/simple;
	bh=N75HUiNqcdeZ50z79bWeeq3CjPqTUJiSc5iIHit8+uE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HfVjQxo8bWJuhs9Fqcttqzk33YRkGlY/q5CI6EzN49uao14u4Vc8l999vdBmRDs7vo6yNzjDf6XID2SahVJYNOVxUrAZAkp3cZMmsq2Bf3ytiYCj7oTglLgsmNuMBGU2rU3j4bvVwWY7toPoQI9O+0oIng5GGmaSyB4MHctEq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AVBHX8/r; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AVBHX8/r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=l5/9eMwwFgQir1qphu/wuNtjNbL3/DTr8yzHYpJaT98=; t=1757358099;
	x=1757962899; b=AVBHX8/rS6lMjo7gNn/UiMvaFNTw4IOhWFbH/fVVd6LWJ3deptgyEV5v9PIAJ
	XFKM70FGbmdo1Toiwdftz1KK/Y41nuWLKmbO/PLe1bvIPWwSqqQ0ImustWQOqdgmneOVWucam/l+Q
	m44+cBj2DexegGHiiLkwzs0XBnBtcECrLN54Gy0zlL/4miWBb+RYVqu/lzGXy1f4ZhULDfGBgFvDm
	ijRr0RMR1BFXWvtB28WvUB30LOdXejmVLf6hOcEBOnQMUUyWSn/WAbEE+fn3pcTA10JWVHbd1LgR/
	Ew3v6W6HeDppCLoZ8+3iX4qmoqDT9Ga40hXnYHLWk8mtJmN2Gw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvh7L-00000004B9q-00uE; Mon, 08 Sep 2025 21:01:31 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvh7K-00000003I9o-3IM7; Mon, 08 Sep 2025 21:01:30 +0200
Message-ID: <dbb9a594bf695a3df4170421087fd21fa498e0d0.camel@physik.fu-berlin.de>
Subject: Re: New test kernel available - please verify
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Mon, 08 Sep 2025 21:01:30 +0200
In-Reply-To: <80181c7d6f6a3303eeb5df06c7a6a3c76a2619e9.camel@physik.fu-berlin.de>
References: 
	<46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
		 <24e383af5b1714de3debb8a4043016ec801a0bae.camel@physik.fu-berlin.de>
	 <80181c7d6f6a3303eeb5df06c7a6a3c76a2619e9.camel@physik.fu-berlin.de>
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

On Mon, 2025-09-08 at 17:50 +0200, John Paul Adrian Glaubitz wrote:
> New kernel is building, old packages have been deleted to keep users from
> testing kernel packages known to be broken.

OK, even building with binutils 2.43 doesn't help. We've got to stick with
6.12.x for now, it seems until I have found out what broke in Debian's
6.16.x kernel.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
