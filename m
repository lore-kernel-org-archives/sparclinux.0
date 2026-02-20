Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E71CD1E4;
	Fri, 20 Feb 2026 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593358; cv=none; b=l2rZp9d7Ez1UQJQx9c4Fc8GT0vpEearShriyAdWiBEMVlasGaRs+EAvJH7Ps/9Bq+iBVr+fbYheCz+Wh+M1r1fvO62QJu14u8hkTPq7VixYIpaynK4KeF8GG9S+nsu1hoE+f694VbHmLGT0Oa46AHRz1XD4iVhGHblBmpCiVWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593358; c=relaxed/simple;
	bh=xhs0A+TPF4HjjwmUYRj1e5SPbOA4XjjbPk1x8mlako4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBcMZXBvlE+Q10KLRz+arbeLlHgQBrDWEK7q3xqusrch6PgH3JlW7uVh35SISefDWFBvoCR3mJidX9b2O0Oqhe2cYvaj3EQBxoF+QbWFPZVutO8sucEC+nCX+lAqUHZfJdDUvva/dawelhGZyi3sZX3YrOF/S3i+z0s0zks6Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=L0WsDBrz; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="L0WsDBrz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=mOkNCk6azFD4Se56SNgIay6/ojZdDJ39xzBXTJXthIE=; t=1771593356;
	x=1772198156; b=L0WsDBrzl/TBCqv7bZ5Fm2FbF5X+D8MvOY8bss3BrDsxLZ1ED7W5Pw3KtXtLN
	cmyOERRA+cKEKWvZJLgrs10FoPbmJlziEuQJLmVxKa7Z81vrDasImIhqXrGvmBOqLbNyyjuqKyblc
	TklvN4HOVC4cqJvwA9ZgBaiP8z3o31tzE1thM7dFOu51aGa98fGePMWb9GB/IQB/5APifF91iAKiW
	kLVZvg0pNzS5pf+EZr+Sy2oDxN/FcQYlWd/Opvpbyb57nMy6OT66jzQUDm+axg3sEdKqsqxVm2rSy
	TmJDa+rwYJhHwgzq5FWHYikxazf8MJ+f9zxjA4+J60o55TUDxQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vtQMI-00000000Zex-35F1; Fri, 20 Feb 2026 14:15:50 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vtQMI-00000002ANB-1yr4; Fri, 20 Feb 2026 14:15:50 +0100
Message-ID: <8aa6c538d4a49084f6464772f8dd1bd2b642c54b.camel@physik.fu-berlin.de>
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc
 systems
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Nilay Shroff
 <nilay@linux.ibm.com>, 	linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, 	sparclinux@vger.kernel.org
Cc: tglx@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, 	chleroy@kernel.org, gjoyce@ibm.com, helgaas@kernel.org,
 davem@davemloft.net, 	andreas@gaisler.com
Date: Fri, 20 Feb 2026 14:15:49 +0100
In-Reply-To: <782eaaf6-f7e2-4c15-b4a2-52e7697dbd95@iscas.ac.cn>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
	 <782eaaf6-f7e2-4c15-b4a2-52e7697dbd95@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Fri, 2026-02-20 at 18:14 +0800, Vivian Wang wrote:
> Hi Nilay,
>=20
> On 2/20/26 15:02, Nilay Shroff wrote:
>=20
> > Hi,
> >=20
> > Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
> > msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_=
mask
> > to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the=20
> > validation the programmed MSI address against the msi_addr_mask fails.
> > This causes pci device probe method failures on powerpc platform. We al=
so
> > realized that similar issue could potentially happen on sparc system as
> > well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK=
(64)
> > when pci_dev is instantiated for both powerpc and sparc platforms.
> >=20
> > The first patch in the series fixes this on powerpc platform. The secon=
d
> > patch fixes this issue on sparc platform. Please note that as I don't h=
ave
> > access to the sparc platform, this patch was only compile tested on the
> > sparc system. Anyone from the community is welcome to test it who has
> > access to the sparc machine.
> >=20
> > [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998=
f2750@iscas.ac.cn/
> >=20
> > Changes since v1:
> >   - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang=
)
> >   - Some minor cosmetic fixes (Bjorn Helgaas)
> >=20
> > Nilay Shroff (2):
> >   powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
> >   sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
> >=20
> >  arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
> >  arch/sparc/kernel/pci.c           | 7 +++++++
> >  2 files changed, 14 insertions(+)
>=20
> This series is:
>=20
> Reviewed-by: Vivian Wang <wangruikang@iscas.ac.cn>
>=20
> With the caveat that I have neither powerpc nor sparc machines to test,
> so it really is only reviewed.

Then please make sure that the changes have been tested on actual hardware.
We've seen some regressions with changes on SPARC that went in without test=
ing.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
