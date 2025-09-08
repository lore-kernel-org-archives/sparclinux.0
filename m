Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91B1DDC3F
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369873; cv=none; b=VAiYXIazTTi8OfvdHyB/aB9VMxkkJVem1dr+z0qlzUaB3T+9b9Sj7FY8AKUWkEDDJT7z+fGGAQBa2pFIVAZ+DbtVYiQpl0U4jStYxwJY0Fiosgcrb444bqZ8I2SLR3/jj1CnlI3GZkk9HZJsXjDwW2fGWdLuL00FQEZZhSCOsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369873; c=relaxed/simple;
	bh=Q00wNw2ozeEVHeKJG+6nXXkWjeL9AjECvxySR3Ziq6g=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=is77dFmGCZqrhuOds8QtdZENI9F62oHdAeHArBMlnpEgitUGVnA67YGzSdf9U0tZZlvpOQu3BxxNaxHZKUFhaJpqhjSu3pQFsvs+jXMMU6XazcnmM1TBWcilIc1WjS457UNtmrbWNXk+Jduo5WoiTE2dL9Jnu+owM4RzTonP74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KBhbC25p; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KBhbC25p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ET7jxLqIp/5LJ94TAQQcKowISd83oawQVvDN+gvRKO4=; t=1757369870; x=1757974670; 
	b=KBhbC25pdtc/tLw76InOBVWHqFAtiRnb213w6iiOLjgVjAFMv4TbWnLl9ZzepLTyi8Z5GbmecZX
	3ytxM3aNizFr6uttrnsJYgZaIzGqmnOfGqlocA5+QjuxEH1OxA4vW9Qf7NtpoF3+Lkhtmp0z8UC2N
	Qhb4eyWkbrTllrsy7IREnvgmjKo7cceFbYTCfXMEUcKDZUrjD0tKakvvpom3HiOOFLYRMHmlY5ihh
	6xlAhkMAB0juI8FWIjOm92KKsdUGZ0rq64hao+K41dj+PoDOmMrEKWIE4tDAfm0gqzbbGbLmsdEpR
	XH3dNsS4DIa/yotZnBi0sdxHp+FZOWXh9M/w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvkBH-00000000e4Z-34Z0; Tue, 09 Sep 2025 00:17:47 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvkBH-0000000446b-2CKC; Tue, 09 Sep 2025 00:17:47 +0200
Message-ID: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
Subject: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Tue, 09 Sep 2025 00:17:47 +0200
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

Hi,

please test this kernel:

https://people.debian.org/~glaubitz/sparc64/

Don't mind the weird version number, it's a 6.12.3 kernel:

linux (6.12.43-1+nothp1) UNRELEASED; urgency=3Dmedium

  * Add sparc64_fix_hugetlb.patch
  * Add sparc64_fix_copyops.patch
  * Disable CONFIG_TRANSPARENT_HUGEPAGE
  * Disable CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS

 -- John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>  Mon, 08 Sep 2=
025 21:14:41 +0200

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
