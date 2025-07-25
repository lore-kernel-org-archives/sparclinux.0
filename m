Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC226CE1E;
	Fri, 25 Jul 2025 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423200; cv=none; b=oSqpOmbI0Ba+ZiU9Lz/jbz6GvugYzE1ZgJ4TbZl/arJX8QyUzq1UmU1yIhCY9PZxfGMSSWQGtN3HL/Hi9+GMnMtF/OVnBaDNm7gEgHILMsZt2AnadGi9EysJf9os4mmZ5ykf1CG2BQ+iyn4aYDK/rTlB6+EeUQfg2CYm7iUPWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423200; c=relaxed/simple;
	bh=HkxuMbm28Jmp5Dp1zZTr9hUxxe5YJ0CjJVZGZTKJzys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiJinAuB5awfLPjkVeJI4H8XHmyJR1fd/zcGME8WKplyqFVZUlpYXiRfCs3AROVPWgLDeAGKn6t9sqxsMUhg+hs3X3IBXla4TbB7QArhTYLRSLiyk5W2JyQIilFLPauLHhfbBrxVmfZlLRLNH40rfp0pzqeA/UtVXPr2Znmd0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jFQ2Bl1i; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jFQ2Bl1i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7wbvCCPynBwB7VQAUk7nBjreu/8tSqi4n5kNLYtBBSc=; t=1753423196; x=1754027996; 
	b=jFQ2Bl1iyg/FezGXZDnS8asGoJ1BD2MadBfHoWWc2muEfPIlBn3DiLqNneeL+/FmFJT/tqQurL/
	15GTNseDCjfIs6uHgZPaK35U4ZmFuOehLKt5FKdv2WiQuPLHiQZVB7ytb5nLFrWS/y1ySGDCcpTUM
	t2cfyef7FkCWpWq2GASphYWxpY5BsFSoSVQw5buNZr8vWbU1dwRcWrGzFeddd1/JpEK+Tu4bXad6p
	euxS/CWB9tHNV/+xzO47iN3t2DVQwo9zmAevNRJxg5Hh1m3EP24ubQxLsIQC75uV+EFh0nul+gxsK
	AMMtSuPKCLb2UBvaH5B+W3G5WpsAF1OANVsQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ufBT9-00000001SwZ-0VHj; Fri, 25 Jul 2025 07:59:47 +0200
Received: from dynamic-002-245-058-127.2.245.pool.telefonica.de ([2.245.58.127] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ufBT8-00000000Jbc-3jmO; Fri, 25 Jul 2025 07:59:47 +0200
Message-ID: <026dc0f797082edf59d9c08f500baac6a1daf5c9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Fri, 25 Jul 2025 07:59:46 +0200
In-Reply-To: <20250716012446.10357-1-anthony.yznaga@oracle.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
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

Hi Anthony,

On Tue, 2025-07-15 at 18:24 -0700, Anthony Yznaga wrote:
> An attempt to exercise sparc hugetlb code in a sun4u-based guest
> running under qemu results in the guest hanging due to being stuck
> in a trap loop. This is due to invalid hugetlb TTEs being installed
> that do not have the expected _PAGE_PMD_HUGE and page size bits set.
> Although the breakage has gone apparently unnoticed for several years,
> fix it now so there is the option to exercise sparc hugetlb code under
> qemu. This can be useful because sun4v support in qemu does not support
> linux guests currently and sun4v-based hardware resources may not be
> readily available.
>=20
> Fix tested with a 6.15.2 and 6.16-rc6 kernels by running libhugetlbfs
> tests on a qemu guest running Debian 13.
>=20
> Fixes: c7d9f77d33a7 ("sparc64: Multi-page size support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  arch/sparc/mm/hugetlbpage.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index 80504148d8a5..2048b5c42ca8 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -22,6 +22,26 @@
> =20
>  static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift=
)
>  {
> +	unsigned long hugepage_size =3D _PAGE_SZ4MB_4U;
> +
> +	pte_val(entry) =3D pte_val(entry) & ~_PAGE_SZALL_4U;
> +
> +	switch (shift) {
> +	case HPAGE_256MB_SHIFT:
> +		hugepage_size =3D _PAGE_SZ256MB_4U;
> +		pte_val(entry) |=3D _PAGE_PMD_HUGE;
> +		break;
> +	case HPAGE_SHIFT:
> +		pte_val(entry) |=3D _PAGE_PMD_HUGE;
> +		break;
> +	case HPAGE_64K_SHIFT:
> +		hugepage_size =3D _PAGE_SZ64K_4U;
> +		break;
> +	default:
> +		WARN_ONCE(1, "unsupported hugepage shift=3D%u\n", shift);
> +	}
> +
> +	pte_val(entry) =3D pte_val(entry) | hugepage_size;
>  	return entry;
>  }
> =20

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
