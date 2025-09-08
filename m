Received: from dev2.ember.systems (dev2.ember.systems [221.121.142.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2C189F5C;
	Mon,  8 Sep 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=221.121.142.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306366; cv=none; b=KonxbEvuSkHhceMglLK7WTZqCpVyW/KugGBshb7MGziTxZnIvAeNc9fLWYzRkxEFicvU9GKSzrn+8h9ubvhNryZ541UleU20+dzbai3mhdi6y3nwJ96xeW0MztDoxTML5UfiXiDetMNZAeKcPvy91X+BERqNKDGo0mXmXJ+luEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306366; c=relaxed/simple;
	bh=4xYBjJdM4NDur808FlxnDYkG6BSSHAGlwleL6tIRjec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XM7gUrM8L7julzFekTfA6BcRRJNmDIlhDbfmv5I7xPQzfF76RgqZTWZzR+7qumdFRaADbVcI9cR/FrsYXBj+Usma+d/80XuD0rj2C1e0qo8SbLBi26lilWkmGLhK4OCxTBqOLn/8aakAarIFhz5ypXPmG8Jvb8i9FvE1pVcMcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ember.systems; spf=pass smtp.mailfrom=ember.systems; dkim=pass (2048-bit key) header.d=ember.systems header.i=@ember.systems header.b=DFihtIPt; arc=none smtp.client-ip=221.121.142.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ember.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ember.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ember.systems header.i=@ember.systems header.b="DFihtIPt"
Received: from [192.168.1.10] (gw.ehawk.au [119.17.157.5])
	by dev2.ember.systems (Postfix) with ESMTPSA id B914A103DE8B;
	Mon,  8 Sep 2025 14:32:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ember.systems; s=dkim;
	t=1757305950; bh=4xYBjJdM4NDur808FlxnDYkG6BSSHAGlwleL6tIRjec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DFihtIPt2yveFgr9F+T+cXiwOcr2g0Gwjr3Xd+KmNytnVEHisKn4uIHDik5YYzeqz
	 DuH01xt1n5CVoQmD+SRSVumSpetLOLOWrqvd65PHhiyajC7uQJ4uBkrYenIvY3X/1/
	 8WZMJDfXPgBa+Lrvq2ETcKQc5q5caGp7r6poYV4H0HOiVZtzRyv/jYTHXxoVWcHTXi
	 N1188sGH5GVdmVeUf8VfCP4A+pq9SpgQZ1wS1lgh81pGD57tLAXx+/Yps3MZOgWuNj
	 +FVrg0ngin29lr7yvHfGbFdzarZcYpkYiUpVhD89SMRcBADnxDoy7J/mrUIoTkIA0U
	 zEC5HBbVRtfiA==
Message-ID: <fe3faf18-460c-404c-aebb-d57cded6b8b8@ember.systems>
Date: Mon, 8 Sep 2025 14:32:24 +1000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
Content-Language: en-US
From: Ethan Hawke <ehawk@ember.systems>
In-Reply-To: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-By: Ethan Hawke <ehawk@ember.systems> # Sun Fire T2000

On 8/27/25 02:03, Michael Karcher wrote:
> Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurate exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>   arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
> index ee51c1230689..bbd3ea0a6482 100644
> --- a/arch/sparc/lib/NGmemcpy.S
> +++ b/arch/sparc/lib/NGmemcpy.S
> @@ -79,8 +79,8 @@
>   #ifndef EX_RETVAL
>   #define EX_RETVAL(x)	x
>   __restore_asi:
> -	ret
>   	wr	%g0, ASI_AIUS, %asi
> +	ret
>   	 restore
>   ENTRY(NG_ret_i2_plus_i4_plus_1)
>   	ba,pt	%xcc, __restore_asi
> @@ -125,15 +125,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
>   	ba,pt	%xcc, __restore_asi
>   	 add	%i2, %g1, %i0
>   ENDPROC(NG_ret_i2_plus_g1_minus_56)
> -ENTRY(NG_ret_i2_plus_i4)
> +ENTRY(NG_ret_i2_plus_i4_plus_16)
> +        add     %i4, 16, %i4
>   	ba,pt	%xcc, __restore_asi
>   	 add	%i2, %i4, %i0
> -ENDPROC(NG_ret_i2_plus_i4)
> -ENTRY(NG_ret_i2_plus_i4_minus_8)
> -	sub	%i4, 8, %i4
> +ENDPROC(NG_ret_i2_plus_i4_plus_16)
> +ENTRY(NG_ret_i2_plus_i4_plus_8)
> +	add	%i4, 8, %i4
>   	ba,pt	%xcc, __restore_asi
>   	 add	%i2, %i4, %i0
> -ENDPROC(NG_ret_i2_plus_i4_minus_8)
> +ENDPROC(NG_ret_i2_plus_i4_plus_8)
>   ENTRY(NG_ret_i2_plus_8)
>   	ba,pt	%xcc, __restore_asi
>   	 add	%i2, 8, %i0
> @@ -160,6 +161,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
>   	ba,pt	%xcc, __restore_asi
>   	 add	%i2, %i4, %i0
>   ENDPROC(NG_ret_i2_and_7_plus_i4)
> +ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
> +	and	%i2, 7, %i2
> +	add	%i4, 8, %i4
> +	ba,pt	%xcc, __restore_asi
> +	 add	%i2, %i4, %i0
> +ENDPROC(NG_ret_i2_and_7_plus_i4)
>   #endif
>   
>   	.align		64
> @@ -405,13 +412,13 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
>   	andn		%i2, 0xf, %i4
>   	and		%i2, 0xf, %i2
>   1:	subcc		%i4, 0x10, %i4
> -	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
> +	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
>   	add		%i1, 0x08, %i1
> -	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
> +	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
>   	sub		%i1, 0x08, %i1
> -	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
> +	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
>   	add		%i1, 0x8, %i1
> -	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
> +	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
>   	bgu,pt		%XCC, 1b
>   	 add		%i1, 0x8, %i1
>   73:	andcc		%i2, 0x8, %g0
> @@ -468,7 +475,7 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
>   	subcc		%i4, 0x8, %i4
>   	srlx		%g3, %i3, %i5
>   	or		%i5, %g2, %i5
> -	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
> +	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
>   	add		%o0, 0x8, %o0
>   	bgu,pt		%icc, 1b
>   	 sllx		%g3, %g1, %g2
