Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF71ADC97
	for <sparclinux@vger.kernel.org>; Thu,  4 Sep 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971610; cv=none; b=eIbxeFJrb7k65NDdkj+VL/VwDgjsiRC1oN66dBUVV3MKqRdt9jgS64QYCqTPbMke91VkWg4HkrtEcXFOVJiYxbsY2Zw9yi1rJ3QGL/n/TeL4kBVDQom+L2SgzG7L4ks8qnLePR02hXjLhEnsfG6hoWKBZAWEw0knIHBDq5nHwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971610; c=relaxed/simple;
	bh=NFLn1fCw2G1r7fpsvdOPvcPgagBbljW9fFxJKxuoWJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItyYFRbhwtj5zwpR54JGmmczz9YNZuuNhqDkOwtxIAyOdu0UjRYYGGotse8PIbRvuSvqfMEYkw6S12MvtMQDXpUMij6OUy7SK+5ed3UN0/J6HdSKCEOUVmPmIsVa13EMqZvghdJ4Wo5G2CfFWgCAERoNlGMVfqoPha26gD1jEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gEtLeJ0z; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gEtLeJ0z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8HXWzHAg32sl681gsE82seF2wfMdW/sC16ROUK0mcqI=; t=1756971607;
	x=1757576407; b=gEtLeJ0zqAiWJviYePluCqi1vuViUo38tyKaliqFuUpN22CnKxZGWk208oOga
	VWshOqx1gj5Sqgb/annTghdunEMuizgIifUnMALdSwRnRZ2yYW+Rm0/ETAwCgDEDJkvU2I3zrN0g0
	fBUaKK1pn6Xz0wmHjIMfq7NH5cTtVZXGWhyb9/xieWhB+vWHSd39Ipe6tu99jxvWGNVuyo9hXigTe
	DGDMY+wMWdDuBvJ5Zuo4n8fp/Zv1raUYqS6t5OA0kH6Fe8tPVTeqrLnLAOJywik257+E+EFhMdKgq
	9pMAYOnATVoXhvh54aIyNrPr0mFQU2XrZXX+YpdgbF84DTz4SQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uu4Zi-00000000bdq-0ast; Thu, 04 Sep 2025 09:40:06 +0200
Received: from p5dd48348.dip0.t-ipconnect.de ([93.212.131.72] helo=[192.168.46.214])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uu4Zh-0000000376A-3v70; Thu, 04 Sep 2025 09:40:06 +0200
Message-ID: <b6cec311e4e8b74ad6a5d4fff68ffb1e8e38c4e4.camel@physik.fu-berlin.de>
Subject: Re: Testers with a SPARC T1 (T1000 or T2000) needed
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: gentoo-sparc@lists.gentoo.org, "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>, port-sparc64@netbsd.org
Date: Thu, 04 Sep 2025 09:40:05 +0200
In-Reply-To: <cac3f07a57c4d620f05a8aacc4fa7ca92727c92e.camel@physik.fu-berlin.de>
References: 
	<cac3f07a57c4d620f05a8aacc4fa7ca92727c92e.camel@physik.fu-berlin.de>
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

On Thu, 2025-09-04 at 09:30 +0200, John Paul Adrian Glaubitz wrote:
> In case of a successful test, please reply to the patch mail titled:
>=20
> "[PATCH 3/4] sparc: fix accurate exception reporting in copy_{from_to}_us=
er for Niagara"
>=20
> with a "Tested-by: Your Name <your.mail@domain.com>" (filling in your det=
ails, of course ;)).
>=20
> If you're not subscribed to the the sparclinux Linux kernel mailing list,=
 you can reply
> to the message by downloading the mbox file following this link:
>=20
> https://lore.kernel.org/all/20250826160312.2070-2-kernel@mkarcher.dialup.=
fu-berlin.de/
>=20
> Import this file into Thunderbird or any email client of choice, then rep=
ly from there.

Sorry, this should be:

https://lore.kernel.org/all/20250826160312.2070-2-kernel@mkarcher.dialup.fu=
-berlin.de/raw

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
