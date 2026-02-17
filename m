Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6D3783D5;
	Tue, 17 Feb 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357390; cv=none; b=jZrB+F5q7WgNHdjtxZw9a+K5hWeFJLh/A2MemkLeIR2+Inhp7wCiWYRbx+XoybUX4DhaBILM82icPrZeWthaF7VsGk6K1I0Ogvhc4Fpcsq0aEphxomcgKg68qfAM+wQjKL4ADypArlQWfXt/BpqxMNjALbyAVhy9EYwd9SZqOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357390; c=relaxed/simple;
	bh=CRakEiMBpcMPOjadbvfpq0p+zY4Vwwg5Q3phwdoGXco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcg0IH9cNHLAUMgQvzrXSHsIgGrlxyFv+5wTXw6jVuZMRFK3SAYFpFdSUScp6TfyeITkaycFvpbhYrhzyvbHlc+rRyh44EnL4Jnpdf7j0QbOthzUdVIos9hOG8jXAQmc+JekGqymldAdWN7iFULMnuyS+iRcObq53+rlwXUPUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=R9S0pHVJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="R9S0pHVJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jwGF43Pg8Wzvo0EtseY/1RUmYdCg/DMWA53KoUDusFM=; t=1771357387;
	x=1771962187; b=R9S0pHVJFLhkJdLRxAc2JaULvdfi37iGl9wCRWlUvQi77bXp5dlPDbdKdde5H
	nyfRvcZuINd9E0NtKt1VqwqHKwkIqSSLiXvRjU+wEpd2EhpOR7J50pkLGeuSVRmfiatdnNqS4AHAj
	oWtmY7tK2xIKKygDW2V3+LtsGyuhGtAm/VqJkJMszvAgiOoFNQO/sSW6x3mvzlcMQ2+yDjR9dQSxv
	w+R0OsebienMlq/n5Tcn3g0k09sHi0LXhZYHFZxav/fJfagbFncuJWTZfEfRa4dP1DWHeG6MWKy38
	Zm6mauBjPvvo5g+/JKkYz5ELpTOTfSEK09CJR2WtOsz31gbySA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vsQyM-00000001ysX-1HJB; Tue, 17 Feb 2026 20:43:02 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vsQyM-000000024pD-0JDI; Tue, 17 Feb 2026 20:43:02 +0100
Message-ID: <88ee72df89a9df4c6abf296bb45002d63453ce08.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma
 mapping
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, David Miller
	 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 20:43:01 +0100
In-Reply-To: <276c9e7c2e45b4170e102d45066a8892ba33d541.camel@itx.no>
References: <20260217162141.4669-2-stian@itx.no>
		 <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
		 <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
		 <2124864d0640cd5d8f0697b1d01061ccf3e4243c.camel@physik.fu-berlin.de>
		 <b3da4bf0-d66a-404c-8d29-cfd58f89e84e@app.fastmail.com>
		 <4d219c0521dc14e51ffffc954d283dfd05fdce38.camel@itx.no>
		 <359aa017-ca72-460d-96dc-c3b46edb186c@app.fastmail.com>
	 <276c9e7c2e45b4170e102d45066a8892ba33d541.camel@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Stian,

On Tue, 2026-02-17 at 20:41 +0100, Stian Halseth wrote:
> Let me know if there's still an issue with the latest patch, or if I've
> made a mistake when submitting it. My first patch to LKML, sorry about
> the extra work :)

No need to apologize, you're doing a fantastic job! ;-)

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
