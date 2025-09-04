Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB1292938;
	Thu,  4 Sep 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006521; cv=none; b=Zr8RaDzTxUS2t79mSsrFRigrO/VEhWIZYn+zfLfssQKuOuuYUbsXMrqB5Xpu7F7mbDJA4M4kuILq/6xKZRu5vRL53QWRnnRYNaU8KJIMhmV4M2PyMEifKj0ItPiQ9OdjPcnEOD4aKJFtgzMlL8wuPQzXlAhBwNHK3rtxfnyVL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006521; c=relaxed/simple;
	bh=ySe/GcDqsh1QnW43IVRLeuFm1LRq2D8d6GaeGrKHO1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZF6PSZhQPpgLUZu0tzw5GxOavGVrZKoRuoZVoLZ4dIBnr/EFSoIZn4ohfhMI6jlA4219HAaqpFN5WauXFLBMPPhiPhnPCmG0e4jj/wlnBO7ngbZV8cEn5e409W7wh2frS06bIxtLmyNItWTCgirGWFJt/Vugq0UCO53PfykDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HWnbsygc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HWnbsygc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=WJb7aKj7ZvDj0/bNVa1rqqK/4QiAd4WEQvK9Le3i/Rc=; t=1757006518;
	x=1757611318; b=HWnbsygcVVbuTza52TJd1T/jwcy1Ob8PGERQ2bgrI+9kjaETPiIXTPH4V9kh6
	YyHidUdxxeV0a75LMGo1Z5iqbFSg5FHW2WJe1ZsU0GQIgSAs7/whZxgKi2DQ31HSUYwQ8vHbY90g7
	JcI+8Bu97shi3DIQM8ggjcAt0NzNB1Fou3wH+ttRzUXpIMmI993Mu1IpIakFGGKY4oHwqH+bsXGvB
	4axyzprAODvTgjLhF9mFRCVcF6J9PKjDZQHdIi/mi/NRmbU5Ca53YIuFf5xof8Pgoq8V+z466YIQZ
	0JRmr7ZPXO02EJZiCjFeP1JR0ceE8Q6H69kh00jItFKRPWawMQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uuDel-00000004AOH-22ty; Thu, 04 Sep 2025 19:21:55 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uuDel-00000001BjZ-10e9; Thu, 04 Sep 2025 19:21:55 +0200
Message-ID: <2e8a8a058e7451174ddbf3ec2a0a1d7728c45210.camel@physik.fu-berlin.de>
Subject: Re: Fix accurate exception reporting in SPARC assembly
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, Michael Karcher
	 <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Thu, 04 Sep 2025 19:21:54 +0200
In-Reply-To: <0253d6fe-dafe-492f-b7ad-12f98ba3c507@gaisler.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <0253d6fe-dafe-492f-b7ad-12f98ba3c507@gaisler.com>
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

Hi Andreas,

On Thu, 2025-09-04 at 15:49 +0200, Andreas Larsson wrote:
> On 2025-08-26 18:03, Michael Karcher wrote:
> > In 2018, David Miller implemented accurate exception reporting in
> > copy_from_user and copy_to_user by handling exceptions on each load
> > or store instruction that accesses userspace memory and calculating
> > the remaining bytes from the processor context. As issues with
> > transparent huge page support and folio support in ext4 were due
> > to a bogus return value from copy_from_user, I wrote a comprehensive
> > testsuite for the generic variant, and the machine-specific variants
> > for UltraSPARC I/II, UltraSPARC III, Niagara, Niagara 2/3 and
> > Niagara 4, see
> >=20
> > https://github.com/karcherm/sparc-cfu-bug-reproducer
> >=20
> > despite the name of the project, it does not only test copy_from_user,
> > but also copy_to_user, and it also contains fixes to a very small amoun=
t
> > of exception handler references that were calculating the result in
> > a wrong way.
> >=20
> > For UltraSPARC III, I chose to adjust the memcpy code itself instead of
> > adding complexity to multiple exception handlers. That fix has already
> > been tested to fix stability issues observed by Adrian Glaubitz which
> > kicked of the investigation. On all other architectures, the changes
> > are just to the exception handlers.
>=20
> Hi Michael,
>=20
> Thank you very much for this series as well as the followup patch for M7!
>=20
> This cover letter for this series gives good contextual information for
> the series, but when looking at the commit message for a single patch in
> isolation it is not clear at a glance what is being fixed. Do you think
> you could put in a short description in each patch in this series, and
> also in the followup M7 patch, on what it is doing and what it is
> solving?

FWIW, Michael is just waiting for a pending test on a SPARC T1 CPU which
would test patch 3/4 which fixes the Niagara-specific implementation.

Results should be posted today or tomorrow.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
