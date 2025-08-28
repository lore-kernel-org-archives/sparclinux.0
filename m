Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F32512C8;
	Thu, 28 Aug 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396406; cv=none; b=nNHczJ2HEzkTaaY8hddQUXWW8EWTEju+nMtGGO0cGCSS9KwGJ8N5Kyi84zFKFJ2122PdDEhwOe0vjolmo2T+MO3EvvGwHqPZnXwH9Bb7QsqiHgD7cdKewrGioTNdHMQVnpfQx/O7R8GkK0ln1dkJtU0jqymgGuuOrLDPicK7BV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396406; c=relaxed/simple;
	bh=tGQN0d7TRDLKBUICZx+jkra98Y/2WI8kLiTQsOqgsu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZD+7v48htnFDDNQDGOtxylcJaXWJEtlhJfgRgJP1drbJfHlr4qM9BdjxealDe7ydOQ2KY8BJ3ga7/mK1ybMPTDwYDHh+gaioNroKXWvKHeiSbtKJ3bOBUcOfhIPOZoCrQSvM9I5OC8PVsUHnvd9eOpaIHZmBf/LKqb3j3PbGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CGmAt9zn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CGmAt9zn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9a2LQ6bXTt0LZl1AGm/s/pdNZ/2kG6z/lkK6mMLP+fo=; t=1756396403;
	x=1757001203; b=CGmAt9znDFICGjqN2pH6Wxsi/ll1YxDILOiOeYZ4/cLMwWRfSFz5Lc6TnUp9M
	B3sOs0VmSHV39G0aLqd6w+Xp7E7WWLorvZapOqjDU4Xy2OjXHGhv1j3luBGBJaSsclb9gNmcp8zit
	isOL3TYotTm05UiVd9AuYalu836+0We50/u7bm+ZsBERHnTloinB9PD0tEFX6lnUm9RhjzFL6X5dG
	dDPto9WbPMyyF4n8S2BKSKcIdoR3e3kORBv9Ua3uNmTG2bbmbylbaEkzoKP4lUtiEQAw992Aru24t
	HkF9rQZjUE3JbPc/UTAeC4Z4Slk66sQrnByXzcpJon1v2Wo5Ew==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1urewC-00000000ncs-0ZmA; Thu, 28 Aug 2025 17:53:20 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1urewB-00000000wiy-3pPK; Thu, 28 Aug 2025 17:53:20 +0200
Message-ID: <dd35a213ce2f42a97d791415b594396466da5b14.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Thu, 28 Aug 2025 17:53:19 +0200
In-Reply-To: <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
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
> Based on a finding by Anthony Yznaga that the UltraSPARC III copy_from_us=
er
> returns invalid values breaking other parts of the kernel in case of a
> fault, while the generic implementation is correct.
>=20
> Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate =
exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/U3memcpy.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> index 9248d59c734c..bace3a18f836 100644
> --- a/arch/sparc/lib/U3memcpy.S
> +++ b/arch/sparc/lib/U3memcpy.S
> @@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	faligndata	%f10, %f12, %f26
>  	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
> =20
> +	and		%o2, 0x3f, %o2
>  	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
>  	add		%o1, 0x40, %o1
>  	bgu,pt		%XCC, 1f
> @@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	 * Also notice how this code is careful not to perform a
>  	 * load past the end of the src buffer.
>  	 */
> -	and		%o2, 0x3f, %o2
>  	andcc		%o2, 0x38, %g2
>  	be,pn		%XCC, 2f
>  	 subcc		%g2, 0x8, %g2

After further testing, it turned out that the previously observed crash was
related to my build environment. I can confirm that with the patch applied,
the previously observed memory corruptions on UltraSPARC III are fixed.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
