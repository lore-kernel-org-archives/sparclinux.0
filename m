Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA832E92BB;
	Tue,  2 Sep 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831213; cv=none; b=glKVU78vxMdqwmyfOaIGE6YDA5P8aBNuRTFTc/rBGCXLoKbxIC5WJThVXza6bXodjCtRHaZQ7VNGTaTzJgAykpEkKWkiQGXheDACDjj4OarB/w+y+ls4G22O4XHdOQuEjeLg4U5XesE94OuvIjhaY2CJR6jPf0yT2EW/Wy4SoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831213; c=relaxed/simple;
	bh=O+CiFUXK19a4qlQTMXJPUCsKlQMWNNu08cipXC779Cc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Tgdnwpjxv8V7q+m++WB5eilxnga1ZXzj8akPG5IpE7comm8rCUN+UeT/pH+ycgnpU26I/4cAO3jekvDWfzSp83LQV/J1MiXxX6ViRkEjonneHTbUTPlUT2V9ydnGE/Pant05V7j7hzcjYL3QFEYxipWX9AvQ6XNgMLpjDf6WD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=UEUqo0vz; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="UEUqo0vz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Sender:Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=newOGdvmUa6vft90u655j3V2ptdVczfzsCxNV5dwPU0=; b=UEUqo0vz3ZZwZpMYFRTxGTHPNS
	Qhk8Ds2x8ZrTah8//V7xim+BjADO9xJ1suHM6NLbU9Z1w0f6KKxoq0BLHtVf8BQ2Eiso/XJaKETMJ
	7gdw3knlZ/FLqoSMBj46+6xMXyWB0EWfO9XthZa6E9s15icmi8TN5UjSRn0ZEWI8RIncD/CaXwmHD
	rqa32MOINIY3deiCVjwbjPlBZ0BkbE3L+TP/Ql3yJcKjJPdvATuLZQp+YuVnGzuXZIJBezJniQGra
	H4/AdSMACun/333ufjJYEtcrFuw7vfXWhsMbpijO373sXMo8UzBJjzFnLoEIEPS6EzLJoj8b/9lIu
	wfYGGZmQ==;
Date: Tue, 02 Sep 2025 18:40:11 +0200 (CEST)
Message-Id: <20250902.184011.440504961051160142.rene@exactcode.com>
To: kernel@mkarcher.dialup.fu-berlin.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 andreas@gaisler.com, glaubitz@physik.fu-berlin.de,
 anthony.yznaga@oracle.com
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: Rene Rebe <rene@exactcode.com>
In-Reply-To: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	<20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: rene@exactco.de

Hi,

From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

> Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accur=
ate exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

Tested-by: Ren=E9 Rebe <rene@exactcode.com> # UltraSparc T4 SPARC T4-1 =
Server

> ---
>  arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> =

> diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
> index ee51c1230689..bbd3ea0a6482 100644
> --- a/arch/sparc/lib/NGmemcpy.S
> +++ b/arch/sparc/lib/NGmemcpy.S
> @@ -79,8 +79,8 @@
>  #ifndef EX_RETVAL
>  #define EX_RETVAL(x)	x
>  __restore_asi:
> -	ret
>  	wr	%g0, ASI_AIUS, %asi
> +	ret
>  	 restore
>  ENTRY(NG_ret_i2_plus_i4_plus_1)
>  	ba,pt	%xcc, __restore_asi
> @@ -125,15 +125,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
>  	ba,pt	%xcc, __restore_asi
>  	 add	%i2, %g1, %i0
>  ENDPROC(NG_ret_i2_plus_g1_minus_56)
> -ENTRY(NG_ret_i2_plus_i4)
> +ENTRY(NG_ret_i2_plus_i4_plus_16)
> +        add     %i4, 16, %i4
>  	ba,pt	%xcc, __restore_asi
>  	 add	%i2, %i4, %i0
> -ENDPROC(NG_ret_i2_plus_i4)
> -ENTRY(NG_ret_i2_plus_i4_minus_8)
> -	sub	%i4, 8, %i4
> +ENDPROC(NG_ret_i2_plus_i4_plus_16)
> +ENTRY(NG_ret_i2_plus_i4_plus_8)
> +	add	%i4, 8, %i4
>  	ba,pt	%xcc, __restore_asi
>  	 add	%i2, %i4, %i0
> -ENDPROC(NG_ret_i2_plus_i4_minus_8)
> +ENDPROC(NG_ret_i2_plus_i4_plus_8)
>  ENTRY(NG_ret_i2_plus_8)
>  	ba,pt	%xcc, __restore_asi
>  	 add	%i2, 8, %i0
> @@ -160,6 +161,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
>  	ba,pt	%xcc, __restore_asi
>  	 add	%i2, %i4, %i0
>  ENDPROC(NG_ret_i2_and_7_plus_i4)
> +ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
> +	and	%i2, 7, %i2
> +	add	%i4, 8, %i4
> +	ba,pt	%xcc, __restore_asi
> +	 add	%i2, %i4, %i0
> +ENDPROC(NG_ret_i2_and_7_plus_i4)
>  #endif
>  =

>  	.align		64
> @@ -405,13 +412,13 @@ FUNC_NAME:	/* %i0=3Ddst, %i1=3Dsrc, %i2=3Dlen *=
/
>  	andn		%i2, 0xf, %i4
>  	and		%i2, 0xf, %i2
>  1:	subcc		%i4, 0x10, %i4
> -	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
> +	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
>  	add		%i1, 0x08, %i1
> -	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
> +	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
>  	sub		%i1, 0x08, %i1
> -	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
> +	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
>  	add		%i1, 0x8, %i1
> -	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
> +	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
>  	bgu,pt		%XCC, 1b
>  	 add		%i1, 0x8, %i1
>  73:	andcc		%i2, 0x8, %g0
> @@ -468,7 +475,7 @@ FUNC_NAME:	/* %i0=3Ddst, %i1=3Dsrc, %i2=3Dlen */
>  	subcc		%i4, 0x8, %i4
>  	srlx		%g3, %i3, %i5
>  	or		%i5, %g2, %i5
> -	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
> +	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
>  	add		%o0, 0x8, %o0
>  	bgu,pt		%icc, 1b
>  	 sllx		%g3, %g1, %g2
> -- =

> 2.50.1
> =

> =


-- =

  Ren=E9 Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactcode.com | https://t2linux.com | https://rene.rebe.de
