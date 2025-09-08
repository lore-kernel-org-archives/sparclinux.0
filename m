Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CC1A2387
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345840; cv=none; b=Ag0+uyky1s8vY6lThEG71eS3DgHomcMgH/UHLxMRWjEdbrJezYt7W/hTz2pFl3JI1Lm3STRGqZQJOYU+QyIx1CC6Ad8aIxrdqZotJwxjBCUcsrT+eXAhuLa4Z7l9QdMVFsQUpaXM45H9jbGD4oBrsAUXMFBaUzCFstBxFQvqjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345840; c=relaxed/simple;
	bh=8GvWtDI+qkSB/CsV1fmLqzV1DWkrOvHOYIrsNeTTr/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKNLbZLg4DfgLNYTSPe2SPVi16GA0YISNsndmY9A30x5Ab4eTvfjk+l/fI4TtPJDSydOU45cRvQ2qb69X60I0XFXS+6Gz1SE536jN+HCH2oEqSogKQs614l+SKLNXBeymeF1YTS8wf2y6XfaKuU6R2OphW3Qg9ZitbDmpEKNh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=daqF8aI1; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="daqF8aI1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ITxTsEeT+06t1E/lQDRnWjjob+i6g5wG0t6WDzSfHh0=; t=1757345837;
	x=1757950637; b=daqF8aI1ED4HY9fBxNqU6A6naC3jvjdcUprykvbx0f9elZQQToTcgKRaKCpfa
	7ISHspOL59p2mbEHq442SwWKRPUbR9oZzEXuAwzKI4Q9r6GQ0P6bpgw/AhWWuDC0wag7njU9uqr46
	suAr6pp2QNdqZAQG3j2eFCyOdDKavD28APchZpXKNm1ygCkXtBYY9alFudDhXbcNglr7Un/s/+oei
	/fAk9UXhHJezOsHy05NG4pb4vZM3Q4u9lcGJEQhrjCi0svbQCA+FSCd/io/Z4NZA6ePri26eUgE9j
	U6xjPpOtbYCmBpyv8zjl1hjt83l6UtvomaJoEX+OzDLIZ7Do5w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvdvc-00000003Hpa-1iAx; Mon, 08 Sep 2025 17:37:12 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvdvc-00000002KR2-0nOR; Mon, 08 Sep 2025 17:37:12 +0200
Message-ID: <24e383af5b1714de3debb8a4043016ec801a0bae.camel@physik.fu-berlin.de>
Subject: Re: New test kernel available - please verify
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Mon, 08 Sep 2025 17:37:11 +0200
In-Reply-To: <46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
References: 
	<46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
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

On Mon, 2025-09-08 at 17:31 +0200, John Paul Adrian Glaubitz wrote:
> I just uploaded a 6.16.3 Debian kernel package with:
>=20
> - all patches by Michael Karcher to fix copy_{to,from}_user
> - the patch by Anthony Yznaga to fix HugeTLB support on sun4u
> - support for transparent huge pages disabled
>=20
> Packages are available here: https://people.debian.org/~glaubitz/sparc64/
>=20
> Please test and report back!

Never mind, it's broken. Most likely due to the binutils version used.

Will have to rebuild with binutils 2.43.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
