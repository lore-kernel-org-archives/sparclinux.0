Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9DEEDE;
	Sun, 31 Aug 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683826; cv=none; b=dOtEoe+3xqYnhTIjt5mOR3dL2rFBFNGlGA1AHCtBIbnGZAh2jG2anM4hh49b6n9ActZ7u36eA75yu3wjX3ohPNGyDk8V7xknzMNUZkBQ05O4iYk58n3I8/Ds8MZwA56SnI0ADuDzvBsRNz9WD5zqHI3nyUg/k5B4OgWc85PAJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683826; c=relaxed/simple;
	bh=qdK8g1fxTruaW/KhgLuvvpXhoCz1ED9Zsh7X3diA2cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFbGpeLEnq3rhxjeDDN0heh9L6OtJl7n0llN3Bawn5Di3uC71Z0Rs1DtdqEaWvlZI9H6r79+lmYRvGynT6dsvvh1576Cq4semaV5MraO6TywnmVbEIA2aIhelWZRLbHnSjKUhQ59zPmFH0XA6g8FNQE7OkowtOh9Q+3hAkgrcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lt6tj7rL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lt6tj7rL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=71l4lO1nI6Fz53i8Z4MAvpvgcx5FKkdYPOp6L+MtDoI=; t=1756683822;
	x=1757288622; b=lt6tj7rL2uV7B2xW1a5mPDtbIhFaq8m3v7m6g7C86Crz1Hvr2JrBpoCqUf/QN
	lh3imqmN71jGG3T3F02KQAdpzYVXD5w29TJJha8NSvlgeGNMKhzB19+SYBXGmwsMVQF6XR4QxLpVY
	jF4n9HEciVq9Ee5fShnUQc8DfS38hR6rNuY0JWAZd+YcFYwT7GZYzTutE024vsHAF3vmGBabSVXzu
	MgTw/F8I0OkHSmQDvxnioZvmoFevKZt2Bqyj8xThyRAktNyR2qdTQh//g5ze8mVUM7+RxVyYgvoRq
	4TNFJZevY/sxyNEqkDUJs8fWgiLbbIdCDLfmsrN6Vjkibvf2Hw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1usrhu-00000003cc0-0Mzu; Mon, 01 Sep 2025 01:43:34 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1usrht-00000001Zz9-3f6r; Mon, 01 Sep 2025 01:43:34 +0200
Message-ID: <240f0f51687dcb146656a47932ec075b0821b605.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/1] sparc: fix accurate exception reporting in
 copy_{from,to}_user for M7
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, Rainer Orth
 <ro@CeBiTec.Uni-Bielefeld.DE>
Date: Mon, 01 Sep 2025 01:43:33 +0200
In-Reply-To: <20250828130456.2335-1-kernel@mkarcher.dialup.fu-berlin.de>
References: 
	<aecb14d84b1af658a87a2b1ba3a49ac13d39560e.camel@physik.fu-berlin.de>
	 <20250828130456.2335-1-kernel@mkarcher.dialup.fu-berlin.de>
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

Hi Rainer,

On Thu, 2025-08-28 at 15:04 +0200, Michael Karcher wrote:
> Fixes 34060b8fffa7 ("arch/sparc: Add accurate exception reporting in M7me=
mcpy")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/M7memcpy.S     | 20 ++++++++++----------
>  arch/sparc/lib/Memcpy_utils.S |  9 +++++++++
>  2 files changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/sparc/lib/M7memcpy.S b/arch/sparc/lib/M7memcpy.S
> index cbd42ea7c3f7..99357bfa8e82 100644
> --- a/arch/sparc/lib/M7memcpy.S
> +++ b/arch/sparc/lib/M7memcpy.S
> @@ -696,16 +696,16 @@ FUNC_NAME:
>  	EX_LD_FP(LOAD(ldd, %o4+40, %f26), memcpy_retl_o2_plus_o5_plus_40)
>  	faligndata %f24, %f26, %f10
>  	EX_ST_FP(STORE(std, %f6, %o0+24), memcpy_retl_o2_plus_o5_plus_40)
> -	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_40)
> +	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_32)
>  	faligndata %f26, %f28, %f12
> -	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_40)
> +	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_32)
>  	add	%o4, 64, %o4
> -	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_40)
> +	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_24)
>  	faligndata %f28, %f30, %f14
> -	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_40)
> -	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_40)
> +	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_24)
> +	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_16)
>  	add	%o0, 64, %o0
> -	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_40)
> +	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_8)
>  	fsrc2	%f30, %f14
>  	bgu,pt	%xcc, .Lunalign_sloop
>  	 prefetch [%o4 + (8 * BLOCK_SIZE)], 20
> @@ -728,7 +728,7 @@ FUNC_NAME:
>  	add	%o4, 8, %o4
>  	faligndata %f0, %f2, %f16
>  	subcc	%o5, 8, %o5
> -	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5)
> +	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5_plus_8)
>  	fsrc2	%f2, %f0
>  	bgu,pt	%xcc, .Lunalign_by8
>  	 add	%o0, 8, %o0
> @@ -772,7 +772,7 @@ FUNC_NAME:
>  	subcc	%o5, 0x20, %o5
>  	EX_ST(STORE(stx, %o3, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
>  	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
> -	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
> +	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
>  	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
>  	bne,pt	%xcc, 1b
>  	 add	%o0, 0x20, %o0
> @@ -804,12 +804,12 @@ FUNC_NAME:
>  	brz,pt	%o3, 2f
>  	 sub	%o2, %o3, %o2
> =20
> -1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
> +1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_o3)
>  	add	%o1, 1, %o1
>  	subcc	%o3, 1, %o3
>  	add	%o0, 1, %o0
>  	bne,pt	%xcc, 1b
> -	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
> +	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_o3_plus_1)
>  2:
>  	and	%o1, 0x7, %o3
>  	brz,pn	%o3, .Lmedium_noprefetch_cp
> diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.=
S
> index 64fbac28b3db..207343367bb2 100644
> --- a/arch/sparc/lib/Memcpy_utils.S
> +++ b/arch/sparc/lib/Memcpy_utils.S
> @@ -137,6 +137,15 @@ ENTRY(memcpy_retl_o2_plus_63_8)
>  	ba,pt	%xcc, __restore_asi
>  	 add	%o2, 8, %o0
>  ENDPROC(memcpy_retl_o2_plus_63_8)
> +ENTRY(memcpy_retl_o2_plus_o3)
> +	ba,pt	%xcc, __restore_asi
> +	 add	%o2, %o3, %o0
> +ENDPROC(memcpy_retl_o2_plus_o3)
> +ENTRY(memcpy_retl_o2_plus_o3_plus_1)
> +	add	%o3, 1, %o3
> +	ba,pt	%xcc, __restore_asi
> +	 add	%o2, %o3, %o0
> +ENDPROC(memcpy_retl_o2_plus_o3_plus_1)
>  ENTRY(memcpy_retl_o2_plus_o5)
>  	ba,pt	%xcc, __restore_asi
>  	 add	%o2, %o5, %o0

in the past, you reported stability issues with the Linux kernel when runni=
ng
inside an LDOM on SPARC M7/M8. Could you verify whether the patch above fix=
es
these problems or whether at least they don't introduce regressions?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
