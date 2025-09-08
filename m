Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E5315D36
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345502; cv=none; b=p1e1z1kH7PrXexbWSRPX1hg+KacksJEZV7JnCaceEAiDPQcrb1gQtSix1faHMBictoPTBfXptBUJhO2IVtaP7w+njHQzB93q7jYkRmYCwjQ7jbXNCoVp1VLrxvS096KFfkdDBdvGktB5hAkYzxWCwEiuqpWjfjcpSCrsmLzEDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345502; c=relaxed/simple;
	bh=T5K5EbG7DUqApEwwSpLqxnHFrJVBKY3giNTh1Kpq1YQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=FYX36+Pee5jAQqs77EuQeG4LqQ/Z5g5fxPGCkJGtDUcgCU8s35/w3BhkXWYa+UKMWz7RxEwjBO4iKOKn4aeco8trYhTNj5K9XStV0XlZ6ZhZP15Z51YaBPijCbBMwHKRW1+kpoLgOomX6GtTjbq432mozxoGX7jdCwHBqMBbVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ngApqHYl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ngApqHYl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IsynV8jZxabM5FPP7Bt3DFZfQ3qugoYUhM7VNYXb9Fo=; t=1757345498; x=1757950298; 
	b=ngApqHYlxqHKrASlt5VSltSF7PkpVLEUeCN0Mt28RwnLuQF464uyDx7DsUDijS2gi+5jbZQfyNi
	Y/waoSzkj9OEqFi+YV7HYGj3y1xMjZCr2hav/tA+a7OJtPVPXXUgtXBOB5xUM0Ns5EoymyV+PDjBL
	Xc+VwCLi3aR09mBV/kcJ/OnU1IGa3idIJacguBvMezhyS8/0sP/MAhhTwlQ8tGHR/XjhulsKb/4+T
	z9GGazs1eJxVaeqtYjScuZ9ODOumHnntLicgla5h6fZJO3PXThOWuZbYl9Tre9oaTPcj9rH16zZ2k
	lWN1ncmgDWv5+itiPwkbPJmc4cWPPeL1rkiw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvdqC-00000003EtD-32WD; Mon, 08 Sep 2025 17:31:36 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvdqC-00000002GXa-1guY; Mon, 08 Sep 2025 17:31:36 +0200
Message-ID: <46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
Subject: New test kernel available - please verify
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Mon, 08 Sep 2025 17:31:35 +0200
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

I just uploaded a 6.16.3 Debian kernel package with:

- all patches by Michael Karcher to fix copy_{to,from}_user
- the patch by Anthony Yznaga to fix HugeTLB support on sun4u
- support for transparent huge pages disabled

Packages are available here: https://people.debian.org/~glaubitz/sparc64/

Please test and report back!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
