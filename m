Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7101804A;
	Mon,  1 Sep 2025 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710369; cv=none; b=YgjIn7FIxEDI7nno3s11dapidf05pa8RZIfc45ybdRIlICPIJgnVNxzB7YJXQjEHgRlEeTPm4DotlU2g5Qt1R2uqEE8Irk/01iD8k1cBR2w2OfWXkjJbmsIWjWet3YS9kZo+qsxCXCGwSuynsaATOAG2S07kaxhXRZWJxW6ywhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710369; c=relaxed/simple;
	bh=D/hYsH0w+i5tF9S5XEvhBqUABdE/dU1F3VhNIXxauZk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UymfgZN/bc0o+kwa8628JmyZWmFDKwcj2iBFcd//CpN5NtXvt25IJprXgI6oE/WQyRFmKIzdW9MkDYtULaV4lKGqlAqDNNjdqAYvnE4R24tmALmvik2pa+PM5U+DGLo8asgwGXp1WFpJbL8PaAGN0UocNuXowpDVGkDJbqePuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=A35wPPao; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="A35wPPao"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MPgh1/ZPw2CdKPWJl0bD2cP1L02gYkFQx8nUqM9w8Ng=; t=1756710362;
	x=1757315162; b=A35wPPaoWx+0fIIYFcEhKqQR95Uxc0drFD6W2QksmSaOjsov0eXtCxykgGteF
	UDJUToheLc2M2qB2rQdu8yq5saa/MHzIVs/9tH3UVJzKD6q79w0Akok2WhufMJT5U7FpXWTTLLf4g
	VFyQYb/94OCC2sG2WJ7w6FAcDnp64bJE9cUtjd40DTWJp4ICxVYRduugfW2sORgbe+aAlp1yzBndE
	Tq5o/kduH/CNTqGLwd8Of1e1/0hhh0fjT0j71v38sKHiqeVUXl7qwrTyrG2ufvpnabXFiZWjI8liG
	U0dCPWRRJ7ltFNWIr/bGISfaxzwHukW/2gMrFJg/ht6PFVwWng==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1usyc3-00000000joo-2Idj; Mon, 01 Sep 2025 09:05:59 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1usyc3-00000002ixN-1LmA; Mon, 01 Sep 2025 09:05:59 +0200
Message-ID: <4c92d08cff24c04023bff8555ecf3bbd2eb0e944.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/1] sparc: fix accurate exception reporting in
 copy_{from,to}_user for M7
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rainer Orth <ro@CeBiTec.Uni-Bielefeld.DE>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Andreas Larsson
	 <andreas@gaisler.com>, Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Mon, 01 Sep 2025 09:05:58 +0200
In-Reply-To: <yddjz2i64j9.fsf@CeBiTec.Uni-Bielefeld.DE>
References: 
	<aecb14d84b1af658a87a2b1ba3a49ac13d39560e.camel@physik.fu-berlin.de>
		<20250828130456.2335-1-kernel@mkarcher.dialup.fu-berlin.de>
		<240f0f51687dcb146656a47932ec075b0821b605.camel@physik.fu-berlin.de>
	 <yddjz2i64j9.fsf@CeBiTec.Uni-Bielefeld.DE>
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

Hi Rainer,

On Mon, 2025-09-01 at 09:00 +0200, Rainer Orth wrote:
> > in the past, you reported stability issues with the Linux kernel when r=
unning
> > inside an LDOM on SPARC M7/M8. Could you verify whether the patch above=
 fixes
> > these problems or whether at least they don't introduce regressions?
>=20
> thanks for the heads-up.  Indeed the hangs persist even when the system
> is idle.  However, I've never built a Linux kernel before and have way
> too much on the plate to try now.  Besides, I don't have a reproducer
> for the issue, so even with a patch I'd have to wait for an extended
> period of time to see if the issue is gone, so I'll just wait until the
> patch lands in the Debian/sparc64 repo and see if it helps.

Would it work if I built a kernel for you plus installation instructions
and a quick explanation how to test it?

FWIW, we consider the patch already acceptable when it doesn't introduce
any regressions.

I did some testing on a SPARC S7 yesterday, but the problem is that the
support for SPARC S7 in the Linux kernel is incomplete at the moment and
I had to add it quickly myself which did actually work but I really would
like to verify it on M7 or M8 again to at least not cause regressions.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
