Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C72DCF70;
	Tue,  2 Sep 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831107; cv=none; b=m2cpFuqCdlMXcnygL7dbQ8ThorO16sbOg9jW8jxTb0M129T1BWljWd9K6SznFlCsxDqPmfqfRHeEldIqXqZ/NJOImdfltkRIA8/ZaxUg7e8cNk7pLFZjNUuJPos+GCo8FVLdLuQhkiTpgsZd7EUb+acZ9QIR1KBIh9JQ6xncTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831107; c=relaxed/simple;
	bh=wRWMbZzwaiWrUO3MKkMmjAkflQVO4DecV9CwCrcPJqM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rrjd3VQQ2XEfwBx+u5dgPaqFvJEaAWzp30yoaLBPQPvYhNXXRfrGEeJ8jn8zR+5MqqCy0sRQVxVd4AM923iG0jpb1tlFmUZzAV37pdMKqFp5GvgZ/JeaO6Ij5BnPn42+/d3D1Z0CuWMPB2As4Tu4YjDEDbodOg42bjS0bfjh1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=QtYwl8Dg; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="QtYwl8Dg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Sender:Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZZz2JrcLiYuRx1hqGWQ3qNBjxiTxlP+uNOjhbIQMHJw=; b=QtYwl8Dg3qtTjOAxqkQFcPr7Ur
	CC6s74tgk9Z5wUcqo9xDOL+IaVfCvgG5vP84vxMsYrAut+Atn4ljlzQVqR+IlRLGqkCR044NLXntO
	wBdPHt8x2aS97vp6UJd1U0iuMju7Tnqhotg0RKWih+8DjrMEg0dbHjOt8XXyxruDVLZzTEo5dLaS8
	cewN1LizISQI1eIBB32fJv64NDoxFhLhriJv/2s9tmeHHRYX3JVjXA/WcQsP5rdRrc8NGS0+EdLqc
	A5wP/vQlbqwRmEQ/X1A2jZq8cF/1vo4GfZfuK51a0g4BrmOMYGXiM0u3+Z98Utk1u/BdK1dilBbaL
	Qi5z6mng==;
Date: Tue, 02 Sep 2025 18:38:22 +0200 (CEST)
Message-Id: <20250902.183822.721197619957773341.rene@exactcode.com>
To: kernel@mkarcher.dialup.fu-berlin.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 andreas@gaisler.com, glaubitz@physik.fu-berlin.de,
 anthony.yznaga@oracle.com
Subject: Re: [PATCH 2/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: Rene Rebe <rene@exactcode.com>
In-Reply-To: <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	<20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
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

> Based on a finding by Anthony Yznaga that the UltraSPARC III copy_fro=
m_user
> returns invalid values breaking other parts of the kernel in case of =
a
> fault, while the generic implementation is correct.

Tested-by: Ren=E9 Rebe <rene@exactcode.com> # UltraSparc III+ and Ultra=
Sparc IIIi

> Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accur=
ate exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/U3memcpy.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> index 9248d59c734c..bace3a18f836 100644
> --- a/arch/sparc/lib/U3memcpy.S
> +++ b/arch/sparc/lib/U3memcpy.S
> @@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	faligndata	%f10, %f12, %f26
>  	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
>  =

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
> -- =

> 2.50.1
> =

> =


-- =

  Ren=E9 Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactcode.com | https://t2linux.com | https://rene.rebe.de
