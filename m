Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FB2C21E6;
	Wed,  7 Jan 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775344; cv=none; b=dFxSDGMY2vaezLj5RpbqsLmDE8EMPpv4N2uRy8xZIeTxaARM8L+TEE7AomLxGU8zFm2kIYqxjCRsp35cauzBYYNLsEox0zAkS6j5qAMgjLJy/XfOKJ8dmt1jd+297oJqijZDjbsCWnJEZAPO1sa0PMBSXJj3agzjLsJr+FYtieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775344; c=relaxed/simple;
	bh=ZFY3CvRZnXwM3aDBN6eFGd2R0eir+a1eGs6Y/b04WXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dh6gaQNrBE/UGszbWJ5z5LFkwF6trcLS07uxlvStqqbowK71/ckzY35pQ5iUe5LIUPNN1Lsph30Jn3AqrGRGsb4ZzSE0p+9VYXbkkQ2Bu3jUYQ5zKVvwxJyjUot+GmWOJ+Swxu5mTyKBSwXP/WMbD4vg8a2YlCe/rrJczCsACmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nVLGuKuM; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nVLGuKuM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=caUymBaeCJbYYKA+OCmiUXPnrNJfVBARu0hwVy5E7as=; t=1767775340;
	x=1768380140; b=nVLGuKuMyOwuxchDLFpdqmeiPhND9Kf+KW6kmPt83Av6D2hiJk3ps4cFj3vl4
	FvNDbFlWt+BZr/fbQYmdw5tnwDLYXw58yEnKjLVceBffFRoD+qtGCR7ENdiXgMfOcMrL7Dtbui1WE
	OF73xXuh7J1XpRVcSnPFQule0AZuvPFIpU7dqCrtH2VpiXjzlYoWvkfh9M59JWmGt9yRSrOSfGiCI
	5Lv2NlxI0D9+P0bthXx5u3iSKH+/b2rxbD6l7gw7ijBYGb7nUFeC6CEZ+EhJcA0LlZCMJ9vuXr11B
	wbhma7VeVPxyVFcoz9/52rWM0GaxwgdkYRZh+Gfu5Shf10i5xw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vdP7O-000000049f9-2czR; Wed, 07 Jan 2026 09:42:14 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vdP7O-00000001LQT-1bjn; Wed, 07 Jan 2026 09:42:14 +0100
Message-ID: <072b8188e07208b995eaf5d499c51cd12a25954d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch/sparc: fix unused vaiable warning error
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: alexs@kernel.org, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson	 <andreas@gaisler.com>, "open list:SPARC + UltraSPARC
 (sparc/sparc64)"	 <sparclinux@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Dave Hansen	 <dave.hansen@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Kevin Brodsky	 <kevin.brodsky@arm.com>, Mike
 Rapoport <rppt@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>
Date: Wed, 07 Jan 2026 09:42:13 +0100
In-Reply-To: <20260107064209.15461-1-alexs@kernel.org>
References: <20260107064209.15461-1-alexs@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Alex,

On Wed, 2026-01-07 at 14:42 +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>=20
>    arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>    arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set bu=
t not used [-Wunused-but-set-variable]
>      361 |         unsigned short hv_pgsz_idx;
>          |                        ^~~~~~~~~~~
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Cc: Matthew Wilcox  <willy@infradead.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Mike Rapoport  <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/mm/init_64.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..ba19d23d4040 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -358,30 +358,24 @@ static void __init pud_huge_patch(void)
>  bool __init arch_hugetlb_valid_size(unsigned long size)
>  {
>  	unsigned int hugepage_shift =3D ilog2(size);
> -	unsigned short hv_pgsz_idx;
>  	unsigned int hv_pgsz_mask;
> =20
>  	switch (hugepage_shift) {
>  	case HPAGE_16GB_SHIFT:
>  		hv_pgsz_mask =3D HV_PGSZ_MASK_16GB;
> -		hv_pgsz_idx =3D HV_PGSZ_IDX_16GB;
>  		pud_huge_patch();
>  		break;
>  	case HPAGE_2GB_SHIFT:
>  		hv_pgsz_mask =3D HV_PGSZ_MASK_2GB;
> -		hv_pgsz_idx =3D HV_PGSZ_IDX_2GB;
>  		break;
>  	case HPAGE_256MB_SHIFT:
>  		hv_pgsz_mask =3D HV_PGSZ_MASK_256MB;
> -		hv_pgsz_idx =3D HV_PGSZ_IDX_256MB;
>  		break;
>  	case HPAGE_SHIFT:
>  		hv_pgsz_mask =3D HV_PGSZ_MASK_4MB;
> -		hv_pgsz_idx =3D HV_PGSZ_IDX_4MB;
>  		break;
>  	case HPAGE_64K_SHIFT:
>  		hv_pgsz_mask =3D HV_PGSZ_MASK_64K;
> -		hv_pgsz_idx =3D HV_PGSZ_IDX_64K;
>  		break;
>  	default:
>  		hv_pgsz_mask =3D 0;

Thanks for the patch! Could you fix the typo in the subject?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
