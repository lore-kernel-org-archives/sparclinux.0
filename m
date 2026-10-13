Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8843CCFCB
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896361; cv=none; b=HLjj2a3WHPmdBkSDN57nsOThb96FdA/PEDhWjTMQqNPBojXby3mKeX4mgMR7cNJsc9xL5V+1VAMwN1/euuAw32G2nB475n5NNBlJnjDwm58l1AGWfgOPgmMZXpgOg76FuD31hWHTt/ecyHUKK3vc5t1l4Bm7w/sw7JEWi1WTw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896361; c=relaxed/simple;
	bh=4v2m+X8IGh5nWntFMumS3IZIsVHtSauEvQGjnE80Z9I=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=QilN0W47/h7vRKpxc2zLxrfh1NaAVPORYGr3sOygQxBOZlM8T5008MLFCxjlin4/AcDA+Pfvui0nSaBKK1fOqiL3r9ahiZ1y/0ZrFazalWWObuZ6qh2RMlqLqA3CPm2fE4hxkD7iNDS6alsR6NTeU4Bjyw0tMDRKtfvNJGH4p2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OCVBsNck; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OCVBsNck"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZQ8U+Y2FnRdZOH/PHaM6ZoQE6Nugn4bnlz5LY4kZnwk=; t=1791896357; x=1792501157; 
	b=OCVBsNckKTflpQnm/3+adggX96C51QWd4vEWe6i1ksyytZ0eX0kmb+I3nLnI6P3NGZzstt7MhIm
	S+hzI5gNyhMDuTdwVKCDGhvld1K3aaACEmQseZsAQ9jzXd/oDaUCpwT48M8R12EFEjsBRottsfoZf
	gWipTNJyYVv4MfcghpkVxxkkkuSNjz1stKm+UYsYdbsYhh5jnUYn1i/kjIyEmfaaJvs/tvRQqx2Uj
	zp4gNC0k+yCRK8iE4aDuMibiJqrNmBlyW2b97P7L+Z63/o5D4fut6r+JXHQfpwolZurDt/LMgsUTV
	f4Ove6WGiVBuhg0hx+kaOcPHsAugZ/yA8FSw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xGc5z-00000003Vzy-2tSH; Tue, 13 Oct 2026 14:59:07 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xGc5z-00000003kIO-1tQo; Tue, 13 Oct 2026 14:59:07 +0200
Message-ID: <8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
Subject: SPARC Meetup at FOSDEM
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, Magnus Lindholm <linmag7@gmail.com>, 
 Andreas Larsson <andreas@gaisler.com>, Imre Kaloz <kaloz@kernel.org>, Sam
 James <sam@gentoo.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, 
 "<debian-sparc@lists.debian.org>"	 <debian-sparc@lists.debian.org>,
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Date: Tue, 13 Oct 2026 14:59:06 +0200
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

I was wondering whether people would be interested in a SPARC meetup at FOS=
DEM?

I will be around as usual and maybe we could arrange a meeting with some ha=
cking
and beer.

Adria=20

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
