Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71354315A;
	Sun,  7 Sep 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757280708; cv=none; b=Mo+GWUME4pV8g5gjWO0G8PofUy92qSD0feSA0fGN0T9Hu7PGaF5OFm3oWExaWixC6j37ZOoPEd97eRLHGYqF/+a61T1J6Mr2waVDtqyyyI1XNEmfjFHLTr1upf2mlOknek9SCZirlFxSzTphW61euymt+2CcqyXEQgehDdBu0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757280708; c=relaxed/simple;
	bh=e7ID+j9at7heoLiVoP6Gvy/Zu4m9t7Xr9DSTbMDwKas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAKT6GzZACBTTyKSwggnEhVqrjS1YEDbP1YZY2q+j3DzmfUmmF3OfDHB9Zx68+vzYYWrKDby1n7Ng8mt3XDELvFB4lQ/ZcbOkV82ADoNjnG71YQ0di0jkPthS3r4rOJXPzweIN1jYKytldMUWUsa/YrRcUDfscs6C08c+5BV+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=antCOnEt; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="antCOnEt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Dpvq0/dIiPcHnZ2VR0QXijoUGUgIX3GdzhJAKHK2nUU=; t=1757280705;
	x=1757885505; b=antCOnEti/W9aNu00AxPsJq4jtf0uXnVh0JL50LNMwNrcqwaMlMC5HdiIicEw
	TGj6VIvTj/nIU+28V+UAZl3KSzxf11ZulnQELY1I7351lXzAspjjgHWpCk4zBBUmhrDNxhETb0Ld0
	t9DlP2iBlhcLq7qEmpxv7YRys7r9Hho8oCHdXzbZaTDrA4uEJd0/DAb/5dfj+1YV77+6IgyvAxgCr
	fHsTPcpr6V37py4Q63a+V9tFTfIW6ginZ+Ve1Rv3+gsbQvm2GfCsueJL8QfXG45SGsaW4GZomtsY7
	1xBi6gBMEVwbVDWT8gga32L0flePRpseqJgv71dlEY37VxL7tQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvMz8-00000002qWw-1zt3; Sun, 07 Sep 2025 23:31:42 +0200
Received: from dynamic-089-012-071-066.89.12.pool.telefonica.de ([89.12.71.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvMz8-00000003b04-153m; Sun, 07 Sep 2025 23:31:42 +0200
Message-ID: <c3e1173f99e6222ab09093e1a197d6366bcf2b95.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Yznaga
	 <anthony.yznaga@oracle.com>, =?ISO-8859-1?Q?Ren=E9?= Rebe
 <rene@exactcode.com>
Date: Sun, 07 Sep 2025 23:31:41 +0200
In-Reply-To: <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
				 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
			 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
		 <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
	 <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
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

Hi,

On Sun, 2025-09-07 at 20:33 +0200, John Paul Adrian Glaubitz wrote:
> I assume that cheetah_patch_cachetlbops has to be invoked on UltraSPARC I=
II
> since there is other code depending on it. On the other hand, the TLB cod=
e
> on UltraSPARC III was heavily overhauled in 2016 [1] which was also follo=
wed
> by a bug fix [2].
>=20
> Chances are there are still bugs in the code introduced in [1].
>=20
> > [1] https://github.com/torvalds/linux/commit/a74ad5e660a9ee1d071665e7e8=
ad822784a2dc7f
> > [2] https://github.com/torvalds/linux/commit/d3c976c14ad8af421134c428b0=
a89ff8dd3bd8f8

I have reverted both commits. The machine boots until it tries to start
systemd when it locks up. So, I guess if there is a bug in the TLB code
it needs to be diagnosed differently.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
