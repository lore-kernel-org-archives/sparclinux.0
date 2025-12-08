Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003D22D785
	for <sparclinux@vger.kernel.org>; Mon,  8 Dec 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765211864; cv=none; b=JwQ+JwvCfedRsil4nZSsWP+9J3DYJjpwD0DA9THynEeVwgtIkf1oFRYx+VTcKSdJ4BclJYN+QPHOdYVJg399DCB3KyX0wHRs7Pv0xnyi+q/XYjcBv+fDYKbkUYChhAYgraBh5nnAFby519LyZhCNzk9J6efm6ZKHyPBpHHtcoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765211864; c=relaxed/simple;
	bh=z7Ym+IoG4qLSCdESxlcgpxQ31QyMAnYVbaNtlYEu1kE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Z3tjFG5SKV32gwOa4hEgv0bcjcANDPD6jjbgADhGOM1q5pijAllyudRI7iAl2hSjQ588dLTdB34DpeEXs6eE55KzsYfLz7zdWVkIh64cJOs6U5DNEHAAvEqSXTMfEOET6RA/blNo4fj8Br3xriak4mfbyjIoJ0eM1DiU5Vl7/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WA4oGc1U; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WA4oGc1U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0gRW/Q7VKZBVgzrLLgOk/Eh6evAlQB/46dLp4yxA5sw=; t=1765211861; x=1765816661; 
	b=WA4oGc1U6IhEPOwSuPw0DhNBNUEHVRBbUC3vDuxb6yz7CdQy7kHFau1JHoTvD5jsCfo8CISpSp4
	tiqKVOi/ZBMM63PsRQA0We5zY7TH4S7cVB4oeAsvCije1UtQ550eLBVJGlLSNYdepfdqsptcfavPL
	jwrSEqUxexnWG52cExRl29sJjGRETmyvfnPgQafBFt0Le5hJV0n1vIn3h/zuSw+KidgmEnDEFE/Aq
	sjenLO7vKg27E7sqZHvaY1j5g1K0EtnL7g8mwVkaFB0Dbjml/0cnHeMvCxpN4tpM+8PiF+tyOv+kg
	rISmyp89vBXfZ/kV4SpKV/md0086kDAXS2Vg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vSeEu-00000000ecX-2FW7; Mon, 08 Dec 2025 17:37:32 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vSeEu-00000001mQ2-1OLy; Mon, 08 Dec 2025 17:37:32 +0100
Message-ID: <d5c589096ad59058be99bfde42808f2c1bc06c5d.camel@physik.fu-berlin.de>
Subject: New potential regression on Niagara 2 with 6.18.0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Date: Mon, 08 Dec 2025 17:37:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

I just tried booting Linux 6.18.0 on a SPARC T5120 server and noticed the k=
ernel buffer
was spammed with the following error messages:

[   14.756781] iommu_batch_flush: IOMMU map of [00000000:00000005:1:1:e0660=
00] failed with status -8
[   14.756959] iommu_batch_flush: IOMMU map of [00000000:00000006:1:1:e0660=
00] failed with status -8
[   14.757133] iommu_batch_flush: IOMMU map of [00000000:00000007:1:1:e0660=
00] failed with status -8

This was accompanied by the ethernet and USB controllers being unable to in=
itialize.

I will file a sparclinux issue for that. I have not bisected the bad commit=
 yet.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
