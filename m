Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D32904
	for <sparclinux@vger.kernel.org>; Tue,  3 Sep 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358638; cv=none; b=rl0gPTUEjnMTzlrZH95uV7iYUiDJ54u/F3U/izfoclqC5glt6nBRdFGUrqAdF5hamHSYFATLAuzSHsW9CgwwEbo+uE2vmtLtVB3dRtclwFjvFGtC5bb1SkAJdYxb/p1f69DUGiUSxetVkzXBBclvdqL7HeWTh9/rGEkIAp6HJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358638; c=relaxed/simple;
	bh=aWr18nsak+rc4q7ZfbUAU6/0af13vBjQXAHRDoW8kkE=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=NtwtFO1mX2tPiYjRr7GR9dEX34yC0XIt6BUQpDiuI+KQaoKZb1Mn1XC5nBZAN9+7KLZ0Q9i1IPcss0CR/ILd1Rd38njuIECfHJS8v+wIsvsCmybFL5xloIIRDM+nSaZv4rLUVj+kKtslaQ760uChcQ1pWiJF6DUBOHk14VB9j9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com; spf=pass smtp.mailfrom=exactcode.com; dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b=QytyH6zx; arc=none smtp.client-ip=144.76.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactcode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b="QytyH6zx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
	h=Message-Id:In-Reply-To:To:References:Date:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From; bh=+oM7qkp/ADgD5n4o/aCOv0cJIzsWT3H8PY2Xv8FyogE=;
	b=QytyH6zx/CaRD1U/ATfQEbDbUtIdqj4Izj6BoTLbcPIN8Qm7W2/0A9DMTCRrsv3eJ47WDIWVmnoN25SgHtxkjx6pZIQ2Cn7sqm3pK2pZrlwGIAKdJ+/H3GZBVLoh9YrqcKhPEcDK5b19B4XqE9MJQ2qWTxaBpqIa7GKY7EazHuI=;
Received: from exactco.de ([90.187.5.221])
	by mx.exactcode.de with esmtp (Exim 4.82)
	(envelope-from <rene@exactcode.com>)
	id 1slQbe-0008Oh-Dk
	for sparclinux@vger.kernel.org; Tue, 03 Sep 2024 10:17:50 +0000
Received: from [192.168.2.131] (helo=smtpclient.apple)
	by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.86_2)
	(envelope-from <rene@exactcode.com>)
	id 1slQKW-0003Qt-Cu
	for sparclinux@vger.kernel.org; Tue, 03 Sep 2024 10:00:08 +0000
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: Linux kernel  stability fixes for older SPARCs
Date: Tue, 3 Sep 2024 12:17:09 +0200
References: <caf9102c649a8c76e7eb444ab8c702e3a8da8a52.camel@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
In-Reply-To: <caf9102c649a8c76e7eb444ab8c702e3a8da8a52.camel@physik.fu-berlin.de>
Message-Id: <CD684FA9-566A-4575-8700-AF2601D8FF53@exactcode.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-Spam-Score: -3.1 (---)
X-Spam-Report: Spam detection software, running on the system "exactcode.de", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 
 Content preview:  Hi John, thank you for your email. Happy to hear from you!
    > On 3. Sep 2024, at 10:15, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    wrote: > > Hi Rene, > > according to these posts [1][2] by Iggi, you figured
    out the stability problem [...] 
 
 Content analysis details:   (-3.1 points, 5.0 required)
 
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.5 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  1.0 DNS_FROM_AHBL_RHSBL    RBL: Envelope sender listed in dnsbl.ahbl.org

Hi John,

thank you for your email. Happy to hear from you!

> On 3. Sep 2024, at 10:15, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> Hi Rene,
>=20
> according to these posts [1][2] by Iggi, you figured out the stability =
problem

No, we are just sometimes lucky it run that long stable. I was only made =
aware
recently that sun4u was not 100% and my fasted UltraSPARC until some =
year ago
was only a 360MHz Ultra5 until I was donated a Sun Blade 1000 recently. =
I see
some MM corruption that I wanted to hunt next.

> with newer kernels on older SPARC machines. There has been a =
regression on older
> SPARCs since around kernel 4.19.x which I haven't gotten around to =
bisecting yet.

Happy to bi-sect. I guess you mean random memory corruption I see or =
anything
else?

If you have issues to bi-sect just let us know for any arch. Given =
T2=E2=80=99s cross-compile
support and I have most hardware in my museum now, I can usually bisect =
issues
within a day or two.

> If you've found and fixed the bug in question, it would be great if =
you could share
> your fix with the community and maybe whip up a kernel patch to fix =
the bug upstream.

Of course - all patches are always nicely sorted in our public and =
nicely readable
SVN tree in any case.

	https://t2linux.com

> Newer SPARCs are not affected by this bug, although there are other =
issues.

You mean sun4v? I found a cheap T4-1 some month ago, and T2/Linux =
appears
to run stable on that. Any list of issues w/ sun4v I should be aware of?

Thanks,
	Ren=C3=A9

> Thanks,
> Adrian
>=20
>> [1] https://x.com/Iggi76123640/status/1828396228444389600
>> [2] https://x.com/Iggi76123640/status/1828673611080589641
>=20
> --=20
> .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--=20
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com

