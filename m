Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE14207A;
	Fri, 29 Aug 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503862; cv=none; b=XlMkrQxbCZ5T/suKXlpJrTx2AGCV3DZ6MwYz7QRXez4fZ2qqsgIUR72PSyX9KxhEFRonc5GrANdWjk++7YMS/FyOymgT96Iru1qQDLg63YO96PT58jQ3zt0xmZuRUij211eQsOiKpxhWtO6352mXoRlZsr5XKIJaqOu1gF/15Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503862; c=relaxed/simple;
	bh=M4lN6GEZ8kdVY69dEz91YS4WpAGr4RmAX8mo2e3oWTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bdv+Qt+5ITiC2pWZkrWBgsoNWGA2YB7N3V78X4piC/NIvQwQ+WtKKu+gZdiNlOT8lSXmM+PzuqLVgdsh7TBF6q3uHhfq77kIug3FRjiuDT4oN4FG/+P3fcQxNKgzAq0bD3Atub+h0QCP07icIjqSpeD7czkBo1O3t4b+1FctOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=R3oq2xmf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="R3oq2xmf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=t+5MnaWs+gRiDiUTWKD8sEhYpt7ASsjdxpmIIj24f+w=; t=1756503858;
	x=1757108658; b=R3oq2xmfNT5HfXchwcVSjHFcA2tz7SFdl9aH/4KK3nE/ndI07JFUB7tfbUfnt
	hX8ZhadhIAnSmuWdZ1PGMJ3Kt3q/CkdX+k6JWr0OsUsv0xZ6SzQ4IPcesbLAXWW6tiOj7uv8zq8ZQ
	VhDlteL3DTdDGalH7UQ0xKPRNbSgUSftcHJW8AXfh6oCuko7DQ7ZEoCc8OWWYu3w2cm8YlJi4IVPi
	e/1Li6lovZtHWGWRs1rc/yDhEWNVU7ziYj88PWYFbyGO4lJ/lKfRy+MIbs0xzKy748tNJQyl9lJGW
	g7epBzwnTAoW4saO5sfePhmvloY2uz8ISQDT/tmkXV4zMwkLHA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1us6tM-00000003huA-0HhZ; Fri, 29 Aug 2025 23:44:16 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1us6tL-000000049mx-3YCy; Fri, 29 Aug 2025 23:44:16 +0200
Message-ID: <90082c61c8bee761b1a57070e2755bbc8a812cd9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 29 Aug 2025 23:44:15 +0200
In-Reply-To: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
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
> Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurate =
exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20
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
> =20
>  	.align		64
> @@ -405,13 +412,13 @@ FUNC_NAME:	/* %i0=3Ddst, %i1=3Dsrc, %i2=3Dlen */
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

Verified on a SPARC T4 with the following hack applied:

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index cf0549134234..886cb8932a0b 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -635,7 +635,7 @@ sparc_m7_patch:
         nop
=20
 niagara4_patch:
-       call    niagara4_patch_copyops
+       call    niagara_patch_copyops
         nop
        call    niagara4_patch_bzero
         nop

Kernel is stable and does not produce any backtraces. Should still be
tested on a real SPARC T1 if possible though.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
