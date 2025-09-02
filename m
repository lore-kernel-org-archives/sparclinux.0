Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556092550A3;
	Tue,  2 Sep 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849912; cv=none; b=XhpZHeCZkKJHdSj2AegMu1kymtn8OZjP4zkqW5ziF6QQ2hn50aOOSjvU3yVIkTc6SrVHbpSDoy1bKfSdN6DDlE0VqQdwjQL2qD0DZZb5iM/UTWHYJe8Y9Fx0OUgFdZdJkrI6+ziTq4z729EJptcHmEwhQusGcwhhJpajD9TLmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849912; c=relaxed/simple;
	bh=kghvhoMMhFMeo39SoLVZhsFTd8dV2oMqT8bh6D7T550=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=taziRyvlehRJP9GaI4PUVBRieR0mpQpIGHytdupX6NTcWdcIKSRzirOkpR4m3dDvVNJlXRlr96ajPLKRjtZ/0+nzml5Y1Yes+nxReYAkLzJ/tKYb437p+VUTFwm0HZqTL1Gvjk7TEVmvmLF2YiOKVkrFiKxr0voUo5jbP+DhL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=Apl2u/dy; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="Apl2u/dy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Sender:To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4xd3P4pw+1BW58hmfRx8jNfpIWEnDFB/PXNkDo4ENyw=; b=Apl2u/dyl4bcoQS+4RGOaQ8BsP
	xoSSkZ/P/WKiq4VRLUxXvpl1zUg8oBRX4MIZulHF16tW/NH5TteLWSLMc+FaPLYfvyr+fePkplLtw
	TR+EWJ9865xzcc2D2Gg9a9Zg6CjP1fQJ2vKEEoZeumT/FXa2yavBj+muQK3vG2905updK2RkqIwxt
	3IeAN8v9mfC6WSutNsNLjQx8B5BJSfQak1BQGl9Km6DZteasht497GojZnOXOcMPyd19Tmk/8TRMA
	UKZ2Igiq/A7Gs00VGnHR/o0R5PipcvH/uJv+0KOXRe5FR3UDakwIxP/UyPOOtPmdCh7m0WfVFaLBZ
	UGjY+u+w==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
In-Reply-To: <1d32418278ac11e4a2f65c8b6bcd4c90143a1451.camel@physik.fu-berlin.de>
Date: Tue, 2 Sep 2025 23:51:40 +0200
Cc: Rene Rebe <rene@exactcode.com>,
 kernel@mkarcher.dialup.fu-berlin.de,
 linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org,
 andreas@gaisler.com,
 anthony.yznaga@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7C1772C-FBB1-49B0-B942-5D4D6F3376D8@exactcode.de>
References: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
 <20250902.184011.440504961051160142.rene@exactcode.com>
 <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
 <20250902.185101.101005511917098882.rene@exactcode.com>
 <1d32418278ac11e4a2f65c8b6bcd4c90143a1451.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
Sender: rene@exactco.de

Hi,

> On 2. Sep 2025, at 18:53, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> On Tue, 2025-09-02 at 18:51 +0200, Rene Rebe wrote:
>> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>=20
>>> Hi Rene,
>>>=20
>>> On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
>>>> Hi,
>>>>=20
>>>> From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
>>>>=20
>>>>> Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to =
accurate exception reporting.")
>>>>> Signed-off-by: Michael Karcher =
<kernel@mkarcher.dialup.fu-berlin.de>
>>>>=20
>>>> Tested-by: Ren=C3=A9 Rebe <rene@exactcode.com> # UltraSparc T4 =
SPARC T4-1 Server
>>>=20
>>> Thanks for the testing! However, this actually needs to be tested on =
a SPARC T1
>>> as both T2 and T4 have their own implementation that is being used. =
Testing on a
>>> T4 will therefore not invoke this particular code unless you modify =
the kernel in
>>> head_64.S to employ the Niagara 1 code on Niagara 4.
>>=20
>> Ah right, sorry, IIRC you wrote that :-/
>>=20
>>> Do you happen to have a SPARC T1?
>>=20
>> Unfortuantely not. A T2 user might have one, but I could also modify
>> the kernel and use the less optimized T1 code if that helps, ...
>=20
> I have done that already to test the Niagara 1 code on Niagara 4.
>=20
> However, it would be nice to test on a real T1. Unfortunately, I =
haven't found
> anyone yet who got one. If you could ask your users, that would be =
great.
>=20
> Otherwise, we will have to go with the current level of testing.

In case someone has a T1 or M8 in their basement -or otherwise likes to =
test new things-
here is the current WIP pre-release build with basically everything as =
up-to-date as possible=20
and the patches included:

	=
https://dl.t2sde.org/binary/2025/incoming/t2-25.9-sparc64-base-wayland-gli=
bc-gcc-ultrasparc3.iso

the .d directory has the content for cherry picking. Even latest Firefox =
142 works (at least it did last
week when I patched and tested it ;-)

	Ren=C3=A9

> Adrian
>=20
> --=20
> .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--=20
https://exactco.de - https://t2linux.com - https://rene.rebe.de

