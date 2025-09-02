Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABC26C386;
	Tue,  2 Sep 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831388; cv=none; b=RNo8q5c254ryHb/K/XwoY2GcdjsrixcjTUSbnKX4ovRvuG/yzwh6Wp4mANxCSlAZfhI+HF4ReA46WAsoYZn8SKztMEMpA4Iq7lURoqh+9D3KxKLuFw8MEl69pELZ9s3yH3fx3IzVm+U5lNV90Rr3tkr0THXI70rr/YZQbM96Z3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831388; c=relaxed/simple;
	bh=rfktqMLqj/HEGtTA/vFQSSXSbayE7EEksa3KKdX8Sys=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PM73qqYshTBhDfrSpS+kIAqdH6ip8Wwx0qyekVCZr4YsxG18MLuiRJq3dY0MPRzvWVqQIZrT66b4z1OYGJouIZn0cF0kd6N/hvJEs/GXBDEXXgpoe74Gq0aBT+cqwt3H5vdTQfuCA4PV+1wQld3EaFZHgewBVy6EqXOAKhBYFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=Hgt9I1aF; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="Hgt9I1aF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Sender:Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RpNQu/7GD6lqrNXUZUK8qxSjAj2abH8bPyt1t+uavUA=; b=Hgt9I1aFicE8R0GhIkCOEzvVRb
	czOdL56txGDEXeR9MS8XIkYK926hESg6gN2SwNzsiP4lHSEfaJx6oGAsj2dryC+ia4akjPJRUAoGD
	06JtI3RU4PSiQzeDxVV4iu68FtbRTeVufGdcy37Zjn6OS58PYjOzO0pn9WWP90puNIGI9gleghtyJ
	MWMk+a9WfLeV92ml6rPR6QFiMDvf1tXw8wAduXFRdK6oHNCqjAjvb3MLRdjwYvAKoifeTn+CQTE4G
	pCT9C0B4rjjBBm8rMtUXZfBKym9KElzuRUKWMUUU/iu2QmPH3jTLo4Veg73LGH1/iJUt1039zKAIu
	evcHIkZQ==;
Date: Tue, 02 Sep 2025 18:33:48 +0200 (CEST)
Message-Id: <20250902.183348.7850037982207673.rene@exactcode.com>
To: kernel@mkarcher.dialup.fu-berlin.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 andreas@gaisler.com, glaubitz@physik.fu-berlin.de,
 anthony.yznaga@oracle.com
Subject: Re: [PATCH 1/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC
From: Rene Rebe <rene@exactcode.com>
In-Reply-To: <20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	<20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
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

Hi Michael, Adrian,

thank you so much for doing this work and dropping me a note to test!
I had bisected that last year, too, but due to lack of further time
only ended up reverting d563d678aa0 "fs: Handle intra-page faults in
copy_mount_options()". I also did not suspect copy_{from,to}_user be
that regressed and broken on sparc64, ... :-/

Tested-by: Ren=E9 Rebe <rene@exactcode.com> # on Ultra 5 UltraSparc IIi=


> Fixes: cb736fdbb208 ("sparc64: Convert U1copy_{from,to}_user to accur=
ate exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/U1memcpy.S | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> =

> diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
> index 635398ec7540..154fbd35400c 100644
> --- a/arch/sparc/lib/U1memcpy.S
> +++ b/arch/sparc/lib/U1memcpy.S
> @@ -164,17 +164,18 @@ ENTRY(U1_gs_40_fp)
>  	retl
>  	 add		%o0, %o2, %o0
>  ENDPROC(U1_gs_40_fp)
> -ENTRY(U1_g3_0_fp)
> -	VISExitHalf
> -	retl
> -	 add		%g3, %o2, %o0
> -ENDPROC(U1_g3_0_fp)
>  ENTRY(U1_g3_8_fp)
>  	VISExitHalf
>  	add		%g3, 8, %g3
>  	retl
>  	 add		%g3, %o2, %o0
>  ENDPROC(U1_g3_8_fp)
> +ENTRY(U1_g3_16_fp)
> +	VISExitHalf
> +	add		%g3, 16, %g3
> +	retl
> +	 add		%g3, %o2, %o0
> +ENDPROC(U1_g3_16_fp)
>  ENTRY(U1_o2_0_fp)
>  	VISExitHalf
>  	retl
> @@ -547,18 +548,18 @@ FUNC_NAME:		/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen =
*/
>  62:	FINISH_VISCHUNK(o0, f44, f46)
>  63:	UNEVEN_VISCHUNK_LAST(o0, f46, f0)
>  =

> -93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_0_fp)
> +93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_8_fp)
>  	add		%o1, 8, %o1
>  	subcc		%g3, 8, %g3
>  	faligndata	%f0, %f2, %f8
> -	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
> +	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
>  	bl,pn		%xcc, 95f
>  	 add		%o0, 8, %o0
> -	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_0_fp)
> +	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_8_fp)
>  	add		%o1, 8, %o1
>  	subcc		%g3, 8, %g3
>  	faligndata	%f2, %f0, %f8
> -	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
> +	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
>  	bge,pt		%xcc, 93b
>  	 add		%o0, 8, %o0
>  =

> -- =

> 2.50.1
> =

> =


-- =

  Ren=E9 Rebe, ExactCODE GmbH, Berlin, Germany.
  https://exactcode.com | https://t2linux.com | https://rene.rebe.de
