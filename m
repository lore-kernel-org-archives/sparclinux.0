Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61430FC1E;
	Fri, 29 Aug 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464819; cv=none; b=i6+NcA4zPRVd9if+5F9MrqwcObpsyHa/Nlq82CZpPdOTUeECiTO7phEZh22ym3pksg06rE488JSdP52Y8af71eb75K1t2jAwIA607QmJXdZYxZSIxrDqianRbJVQHOpumSmgvYu7Gcm1IgnNLVEh/WLrGpjtdcEb8mW0HxNpGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464819; c=relaxed/simple;
	bh=i7qYvN+gUQaQBarnp2pt+8DDZGXFIz26kvITmDlxiMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PRx2Z2kjcnMA47vDB6ieFVswCsgpUImiclrizA/mzp5LgoQU0I5DVlV34zyinK4ZHt0OC5KQ9CNEjwfjxOApqvAZJF8A+NEXQjd4nidHzoQetn8bL/JvdjR4KZ+9WMTThjNZntD5qFbSTT/VTHOfr2jsS+w6GGOyvWtDW3FIeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MD6DcYc9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MD6DcYc9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=yE/OT2jp/IXfF+ZhJViU2n0O8v9qo02f44rsJAl1lKE=; t=1756464816;
	x=1757069616; b=MD6DcYc94Y/4MfefezHwsgnTVSBqNZ/YNnUMHCTBgPuEPvHQgzIkVcFXAfQiu
	d4IxJDSBDlmGQqD2mwKPXHcB3mGCNafIldbSvWATXw40Z6JWxCNjGRTqLG+VF3LFhye97Gtu6afD4
	VAg0Fi0u8sgx3VQIOwMMBS8Dw0NX3fQurvQfl2tAzb8YLX1xDPbm8JoCUeEK1wTm+nuokI7wQcWc6
	YzC8b5GK68vrwOrg7o/aXNK8D5yUwQjo2Lj2CfY+z1zOHvqOfHIJRmHiDQtSUQ4FTWZ9sxWpxCF6N
	ZnMcxUeyYyI4FNcElTSMc47NlAqnubSunLuEAwSCypWKIFcUWQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1urwje-00000000eFc-0Xyf; Fri, 29 Aug 2025 12:53:34 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1urwjd-00000001Ca4-3o5t; Fri, 29 Aug 2025 12:53:34 +0200
Message-ID: <05acb1676ddc1881e2b9b3fa82f1335c42c2f47e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 29 Aug 2025 12:53:33 +0200
In-Reply-To: <20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
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
> Fixes: cb736fdbb208 ("sparc64: Convert U1copy_{from,to}_user to accurate =
exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/U1memcpy.S | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
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
> @@ -547,18 +548,18 @@ FUNC_NAME:		/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  62:	FINISH_VISCHUNK(o0, f44, f46)
>  63:	UNEVEN_VISCHUNK_LAST(o0, f46, f0)
> =20
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
> =20

Verified to work on QEMU which emulates an UltraSPARC II:

root@debian:~# cat /proc/cpuinfo=20
cpu             : TI UltraSparc IIi (Sabre)
fpu             : UltraSparc IIi integrated FPU
pmu             : ultra12
prom            : OBP 3.10.24 1999/01/01 01:01
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
Cpu0ClkTck      : 0000000005f5e100
MMU Type        : Spitfire
MMU PGSZs       : 8K,64K,512K,4MB
State:
CPU0:           online
root@debian:~#=20

While there were no obvious problems on UltraSPARC before, these may show a=
fter several
days of uptime, similar to Niagara 4. I remember though that there were use=
r reports of
unstable kernels on real UltraSPARC I and II machines.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
