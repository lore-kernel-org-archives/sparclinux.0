Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457922FAFD;
	Tue,  2 Sep 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831863; cv=none; b=DJ31ctSlYnagHkI93XrA/6PtP02NGAXgZrx6Y+UtosTTxga/e4KY5F6niWE9uDGuuTBGTGXVGTCT3Asy3pCUUr610Dmdbf7kjw+HJ20apNSUTTemr6BbkAoWIZpiC697xopjbm9YQRpm46GFUqXvMW+aaSXxuLCCoxPtn1AJqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831863; c=relaxed/simple;
	bh=1i0JvEXxzeQhDhQ3QadruQc9Pqg2kkvDSoZvHpUJGLQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fY1ShZWvBpGcpkFlmYFp4rt/ts77ncIjvneKwIf7e1Iqm97RQQe6gPuz+Qp8UMxP9BedIw5ogykAE4ewSWzi0ZIblIHTaMjiRYit7Aklf04Irn2kVbEdrWyxWYBlspgMkNfblqaMTTTgW0sysoQiRFqMkFvRDSNs7mBRNTi1Y+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=Qob79FtR; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="Qob79FtR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Sender:Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U1NVNZzFNPKLfNEMAY0syXFR4s/LQ4mHFlghr5myPvw=; b=Qob79FtRilIUogJOs+Phf9f5LH
	wUMKGXBZ+HLpXL6d+U2n0QC+gxURNeC3DyY8bY3n4SpzwtE771nl4iYJeJD9w5QACk4veXweDbHKj
	uzVDjM5oiINTeCOWCPsjDZiP7MdbAUVfq9Xakjx42wS1r/eHvtCxYiQPYMV3bCHo6GmaCqW5geTJO
	I9cyR3g6bCdPLDyPRmjcWoA6HhcFWo9L7Yoh1aIU97Fpp5kxCmLwotxFv+PFAV6aRplusCdT35ahr
	v4kFh3iNoTlBPNQEvXpWc66fSVtG1Z8q+FSB6gDDs3XoAZuZfphP6/A7Um1DTDqw85Q/g0AN/uxod
	bmUEm6EQ==;
Date: Tue, 02 Sep 2025 18:51:01 +0200 (CEST)
Message-Id: <20250902.185101.101005511917098882.rene@exactcode.com>
To: glaubitz@physik.fu-berlin.de
Cc: kernel@mkarcher.dialup.fu-berlin.de, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, andreas@gaisler.com, anthony.yznaga@oracle.com
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: Rene Rebe <rene@exactcode.com>
In-Reply-To: <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
References: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
	<20250902.184011.440504961051160142.rene@exactcode.com>
	<cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: rene@exactco.de

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

> Hi Rene,
> =

> On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
> > Hi,
> > =

> > From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > =

> > > Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to a=
ccurate exception reporting.")
> > > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.=
de>
> > =

> > Tested-by: Ren=E9 Rebe <rene@exactcode.com> # UltraSparc T4 SPARC T=
4-1 Server
> =

> Thanks for the testing! However, this actually needs to be tested on =
a SPARC T1
> as both T2 and T4 have their own implementation that is being used. T=
esting on a
> T4 will therefore not invoke this particular code unless you modify t=
he kernel in
> head_64.S to employ the Niagara 1 code on Niagara 4.

Ah right, sorry, IIRC you wrote that :-/

> Do you happen to have a SPARC T1?

Unfortuantely not. A T2 user might have one, but I could also modify
the kernel and use the less optimized T1 code if that helps, ...

    Ren=E9

> Adrian
> =

> -- =

>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactcode.com | https://t2linux.com | https://rene.rebe.de
