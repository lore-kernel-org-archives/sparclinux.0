Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A718A93F;
	Tue,  9 Sep 2025 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397308; cv=none; b=JpIcA8ASI8qNgbOgZ7gME9A6fg3f5qFjUbZScp2dWr3nrE6GBZI3j9nz5fgmwjiioxcu+J41NICPskyfPkAIILXjwhwM8iyp7Vy1tC5V06bCAEfK0HAmC4UAEKASuRHIzfm93N+1jp5GoRUdVWqfMbGGMf9mUp8I8MSL74NhUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397308; c=relaxed/simple;
	bh=Df96yvf2Xh6xrEIUgiicm19yjU2AICaVs86nIWkCN0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBlQ3kZeeetW3y9z7CXPYH9K9l/T+dJ7l0c+aeBnO+cNWm5/Jmz44cvp0d4La3lzELACGNDiAtfWXWnoVm/ix4QooUBDvHzcj2jkLatUzCt4vZbOhIO13fgKySu5tDkp1Xzzw2thctQlcElY9rz1WxZOJrzoUXKMqBmr/mCakbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CB28A2ac; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CB28A2ac"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5hXliLQHucvQWNmJ5HAB5OK/4ev/m3qsVijclDYkrFI=; t=1757397305;
	x=1758002105; b=CB28A2act5gvhCU6OCtMeRcaZIZ7D9wYEAzIg2qQkcA3d0AFtSYH9UlzRiHYD
	4tHQM915SH3Z4FIdQcTFM3Ryuy8mPSCcdjTV7HlFptiszinSd+e46feocE5/eS6R7Rfn5+7dut1lT
	mnMx+yO0ypEGg17vhkDygIZD1qlWyRPG+Gj0TWsSAD6lQKDzOiUz7g2J+M6xGNccWHbQH6w/jwUOs
	yGvlab0boBcxwWBtbtd3TzZxVjL9EF2ieA1Y0s82Xz+nXaQmom8lv7rT58cMaMFsZG7/qVXbyXfWf
	odC3CK369uU+U+70AZId9cQhCzeleZsfzyrnPFw7wdoxXKvxpw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvrJk-000000022PG-11tt; Tue, 09 Sep 2025 07:55:00 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvrJj-00000001eRs-42WM; Tue, 09 Sep 2025 07:55:00 +0200
Message-ID: <a12114a3e8c48e88a5ae9e0b49577b93bbf30d2d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, Michael Karcher	
 <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?ISO-8859-1?Q?Ren=E9?= Rebe
	 <rene@exactcode.com>
Date: Tue, 09 Sep 2025 07:54:58 +0200
In-Reply-To: <fec617e3-8955-42c6-9cca-588e86833998@oracle.com>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
	 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
	 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
	 <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
	 <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
	 <c3e1173f99e6222ab09093e1a197d6366bcf2b95.camel@physik.fu-berlin.de>
	 <03957ee5ee562b70f7e3278d0ce95b2f52cbc721.camel@physik.fu-berlin.de>
	 <603f6661d99fc6c936f5a75e29f30d50650b9da8.camel@physik.fu-berlin.de>
	 <a9eec6f5a51c82cd2a20a96d614cfd3095ddce88.camel@physik.fu-berlin.de>
	 <fec617e3-8955-42c6-9cca-588e86833998@oracle.com>
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

On Mon, 2025-09-08 at 15:47 -0700, Anthony Yznaga wrote:
> > Could it be that we need to enable the code guarded by DCACHE_ALIASING_=
POSSIBLE
> > unconditionally?
>=20
> It's already essentially enabled unconditionally. PAGE_SHIFT will always=
=20
> be 13 on sparc64 systems.

I see.

I was confused by this comment:


/* Flushing for D-cache alias handling is only needed if
 * the page size is smaller than 16K.
 */
#if PAGE_SHIFT < 14
#define DCACHE_ALIASING_POSSIBLE
#endif

My thinking was that there might be a flush skipped when using transparent
huge pages which causes these crashes.

> The flushing should be happening for folios of any size. See=20
> flush_dcache_folio(()/flush_dcache_folio_all().

OK, I'll have a look and maybe add a printk() there.

> You could try setting page_poison=3D1 on the kernel command line to see i=
f=20
> the kernel detects any freed pages being used.

Ah, good to know. Thanks.

> Is this a different Cheetah+-based system than the one I borrowed?=20
> Definitely some sort of memory corruption happening, but the system I=20
> used seemed much more stable than this.

Yes, it's the same Sun Netra 240. It has been running stable for days, but
upgrading to the latest systemd version caused these new reproducible crash=
es
which started my new investigation.

Replacing "call cheetah_patch_copyops" with "call generic_patch_copyops" di=
d
not help in this situation which indicates that the bug is not in Michael's
patch set which is a good sign at least for Michael's work.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
