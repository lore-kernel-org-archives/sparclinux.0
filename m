Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615779;
	b=GRFlLcmkSBxBEJVF+9vj24pQRciD/uUhNoZBKYYxijAoil+EW+fR/Kk4Da3kiKTgODCG
	 8pOiXpupGT1e6lWS9fEdFxU0sU7VrIRd3qlWQnAB1GKE2W6HqWVpM1ITSCwB2fB7JzUE5
	 UV/z5hgw+BsIH+ChhgIEHvpI0lgd14YmxzKAx9usEq6Uu3IqjjNXGGno5CkOpl/o1DnAt
	 XkKc6keBPjou2EOLK4512QnZ0iXb3oCCdo+BLnew4ACKpvWBev6WdAZ5HtZ5QASr92Jr1
	 +nBaUc/8rKBlP6btqoMccT8M0OQ4AJkz05VhhBQu2f2Yl3v3afaQvXxmecBB55nCgCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615779;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=Uk8qAiG/IPrN36n5DqiO5Jj7nMXwV1HyK4QPffhcFj0=;
	b=JyxAQQ/D8QtG5LyYxXVIvTklZZll+TLZDxwpXmCGyhNk9GnrgJHWYLKCl847uozxN4E1
	 bz0+Uv/AXCbyUiQHIW5tByxkgS4GYz5BymN7lg/gkgIx/AVFwjD8sqcrtk3uSflUd0KkJ
	 lVxGAQxuAU9cCnuLxZFxKOHjIjRLTTC0anS75W/MKrzRo04dfWDKCKsCVF6UpuoXm1Sse
	 LBvMZregiHGwA+w/94nSZeSTqD6nh5uI8SQUgigTq6ehp4I3fCFkq/l6L3gDtOetPsfoW
	 P9jmOg6hYFjAE1jFSUCWxfVd8CjR6UPFJ0v9CnFsSVa3pp35WYWmFF9Iy8t9n3D06/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=WI6kfOTA;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E4606A31A;
	Wed, 21 Oct 2026 20:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=WI6kfOTA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Uk8qAiG/IPrN36n5DqiO5Jj7nMXwV1HyK4QPffhcFj0=; t=1792615777;
	x=1793220577; b=WI6kfOTAxWB/ImHoT3K2ZvjmxyqBHRbpBP18d7vVt6NWcEMIqIvYij2slhebm
	7I/c+3NR5WW1yQzaZd/7C7FnyNUWl9WylE2bvNOGIRSfN4vOyUqVtbQ9oz/i4F6SbrO/e+6Gqlb/h
	lVU7UaTBkx59ObjcY90JJYv8mX+8O8r3TiGSS3oiZxcU87qgo9qZR2tddfSTrbOlxevJuYdbLRFzp
	qKd1uuQtAO/cEF+u30+cyIo9sg5zUwPVtDH+nP7aag4t78etSoM3qGnR/VJVHdkyE91sUF/9mU0NE
	6feYhYfraYgAZehDTp9HX1/O9xpqk0ACYpzQK0wg7hiC8x17hQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJdFX-00000001i8V-1euN; Wed, 21 Oct 2026 22:49:27 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJdFX-00000001hei-0jIT; Wed, 21 Oct 2026 22:49:27 +0200
Message-ID: <0892a8803ca20869cd8cc76fcffc9f7543cffd2f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: Use relaxed ordering for DMA_FROM_DEVICE
 mappings on sun4v
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Tony Rodriguez <unixpro1970@gmail.com>, Stian Halseth <stian@itx.no>, 
 Andreas Larsson <andreas@gaisler.com>, "David S . Miller"
 <davem@davemloft.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky	
 <leon@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 22:49:26 +0200
In-Reply-To: <e8f08d9a-8b67-4c7a-8ef5-1ed38351e499@gmail.com>
References: <20261013133731.1795299-1-stian@itx.no>
	 <e8f08d9a-8b67-4c7a-8ef5-1ed38351e499@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Tony,

On Wed, 2026-10-21 at 13:30 -0700, Tony Rodriguez wrote:
> On 10/13/26 6:37 AM, Stian Halseth wrote:
>=20
> > sun4v IOMMU and ATU mappings carry a relaxed ordering attribute, but
> > dma_4v_map_phys() and dma_4v_map_sg() set it only when the caller
> > passes DMA_ATTR_WEAK_ORDERING. Some network drivers do, storage drivers
> > do not. Without it every device write into memory is strictly ordered,
> > which on a T7-1 (M7) caps DMA reads at about 280 MiB/s per PCIe device
> > while writes run at full speed.
> >=20
> > Set the attribute for every DMA_FROM_DEVICE streaming mapping. Devices
> > report completion through coherent memory or an interrupt, which stay
> > strictly ordered, and a strictly ordered write does not pass the writes
> > before it.
> >=20
> > T7-1, fio 1M sequential read, QD32:
> >=20
> >                        before        after
> >    NVMe (PM1725, x4)   281 MiB/s     3169 MiB/s
> >    SATA SSD (mpt3sas)  278 MiB/s      502 MiB/s
> >=20
> > Closes: https://github.com/sparclinux/issues/issues/114
> > Signed-off-by: Stian Halseth <stian@itx.no>
> > ---
> > Tested on a T7-1 (M7) and a T4-1:
> >=20
> > - T7: fresh RAID1 on two NVMe drives, 192 GB fio crc32c write+verify
> >    and md check: no errors, mismatch_cnt 0.
> > - T7 and T4: file checksums on the SAS boot mirrors identical to a
> >    strictly ordered kernel; no new messages in dmesg.
> > - 4k random read and sequential writes unchanged.
> >=20
> >   arch/sparc/kernel/pci_sun4v.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4=
v.c
> > index 61f14b4c8f90d..4dd17b65dd6cc 100644
> > --- a/arch/sparc/kernel/pci_sun4v.c
> > +++ b/arch/sparc/kernel/pci_sun4v.c
> > @@ -403,7 +403,7 @@ static dma_addr_t dma_4v_map_phys(struct device *de=
v, phys_addr_t phys,
> >   	if (direction !=3D DMA_TO_DEVICE)
> >   		prot |=3D HV_PCI_MAP_ATTR_WRITE;
> >  =20
> > -	if (attrs & DMA_ATTR_WEAK_ORDERING)
> > +	if (direction =3D=3D DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERI=
NG))
> >   		prot |=3D HV_PCI_MAP_ATTR_RELAXED_ORDER;
> >  =20
> >   	local_irq_save(flags);
> > @@ -503,7 +503,7 @@ static int dma_4v_map_sg(struct device *dev, struct=
 scatterlist *sglist,
> >   	if (direction !=3D DMA_TO_DEVICE)
> >   		prot |=3D HV_PCI_MAP_ATTR_WRITE;
> >  =20
> > -	if (attrs & DMA_ATTR_WEAK_ORDERING)
> > +	if (direction =3D=3D DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERI=
NG))
> >   		prot |=3D HV_PCI_MAP_ATTR_RELAXED_ORDER;
> >  =20
> >   	outs =3D s =3D segstart =3D &sglist[0];
>=20
> Tested-by: Tony Rodriguez <unixpro1970@gmail.com>
>=20
> Tested on a Sparc S7-2 with a Samsung 2TB EVO SATA SSD.
> No functional issues or major regressions were observed.

Did you also see the vast improvement that Stian has reported?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
