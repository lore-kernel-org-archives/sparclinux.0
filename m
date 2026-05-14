Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D43BFAF0;
	Thu, 14 May 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737230; cv=none; b=MaX3L4jgpPqlQQjP+xCbJwreBwdgDuFp8y8o0sBMecetU08b3Gvbv9jFow/1C0cb/MxUTuNNGAX5X9LmIV+nYVzcyXeaF0fDIJOdZVU2pdMZTI2aojgpjfUiZfvonuBeOHHoXC0LbR4Bl0R6W4z8goYk9ugq+YTGn/a8+S6xxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737230; c=relaxed/simple;
	bh=WJuP3qJyxmVcO8w90nrF0CDjVvnbl4X+a+wmcNPHdvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hU4EFuMlhdNzLTgQV6Mq0/N/D+CRvKQ0zmo0onrF9l2jJsqYSGTsnRd5Z7FkZ5tSMkdLIeNyrtrVSE81lLJ5BdIe4DvV380klEPfYSzW7jZOR3o3kBJYb0cefJuQ9XgeoCwqKRhYXzNhCby59HElf5MLnbEhscZi1mVGl8jzDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GJwcm/Uw; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GJwcm/Uw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nJkGjiluwSwpYa1uXAhIlqqCzJhQzELz7NbH86Xblf0=; t=1778737226;
	x=1779342026; b=GJwcm/UwLn4yoMDZkzcFxdlR8usENPEDQn8YOb9gUfhYm8HfyVJFxSEBzB4zo
	VnBQkZNcjVbnweQMAGN7ahzTAjxVq7rXDZWt6LnfbDMGIU8XAoyfdWPpdysiKyOykmBPmMJNxpbly
	RnguH7reWi7nlmMEBK+WINk6GCIeXOTPPvfH2BM+52/Lisi4pVXzKfojlEAMxsQBWJw6SjfdSdsc3
	K9FwizPCjkissP/Pv31e2MM0W5E4A3xC4pBUyTl51G+l13NcXoJAhp0OPqhmKbTOAMfoULnaTiGHm
	5QO/TjrD6j68sNPBn36w115k981MVmqG6FRSIkt6c3I3TGl2ug==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wNOo4-00000000c1v-1cZw; Thu, 14 May 2026 07:40:24 +0200
Received: from p5b13ad18.dip0.t-ipconnect.de ([91.19.173.24] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wNOo4-000000031lZ-0AQS; Thu, 14 May 2026 07:40:24 +0200
Message-ID: <07519d6f071f9e7fc5a1a58e95a7348d5db4f6cf.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: Avoid unsupported LLD branch relocations
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Christian Brauner
 <brauner@kernel.org>, Nathan Chancellor <nathan@kernel.org>,  Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:\\b(?i:clang|llvm)\\b"	 <llvm@lists.linux.dev>
Date: Thu, 14 May 2026 07:40:23 +0200
In-Reply-To: <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com>
References: <20260514041908.874355-1-rosenp@gmail.com>
	 <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de>
	 <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2026-05-13 at 22:34 -0700, Rosen Penev wrote:
> > I would rather fix LLD than making such intrusive changes to the SPARC
> > code in the kernel. In particular, since this touches the CPU-optimized
> > memory routines which had been haunted by subtle bugs for years and wer=
e
> > only fixed recently.
> >=20
> > Is improving LLD in this case not possible?
> Above my paygrade. I use this so that allmodconfig succeeds.
>=20

The kernel must also work in the end. Being able to build it isn't really e=
nough.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
