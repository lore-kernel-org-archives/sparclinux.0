Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F526056C;
	Thu, 24 Jul 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354384; cv=none; b=l2rvOfQDgnLHnFhEnY+E6ExpD8RbkpVkiPrKdjfUtkv+hRPw4sqslTYAeKNVZfquOECanG9MrQ52jqlFcv8T72cC4fFgPBKYOZDN2JlcgIfdAc0vFsx2FlwtVvCru6YuBakv+FYLR4H/jLEpaYjgwDl6uO+xyPoRd/VEExlbQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354384; c=relaxed/simple;
	bh=MZwM76X2PIg/lV7ghBy+QEY828XDYAF3meHigbrOra4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+tmDtP7YhinyGak4Hv2WVP6MDGiWP6jf5PaaUmEF0Gl0t5HcI3Z0jQtxAx4Kw9blWHuJza76+zNxGgQSmFuqe87FQXnoHkN09CuUIRtkmzZoDbcW26R7nuRjqjmHhq+RHiUlvHqPc8IHFXJUin5CjgeS7gHZ6INGHvA4HUG52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CO+KDuAB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CO+KDuAB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C3CStslV95qF0H8/lXkFm98BQsFhll8DXl4j+ZA0Otw=; t=1753354380; x=1753959180; 
	b=CO+KDuAB64vZd280hlVhMKRVF1B3xcC9bV8N7EdVxZ6AbvlrCPxzV/aCq3lyN2pjS0A1tUZeCc/
	Ig1/HRMf+p04+rg8L2SjJsD26TWc+qIcPj0GlzlGnbNDl76ckEkG7O/dfQbr5EFcrV072PbbvEUV2
	gycKeh6QdHqxQIRE1vRX5HW4sRJyitWFoHEaqYBQ/MWy24t/xeXY9Fodt3J8noPgOQohmBq8hVhzW
	T0A0goLXYfZ1KsRjCnJ9U3eyXa8ipwp02sojRqT7Fx6cy5kk7YsulA7Gm1Bbd9uVrMBOtKZJibqO/
	XTG2B0bjLWjf/qX1EXC2BX3IrDkJ14Ye5MMw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uetZI-00000000ssc-2EQG; Thu, 24 Jul 2025 12:52:56 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uetZI-00000000rgm-1Dqt; Thu, 24 Jul 2025 12:52:56 +0200
Message-ID: <57136aa08c928601d17cf9d37e1da55f4d0410df.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Thu, 24 Jul 2025 12:52:55 +0200
In-Reply-To: <1821f2fc2e339fbb4bc6a4af1748a3462f501392.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
		 <7531c897d8a4dc874bc226f5cb724eb66ee17974.camel@physik.fu-berlin.de>
	 <1821f2fc2e339fbb4bc6a4af1748a3462f501392.camel@physik.fu-berlin.de>
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

Hi Anthony,

On Wed, 2025-07-16 at 10:41 +0200, John Paul Adrian Glaubitz wrote:
> > It has actually been observed for a long time that newer kernels are
> > unstable on sun4u while there are no stability issues on sun4v.
>=20
> Just as a heads-up: I'm currently building a Debian kernel with this patc=
h
> and see if this fixes the stability issues we're seeing on UltraSPARC mac=
hines.

I'm still testing here. There are some still some issues with newer kernels=
 on
sun4u with the code crashing in ext4, but I'm going to perform stresstests =
with
a patch 4.19.325 kernel now.

I will also try to bisect the other crash regression in sun4u that was intr=
oduced
sometime between 4.19.x and 6.x.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
