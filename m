Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F61A2630
	for <sparclinux@vger.kernel.org>; Sun, 14 Sep 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859593; cv=none; b=M+kDPsrNcfshe2dLJdJde5uOkboEBRm32n7Q7+jIfWV6VYQvp7EygBrbGBuFYy7/ky9YtKTVKlQp+NslDJGg2QDSELyCZBGnNZRDCUY8JTWHHGR5jqqkLFxAmFad1M+yI4erVueoJumOxRWY/C5k+H5+byuqkRSQ4fFFTnsPGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859593; c=relaxed/simple;
	bh=vSxm3gr4fXHfaYxa3ZGRwhhjZeB/ZxPsiTLP2lQ97io=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=lNO8EC4CBTSlXUnZiHvEV64oSJc683lqOr9avvli8bzy0i/06D0b10ARDjlbVUqBrv0Oy+M9OtauiW0ITzXDNkgYXRTFYNaToeMU2xBcij7fyocJ6k5jJVagWJ7sskKviU0qflX8pL7F/gFe7mzo3UkzkORxmhyCOGH0q3gpgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=bPfH5KZ3; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="bPfH5KZ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/l9k9XW6IKC47uow8oNMQCZSR/2p3/3csm8dWm0CwbA=; t=1757859589; x=1758464389; 
	b=bPfH5KZ3VEEGt8EGLYBBa2cU/ECFU6YE2bCbAiNToCL6ORzjc/yYyWY5g3Qb0ROwLWDrG0oSONp
	glGr4/lPQSzz//pSlTN6pBhc4F2zBVkdOqouO9pYoTovCh4ZUOxpPyhOCe1v+H1c/oxvBk33TDIPh
	Sc69sVLgSthJavo7HX65V+CQKY9qQuzwNrGQtgXi9rp9O/8zm/9hA9HKX/fnxE8Wz6H3a4rZt8Bli
	fz0nmM13xJjDhtK/DhTVNjtOvm6M1W3GqqzyepA/Nwh+m5tojRWH/mCpuIL27cgXvD+1nO05Fe6F3
	N5cYGVWSIL8nENivKcvjpeqhIj4oIz3esMKA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uxnZt-00000001hxw-23Ra; Sun, 14 Sep 2025 16:19:41 +0200
Received: from dynamic-077-183-251-171.77.183.pool.telefonica.de ([77.183.251.171] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uxnZt-000000002Y0-1DCO; Sun, 14 Sep 2025 16:19:41 +0200
Message-ID: <1a207ee8c38013bcbce70cb1f4daaa07691fc653.camel@physik.fu-berlin.de>
Subject: sparclinux Github organization created
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>, sparclinux
 <sparclinux@vger.kernel.org>
Date: Sun, 14 Sep 2025 16:19:40 +0200
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

Hello,

I have created a Github organization for Linux for SPARC.

It contains forked repositories of:

- the Go compiler with SPARC support
- Oracle's UEK kernel with various SPARC improvments
- an issue tracker where I am going to collect known problems on SPARC


In the future, I will add:

- Valgrind with SPARC supoort
- ... and more

The organization can be found at: https://github.com/sparclinux

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
