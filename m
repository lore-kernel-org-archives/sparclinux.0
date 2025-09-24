Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687601552FD
	for <sparclinux@vger.kernel.org>; Wed, 24 Sep 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698027; cv=none; b=FA040t3ixIua/PP76umJB7d7pXQSLCMHbbujGv0IYA+4RGtWeE0D/r+hBqLWaR+CCEj6XBwjER6rynLI1a0Uj11v51UHJ9lKGGV2Ocn3LsPeBgpbwzLEYW7D6NhQNiHs1lk9FMCqv1MEG/ZuvJTroTBgSFqOT/0JJnqYTXt4C+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698027; c=relaxed/simple;
	bh=i0+LGexTSt8NyKSVsQwe4MOHCcza5UWEWx27dfX/Dfs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=uKmHxo5FJA6Du6Kkw3rqspuzwhJUJ8UXc1UKvKzKi5e2NtmurLzW6SvCiHsj91bPCyZdsvVzyNPkoVKTm3XPXXbLocgg25dgx2ENyL+uGu/taisq7VsWcAd4r4q609bv+mmhc1AjLUjfBuc//88kxQxjqbZFmaGixfcvFwn1w+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lu33k0Xx; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lu33k0Xx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oraJ+8+tHbRi/y7PH5ENBb3z3Jc9HlLHmMgP+3GFIz0=; t=1758698024; x=1759302824; 
	b=lu33k0XxjpsDo1H245BnNjM+J1qF8m3N3+HowjtAdyy78dDsFTV3y4cjZuyeqDGpbZQ5YNQiVX2
	ABJEuZdcPNriL8Rq0/gMAx3+zVF1qCUqPlassCgw22VTIbsN0XMTjFE6G9RxE4pJtJUG+BYmF4wm7
	8bYSkPp52/A3xYxyAn0GHHn5H6/ZFdxupBY9lVYDNhMmURLzUPG8cJ1Arsl290g5w22d+JPAZkS5I
	sM3ZP58hI+aJCJUKSq68wQKjWS5q6v/u8RMrDdflL50qkSf7IqJe3sO9Uq7zOnWfgXQNX7uz+P63y
	D6aMYLKbmiYUOH+o/A23rq3yO/uVXCocwjFg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v1Jh2-00000003fmS-2CwU; Wed, 24 Sep 2025 09:13:36 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v1Jh2-000000037mP-1AXT; Wed, 24 Sep 2025 09:13:36 +0200
Message-ID: <f3bf42c671e1499f598055ea901a7b8f5c08cdc6.camel@physik.fu-berlin.de>
Subject: Linux for SPARC issue tracker
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: gentoo-sparc <gentoo-sparc@lists.gentoo.org>, sparclinux
	 <sparclinux@vger.kernel.org>
Date: Wed, 24 Sep 2025 09:13:35 +0200
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

I just wanted to remind everyone to the Linux for SPARC issue tracker I cre=
ated:

https://github.com/sparclinux/issues/issues

If you know of any particular issue that needs to be fixed, please file an =
issue
there. Please look at the other issues and use them as a rough template.

There might be some undiscovered patches in Oracle's UEK kernel that I'm as=
king
anyone to browse for interesting patches (on the uek4/qu7 branch):

https://github.com/sparclinux/linux-uek

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
