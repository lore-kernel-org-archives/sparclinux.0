Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A110274B29
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435957; cv=none; b=pUXEol3sfj1zj9RVhzHujrur0M0OjFjWZx46BHORcMrMY586uNKKBYaatnpoQxOygtJHDAwv02Mn/UHgOBKhch+4V28zwD0DX/uzqaMHavnQw+Kp15n2YolF5O+2j4C1C1zXrJ4fG2AbKuEAy2fgxNT/1bnqyPk7E5nxCKFVa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435957; c=relaxed/simple;
	bh=KwNkaMhaAPJMG55ndSs+dzOJzf/w7vo58gQ9boI7LAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+Y+5shTg2yNrFpKoqaixIAf4SuOxVyIa2Rav3+9Vo7V3wfy5LamGFVOKMLukFjqb1uDY7b4jco/f9uqTbeuZSGawwJ45BFXbrXv4NCEC1uk0cX/KsOAlsTu+nysJ+6hMQiHWUuq+Fniv5YO38MO25JSH9bycPELPKO+42Ou5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LAgVie1j; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LAgVie1j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tG/bDn0YoaOwQ//hwbuJTrEVl7WZw3XSE1mfNVwmcVI=; t=1757435954;
	x=1758040754; b=LAgVie1jUjmDLUPdlQtT20Ae/TOrAWDwYLvFrK+WnH7TlAOC0Ta0n4Z0zaFis
	bcTHNzTmgQeRSnz+yLEWY/ydRa46b/Jowklgqq8u3V2PoeA3ah2KX3KLJ10g+VeYRgwJM+AIAqtVl
	zNmvThbB3dvjYpkEqds20GjjgyYCKlEdvwuNLyQI6juAn1hUgdaigahgXa/pFc/Lv8HbDWt9z8vSs
	xfdrsGcQiNKuQf193irehAlba9yHi/cC1CHrhMzeNkm78qUPAGk+jBQnTGOK7YVDvB7HVZflTQMIz
	VR3c6MyDQdZg5GU8YyzFF2zyapGSmkOfslKH+qddQSXudzMFLg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uw1NA-00000002DSd-12qM; Tue, 09 Sep 2025 18:39:12 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uw1NA-000000003uG-09tj; Tue, 09 Sep 2025 18:39:12 +0200
Message-ID: <2065ad04a01f52b8c4d5158e35932b273585345d.camel@physik.fu-berlin.de>
Subject: Re: New test kernel available - please verify
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Tue, 09 Sep 2025 18:39:11 +0200
In-Reply-To: <674871bb-857e-e9c9-18ce-9a1d68120888@libero.it>
References: 
	<46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
	 <674871bb-857e-e9c9-18ce-9a1d68120888@libero.it>
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

Hi Ricardo,

On Tue, 2025-09-09 at 17:50 +0200, Riccardo Mottola wrote:
> Hi Adrian,
>=20
> John Paul Adrian Glaubitz wrote:
> > I just uploaded a 6.16.3 Debian kernel package with:
> >=20
> > - all patches by Michael Karcher to fix copy_{to,from}_user
> > - the patch by Anthony Yznaga to fix HugeTLB support on sun4u
> > - support for transparent huge pages disabled
> >=20
> > Packages are available here:https://people.debian.org/~glaubitz/sparc64=
/
> >=20
> > Please test and report back!
>=20
> a bit old news now, but yesterday I tested this kernel (I saw there is a=
=20
> new one... will test that too) and it installs and boots fine for me on=
=20
> a Fire T2000
> It works with a "warm reboot" too.
>=20
> I was able to compile on all 32 core, use git, do some apt-get upgrades.=
=20
> I surely stressed CPU, Disk and Ethernet decently. No evident issues foun=
d.
> Of course, not testing of multi-day long running stability.

That's great to hear. If you want, you can add your

	Tested-by: Riccardo Mottola <riccardo.mottola@libero.it> # on Sun Fire T-2=
000

here:

	https://lore.kernel.org/sparclinux/20250905-memcpy_series-v4-3-1ca72dda195=
b@mkarcher.dialup.fu-berlin.de/

To reply with your email client, just download the message in mbox format f=
rom here:

	https://lore.kernel.org/sparclinux/20250905-memcpy_series-v4-3-1ca72dda195=
b@mkarcher.dialup.fu-berlin.de/raw

save the file as ".mbx" file and import it into your email client.

Then just reply to the email normally with the Tested-by tag above.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
