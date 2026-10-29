Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261161;
	b=vyK6fAu4FTR6QZoF6RwqIZ7EgreNEXznLSBa9c992wAdnXCdCNmyh39m39Wc3fnYdybG
	 3rVIKgwgdWGrNhYViX4FPnYyHJaZORyb89s+y2VIJIWQzn2+xEaakWX7Ap9dCk3z7C80z
	 5pWh1RT2xnks8T4QkBgpysfHMNj3xC8eY7Ja+yOIZ12SQxlwESNla/S3ImXmfPvcQPP1l
	 yM31qeOnjL13OfdTtvh4zvPW0Zxd2Ku/LtjIMMHGbEN12ux0SUPh5UWkatM69Z+iqn3ii
	 eO8sqUyV+yKWPSWbcQoxqnPZlz2yM/TFKrpUJG94LQ+3v/pJgeo0CLuubgeqDl//+PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261161;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=v0rQSbV5ozj0CSaTaKb7xcBdpll55RTEET3OHjUcfs8=;
	b=5sxTyyqnievbccF0BaLIKZx89qtKeK5ITJyhpgB8E84xQz9aQT6TzeeNqvwMK2B0UJev
	 e4fGS7rYi3jXetevmVPmaFr1qDHonpNJ3V8cc9bpwlzwAyvNBvIlICiPQpvMbg6RqCZOV
	 kTSHw1QbDlS4bZQEbGuTc4uw7P+SIb0U9dmAS3w+l3DwmC5kqKQETz96gHxY6u0a4aoN8
	 gi/A8S9ZmLsgAFwvUah9XEm6zRgdyIikSL1lw1I1VFl11wiCizq+WNEOMh8NAlowtQhOa
	 BG4FE4nnx7pihJy7QQ9g3W7V+YGLZzOR7IwoPkxvih1No8Id4+rhhDpAJQF/PAvPv0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=ggFC4Z55;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B019606A31C;
	Thu, 29 Oct 2026 08:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B019606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=ggFC4Z55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=v0rQSbV5ozj0CSaTaKb7xcBdpll55RTEET3OHjUcfs8=; t=1793261159;
	x=1793865959; b=ggFC4Z55sNs8wQuqndorBwkyuho97TluFPYs/Guibl+3ivfJ7dc3L0B25BnaQ
	k6WDJYOfnikwPRrGfHUblcvVGZjNXGsVUxHIzjzrLiPYUZHJiW3QmcSZr/NHsjqWqP2AHymwQnEdS
	YzuVE9t9ohM/rfuV/GAsRREzWonndzLwOBOVJ3glN6Z+JlvTO0waivyLjjl11N3/qlhkhT4LNAcjZ
	iCQFgQqpv6mALF0qFXbeRqxxImkMRxUoNlRIOXeerV+I5tf7VsHhEGnGZ0izk9SY50L1komKysVf/
	Phad8Z1a+ZPzgMZodmQOFJU7DRh1doRrghmx2/lsPDPH3Q84Cg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xML92-00000000Nob-1APi; Thu, 29 Oct 2026 09:05:56 +0100
Received: from dynamic-093-128-055-098.93.128.pool.telefonica.de ([93.128.55.98] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xML92-000000033HV-0JMw; Thu, 29 Oct 2026 09:05:56 +0100
Message-ID: <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sparc updates for v7.4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 09:05:55 +0100
In-Reply-To: <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com>
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
	 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
	 <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com>
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

Hi Andreas,

On Thu, 2026-10-29 at 08:03 +0100, Andreas Larsson wrote:
> I got a late Tested-by for one of the patches, "sparc64: increase kernel
> thread stack size to 32K" that I picked up already 2026-09-27, that I
> inserted just before preparing the pull request. Sorry about that. Apart
> from that added Tested-by, all changes has been on my for-next since
> 2026-10-23, and most much longer than that, and with that included in
> linux-next.

If you really want to modify an old commit without touching the date, you
can use this git rebase command:

git -c rebase.instructionFormat=3D'%s%nexec GIT_COMMITTER_DATE=3D"%cD" \
       GIT_AUTHOR_DATE=3D"%aD" git commit --amend' rebase $COMMIT_ID

> Below follows a pull request for my original for-next before the added
> Tested-by. I hope you can take either my original pull request with my
> explanation of the one below if you rather want to have commit dates
> that better represents when they were picked up.

Can you push this to your for-linus branch?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
