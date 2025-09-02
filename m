Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628F31AF2E;
	Tue,  2 Sep 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831669; cv=none; b=lLgKVN94TciWe3OS+UlNsRLJ8GvZ00/l5x2/9IdFneqeKGNgxf+JgvIprdp334f8IFFZxv8NW302PMwN/7NiccTLMZu/a2k/j55Pek1CJt5/yvXC+2Fn2S3IoaSr2HrBJlh8SXIg1VY2uxqG3VkIjb5MpGZcVLXxxwQ1lm/+ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831669; c=relaxed/simple;
	bh=UTC2GyluPdRpA4vm1s9KI1N3EECdAr9uVw3rbOVnxBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESzLtPsP9P92ziv8qBywEvXfm/In7c+wldQmvflSXwwIZBk/SpaqzjewpC1OlkR0q5Ubqwi4Axmj5J/W2h5TEd9YSKKiyp+xAwH6QWmUYRFGGjnECcMFRL+7XLAseZtUSSLuKgJD8iqrrGcbtbkQH7Dc5r34lZ2QABjlkn3EstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gFgk19Jf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gFgk19Jf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0d+VCvvchtfyxeVhxRdYyEzzFtwK5+d4izY09aCco30=; t=1756831666;
	x=1757436466; b=gFgk19JfTGKF0b1tt8UmD645hbmB3Fz1cpGpYy6MG5Mp9SH/JnYUPk2E7osGu
	X9+4C54wWvaIioNBBlBVvShVnTndxCQGFXVGSjYSPkmT+LqPlB6BY4VAy4wX709AdA04z82i6CV4J
	2Lz3an9QnDgzjLzRIqwN2zUKVEOVDEFyxVaW5U6LM0jpjwQt/v8s6NITPrZv5LNY35mmFj7C+GVEN
	YP0NNtAyFM0klS7BGpSqX5GR/Ud35m6In2bNkXIT6hIhu9a3lEHrGgNjQ8cBJaQbq9MaxaQxl3+91
	9cH58OvdcLHBYCNkv2RRTC6PIUUER9nrBnN5lHDGAxXutKVw6A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utUAZ-00000003vKf-2rLG; Tue, 02 Sep 2025 18:47:43 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utUAZ-000000008Nr-1CTf; Tue, 02 Sep 2025 18:47:43 +0200
Message-ID: <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rene Rebe <rene@exactcode.com>, kernel@mkarcher.dialup.fu-berlin.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	andreas@gaisler.com, anthony.yznaga@oracle.com
Date: Tue, 02 Sep 2025 18:47:41 +0200
In-Reply-To: <20250902.184011.440504961051160142.rene@exactcode.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
		<20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250902.184011.440504961051160142.rene@exactcode.com>
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

Hi Rene,

On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
> Hi,
>=20
> From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
>=20
> > Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurat=
e exception reporting.")
> > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
>=20
> Tested-by: Ren=C3=A9 Rebe <rene@exactcode.com> # UltraSparc T4 SPARC T4-1=
 Server

Thanks for the testing! However, this actually needs to be tested on a SPAR=
C T1
as both T2 and T4 have their own implementation that is being used. Testing=
 on a
T4 will therefore not invoke this particular code unless you modify the ker=
nel in
head_64.S to employ the Niagara 1 code on Niagara 4.

Do you happen to have a SPARC T1?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
