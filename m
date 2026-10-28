Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221015;
	b=CmKCYifQZiBepFld1TbsSf3HXvm3IcpkLzUje0jLTX6x7DRvwP8mfvhQjERp+F7zrLTY
	 subDKbWr5Yps3nMcyDDqwPNTQWcOpj1CupQrJD7dj1O9yQfdidEHUiTN+QZI9lPwRSYfB
	 lsu88JeJo1evQmhU71MbfjxJGgVgJGpq23b83Bw3GtkpNAHtHb4Ak+LvUOomh8vGcu9A9
	 rlPPg4Fx14NQ/vFGNE8/rJb9xWIfPrZNWsqK2iBOkrUv8uq4nEAXBcdzbVNgvLI9KUlbK
	 r2YyagI4qekqj6vrVohq/TbR7tLmC8CoZjNBJhq9rNm6+wUpDkaOeV/xHZa7cc3JcAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221015;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=jnuOEEL5hG7x9ZJuyrYKzDUpGlESN38JfJAqMruBbEk=;
	b=K8TfEz9DfbM7s23Tx7/t7+UDG15ET4EMOdu0sQy0HmuYWVXg5NAUZgO3DzcHMrLyDWQF
	 fsO93Eo/ALxtC0zyjKXOxZtpawNqWt5bhk9HxMXi+BDjDpdwpt8W59XIcEEqpQlFbegZy
	 DPjj9RUg6LjBmCV6vmEZf12jiXeKjmXoAO7uYP33mB3EW04OXJ29xq4by+HGW8fxjQij/
	 AM8XLbHgn3ENDtmnVO2MFjjNWr2sS6WXCM08DnAXWT1upQRGmNa4THHxuWOW1uqtY1+uY
	 Inu6Bw2d7DV0D2gIb+J6DUSNGQtF2XAesqsQlGKgGlzf4P0HRwuqCNPE3MzSYfCAN9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b="f6/8ZPrG";
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1994606A31C;
	Wed, 28 Oct 2026 20:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1994606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=f6/8ZPrG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jnuOEEL5hG7x9ZJuyrYKzDUpGlESN38JfJAqMruBbEk=; t=1793221014;
	x=1793825814; b=f6/8ZPrGBgkR2XgEep5lMeFFiBfRga0nLCrjO24MyiMaLOM10aTJPWSDnSYVF
	geGV4d+clRpt4T9bNOmxrznocw9i2gw2OuWjur3Lh1OEbdyt8H+ZMgVebUMmlPvuo1dMd4bXt/dNs
	G72DHiSlP6k7DPEFHI8wB0km73spjMY5Ic5wSLGa+6xx7Df21GH162AIzETfX5ljhlL6ty2FuWa7B
	Pi2vrZCpPpA9qVuLUONQvKl3GfdazKiWJeBPeND52YT2hbZ7fr8QNil2R4+fO0XmAJHyZpGDUV/Y4
	ZRa+AsQZiH1xUH+YXGI5FkVJHFXLElpr56WYE3ykeM2xPi7XWw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xMAhY-00000001Uha-2Ejd; Wed, 28 Oct 2026 21:56:52 +0100
Received: from dynamic-077-183-189-206.77.183.pool.telefonica.de ([77.183.189.206] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xMAhY-00000000OTH-1LE9; Wed, 28 Oct 2026 21:56:52 +0100
Message-ID: <95250e240e43f09829935373afd004a06338242a.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sparc updates for v7.4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 21:56:51 +0100
In-Reply-To: <6dae1312a957da6e140d684a04ea69e15c21647a.camel@physik.fu-berlin.de>
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
		 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
	 <6dae1312a957da6e140d684a04ea69e15c21647a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

On Wed, 2026-10-28 at 21:50 +0100, John Paul Adrian Glaubitz wrote:
> It seems that Andreas rebased his tree today and therefore bumped all
> the commit dates.  I unfortunately don't have a newer pull of Andreas'
> tree, so I'm missing some commits.
>=20
> Andreas, do you happen to have a local backup from before?

Short follow-up question: If Andreas doesn't happen to have a backup,
is there maybe a daily cron job that backs up git.kernel.org which
could be used to retrieve the original tree?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
