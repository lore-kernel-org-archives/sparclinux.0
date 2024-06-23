Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3F1822D4;
	Sun, 23 Jun 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161634; cv=none; b=mSmrs0t5yD8XGq9CtnlpWxuQGwUPClXbnhJAKk3dM83kOToXC2SiAqbANgFF/iXMhLnkelTfByxG6jriPqyZjqZ0NSvDJdByk9x57Ib4gkGme5dFy9z2mmO7bHiZhrbRYcqv8WOK2IzSfPhkI4f/BOAZsVazxe4G3qW67ebxNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161634; c=relaxed/simple;
	bh=v+rKXPoMM+NgIN5MI2bPlzCVilLhrvQk7A8JsfCUxZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOVA7O6g0tnvbrGqS8LJyplr7rSnBPKRPbmxEwXzANgQ1CD4EwK5UyKvvR5P4iXp0mZtRBgbEmGmei66GByi0PYkroAiuWzRG2/CgWBqNVzL6FTd8O/hsanPDJHJYl75iErR0a6pPXtnIkfNbJHs64ZBuQ86/kWT3HlLbhj29eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FZKSQqAt; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FZKSQqAt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E+CzwN+RZpYMqJ6tzL5pN6ap4pbapH0mHUpTrrmE0+Y=; t=1719161630; x=1719766430; 
	b=FZKSQqAtUJmjoHBcKYKG9hjc0KA+azRdFZQRIgOO7kGndyITHS4WfdF8jCR7Q0eWRc5RydCnX5c
	uax+dcicp6Ioz0/wrHU5aR7runAYZUMLa/8/Y2HoxFtkVph3szXO19JX1iRty3f0kBdzqrATj9Uwc
	rkWJOk526t4ylJXSsESAP2w8sJMzn1lHVyYL7AhUwMt2VpDP460D/HhY+OuDYGMM/eASfOqNk2uAI
	fdZYn1v9vWJAq10y5QLYC/kO/ypkAOQcTLmMdXBWl7pbA9VVA/KtnJGHnWNQaIOBUeIH8dD+FcEtj
	vsGgX8r4fDzPub6Rne7mAs/eEWR6XSdJF8ew==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sLQTC-00000001U07-1pfq; Sun, 23 Jun 2024 18:53:38 +0200
Received: from dynamic-077-191-125-192.77.191.pool.telefonica.de ([77.191.125.192] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sLQTC-00000000YxX-2uiW; Sun, 23 Jun 2024 18:53:38 +0200
Message-ID: <9449319ebbcd59719614ee786f1abe18256d0331.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc/build: Make all compiler flags also
 clang-compatible
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: koachan@protonmail.com, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Date: Sun, 23 Jun 2024 18:53:37 +0200
In-Reply-To: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Koakuma,

On Thu, 2024-06-20 at 22:56 +0700, Koakuma via B4 Relay wrote:
> - More trivial is to change `-mv8plus` -> `-mcpu=3Dv9`.
>   This should be safe too since the kernel seems to require a V9
>   processor to run anyway, so I'm changing the flag to one that is
>   portable between GCC and clang.

I just looked up what the exact difference between V8plus and 32-bit
V9 is and it turns out it's not exactly the same [1].

V8plus does not use VIS instructions and also has a different ELF machine
type, namely EM_SPARC32PLUS instead of EM_SPARCV9 if I understand correctly=
.

So, we should make sure that the above change will not affect the ELF machi=
ne
type.

Adrian

> [1] https://stackoverflow.com/questions/23506538/what-is-em-sparc32plus-f=
or

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
