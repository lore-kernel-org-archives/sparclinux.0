Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07971F9F73;
	Thu, 28 Aug 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412514; cv=none; b=YtZsaHJBsKuS78IH0DGcU8/A+YRfCAMF/envHRCmz1unZICFCGXXtDIQclFhYj+/qVZmxzHH2KvZcSQkScg4ptzpWcImkH+HF+s+h1gos1qjJf74jLvIctPp6CS+TEy/YioLBVvGl/4Cz2XmtXIivN9d88mAZTJPTlMOxRLfZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412514; c=relaxed/simple;
	bh=NW33AYuptd3cfx3/iJW85Vv3Xs7A2EFJJawCOqPkoX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBr8pc4jBWF4mE4Vb+okD6a8sM7RR9POK6K61yA24rtwEgJMXImXUqlh7nOl3KsBob/ydXVLvfb8IVZPX9fABMXG0UrUZu+NpzwEbgcc7JLOBf5rR8JMD/e4/SPUsPP3LvRW2Fri75rMzWOFzFoiF4ipOCbEZraEJ0MIindHqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pxg8uZUl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pxg8uZUl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Epc33ZiLuoafkw6jdyWwrGsUQr8AaZgYiE+doMJItWg=; t=1756412510;
	x=1757017310; b=pxg8uZUln1GsPYG3SzT+j+jhhUSs5NTlvq67Mlf69shpgpC/8ealo/Faldyt9
	mytZLGWkMtDHo+pf06wNu32HkXOXanxTCVhpw6iY26V2YV8CFAQeR5v8v6tIPfC/hW767y5UEDo+u
	PMOmUyxWleyOoMnQsKC01gaWEPT5XhU47uTrObw67kKjWgwRU4z2X28O9VZTLfMxeDr2MpyRrMDDN
	YnbjEDBAYDdRlRGv/tTOiT3zHtszyDoVYjssh31qh5bQq7ICASNjy8jQla4P3plDLdElkdcp3QdOK
	YJQAt11c6Eoy7FCC8Bpnc/taEsrQRGSxBmPbDM8py6O+Xo34aw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1urj80-00000001gm3-0JVW; Thu, 28 Aug 2025 22:21:48 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1urj7z-00000001wWa-3b5L; Thu, 28 Aug 2025 22:21:48 +0200
Message-ID: <4c827eba2ce2c501cb4e0b820653ae582ae87daf.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara 4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Thu, 28 Aug 2025 22:21:47 +0200
In-Reply-To: <20250826160312.2070-5-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-5-kernel@mkarcher.dialup.fu-berlin.de>
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

On Tue, 2025-08-26 at 18:03 +0200, Michael Karcher wrote:
> Fixes: 957077048009 ("sparc64: Convert NG4copy_{from,to}_user to accurate=
 exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/NG4memcpy.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
> index 7ad58ebe0d00..df0ec1bd1948 100644
> --- a/arch/sparc/lib/NG4memcpy.S
> +++ b/arch/sparc/lib/NG4memcpy.S
> @@ -281,7 +281,7 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	subcc		%o5, 0x20, %o5
>  	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
>  	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
> -	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus=
_24)
> +	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus=
_16)
>  	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
>  	bne,pt		%icc, 1b
>  	 add		%o0, 0x20, %o0

Verified to not cause any regressions on SPARC T4. Whether it improved anyt=
hing is
hard to say. It might be that previously observed crashes after long uptime=
s are
gone now.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
