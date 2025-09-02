Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93712DA77E
	for <sparclinux@vger.kernel.org>; Tue,  2 Sep 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844294; cv=none; b=qBXPmjRGiuJW+qb+lNI/ae2LUBxg1TQtdk6EG/v/MRG4GKFohDPW/RK+WAgw0W54lQ3Y+TBrKOtQECOaizN5hgBERWmDgo5YaA5TuK+xRwo73pN5EsaDyIMNI1WBEcK7sNe4Km7Gz83BmfqSJz0uffxvkXVUcsvfNT4u2WG74r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844294; c=relaxed/simple;
	bh=MvxNQaKUz6wYy0lMkL8q1rLBFQBOfq+dsTkMaVN3aLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hk9pnIUHY6SUz6djLsnvEqU7bAcp7myaq5Xb8b6VmsBdYDkgVQC5YnutVocs7hiEae1z2W5qaYbz5u3TllN/YyvgmMj3BJo6tSJi/u1Y86QEwGvJpIRcfvRU5dBT13quRZcIgiZueSH7CPRVll/w8Ziwf9WLX7vJIniWybQacqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Vc4rLPTo; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Vc4rLPTo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=edHULaMeB5YkRD3whndFD0EBPgkhuemGkPQ7rxxKUp4=; t=1756844291;
	x=1757449091; b=Vc4rLPToGxxKjxBVwQKYk3KUbqs0t3Vr524rw4fkJ9e8mjuVsaBjR+H5il4wD
	N97y8oe0ADoiIprmZjL6g6+78K+A/V4upaNGEElhRX7NHMXJ7qbG4jjocyQPgozM9oY2b++x7cE3D
	OddrFG7DO37HQEFpOvt0sztlwPsFjnLd+o3Sbul6l/X3x2efnuAyfgpRF0xKRerw/gmenvFu0E5aE
	WuNrozOtR+WcydnGTj8SjIT/6ikr4KQxigxTsG0jrB+AzyTargNT3gG5CHDbuSeqGfchEafFy9LMu
	0+VA42m/YcpyDkw7PPOXTltNUPcO41u8OFrnMnGnsn4luGOFzg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utXSC-00000000dZE-2nIe; Tue, 02 Sep 2025 22:18:08 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utXSC-00000000kI6-1owb; Tue, 02 Sep 2025 22:18:08 +0200
Message-ID: <e705404a9f66e0cffc0c474b565b2755d8d560c2.camel@physik.fu-berlin.de>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Christoph Hellwig <hch@lst.de>, Frank Scheiner <frank.scheiner@web.de>
Cc: Jan Engelhardt <jengelh@inai.de>, Sparc kernel list
	 <sparclinux@vger.kernel.org>, debian-sparc <debian-sparc@lists.debian.org>
Date: Tue, 02 Sep 2025 22:18:07 +0200
In-Reply-To: <20210325075036.GA27022@lst.de>
References: <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr>
	 <20210323165721.GA14577@lst.de>
	 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de>
	 <20210324082817.GA2625@lst.de>
	 <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de>
	 <p1p52s61-n8p-s29n-n195-q22rs07qoq40@vanv.qr>
	 <250aaeb3-40fe-60c7-044e-aa9daacd7c12@web.de>
	 <20210324161045.GA5969@lst.de>
	 <092f6c45-d4fe-ac02-d416-e644e2f26795@web.de>
	 <b8e98852-8e90-2860-a051-2173da2805c7@web.de>
	 <20210325075036.GA27022@lst.de>
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

Hi Christoph,

On Thu, 2021-03-25 at 08:50 +0100, Christoph Hellwig wrote:
> I have to admit I'm completely lost at this point.  This new trace looks
> totally strange to me, and I'm pretty sure whatever symptoms you see are
> due to different alignments / code sections etc just triggered by the
> removal, we need help from the real sparc experts.

This has finally been tracked down to a regression in the copy_{to,from}_us=
er
code on SPARC as it's found in arch/sparc/lib. Patches to fix these issues
have already been posted in [1].

I'm waiting for Frank to test the patches on his SPARC T1 which is the only
SPARC sub-arch we don't have test results for yet.

Adrian

> [1] https://lore.kernel.org/all/20250826160312.2070-1-kernel@mkarcher.dia=
lup.fu-berlin.de/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
