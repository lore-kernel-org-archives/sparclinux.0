Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5173054C1;
	Tue,  2 Sep 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833098; cv=none; b=qlNXHw1kmW02PlnJfNcowdA89+crKlEEqo7Xd0KT/jE4vVQ3VcBRIhC70D+mm+MJZMpdmDtjtmrhVzzpuy/YoEeRKBhNhXH1qq8+qQKDpa+lWYBiZ+SSc8M5K6bWpWu4OUun1DTzziI+Z/Wh7mNH5RHTYpo1gnFRLOu/EEFqgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833098; c=relaxed/simple;
	bh=5gzVLzZ7zW2+ctaPZ6RUd+xTcwYjPczwKxIX1Ehpxn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUH8EgvInVctOpO9efHHg0AnHAcK7utJ51gS/XtniPwDH8HsOYnWxmSSamEjz7b8twetfDsHUrTvkgthOFItF4de63/9llkvn70uRwkO1vcwp/jcOIvcno+9WJTnvjaAt10231l4KQjPmea08BD7ORP/dOD3UDTRbB09DXl73DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=V00VnOZK; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="V00VnOZK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=SUhbJkxc5ofCDvc9EJxoCt40uv7sHH2iAvCqEtcI7zs=; t=1756833096;
	x=1757437896; b=V00VnOZKOt+Yh1PoR9ROovi5xiWngAAirqcquWhY1558G1hDNAvVhJNf8/smk
	mNM88Ud68ljJOL4g9BgEmfksOm7Jafm7j3X4kcDh5Tt/dInrfil0uyLXJl8sksEI69pFvVgRbnstS
	oYTrpatwM686NX3rf27rQOTZeNwsgue4GKygTt33V9OAMCgMGYdmmK0L4MmE0/mBl3vDiFPa+FCvH
	Ng1OnbFUBxZ26S2n40TAFaTziHFc1rou95W3KrwFAboLny9P+jEYAaFM2F3UIMfEeJRwoWb46UH+x
	jOGmblMmEYsq6+mWiEqCqjY2CTPU4TrTLuCZtU/wrUTjqAtQIQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utUXe-000000041ys-1m1P; Tue, 02 Sep 2025 19:11:34 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utUXe-00000000D8h-0pOa; Tue, 02 Sep 2025 19:11:34 +0200
Message-ID: <bcc8c498ccd773919c5dfe8026e4f25139151827.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rene Rebe <rene@exactcode.com>
Cc: kernel@mkarcher.dialup.fu-berlin.de, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, andreas@gaisler.com, anthony.yznaga@oracle.com
Date: Tue, 02 Sep 2025 19:11:33 +0200
In-Reply-To: <20250902.190459.1097165280513668946.rene@exactcode.com>
References: 
	<cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
		<20250902.185101.101005511917098882.rene@exactcode.com>
		<1d32418278ac11e4a2f65c8b6bcd4c90143a1451.camel@physik.fu-berlin.de>
	 <20250902.190459.1097165280513668946.rene@exactcode.com>
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

On Tue, 2025-09-02 at 19:04 +0200, Rene Rebe wrote:
> someone in our Discord probably has one in the basement or attic, but
> the chances of them turning just that system on the next days or weeks
> is probably rather slim.
>=20
> I guess testing all the "popular" systems: vintage collected
> workstations and affortable more modern higher performance T4 servers
> is all we got for the near future for this patches.

I just realized that QEMU can emulate a Niagara CPU, so we can test there:

https://www.qemu.org/docs/master/system/target-sparc64.html

Maybe you can test independently on QEMU as well using your kernel, then
your Tested-by will become valid.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
