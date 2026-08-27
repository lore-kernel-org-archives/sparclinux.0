Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5543E06A
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842416; cv=none; b=SYgL6JhE3npKdHgao261TFFgSiobUk+FcIoL5RxKD8HQQJ0bJjUji+AWf7MMYDoIlBRXqiF+6Pc3e/IE6t+39F8tPzx864SGyBl5nsp11iKLZISOin4e0isEnEOk0s2adaXV9BHZ0uOyQ4xYRCINrgGOCBIsoLQHE+k5RUm78Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842416; c=relaxed/simple;
	bh=bq5t7BpkdQBLknsV45gxFXffgo42Kc6Gbzq3XfyTBbI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qe0eV5oDcc8V9RchmO/Zof63dKO6N4kN7I08nDlkcTdslLBP2OEXjwGdEz7vby8J/6soC+R+xw2qI5UWRDnyRSBV8yElx4sXnlsCaVvrKdgvkmRo9+ev9ceXhErIbyOqSLrhYJiLUktOj+Z4Ywg+DWrfA1VGVbaMVFCMEorAG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ImGjNIzq; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ImGjNIzq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=G+cfkhvWz2FX27224IE3KQ7lz5FAoajyY3BQxkeXYpE=; t=1787842402; x=1788447202; 
	b=ImGjNIzqP1eaGNA4tAqYG8LjqdhfJWYTnKbX2N9R5/TkhoIEe/uaR/FaIM4RoafK7YEdpVGnUVO
	P4cifTDIzCKAzWgX34BqSotCo8TojqRTB+Pc+m0C739rZk1rDr8oXSCSAUHqTwMjyV+QHpKSd91gg
	/2+5sF+/3WfDPvK1lVdx1ZwklyZn6tN5zZDIl6F6wr7fXO6Y6QJikl8G2F3M/VSqlNJ2RTgwSMxke
	Ek6ApXnwmFCOT0nR5h2eIFyHDwSQ9szw2QTFGQ4QM1dky49WLNaPp74yghVuLCcomPQBjPxH5MFeU
	bqA4ErGZ0SM+AxCBdmvDx+BrlhFAZKXHVEfg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wzbTb-000000030tg-2C6n; Thu, 27 Aug 2026 16:53:11 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wzbTb-00000001sQ9-1FvU; Thu, 27 Aug 2026 16:53:11 +0200
Message-ID: <fe9a51c4d5a4d1e0ddcc1978bd8ee39ed9c82a72.camel@physik.fu-berlin.de>
Subject: SPARC kernel soft-lockup with CONFIG_TRANSPARENT_HUGEPAGE and Golang
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, sparclinux
	 <sparclinux@vger.kernel.org>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>, Stian Halseth <stian@itx.no>,
 Michael Karcher	 <mail@michael-karcher.net>
Date: Thu, 27 Aug 2026 16:53:10 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

we recently discovered a new reproducer for triggering a soft-lockup in
the SPARC Linux kernel. The issue was originally discovered by me while
testing Stian Halseth's Go port for SPARC [1].

Stian then spent some time on the issue and was able to write a small
reproducer in C and found out that it can only be triggered when the
option CONFIG_TRANSPARENT_HUGEPAGE is enabled.

The issue is discussed in [2], the C reproducer can be found in [3].

Huge thanks go to Stian, both for his efforts to finish the Go port for
SPARC as well as debugging the kernel issue.

Adrian

> [1] https://github.com/shalseth/go
> [2] https://github.com/sparclinux/issues/issues/87
> [3] https://github.com/sparclinux/issues/issues/87#issuecomment-543126385=
9

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
