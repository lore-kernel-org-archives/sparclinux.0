Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE81339A4
	for <sparclinux@vger.kernel.org>; Fri,  9 Jan 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942963; cv=none; b=nB/druuQ+gPGKaABt/LYptMFD0n+uhmNBNhUQqZ5zHXsGSdP43x+BZULlZ9Od1px+5mAwyGBY2Ipysw85jGQo2wfC81o8z5enGR2Smk0NTYr17nnT3GSLhndtQej421sw1TVs6c/uN9ccuLUvDWxk2TF2onnUFAd/SjBC5FecSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942963; c=relaxed/simple;
	bh=UNf9tFdQd8R2a7ihiu3j86MISI97WQXMMSGM3nhsAaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O4MDHzBZc6uFP8fkRNDV68hYfCCDGW1v+DhxHGioPm2FGDN09xO0xtQeJDX+hy+bqedB6A7sGZLZ0LVdyYZSV805yz6Atl2dsBRIDTRSDgAl39tSRaWp/ZB6tmLL2G2sPjcvpUayckzMDWVdbfAHYkNotuLUOtBP98IhnRjoXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KHkX3pdZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KHkX3pdZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=e1hIC0njmPIjzGs4Fu5P3WqZbVWOgcCfGYAzV9XZO1U=; t=1767942959;
	x=1768547759; b=KHkX3pdZz77oqK8WGWl8wwCyYAoi0la4SwP19S5eJ1I5yIw8kCXdvjUjpxgUP
	0B7m97llGwSNiH7Leq6Mt8ydCGDM5RSSvnQ+AuyMzvNe80nG0/KDcW8VyF/w1QSwXLt4IMqmcZ1LA
	XWoFdcozsBYIF2uPEGrL5ONP7Sc2OI1AbhUorC/RJsKJt0RdhPs0/dpE9A3ziOpeLLmY5HdiIjESV
	hXxGsFIQRYQTg5Z+wjYIajUn7FgMiiMtXTOMb3kCA6QNoq6sjOKVediO/J8Me6axYz/OBaS+wzr/P
	K63cPIWMxJR3i9tuMIfQZeEYOp9K7ZMsoxcTvCQe17y2X4lKRQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ve6iz-000000015eH-2R99; Fri, 09 Jan 2026 08:15:57 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ve6iz-000000029Af-1ThR; Fri, 09 Jan 2026 08:15:57 +0100
Message-ID: <8563d30d63a5156647ec8b968f8a9574a4f2b5bd.camel@physik.fu-berlin.de>
Subject: Re: Updated firefox package available for sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Gregor Riepl <onitake@gmail.com>, "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Fri, 09 Jan 2026 08:15:56 +0100
In-Reply-To: <fd2f7767-6c86-4796-acbe-7a30ef5d8adf@gmail.com>
References: 
	<cfe80c9b88601c65e1cc91104da23f7644fed48c.camel@physik.fu-berlin.de>
	 <fd2f7767-6c86-4796-acbe-7a30ef5d8adf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Gregor,

On Fri, 2026-01-09 at 02:15 +0100, Gregor Riepl wrote:
> Thanks a lot for that!
>=20
> > I have successfully built and uploaded the latest version of the firefo=
x package
> > for sparc64. The package has been verified to work fine (see screenshot=
 in [1]).
>=20
> Unfortunately it segfaults very quickly on my Ultra 10:
> nect.cpp:107

That's unfortunate. However, I could confirm it works fine on a SPARC T4:

https://github.com/sparclinux/issues/issues/59#issuecomment-3705595613

>=20
> It was quite hard to get even a stack trace, because of excessive memory =
usage
> (gdb eats 4.5GB just for tracing a core dump, and the box only has 512MB)=
.
>=20
> I suspected that the crash was memory-related at first, but it looks like=
 it might
> be an issue with the JS runtime? If it is in fact memory-related, I wonde=
r why this
> would happen. There's plenty of swap space available.

Firefox is large and takes a lot of memory. It could indeed just be that yo=
u run into
these problems due to insufficient memory but it's hard to say.

Have you ever tested the memory on this machine?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
